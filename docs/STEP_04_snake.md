# Step 4 — Designing the Snake Class

**Goal:** Learn about classes and objects by designing the data structure that represents the snake.

---

## Background: Classes and Objects

In C++, a **class** is a blueprint for creating objects. It bundles together:
- **Data** (called *member variables*) — the state of the object
- **Functions** (called *member functions* or *methods*) — things the object can do

You've already used a class: `sf::RenderWindow` is a class. You created an *object* (an instance) of it.

Now you'll design your own.

---

## 4.1 — Think Before You Code

Before writing a single line, answer these questions on paper or in a comment:

- How is the snake represented? (A list of positions? A list of squares?)
- What information does each segment need? (x position, y position)
- What does the snake need to *do*? (move, grow, draw itself, check collisions)
- What direction is the snake moving?

Take five minutes to sketch this out. Good programmers think before they type.

---

## 4.2 — Create the Header File

In VS Code, create a new file: `include\Snake.h`

A header file *declares* what a class looks like — its variables and function signatures — without defining how the functions work. The actual code goes in a `.cpp` file.

Start with **include guards** — these prevent the header from being included twice (a common source of confusing errors on Windows):

```cpp
#ifndef SNAKE_H
#define SNAKE_H

// ... your class goes here ...

#endif // SNAKE_H
```

---

## 4.3 — Include What You Need

Inside the guards, add:
- `#include <vector>` — you'll use `std::vector` to store the snake's segments
- `#include <SFML/Graphics.hpp>` — for drawing

---

## 4.4 — Define a Direction Enum

Before the class declaration, define an `enum class` for the four directions:

```cpp
enum class Direction { Up, Down, Left, Right };
```

An `enum class` is a type that can only hold one of those four named values. It's much safer than using raw integers (0, 1, 2, 3) — the compiler will catch mistakes.

---

## 4.5 — Write the Snake Class Declaration

Write a `class Snake` with:

**Public section** (`public:`):
- Constructor: `Snake(int startX, int startY)` — creates the snake at a grid position
- `void move()` — moves the snake one step in its current direction
- `void grow()` — makes the snake longer by one segment on the next move
- `void setDirection(Direction dir)` — changes the direction (but not to the opposite!)
- `void draw(sf::RenderWindow& window)` — draws all segments onto the window
- `bool hasCollidedWithSelf()` — returns `true` if the head overlaps any body segment
- `bool hasCollidedWithWall(int gridWidth, int gridHeight)` — returns `true` if head is out of bounds
- `sf::Vector2i getHeadPosition()` — returns the grid position of the head

**Private section** (`private:`):
- `std::vector<sf::Vector2i> m_segments` — each segment's grid position (x, y)
- `Direction m_direction` — current direction
- `bool m_shouldGrow` — flag: grow on the next move?

> **Naming convention:** Many C++ programmers prefix private member variables with `m_`. This makes it easy to tell apart local variables from class members. It's optional but a good habit.

---

## 4.6 — Create the Source File

Create `src\Snake.cpp`.

Include your own header at the top:
```cpp
#include "Snake.h"
```

Add **empty function bodies** for every method you declared. For example:

```cpp
Snake::Snake(int startX, int startY)
{
    // TODO
}

void Snake::move()
{
    // TODO
}
```

The `::` is the **scope resolution operator** — it says "this `move` belongs to the `Snake` class."

Don't implement anything yet — just get it to compile.

---

## 4.7 — Include Snake.h in main.cpp

Back in `src\main.cpp`, add:
```cpp
#include "Snake.h"
```

Create a `Snake` object somewhere before your game loop. Use a starting position near the middle of the grid. The grid is 20×20 cells, so `(10, 10)` is a good start.

---

## 4.8 — Rebuild

In your **MSYS2 MinGW 64-bit** terminal (inside `build\`):

```bash
mingw32-make
```

CMake will automatically detect the new `Snake.cpp` file because `CMakeLists.txt` uses `file(GLOB_RECURSE SOURCES "src/*.cpp")` — it picks up all `.cpp` files in `src\` automatically.

---

## ✅ Checkpoint

- [ ] `include\Snake.h` exists with a complete class declaration
- [ ] `src\Snake.cpp` exists with empty function stubs
- [ ] `main.cpp` includes `Snake.h` and creates a `Snake` object
- [ ] The project still compiles with no errors

---

## 🧠 Concepts Introduced

- **Class** — a user-defined type that bundles data and behaviour
- **Object / instance** — a concrete example of a class
- **Public / private** — access control; private members can only be touched inside the class
- **Header file (.h)** — declares what a class looks like
- **Source file (.cpp)** — defines how the class actually works
- **`std::vector`** — a resizable list from the standard library
- **`enum class`** — a type-safe set of named values
- **`sf::Vector2i`** — an SFML struct holding two integers (x, y)
- **Include guards** — prevent a header being processed twice

---

## 📝 Commit Your Work

```bash
git add .
git commit -m "Step 4: Snake class skeleton"
```

---

➡️ **Next:** [Step 5 — Movement & Input](STEP_05_movement.md)
