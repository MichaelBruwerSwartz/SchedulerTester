#!/bin/bash

# Directories
root_dir=$(pwd)
test_input_dir="./TestIn"
output_dir="./Output1"

# Create the Output1 directory if it doesn't exist
mkdir -p "$output_dir"

# Define the mapping for test descriptions (used for scheduler argument)
declare -A arr
arr['A']="Priority Scheduler 1 - Given Test Case"
arr['B']="Priority Scheduler 2 - Multiple Processes Same Priority"
arr['C']="Priority Scheduler 3 - Duplicate Resource Names"
arr['D']="Priority Scheduler 4 - Long Boy"
arr['E']="FCFS 1 - Given Test Case"
arr['F']="FCFS 2 - Long Test Case"
arr['G']="Priority Scheduler"
arr['H']="Priority Scheduler 5 - Longer Boy"
arr['I']="FCFS 3 - Longer Test Case"
arr['J']="Priority Scheduler"
arr['K']="Deadlock Detection P1->P2->P1"
arr['L']="RR - 1"
arr['M']="RR - 2"
arr['N']="RR - 3"

# Clean up previous build files and logs
rm -f obj/*.o
rm -f *.log
rm -f schedule_processes

# Build steps
gcc -O2 -Wall -Wno-variadic-macros -pedantic -g -fopenmp -DDEBUG_MNGR -DDEBUG_LOADER -o obj/logger.o -c src/logger.c
gcc -O2 -Wall -Wno-variadic-macros -pedantic -g -fopenmp -DDEBUG_MNGR -DDEBUG_LOADER -o obj/manager.o -c src/manager.c
gcc -O2 -Wall -Wno-variadic-macros -pedantic -g -fopenmp -DDEBUG_MNGR -DDEBUG_LOADER -o obj/proc_gen.o -c src/proc_gen.c
gcc -O2 -Wall -Wno-variadic-macros -pedantic -g -fopenmp -DDEBUG_MNGR -DDEBUG_LOADER -o obj/proc_loader.o -c src/proc_loader.c
gcc -O2 -Wall -Wno-variadic-macros -pedantic -g -fopenmp -DDEBUG_MNGR -DDEBUG_LOADER -o obj/proc_parser.o -c src/proc_parser.c
gcc -g -fopenmp -o schedule_processes obj/logger.o obj/manager.o obj/proc_gen.o obj/proc_loader.o obj/proc_parser.o  

# Loop through test cases A to J
for i in {A..N}; do
    # Use the "1" version of the file for each test case
    process1_path="$test_input_dir/process${i}1.list"
    test_desc="${arr[$i]}"
    
    # Determine scheduler argument based on the description
    if [[ "$test_desc" == Priority* || "$test_desc" == Deadlock* ]]; then
        scheduler_arg="0"
    elif [[ "$test_desc" == RR* ]]; then
        scheduler_arg="1"
    else
        scheduler_arg="2"
    fi

    echo "Running test case $i with input file: $process1_path"
    
    # Run the schedule_processes command
    ./schedule_processes 1 "$process1_path" "$scheduler_arg" 2

    # Check if the log file exists
    log_file="thr0.log"
    if [[ -f "$log_file" ]]; then
        # Derive output file name from the input file name by replacing the .list extension with .log
        base_name=$(basename "$process1_path" .list)
        cp "$log_file" "$output_dir/${base_name}.log"
        rm -f "$log_file"
    fi
done

