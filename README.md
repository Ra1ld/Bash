# Bash Script Utilities


This repository contains a collection of useful Bash scripts for various system administration and data management tasks.

## Scripts

### `createpvs.sh`

This script creates a specified number of `dbfolder` and `datafolder` directories within a given root folder and assigns ownership to a specified user. It intelligently numbers the new folders to avoid overwriting existing ones.

#### Usage

```bash
./createpvs.sh <ROOTFOLDER> <NO_OF_DBFOLDERS> <NO_OF_DATAFOLDERS> <USERNAME>
```

-   `<ROOTFOLDER>`: The absolute path to the directory where new folders will be created.
-   `<NO_OF_DBFOLDERS>`: The number of `dbfolder` directories to create.
-   `<NO_OF_DATAFOLDERS>`: The number of `datafolder` directories to create.
-   `<USERNAME>`: The user to be assigned ownership of the new directories.

#### Example

```bash
# Create 2 dbfolders and 3 datafolders in /mnt/storage and assign ownership to the 'admin' user
sudo ./createpvs.sh /mnt/storage 2 3 admin
```

### `searching.sh`

A script that prompts the user for a directory and performs five different searches for files and directories based on permissions and time attributes. It runs in a loop, allowing multiple searches until the user decides to exit.

#### Usage
The script takes two command-line arguments which are used in the first three searches.

```bash
./searching.sh <PERMISSIONS> <DAYS>
```

- `<PERMISSIONS>`: The octal permission mode to search for (e.g., `755`).
- `<DAYS>`: The number of days for time-based searches (modified/accessed within `n` days).

After starting, the script will prompt you to enter the directory to search in.

#### Search Operations

1.  Finds all files with permissions matching `<PERMISSIONS>`.
2.  Finds all files modified within the last `<DAYS>` days.
3.  Finds all directories accessed within the last `<DAYS>` days.
4.  Finds all files with read permissions for owner, group, and others (`r--r--r--`).
5.  Finds all directories with write permissions for owner, group, and others (`-w--w--w-`).

### `tedb.sh`

A command-line telephone database manager. It allows users to add, list, sort, search, and delete entries stored in a `catalog.txt` file.

#### Usage

The script operates based on flags passed as command-line arguments.

```bash
./tedb.sh [OPTION] [PARAMETER_1] [PARAMETER_2]
```

If run with no options, it displays a detailed usage manual.

| Option | Parameters                  | Description                                                                                             |
| :----- | :-------------------------- | :------------------------------------------------------------------------------------------------------ |
| `-a`   | -                           | Interactively prompts the user to add a new entry (first name, last name, town, phone number).          |
| `-l`   | -                           | Lists all entries in `catalog.txt` with line numbers.                                                   |
| `-s`   | `<COLUMN_NUMBER>`           | Sorts the database by the specified column number (1-4).                                                |
| `-c`   | `<KEYWORD>`                 | Searches for and displays all lines containing the `<KEYWORD>`.                                         |
| `-d`   | `<KEYWORD>` `<ACTION>`      | Modifies entries containing `<KEYWORD>`. <br> `-b`: Replaces the line with a blank line. <br> `-r`: Deletes the entire line. |
| `-n`   | -                           | Counts the number of empty lines in the database and prompts the user to delete them.                   |

#### Examples

```bash
# Add a new contact
./tedb.sh -a

# List all contacts, sorted by last name (column 2)
./tedb.sh -s 2

# Find all contacts from the town "New York"
./tedb.sh -c "New York"

# Delete the record for "John"
./tedb.sh -d John -r
