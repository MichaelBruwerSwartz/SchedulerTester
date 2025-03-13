
---

# Test Scheduler Project

## Overview
This project builds and tests a C scheduling program. The program reads test cases from input files, processes them to produce log outputs, and then these outputs are compared with expected results. Two Bash scripts are provided:
- **run_tests.sh**: Cleans the build environment, compiles the program, runs tests using input files, and saves the generated logs in the `Output1` directory.
- **compare_outputs.sh**: Loops through the generated logs in `Output1` and compares each log with the corresponding file in `/Correct`.

## Directory Structure
```
.
├── src/                   # C source files (logger.c, manager.c, proc_gen.c, proc_loader.c, proc_parser.c)
├── obj/                   # Object files generated during compilation
├── TestIn/                # Test input files (e.g., processA1.list, processB1.list, ..., processJ1.list)
├── Output1/               # Generated output log files (e.g., processA1.log, processB1.log, etc.)
├── /Correct/              # Expected output log files (names matching those in Output1)
├── run_tests.sh           # Script to build the project and run tests
└── compare_outputs.sh     # Script to compare generated logs with expected outputs
```

## Scripts

### run_tests.sh
This script performs the following:
1. **Clean-Up**: Removes any previous object files, log files, and the `schedule_processes` executable.
2. **Build**: Compiles the C source files into object files and links them into the executable `schedule_processes`.
3. **Test Execution**: Iterates over test cases (A to J) using input files from `TestIn` (the "1" version, e.g., `processA1.list`):
   - Determines the scheduler argument based on the test description.
   - Executes the program with the correct arguments.
   - Copies the generated log file (`thr0.log`) into `Output1` with a name that matches the input file (changing the `.list` extension to `.log`), then removes the original log file.

**Usage:**
```bash
chmod +x test.sh
./test.sh
```

### compare_outputs.sh
This script:
1. Loops through all files in the `Output1` directory.
2. For each file, it finds the corresponding file in `/Correct` (files are matched by name).
3. Uses the `diff` command to compare them.
4. Outputs a message indicating whether each test case passed or failed, along with any differences.

**Usage:**
```bash
chmod +x compare.sh
./compare.sh
```

## Requirements
- **GCC**: The project is compiled using GCC.
- **Bash**: The scripts are written for Bash.
- **diff**: The Unix diff utility is used to compare output files.

## Notes
- **Input Files**: Ensure that the `TestIn` directory contains the input files named as `processA1.list`, `processB1.list`, ..., `processJ1.list`.
- **Expected Outputs**: The `/Correct` directory must contain the expected output files with the same names as the generated log files (e.g., `processA1.log`).
- **Directory Paths**: Adjust directory paths in the scripts if your project structure is different.

## Troubleshooting
- **File Not Found**: Verify that the `TestIn` and `/Correct` directories exist and contain the appropriate files.
- **Compilation Issues**: Check that all source files are present in the `src` directory and that your system’s GCC version supports the specified compilation flags.

---