# Step 1 — Setting Up Your Environment on Windows

**Goal:** Get your Windows PC ready to write, build, and run C++ programs with a GUI.

---

## What You'll Install

| Tool | What it does |
|------|-------------|
| MSYS2 | Gives you a Linux-like terminal + package manager on Windows |
| MinGW-w64 | The actual C++ compiler (GCC for Windows) |
| CMake | Figures out *how* to compile your project |
| SFML 3 | Graphics, window, and input library |
| VS Code | Code editor |
| Git | Saves snapshots of your code |

Everything except VS Code and Git is installed through MSYS2 using a single command.

---

## 1.1 — Install MSYS2

1. Go to **https://www.msys2.org/**
2. Download the installer (`msys2-x86_64-*.exe`)
3. Run it. Accept all defaults. Install to `C:\msys64` (the default).
4. When the installer finishes, it will open the **MSYS2 UCRT64** terminal. Close it for now.

---

## 1.2 — Install the Compiler, CMake, and SFML

Open the **Start Menu** and search for **"MSYS2 MinGW 64-bit"**. Open it.

> **Important:** Always use **MSYS2 MinGW 64-bit** for this project — not "MSYS2 MSYS", not "MSYS2 UCRT64". The MinGW 64-bit shell is the one that produces Windows `.exe` files.

In that terminal, paste and run this command (it's one long line):

```bash
pacman -S mingw-w64-x86_64-gcc mingw-w64-x86_64-cmake mingw-w64-x86_64-sfml mingw-w64-x86_64-make
```

When it asks `Proceed with installation? [Y/n]`, press **Enter**.

This installs the compiler (GCC), CMake, SFML 3, and the `make` build tool — everything you need.

### Verify the SFML version

After the install completes, confirm you have SFML 3 (not an older version):

```bash
pacman -Qi mingw-w64-x86_64-sfml | grep Version
```

The output should show `Version : 3.x.x-...`. If it shows `2.x.x`, run `pacman -Syu` to update the package database, then re-run the install command.

---

## 1.3 — Add MinGW to Your Windows PATH

Windows needs to know where to find the compiler. You need to add one folder to your PATH.

1. Press **Win + S**, search for **"Edit the system environment variables"**, open it
2. Click **"Environment Variables..."**
3. In the top section ("User variables"), find **Path** and double-click it
4. Click **New** and add: `C:\msys64\mingw64\bin`
5. Click OK on all windows

> **Why?** Without this, Windows can't find `g++.exe` or `cmake.exe` when you type them in a terminal. The PATH is just a list of folders Windows searches when you run a command by name.

---

## 1.4 — Install VS Code

1. Download from **https://code.visualstudio.com/**
2. Run the installer. On the "Additional Tasks" screen, tick **"Add to PATH"** and **"Open with Code"** options.
3. Open VS Code and install these extensions (click the Extensions icon on the left sidebar, or press `Ctrl+Shift+X`):
   - **C/C++** by Microsoft — enables syntax highlighting, IntelliSense (autocomplete), and error underlining
   - **CMake Tools** by Microsoft — lets you configure and build your project from inside VS Code

---

## 1.5 — Install Git for Windows

1. Download from **https://git-scm.com/download/win**
2. Run the installer. The defaults are fine — click Next through all screens.
3. This installs both Git and **Git Bash** (a terminal you can use instead of MSYS2 for git commands).

---

## 1.6 — Verify Everything Works

Close any open terminals and open a fresh **MSYS2 MinGW 64-bit** window. Run each command and confirm it prints a version number:

```bash
g++ --version
cmake --version
mingw32-make --version
```

If any of these say "command not found", your PATH might not have updated yet. Try closing and reopening the terminal. If it still fails, double-check step 1.3.

---

## 1.7 — Set Up Git

In the MSYS2 MinGW 64-bit terminal, configure your name and email (used in commit messages):

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

Then, navigate to the `snake-cpp-windows` folder and initialise a repository.

In MSYS2, Windows drives are mounted under `/`. Your `C:\` drive is `/c/`. So if your project is at `C:\Users\YourName\Documents\snake-cpp-windows`, navigate like this:

```bash
cd /c/Users/YourName/Documents/snake-cpp-windows
```

Then initialise git:

```bash
git init
git add .
git commit -m "Initial project structure"
```

---

## 1.8 — Try a Test Build

Still in the MSYS2 MinGW 64-bit terminal, inside the `snake-cpp-windows` folder:

```bash
mkdir build
cd build
cmake .. -G "MinGW Makefiles"
mingw32-make
```

What these commands do:
- `mkdir build` — creates the folder where compiled files go
- `cmake .. -G "MinGW Makefiles"` — tells CMake to read `CMakeLists.txt` and generate build files for MinGW. The `..` means "look for CMakeLists.txt in the parent directory". The `-G` flag chooses the *generator* (the format of the build files).
- `mingw32-make` — actually compiles the code using the files CMake generated

If it worked, you'll see `build\snake.exe`. Double-click it — nothing will happen yet (the program exits immediately), but no crash = success.

If CMake says it can't find SFML, make sure you ran the `pacman` command in step 1.2 successfully and that SFML 3 is installed (see the version check above).

---

## Checkpoint

- [ ] MSYS2 is installed and I can open the MinGW 64-bit terminal
- [ ] `g++ --version` prints a version number
- [ ] `cmake --version` prints a version number
- [ ] SFML 3 is installed (`pacman -Qi` shows version 3.x.x)
- [ ] The project compiled without errors (`snake.exe` exists in `build\`)
- [ ] I made my first git commit

---

## Concepts Introduced

- **Compiler** — translates C++ text into a `.exe` your PC can run
- **MSYS2 / MinGW** — a way to use the GCC compiler (common on Linux/Mac) on Windows
- **CMake** — reads your `CMakeLists.txt` and generates the actual build instructions for your compiler
- **SFML** — a library giving you windows, drawing, keyboard input, and more
- **PATH** — a list of folders Windows searches when you type a command name
- **Git** — version control: saves snapshots of your code history

---

## Troubleshooting

**"cmake: command not found"** → Your PATH doesn't include `C:\msys64\mingw64\bin`. Re-check step 1.3 and restart the terminal.

**"Could not find SFML" or "SFML 3 not found"** → Re-run the `pacman` install command from step 1.2. If the package installs but CMake still can't find it, make sure you're running cmake from the MSYS2 MinGW 64-bit terminal (not PowerShell).

**"SFML version mismatch"** → You have SFML 2 installed. Run `pacman -Syu` to update all packages, then re-run the install command. The package manager will upgrade SFML to version 3.

**"Permission denied" when running .exe** → Windows Defender may be blocking it. Click "More info" → "Run anyway" the first time.

---

➡️ **Next:** [Step 2 — Opening a Window](STEP_02_window.md)
