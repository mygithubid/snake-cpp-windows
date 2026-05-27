# Step 9 — Polish & Where to Go Next

**Goal:** Congratulations — you have a working Snake game! This step covers making it feel great, and points you toward your next challenges.

---

## 🎉 What You've Built

You've written a complete game from scratch on Windows. Along the way you learned:

- **C++ syntax** — variables, loops, conditionals, functions
- **Classes and OOP** — designing objects with data and behaviour
- **SFML** — windows, drawing, events, text, timing
- **Game programming patterns** — the game loop, fixed timestep, state machines
- **Standard library** — vectors, random numbers, strings
- **Windows toolchain** — MSYS2, MinGW, CMake, Git

That's genuinely impressive. Well done.

---

## 9.1 — Hide the Console Window

Right now a black console window appears behind the game. For a polished `.exe`, you can hide it.

In `CMakeLists.txt`, change:
```cmake
add_executable(snake ${SOURCES})
```
to:
```cmake
add_executable(snake WIN32 ${SOURCES})
```

Then change `main()` in `main.cpp` to use the Windows entry point:
```cpp
#include <windows.h>

int WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    // your existing main() code goes here
}
```

Rebuild — the console window will be gone. Note: `std::cout` no longer works after this change (there's no console to write to), but the game won't need it.

---

## 9.2 — Polish Ideas

### 🎨 Visual
- **Grid lines** — draw faint lines between cells to make the grid visible
- **Rounded snake** — use `sf::CircleShape` for each segment instead of rectangles
- **Colour gradient** — make each body segment slightly different, fading from head to tail
- **Animated food** — use a `sf::Clock` to pulse the food's size or colour
- **Start screen** — show a title before the game begins; wait for the player to press a key

### 🔊 Sound
- SFML includes `sf::Sound` and `sf::SoundBuffer` — try adding a sound when food is eaten
- Free sound effects: [freesound.org](https://freesound.org)

### ⚙️ Gameplay
- **Increasing speed** — reduce `MOVE_INTERVAL` every time the snake eats food
- **Wall wrap mode** — toggle between instant death at walls vs. wrapping to the other side
- **Multiple food items** — spawn 2–3 at once for more chaos

### 💾 Persistent High Score
Save the high score to a file so it survives between sessions:

```cpp
// Writing
#include <fstream>
std::ofstream file("highscore.txt");
file << highScore;

// Reading
std::ifstream file("highscore.txt");
if (file) file >> highScore;
```

This is your introduction to **file I/O** — reading and writing files in C++.

---

## 9.3 — Refactoring Challenge

Right now `main.cpp` probably handles a lot. Good programmers organise their code.

Consider creating a `Game` class that owns the snake, food, score, and game loop. This is called **encapsulation** — hiding complexity inside a well-defined boundary.

Your `main()` (or `WinMain`) could then look as clean as:
```cpp
int main() {
    Game game;
    game.run();
    return 0;
}
```

Try refactoring your code to achieve this.

---

## 9.4 — What to Learn Next

### Deepen Your C++ Knowledge
- **Pointers and references** — how memory really works; essential for understanding C++
- **Smart pointers** (`std::unique_ptr`, `std::shared_ptr`) — managing memory without leaks
- **Templates** — write code that works for any type
- **Inheritance and polymorphism** — more powerful OOP
- **Move semantics** — how C++ avoids unnecessary copying

### Recommended Resources
- **learncpp.com** — free, comprehensive, up-to-date, starts from zero
- **"Programming: Principles and Practice Using C++"** by Bjarne Stroustrup — written by the inventor of C++
- **cppreference.com** — the reference manual for the C++ standard library

### Next Projects
- **Tetris** — similar structure to Snake but more complex rotation and line-clearing logic
- **Breakout / Arkanoid** — introduces ball physics and collision angles
- **Pong** — build it from scratch *without* instructions and see how much you've learned
- **A tile-based RPG** — introduces maps, dialogue, and inventory

---

## 9.5 — Sharing Your Game

Want to share `snake.exe` with a friend?

The `.exe` needs the SFML DLLs to run. CMakeLists.txt already copies them into `build\` automatically. To share the game:

1. Create a new folder (e.g. `snake-game-release\`)
2. Copy `build\snake.exe` into it
3. Copy all `.dll` files from `build\` into it
4. Copy the `assets\` folder into it

Your friend can then run `snake.exe` from that folder without needing MSYS2 or SFML installed.

---

## 9.6 — Upload to GitHub

1. Create an account at **https://github.com** if you don't have one
2. Click **"New repository"**, give it a name, keep it public
3. Copy the commands GitHub shows you under "push an existing repository"
4. Open **Git Bash** (installed with Git for Windows) and run those commands from your project folder

Your `README.md` will display automatically on the repository page. Consider updating it to describe your *finished* game.

---

## 📝 Final Commit

```bash
git add .
git commit -m "Step 9: polish and final touches"
git push origin main
```

---

## You Did It

Building a game takes patience, problem-solving, and persistence. Every error message you decoded made you a better programmer. Every bug you fixed was a lesson.

The best programmers aren't the ones who never get stuck — they're the ones who know how to get unstuck.

Keep building things. 🚀
