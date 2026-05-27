# Step 3 — The Game Loop & Timing

**Goal:** Understand how games update over time, and make the snake move at a fixed speed regardless of how fast the computer is.

---

## Background: How Games Work

Every game — from Pong to Elden Ring — follows the same basic loop:

```
while (game is running):
    1. Handle input
    2. Update game state
    3. Draw everything
```

This runs many times per second. Each pass through the loop is one **frame**.

The problem: computers run at different speeds. A fast PC might loop 1000 times per second. A slow one might only manage 30. If the snake moves one cell per frame, it would zoom on a fast machine and crawl on a slow one.

The solution: **delta time** — measure how long each frame took and use that to control speed.

---

## 3.1 — Plan Your Update Timing

For Snake, we don't want smooth per-frame movement. We want the snake to move once every fixed interval (e.g. every 150 milliseconds). This is called a **tick**.

You'll use SFML's `sf::Clock` to measure elapsed time.

---

## 3.2 — Create a Clock

Before your game loop, create an `sf::Clock` object:
```cpp
sf::Clock clock;
```

Also create a variable to track accumulated time. SFML uses `sf::Time` for this. A good name is `timeSinceLastMove`, initialised to zero:
```cpp
sf::Time timeSinceLastMove = sf::Time::Zero;
```

---

## 3.3 — Accumulate Time Inside the Loop

At the start of each loop iteration, get the time since you last called `clock.restart()`. This method returns the elapsed time *and* resets the clock. Add the result to your accumulator:

```cpp
timeSinceLastMove += clock.restart();
```

---

## 3.4 — Define a Move Interval

Create a constant that represents how often the snake moves. A good starting value is 150 milliseconds:

```cpp
const sf::Time MOVE_INTERVAL = sf::milliseconds(150);
```

Put constants near the top of `main.cpp`, before `main()`.

---

## 3.5 — Only Update When Enough Time Has Passed

Inside the loop, use an `if` statement to check whether enough time has accumulated:

```cpp
if (timeSinceLastMove >= MOVE_INTERVAL) {
    // TODO: update the snake's position
    timeSinceLastMove = sf::Time::Zero;   // reset accumulator
}
```

Right now the update block is empty — you'll fill it in Step 5.

---

## 3.6 — Sketch the Final Loop Structure

Your loop should now look roughly like this (pseudocode):

```
while window is open:
    timeSinceLastMove += clock.restart()

    poll events:
        if Closed:     close window
        if KeyPressed: (handle in Step 5)

    if timeSinceLastMove >= MOVE_INTERVAL:
        update snake   ← empty for now
        reset accumulator

    window.clear()
    // draw things here  ← empty for now
    window.display()
```

Make sure your actual code matches this structure before moving on.

---

## 3.7 — Rebuild After Changes

Every time you change a `.cpp` file, go to your **MSYS2 MinGW 64-bit** terminal and run:

```bash
mingw32-make
```

from inside the `build\` folder. CMake only needs to be re-run if you add *new files* to the project.

---

## ✅ Checkpoint

- [ ] My game loop has a clock and an accumulator
- [ ] There's a `MOVE_INTERVAL` constant
- [ ] The "update" block only runs when enough time has passed
- [ ] The program still compiles and the window still opens

---

## 🧠 Concepts Introduced

- **Game loop** — the core pattern of every game: input → update → draw
- **Delta time / accumulator** — measuring elapsed time to decouple game speed from hardware speed
- **`const`** — declares a value that should never change
- **`sf::Clock`** — SFML's timer class
- **`sf::Time`** — SFML's time value type

---

## 💡 Experiment

- Try changing `MOVE_INTERVAL` to `sf::milliseconds(50)` and `sf::milliseconds(500)`. Come back and notice the difference after Step 5 when the snake is visible.

---

## 📝 Commit Your Work

```bash
git add .
git commit -m "Step 3: game loop with timing"
```

---

➡️ **Next:** [Step 4 — The Snake Class](STEP_04_snake.md)
