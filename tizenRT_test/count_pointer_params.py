import csv

pointer_func_count = 0
total_func_count = 0

with open('syscall.csv', newline='') as csvfile:
    reader = csv.reader(csvfile)
    for row in reader:
        # 跳过空行
        if not row or not row[0].strip():
            continue
        total_func_count += 1
        # 参数从第5列开始（下标4），只要有一个参数包含*就算
        has_pointer = any('*' in param for param in row[4:])
        if has_pointer:
            pointer_func_count += 1

print(f"Total number of functions: {total_func_count}")
print(f"Number of functions with pointer parameters: {pointer_func_count}")
print(f"Ratio: {pointer_func_count/total_func_count:.2%}")
