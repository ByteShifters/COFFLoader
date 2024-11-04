
# Zig COFF Loader

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Usage](#usage)
- [Command Line](#command-line)
- [Output](#output)
- [Logging](#logging)
- [Code Explanation](#code-explanation)
- [Core Components](#core-components)
- [Utilities](#utilities)
- [Main Entry Point](#main-entry-point)
- [Notes and Limitations](#notes-and-limitations)
- [Contributing](#contributing)
- [License](#license)


## Overview

The **Zig COFF Loader** is a program written in Zig that parses and executes a COFF (Common Object File Format) file. COFF is a binary format primarily used for executables, object code, and libraries on Windows. This loader demonstrates how to read and load COFF files, apply relocations, and manage memory for dynamic execution of executable sections within COFF files.

This project is structured modularly, following best practices to facilitate readability, maintainability, and extensibility.

## Features

- **COFF Header Parsing**: Reads and interprets COFF headers to understand sections and symbols.
- **Section Loading**: Loads sections into memory, based on raw data pointers from the COFF file.
- **Relocation Handling**: Applies relocations to dynamically adjust addresses as specified by the COFF format.
- **Dynamic Execution**: Executes the entry point of the loaded COFF file in memory.
- **Custom Logging**: Provides a logging system with several levels: `INF`, `ERR`, `DBG`, `SYS`.

## Project Structure

The project is organized into the following directories:

```plaintext
COFFLoader/
├── core/           # Core components of COFF parsing and loading
│   ├── coff.zig            # COFF header parsing and section handling
│   ├── section.zig         # Section loading and memory mapping
│   └── relocation.zig      # Relocation handling and patching
├── utils/          # Utility files for common functions
│   ├── logger.zig          # Logging utility with customizable log levels
│   └── memory.zig          # Memory allocation and deallocation utilities
├── entry/          # Main entry point for the application
│   └── main.zig            # Orchestrates COFF loading and execution
└── build.zig       # Build configuration file for Zig
```

Each component has a specific role, which allows for targeted testing, easy maintenance, and clear boundaries within the codebase.

## Installation

1. **Clone the Repository**:
```
   git clone https://github.com/ByteShifters/COFFLoader.git
   cd COFFLoader
```


2. **Install Zig**: 

- Ensure you have [Zig](https://ziglang.org/) installed. This project is compatible with Zig version 0.9.0 or later. 
- Verify installation: 
``` 
zig version 
```
 3. **Build the Project**: 
 - To build the executable, use Zig’s build system: 
```
zig build
```
- The compiled executable `COFFLoader` will be available in the `zig-out/bin/` directory.

## Usage

### Command Line

To use the COFF Loader, provide a path to a COFF file as the argument:

```bash
zig-out/bin/COFFLoader <path_to_coff_file>
```

Example:

```bash
zig-out/bin/COFFLoader ./example.obj
```

### Output

The loader will:
1. Parse the COFF header.
2. Load each section specified in the COFF file.
3. Apply any relocations if necessary.
4. Execute the entry point of the COFF file, if available.

### Logging

The program uses a custom logger to output various types of information. Logging output format:

- `(INF): TIME - Message`: Informational logs, showing program milestones.
- `(ERR): TIME - Message`: Errors, indicating any issues encountered.
- `(DBG): TIME - Message`: Debug messages, useful for deeper inspection.
- `(SYS): TIME - Message`: System logs, showing critical system-level operations.

Logs are printed to the console for real-time observation.

## Code Explanation

### Core Components

1. **COFF Header** (`core/coff.zig`): 
Reads the COFF header, extracts the number of sections, and loads section headers and metadata.

2. **Sections** (`core/section.zig`): 
Each section is loaded into memory based on its raw data pointer and size.

3. **Relocations** (`core/relocation.zig`): 
Relocations adjust memory addresses to ensure that all symbols and references point to correct locations in the allocated memory space.

### Utilities

1. **Memory Management** (`utils/memory.zig`): 
Handles memory allocation using Windows `VirtualAlloc` and `VirtualFree` functions to allocate memory with execute-read-write permissions.

2. **Logging** (`utils/logger.zig`): 
Provides logging functionality, including different logging levels for structured output.

### Main Entry Point

The main entry point, located in `entry/main.zig`, orchestrates the loading process:
- It reads the COFF header and section headers.
- Loads each section and applies relocations.
- Executes the entry point if it exists.

## Notes and Limitations

- This loader currently supports a subset of COFF relocation types (e.g., `IMAGE_REL_AMD64_ADDR32`). Unsupported types are logged as errors.
- This project targets Windows-based COFF files (specifically for `x86_64` architecture).
- The loader assumes the COFF file contains executable code suitable for dynamic execution, which may not always be the case.

## Contributing

We welcome contributions from the community! To contribute to this project, please follow these steps:

1. **Fork the repository**.
2. **Create a new branch** for your feature or bug fix.
3. **Make your changes** and commit them.
4. **Push your branch** to your forked repository.
5. **Create a pull request**.


## Contact

If you have any questions or feedback, feel free to reach out:

- [ByteShifters](https://ByteShifters.dev)
- [Email](mailto:ren@ByteShifters.dev)


## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/ByteShifters/ActiBot/blob/main/LICENSE) file for more information.

