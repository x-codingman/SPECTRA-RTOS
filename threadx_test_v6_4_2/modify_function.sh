# Replace the m_tx to m__tx in the file of a given directory

# Usage: ./modify_function.sh <directory>

# Example: ./modify_function.sh /home/klee/threadx_test_v6_4_2

# Check if the directory is provided
DIR=/home/klee/klee_src/test-rtos/threadx-6.4.2/common_modules/module_lib

# Replace m_tx with m__tx in the files
find "$DIR" -type f -exec sed -i 's/_tx_/m__tx_/g' {} +  

echo "Replacement complete. m_tx has been replaced with m__tx in all files in $DIR"
