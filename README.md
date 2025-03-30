# Version++

**Version++** is a simple versioning tool for Adobe Illustrator (`.ai`) files on Windows. It helps you automatically increment version numbers in filenames, organize previous versions into folders, and keep your project directory clean.

---

## What It Does

When you run the provided script via a `.bat` file (see below), Version++:

1. **Scans a directory for versioned folders** (e.g., `v1`, `v2`, etc.).
2. **Determines the highest existing version number**.
3. **Creates a new version folder** (e.g., `v3` if the highest was `v2`).
4. **Moves all files matching the current version pattern** (e.g., `*-v2.ai`) into that folder.
5. **Copies each `.ai` file in that folder back to the main directory** with its version number incremented (e.g., `design-v2.ai` → `design-v3.ai`).

---

## How to Use (Windows)

1. Clone or download this repository.
2. Place the provided `.bat` launcher file in the directory where your Illustrator files live.
3. Double-click the `.bat` file and provide the target folder (your working directory with version folders).

---

## Script Behavior (Details)

The underlying script (written in Bash) does the following:

- **Takes one argument**: the path to your working directory (e.g., `C:\Users\Name\DesignProject`)
- Locates all `v*` folders to find the current highest version.
- Creates a new folder like `v3` if `v2` is the highest.
- Moves files like `poster-v2.ai`, `logo-v2.ai`, etc., into `v2`.
- Copies updated versions (`poster-v3.ai`, `logo-v3.ai`) back into the main directory.

---

## Example

### Before:

```
DesignProject/
├── poster-v2.ai
├── logo-v2.ai
└── v1/
```

### After Running Version++:

```
DesignProject/
├── poster-v3.ai
├── logo-v3.ai
├── v1/
└── v2/
    ├── poster-v2.ai
    └── logo-v2.ai
```

---

## Notes

- Only `.ai` files are processed.
- Filenames must include the version suffix (e.g., `-v3`).
- The script assumes the version number is always at the end before `.ai`.

---

## Requirements

- Bash (for Windows users, this means Git Bash, WSL, or similar)
- Ability to run `.bat` batch files on Windows

---

## TODO

- Add support for versioning other file types (e.g., `.pdf`, `.eps`)
- Include optional cleanup of older versions
- GUI launcher
