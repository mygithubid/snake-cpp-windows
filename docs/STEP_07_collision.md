# Step 7 — Collision Detection & Game Over

**Goal:** End the game when the snake hits a wall or its own body.

---

## 7.1 — Implement `hasCollidedWithWall()`

In `Snake.cpp`, implement this method.

It returns `true` if the head's grid position is outside the valid area.

Valid positions: `x` in `[0, gridWidth - 1]` and `y` in `[0, gridHeight - 1]`.

Return `true` if **any** of these are true:
- `head.x < 0`
- `head.x >= gridWidth`
- `head.y < 0`
- `head.y >= gridHeight`

Use the **logical OR** operator `||` to combine them. Use `&&` to make sure all conditions are checked in one `return` statement.

---

## 7.2 — Implement `hasCollidedWithSelf()`

Check if the head overlaps any *other* segment.

Get the head (`m_segments[0]`). Loop through segments starting at index **1**. If any matches the head, return `true`. If the loop finishes, return `false`.

Use `size_t` as your index type:
```cpp
for (size_t i = 1; i < m_segments.size(); ++i) {
    // ...
}
```

(`size_t` is the correct type for container indices — it's an unsigned integer.)

---

## 7.3 — Add a Game State Variable

In `main.cpp`, add before the game loop:
```cpp
bool gameOver = false;
```

After calling `snake.move()` in the timed update block, check for collisions:

```cpp
if (snake.hasCollidedWithWall(GRID_WIDTH, GRID_HEIGHT) ||
    snake.hasCollidedWithSelf()) {
    gameOver = true;
}
```

Wrap the entire timed update block in `if (!gameOver) { ... }` so the snake stops moving when the game is over.

---

## 7.4 — Draw a Game Over Overlay

When `gameOver` is true, draw a semi-transparent dark rectangle over the whole window. This signals to the player that the game has ended.

After drawing the snake:
```cpp
if (gameOver) {
    sf::RectangleShape overlay(sf::Vector2f(640.f, 640.f));
    overlay.setFillColor(sf::Color(0, 0, 0, 150));  // black, 150/255 opacity
    window.draw(overlay);
}
```

The fourth value in `sf::Color(r, g, b, a)` is **alpha**: 0 = fully transparent, 255 = fully opaque.

---

## 7.5 — Restarting the Game

Handle the **R** key in your event polling to restart:

```cpp
if (event.key.code == sf::Keyboard::R && gameOver) {
    snake = Snake(GRID_WIDTH / 2, GRID_HEIGHT / 2);
    food  = Food(GRID_WIDTH, GRID_HEIGHT);
    gameOver = false;
}
```

Your `snake` and `food` objects must be declared *before* the game loop (not inside it) so they can be reassigned here. You can reassign any object with `=` as long as its class supports it (which yours does by default).

---

## 7.6 — Rebuild and Test

```bash
mingw32-make
.\snake.exe
```

Drive the snake into a wall or into itself and confirm the game freezes. Press R to restart.

---

## ✅ Checkpoint

- [ ] The game stops when the snake hits a wall
- [ ] The game stops when the snake hits its own body
- [ ] A dark overlay appears on the screen when the game is over
- [ ] Pressing R restarts the game from scratch

---

## 🧠 Concepts Introduced

- **Boolean logic** — `&&` (AND), `||` (OR), `!` (NOT)
- **`size_t`** — the unsigned integer type for container sizes and indices
- **Game state** — a variable that tracks what "mode" the game is in (playing, game over)
- **Alpha channel** — the opacity component of a colour; `sf::Color(r, g, b, alpha)`
- **Object reassignment** — replacing an existing object with a freshly constructed one using `=`

---

## 💡 Experiment

- **Wall wrapping:** Instead of dying at the wall, could you make the snake reappear on the opposite side? (Hint: use the modulo `%` operator on the head position after moving.)
- Can you display different messages depending on *how* the snake died — wall or self?

---

## 📝 Commit Your Work

```bash
git add .
git commit -m "Step 7: collision detection and game over"
```

---

➡️ **Next:** [Step 8 — Score & Text](STEP_08_score.md)
