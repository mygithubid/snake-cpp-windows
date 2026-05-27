# 🐍 Snake Game in C++ — Windows Learning Project

Welcome! This project will guide you through building a **Snake game** from scratch using **C++** and **SFML** on **Windows**.

By the end, you'll have a fully playable game — and along the way you'll learn:

- C++ basics: variables, loops, functions, classes
- Object-Oriented Programming (OOP)
- How GUIs and game loops work
- How to structure a real software project

---

## 📁 Project Structure

```
snake-cpp-windows/
├── README.md               ← You are here
├── CMakeLists.txt          ← Build system configuration
├── build.bat               ← Double-click to compile (after setup)
├── src/                    ← Your C++ source files (.cpp)
│   └── main.cpp            ← Entry point (already provided as a stub)
├── include/                ← Your header files (.h)
├── assets/                 ← Fonts, images, sounds
├── docs/                   ← Step-by-step instructions (START HERE)
│   ├── STEP_01_setup.md
│   ├── STEP_02_window.md
│   ├── STEP_03_game_loop.md
│   ├── STEP_04_snake.md
│   ├── STEP_05_movement.md
│   ├── STEP_06_food.md
│   ├── STEP_07_collision.md
│   ├── STEP_08_score.md
│   └── STEP_09_polish.md
└── build/                  ← Compiled output goes here (don't edit)
```

---

## 🚀 Where to Start

**Read the docs folder in order**, starting with `STEP_01_setup.md`.

Each file tells you exactly what to do next, explains *why* you're doing it, and gives you hints — but you write the code yourself.

---

## 🛠 Requirements (Windows only)

- Windows 10 or 11 (64-bit)
- [MSYS2](https://www.msys2.org/) — provides the compiler, CMake, and SFML all in one place
- [VS Code](https://code.visualstudio.com/) — recommended code editor
- [Git for Windows](https://git-scm.com/download/win)

Full installation instructions are in **STEP_01_setup.md**.

---

## ⚡ Quick Build (after setup is complete)

Open the **MSYS2 MinGW 64-bit** terminal, navigate to this folder, then run:

```bash
mkdir build
cd build
cmake .. -G "MinGW Makefiles"
mingw32-make
```

Or just double-click **`build.bat`** in File Explorer.

The game executable will appear at `build\snake.exe`.

---

## 💡 Tips

- **Don't rush.** Read each step fully before writing any code.
- **Type the code yourself** — don't copy/paste. Muscle memory matters.
- **If something breaks**, that's normal! Read the error message carefully. It's usually telling you exactly what's wrong.
- Use `git commit` after each step so you can go back if something breaks.
- Always use the **MSYS2 MinGW 64-bit** terminal, not PowerShell or Command Prompt, for building.

Good luck, and have fun! 🎮
