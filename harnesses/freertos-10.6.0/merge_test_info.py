import os
from pathlib import Path


def merge_files_in_subdirectories(root_dir, target_filename, output_filename):
    """
    Merge all files named ``target_filename`` under ``root_dir`` into ``output_filename``.
    """

    Path(output_filename).unlink(missing_ok=True)
    Path(output_filename).touch()

    for dirpath, dirnames, filenames in os.walk(root_dir):
        if target_filename in filenames:
            filepath = os.path.join(dirpath, target_filename)
            with open(filepath, "r", encoding="utf-8", errors="replace") as file_to_merge:
                content = file_to_merge.read()
                with open(output_filename, "a", encoding="utf-8") as output_file:
                    output_file.write(content + "\n")


if __name__ == "__main__":
    repo = Path(__file__).resolve().parents[2]
    default_root = (
        repo
        / "test-rtos"
        / "freertos-10.6.0"
        / "FreeRTOS-Kernel-10.6.0"
        / "symbolic_execution"
        / "output"
    )
    root_dir = str(default_root)
    target_filename = "test_info.txt"
    output_filename = "merged-freertos-10.6.0-test-info.txt"
    merge_files_in_subdirectories(root_dir, target_filename, output_filename)
