
# File Organizer CLI

A simple command-line tool written in [Zig](https://ziglang.org/) to organize files in a directory by their extensions. This program scans a specified folder, creates subdirectories for each file extension, and moves the files into their respective subdirectories.

## Features

- Organizes files based on their extensions.
- Automatically creates subdirectories for extensions (e.g., `.txt` files are moved to a `txt/` folder).
- Skips directories and processes files only.
- Handles errors gracefully, including already existing directories.

## Prerequisites

- [Zig 0.13.0](https://ziglang.org/download/) or later.

## Installation

1. Clone the repository or download the `file_organizer.zig` file.
2. Compile the application:
   ```bash
   zig build-exe file_organizer.zig
   ```

This will create an executable named `file_organizer` (or `file_organizer.exe` on Windows).

## Usage

Run the program with the path to the folder you want to organize:

```bash
./file_organizer <folder_path>
```

Replace `<folder_path>` with the absolute or relative path of the folder you want to organize.

### Example

#### Before Running:

```
/example
    file1.txt
    file2.doc
    file3.png
    file4.txt
```

#### Command:

```bash
./file_organizer /example
```

#### After Running:

```
/example
    /txt
        file1.txt
        file4.txt
    /doc
        file2.doc
    /png
        file3.png
```

## Error Handling

- If a file has no extension, it is skipped.
- If the specified folder path does not exist, an error message is displayed.
- If a directory already exists, the program skips creating it and continues moving files.

## Development

To modify the program, edit the `file_organizer.zig` file. Compile the updated version using the Zig compiler.

### Key Functions

- **`main`**: Entry point of the program.
- **`getFileExtension`**: Extracts the file extension from a file name.

## Contributing

Contributions are welcome! Feel free to fork this project, open issues, or submit pull requests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
