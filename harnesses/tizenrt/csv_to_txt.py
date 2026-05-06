import csv
import os

CSV_FILE = 'syscall.csv'
OUTPUT_TXT = 'funcs.txt'

def extract_function_info(func, only_name=False):
    function_name = func[0].replace('"', '').strip()

    # If only function name is required
    if only_name:
        return function_name

    return_type = func[3].replace('"', '').strip()
    parameters = [p.replace('"', '').strip() for p in func[4:] if p]

    # Combining to form the desired function signature
    function_signature = f"{return_type} {function_name}({', '.join(parameters)})"
    return function_signature

def main():
    only_name = input("Do you want to only output function names? (yes/no): ").strip().lower() == "yes"
    
    function_signatures = []

    with open(CSV_FILE, 'r') as file:
        reader = csv.reader(file)
        for row in reader:
            function_signature = extract_function_info(row, only_name)
            function_signatures.append(function_signature)

    with open(OUTPUT_TXT, 'w') as out_file:
        for func_sig in function_signatures:
            out_file.write(func_sig + "\n")

    print(f"Function {('names' if only_name else 'signatures')} have been saved to {OUTPUT_TXT}.")

if __name__ == '__main__':
    main()