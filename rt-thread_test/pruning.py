import os
import subprocess

# 需要处理的文件夹路径
bc_dir = "./test_bc_files"  # 修改为你的文件夹路径

for filename in os.listdir(bc_dir):
    if filename.endswith(".bc"):
        bc_path = os.path.join(bc_dir, filename)
        tmp_path = bc_path
        # 构造 opt 命令
        cmd = [
            "opt",
            "-passes=internalize,globaldce",
            "-internalize-public-api-list=main",
            "-o", tmp_path,
            bc_path
        ]
        print("Processing:", bc_path)
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if result.returncode == 0:
            os.replace(tmp_path, bc_path)
            print("Success:", filename)
        else:
            print("Failed:", filename)
            print(result.stderr.decode())
            if os.path.exists(tmp_path):
                os.remove(tmp_path)
