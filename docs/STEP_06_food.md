# Step 6 — Food

**Goal:** Create a Food class that spawns at random positions and is eaten by the snake.

---

## 6.1 — Create the Food Class

Create `include\Food.h` and `src\Food.cpp`.

The `Food` class needs to:
- Store its grid position (`sf::Vector2i`)
- Spawn at a random position
- Draw itself (as a circle — looks different from the square snake)

**Header — what to declare (write this as real C++):**

```
class Food:
    public:
        Food(int gridWidth, int gridHeight)
        void respawn(int gridWidth, int gridHeight)
        void draw(sf::RenderWindow& window)
        sf::Vector2i getPosition()
    private:
        sf::Vector2i m_position
        int m_gridWidth
        int m_gridHeight
        // + a random number generator (see section 6.2)
```

Don't forget include guards and the necessary `#include` lines at the top.

---

## 6.2 — Random Numbers in C++

To place food at a random position, use the modern C++ `<random>` header. The old `rand()` function is unreliable — avoid it.

```cpp
#include <random>

// A random engine — seeded with actual hardware randomness
std::mt19937 rng(std::random_device{}());

// A distribution: gives integers from 0 to gridWidth - 1
std::uniform_int_distribution<int> distX(0, gridWidth - 1);
std::uniform_int_distribution<int> distY(0, gridHeight - 1);

// Generate a random number
int x = distX(rng);
int y = distY(rng);
```

**Important:** Store `rng` as a **private member variable** in the `Food` class (type `std::mt19937`). If you create a new engine every time `respawn()` is called, you risk getting the same sequence every time. Keeping it as a member means it stays "warm" between calls.

Implement `Food::respawn()` using the above technique to set `m_position`.

---

## 6.3 — Draw the Food

Use `sf::CircleShape` so it looks visually distinct from the square snake segments.

`sf::CircleShape circle(radius)` — a radius of **14** fits nicely inside a 32-pixel cell.

Set a bright colour: red (`sf::Color::Red`) or yellow (`sf::Color(255, 220, 0)`) works well.

To position the circle inside its grid cell, set its position using a `sf::Vector2f`:
```cpp
circle.setPosition({m_position.x * 32.f + 1.f, m_position.y * 32.f + 1.f});
```

(Adjust the offset to taste.)

> **SFML 3 note:** Like `sf::RectangleShape`, all SFML 3 `setPosition` calls take a `sf::Vector2f` using the `{x, y}` brace syntax. The two-argument form `setPosition(x, y)` was removed in SFML 3.

---

## 6.4 — Connect Food to main.cpp

In `main.cpp`:
1. `#include "Food.h"`
2. Add constants `GRID_WIDTH` and `GRID_HEIGHT` (both **20**) before `main()`
3. Create a `Food food(GRID_WIDTH, GRID_HEIGHT)` object before the game loop
4. In the draw section, call `food.draw(window)`

Rebuild and run — you should see a food circle somewhere on the grid!

---

## 6.5 — Detecting When the Snake Eats

In the timed update block (after calling `snake.move()`), check:

```
if snake head position == food position:
    snake.grow()
    food.respawn(GRID_WIDTH, GRID_HEIGHT)
```

Use `snake.getHeadPosition()` to get the head. Two `sf::Vector2i` values can be compared with `==`.

---

## 6.6 — Implement `getHeadPosition()` (if not done yet)

In `Snake.cpp`, this should return `m_segments[0]`.

What should happen if `m_segments` is empty? Add a comment about this edge case — in practice it won't happen, but thinking about it is good programming discipline.

---

## Checkpoint

- [ ] A food circle appears on screen
- [ ] When the snake reaches it, the snake grows by one segment
- [ ] New food appears at a random position after being eaten
- [ ] Food always appears within the grid (never off-screen)

---

## Concepts Introduced

- **`std::mt19937`** — a high-quality pseudo-random number generator
- **`std::random_device`** — generates an unpredictable seed (uses hardware entropy on Windows)
- **`std::uniform_int_distribution`** — converts raw random numbers into integers in a given range
- **`sf::CircleShape`** — an SFML drawable circle
- **Multiple source files** — your project now has `Snake.cpp` and `Food.cpp`; CMake finds them automatically via `GLOB_RECURSE`

---

## Experiment

- **Food in the snake's body** — what happens if food spawns inside the snake? This is a real bug. How would you fix it? (Hint: loop and regenerate the position until it doesn't overlap any segment.)
- **Pulsing food** — can you make it grow and shrink slightly over time using `sf::Clock`?

---

## Commit Your Work

```bash
git add .
git commit -m "Step 6: food spawning and eating"
```

---

➡️ **Next:** [Step 7 — Collision Detection](STEP_07_collision.md)
