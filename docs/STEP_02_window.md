# Step 2 — Opening a Window

**Goal:** Write your first real C++ code — a program that opens a window on screen.

---

## Background: What Is SFML?

SFML (Simple and Fast Multimedia Library) is a C++ library that handles:
- Creating windows
- Drawing shapes, images, and text
- Detecting keyboard/mouse input
- Playing sounds

You'll use it throughout this project. The [SFML documentation](https://www.sfml-dev.org/documentation/2.6.0/) is excellent — bookmark it.

---

## 2.1 — Include the SFML Header

Open `src\main.cpp` in VS Code.

At the very top, you need to tell the compiler to use SFML's graphics module. In C++, you do this with an `#include` directive:

```cpp
#include <SFML/Graphics.hpp>
```

**Why?** Headers are like instruction manuals — they tell the compiler what functions and types a library provides, so you can use them in your own code.

---

## 2.2 — Create a Window

Inside your `main()` function, create a window object. In SFML, a window is represented by `sf::RenderWindow`.

The constructor takes two arguments:
1. `sf::VideoMode(width, height)` — the size of the window in pixels
2. A string — the title shown in the title bar

Use a width of **640** and a height of **640**. Give it any title you like.

**Hint:** It looks like this pattern:
```cpp
sf::RenderWindow window(sf::VideoMode(/* width */, /* height */), "/* title */");
```

Replace the comments with real values.

---

## 2.3 — The Event Loop

If you just create a window and return from `main()`, the window will flash open and immediately close. You need a loop that keeps the program running.

A basic window loop does three things on every iteration:
1. **Process events** — check if the user closed the window
2. **Clear** — wipe the previous frame
3. **Display** — show the new frame

Write a `while` loop that continues as long as `window.isOpen()` is true.

Inside the loop:

**Step A — Handle events:**
Create an `sf::Event` variable. Use `window.pollEvent(event)` in another loop to check for events. If `event.type == sf::Event::Closed`, call `window.close()`.

**Step B — Clear the window:**
Call `window.clear()`. You can optionally pass an `sf::Color` to set the background colour. Try `sf::Color::Black`.

**Step C — Display:**
Call `window.display()`.

---

## 2.4 — Build and Run

Open your **MSYS2 MinGW 64-bit** terminal and navigate to the project folder, then:

```bash
cd build
mingw32-make
```

You only need to re-run `cmake .. -G "MinGW Makefiles"` once. After that, just `mingw32-make` picks up any changes.

Run the game:
```bash
./snake.exe
```

Or double-click `snake.exe` inside the `build\` folder in File Explorer.

You should see a black window appear. Close it by clicking the ✕ button — if it closes cleanly (no crash, no error), you've done it correctly!

> **Note:** The first time you run `snake.exe`, Windows Defender or SmartScreen may show a warning because it's an unknown program. Click **"More info" → "Run anyway"**. This only happens once.

---

## 2.5 — Console Window

You may notice a black console window appears behind the game window. This is normal for now — it's where error messages would appear during development. In Step 9 (Polish), you'll learn how to hide it for a more finished look.

---

## ✅ Checkpoint

- [ ] A window appears when I double-click `snake.exe`
- [ ] Clicking ✕ closes the window cleanly (no crash)
- [ ] The code compiles with no errors or warnings

---

## 🧠 Concepts Introduced

- **`#include`** — imports declarations from a header file
- **Objects** — `sf::RenderWindow` is an *object* (an instance of a *class*)
- **`while` loop** — keeps running as long as a condition is true
- **Event-driven programming** — the program responds to things that happen (like the user closing the window)
- **Frame** — one "picture" in the game. Clear → draw → display = one frame

---

## 💡 Experiment

- Change the window size. What happens if width ≠ height?
- Try different background colours: `sf::Color::Blue`, `sf::Color(255, 128, 0)`
- What happens if you remove the event polling but keep the while loop? (The window won't respond to being closed — you'll need to kill it from Task Manager!)

---

## 📝 Commit Your Work

```bash
git add .
git commit -m "Step 2: open a window with SFML"
```

---

➡️ **Next:** [Step 3 — The Game Loop](STEP_03_game_loop.md)
