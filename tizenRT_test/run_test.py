import shlex
import subprocess
import concurrent.futures
import os
import json
import multiprocessing
import time
import queue
from rich.live import Live
from rich.console import Console
from rich.table import Table

output_dir = "/home/klee/klee_src/test-rtos/tizenrt/symbolic_execution/output/"
test_files_dir = "/home/klee/klee_src/tizenRT_test/test_bc_files/"
test_info_dir = "/home/klee/klee_src/test-rtos/tizenrt/symbolic_execution/test-info-output/"

# please clean the output and test-info-output directory before running the test
# Clean output directory
command_clean_output = [
    "rm",
    "-rf", 
    output_dir+"*"
]
print("Executing command: " + " ".join(command_clean_output))
subprocess.run(" ".join(command_clean_output), shell=True, check=True)

# Create output directory if it doesn't exist
os.makedirs(output_dir, exist_ok=True)

# Clean test-info-output directory 
command_clean_test_info = [
    "rm",
    "-rf",
    test_info_dir+"*" 
]
print("Executing command: " + " ".join(command_clean_test_info))
subprocess.run(" ".join(command_clean_test_info), shell=True, check=True)

# Create test-info-output directory if it doesn't exist
os.makedirs(test_info_dir, exist_ok=True)







func_names = []



for dirpath, dirnames, filenames in os.walk(test_files_dir):
    for file in filenames:
        new_name = file.replace(".test.bc", "")
        func_names.append(new_name)


# for func in funcs_delete:

#     command_clean = [
#         "rm", 
#         "/home/klee/FreeRTOS-Kernel-10.6.0/symbolic_execution/"+shlex.quote(func)+".c"
#     ]
#     print("Executing command: " + " ".join(command_clean))
#     subprocess.run(command_clean, check=True)
def run_command(func_name):

    command_clean_dir = [
        "rm", 
        "-rf", 
        output_dir+shlex.quote(func_name)
    ]
    #print("Executing command: " + " ".join(command_clean_dir))
    subprocess.run(command_clean_dir, check=True)
    temp_output_path = output_dir+shlex.quote(func_name)+"_temp_output.txt"
    os.makedirs(output_dir, exist_ok=True)
    with open(temp_output_path, "w") as temp_file:
        command = [
            "/home/klee/klee_src/build/bin/klee", 
            "--search=dfs",     
            "--max-time=10h",
            "--only-output-states-covering-new",
            "-debug-print-instructions=src:stderr",
            "--test-info-output-dir="+test_info_dir+shlex.quote(func_name),
            "--output-dir="+output_dir+shlex.quote(func_name),
            "--test-target-name="+shlex.quote(func_name),
            test_files_dir+shlex.quote(func_name)+".test.bc"
        ]
        #print("Executing command: " + " ".join(command))
        subprocess.run(command, stdout=temp_file, stderr=temp_file)

    output_path = output_dir+shlex.quote(func_name)+"_output.txt"

    with open(output_path, "w") as output_file:
        # run the tail command and redirect the output to your target file
        subprocess.run(["tail", "-n", "100", temp_output_path], stdout=output_file)
    return func_name
    
    # Delete the temp file
    # os.remove(temp_output_path)


# func = funcs[0]
# run_command(func)


# P = Pool(processes=1)
# P.map(run_command,func_names)
# for func_name in func_names:
#     run_command(func_name)
def clear_line():
    """清空当前行"""
    sys.stdout.write("\033[K")  # ANSI 转义序列，清空光标所在行
    sys.stdout.flush()

def get_running_time(func_name):
    """Get how long the given function has been running (since its output dir was created)."""
    folder = os.path.join(output_dir, func_name)
    if not os.path.isdir(folder):
        return None  # not started yet
    try:
        mtime = os.path.getmtime(folder)
        return time.time() - mtime
    except OSError:
        return None


def render_progress(completed_tasks, total_tasks, remaining_tasks, elapsed_time_str, remaining_functions):
    """渲染进度和剩余任务的动态 UI"""
    table = Table(title=f"[bold black]Task Progress[/bold black]", box=None)
    table.add_row(f"[bold green]Progress:[/bold green] {completed_tasks}/{total_tasks} tasks completed.")
    table.add_row(f"[bold yellow]Remaining:[/bold yellow] {remaining_tasks} tasks left.")
    table.add_row(f"[bold cyan]Elapsed Time:[/bold cyan] {elapsed_time_str}")
    num_show = 50
    if remaining_tasks <= num_show:
        table.add_row("[bold magenta]Remaining Functions (name : running time):[/bold magenta]")
        for func in remaining_functions[:num_show]:
            running_sec = get_running_time(func)
            if running_sec is not None:
                running_str = format_time(running_sec)
                table.add_row(f"  [white]{func}[/white] : [cyan]{running_str}[/cyan]")
            else:
                table.add_row(f"  [white]{func}[/white] : [dim]waiting[/dim]")
    
    return table


def show_progress(futures, total_tasks, start_time):
    """
    Track progress and display remaining tasks along with elapsed time.
    This will dynamically update the output on the same line.
    """
    completed_tasks = 0
    console = Console()
    with Live(console=console, refresh_per_second=4) as live:  # 每秒更新 4 次
        while completed_tasks < total_tasks:
            #time.sleep(1)  # Pause for a second before checking progress
            completed_tasks = sum(future.done() for future in futures)  # Check how many tasks are done
            remaining_tasks = total_tasks - completed_tasks
            completed_functions = [future.result() for future in futures if future.done()]
            remaining_functions = [func_name for func_name in func_names if func_name not in completed_functions]
            elapsed_time = time.time() - start_time
            elapsed_time_str = format_time(elapsed_time)
            last_remaining_lines = 0   
            # Use '\r' to overwrite the line in the console, show the remaining functions next lines
            live.update(render_progress(completed_tasks, total_tasks, remaining_tasks, elapsed_time_str, remaining_functions))
            # print(f"\rProgress: {completed_tasks}/{total_tasks} tasks completed. "
            #       f"{remaining_tasks} tasks remaining. Time elapsed: {elapsed_time_str}"
            #      , end="")
        
        

def format_time(seconds):
    """
    Format time in seconds to a readable format (HH:MM:SS).
    """
    hours = int(seconds // 3600)
    minutes = int((seconds % 3600) // 60)
    seconds = int(seconds % 60)
    return f"{hours:02}:{minutes:02}:{seconds:02}"

num_workers = multiprocessing.cpu_count()-2
if __name__ == "__main__":
    start_time = time.time()
    with concurrent.futures.ProcessPoolExecutor(max_workers=num_workers) as executor:
        futures = [executor.submit(run_command, func_name) for func_name in func_names]
        show_progress(futures, len(func_names), start_time)











