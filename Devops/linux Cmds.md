

### **List Directories**

- `ls` : List contents
    - `-l` : Long format
    - `-a` : Hidden files

### **Open Files**

- `./-` : Open hyphenated file
- `""` : Open spaced file

### **View File**

- `cat <filename>` : Show file content

### **Piping**

- `|` : Pipe output
- `grep` filter

### **Find Files**

- `find <path>` : Search for files
    - `-type f` : Regular files
    - `-type d` : Directories
	
### **Filters**

- `- size 1033c`:1033 bytes in size
- `-executable`: executable
- `!` not 

### **Users** 

- `-user bandit7 -group bandit6`
- find the user and usergroup
- 

### Standard File Descriptors:

1. **`0` - Standard Input (stdin)**:
    
    - Input to a program (usually from the keyboard).
    - Example: reading from the terminal or a file.
2. **`1` - Standard Output (stdout)**:
    
    - Output from a program (usually to the terminal).
    - Example: printing text or data to the screen.
3. **`2` - Standard Error (stderr)**:
    
    - Error messages or diagnostic output.
    - Example: displaying error messages without affecting normal output.

	### 1. **man**

- **Description**: Displays the manual pages for commands, providing detailed information on how to use them.
- **Usage**: `man [command]`
    - Example: `man grep` will show the manual page for the `grep` command.

### 2. **grep**

- **Description**: Searches for a specified pattern in files and prints lines matching that pattern.
- **Usage**: `grep [options] pattern [file...]`
    - Example: `grep "hello" file.txt` searches for the string "hello" in `file.txt`.

### 3. **sort**

- **Description**: Sorts lines of text files.
- **Usage**: `sort [options] [file...]`
    - Example: `sort file.txt` sorts the lines in `file.txt` alphabetically.

### 4. **uniq**

- **Description**: Filters out repeated lines in a sorted file.
- **Usage**: `uniq [options] [input_file] [output_file]`
    - Example: `uniq file.txt` removes duplicate lines in `file.txt`. This command is often used with `sort`.

### 5. **strings**

- **Description**: Extracts printable strings from binary files.
- **Usage**: `strings [options] [file...]`
    - Example: `strings binaryfile` shows the human-readable strings from `binaryfile`.

### 6. **base64**

- **Description**: Encodes and decodes data in Base64 format, which is a method for converting binary data to ASCII string format.
- **Usage**: `base64 [options] [file...]`
    - Example: `echo "hello" | base64` encodes "hello" in Base64.

### 7. **tr**

- **Description**: Translates or deletes characters from standard input.
- **Usage**: `tr [options] SET1 [SET2]`
    - Example: `echo "hello" | tr 'a-z' 'A-Z'` converts lowercase letters to uppercase.

### 8. **tar**

- **Description**: Archives files into a single file, often for backup or distribution.
- **Usage**: `tar [options] [archive-file] [file-or-directory...]`
    - Example: `tar -cvf archive.tar file1 file2` creates an archive named `archive.tar` containing `file1` and `file2`.

### 9. **gzip**

- **Description**: Compresses files using the GNU zip algorithm.
- **Usage**: `gzip [options] [file...]`
    - Example: `gzip file.txt` compresses `file.txt` into `file.txt.gz`.

### 10. **bzip2**

- **Description**: Compresses files using the Burrows-Wheeler block sorting text compression algorithm.
- **Usage**: `bzip2 [options] [file...]`
    - Example: `bzip2 file.txt` compresses `file.txt` into `file.txt.bz2`.

### 11. **xxd**

- **Description**: Creates a hex dump of a file or converts a hex dump back to binary.
- **Usage**: `xxd [options] [file]`
    - Example: `xxd file.txt` generates a hexadecimal representation of `file.txt`.
      


 `df -h`

This will show the disk space usage for all mounted filesystems in a human-readable format.

Here are the `grep` examples in simple lines:

1. **Basic search**:
   ```bash
   grep "hello" file.txt
   ```

2. **Ignore case**:
   ```bash
   grep -i "hello" file.txt
   ```

3. **Inverse match**:
   ```bash
   grep -v "error" log.txt
   ```

4. **Recursive search**:
   ```bash
   grep -r "main" /path/to/directory
   ```

5. **Show line numbers**:
   ```bash
   grep -n "hello" file.txt
   ```

6. **List files containing match**:
   ```bash
   grep -l "hello" *.txt
   ```

7. **Count matches**:
   ```bash
   grep -c "error" log.txt
   ```

8. **Show only matching part**:
   ```bash
   grep -o "hello" file.txt
   ```

9. **Show 2 lines after match**:
   ```bash
   grep -A 2 "error" log.txt
   ```

10. **Show 2 lines before match**:
   ```bash
   grep -B 2 "error" log.txt
   ```

11. **Extended regex (OR condition)**:
   ```bash
   grep -E "error|fail" log.txt
   ```

12. **Match whole words**:
   ```bash
   grep -w "error" log.txt
   ```

13. **Match entire line**:
   ```bash
   grep -x "error" file.txt
   ```

14. **Search in command output**:
   ```bash
   ps aux | grep "apache"
   ```

15. **Filter logs for errors**:
   ```bash
   tail -f /var/log/syslog | grep "error"
   ```

16. **Wildcard (any character)**:
   ```bash
   grep "h.llo" file.txt
   ```

17. **Character sets**:
   ```bash
   grep "[hH]ello" file.txt
   ```

18. **Range of characters**:
   ```bash
   grep "[a-z]ello" file.txt
   ```

19. **Match start of line**:
   ```bash
   grep "^hello" file.txt
   ```

20. **Match end of line**:
   ```bash
   grep "hello$" file.txt
   ```

21. **Search multiple files**:
   ```bash
   grep "search_string" file1.txt file2.txt
   ```

22. **Suppress errors**:
   ```bash
   grep "string" * 2>/dev/null
   ```

23. **Highlight matches**:
   ```bash
   grep --color "hello" file.txt
   ```

### Numeric Permission Breakdown

| Symbolic    | User | Group | Others | Numeric |
| ----------- | ---- | ----- | ------ | ------- |
| `rwxrwxrwx` | rwx  | rwx   | rwx    | 777     |
| `rwxr-xr-x` | rwx  | r-x   | r-x    | 755     |
| `rw-rw-r--` | rw-  | rw-   | r--    | 664     |
| `rw-r--r--` | rw-  | r--   | r--    | 644     |
| `rwx------` | rwx  | ---   | ---    | 700     |
![[Pasted image 20241003145836.png]]
