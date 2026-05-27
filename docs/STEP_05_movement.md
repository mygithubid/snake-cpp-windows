# Step 5 — Movement & Input

**Goal:** Implement the snake's movement logic and respond to keyboard input.

---

## 5.1 — Plan the Movement Algorithm

Before coding, think through how a snake moves on a grid:

1. The **head** moves one cell in the current direction
2. Each other segment moves to where the segment *in front of it* was
3. If the snake is growing, a new segment is added instead of removing the tail

The elegant trick: you don't need to shift every segment. Just:
- **Insert** a new head at the front of `m_segments`
- **Remove** the last element from the back (unless growing)

Write this algorithm out in plain English (or pseudocode) as a comment before you implement it.

---

## 5.2 — Implement the Constructor

The constructor should:
1. Set `m_direction` to `Direction::Right`
2. Set `m_shouldGrow` to `false`
3. Push the starting position and two body segments onto `m_segments`

Start with head at `(startX, startY)`, then one body segment at `(startX - 1, startY)`, then a tail at `(startX - 2, startY)`.

To add an element to the back of a vector: `m_segments.push_back(sf::Vector2i(x, y));`

---

## 5.3 — Implement `move()`

Calculate the new head position based on `m_direction`:
- `Up`    → y decreases by 1
- `Down`  → y increases by 1
- `Left`  → x decreases by 1
- `Right` → x increases by 1

Then:
1. **Insert** the new head at the *front*: `m_segments.insert(m_segments.begin(), newHead);`
2. **Check** `m_shouldGrow`:
   - If `true`: set it to `false` (the extra segment is already there — you just didn't remove the tail)
   - If `false`: remove the tail with `m_segments.pop_back();`

---

## 5.4 — Implement `grow()`

Simply set `m_shouldGrow = true;`.

Growth happens on the next `move()` call.

---

## 5.5 — Implement `setDirection()`

Change `m_direction` — but reject reversal. If the new direction is the *opposite* of the current one, return early and do nothing.

Opposites:
- `Up` ↔ `Down`
- `Left` ↔ `Right`

Use an `if` statement with the `&&` (AND) or `||` (OR) operator.

---

## 5.6 — Implement `draw()`

The game board is a grid of cells, each **32×32 pixels**. A segment at grid position `(gx, gy)` sits at pixel position `(gx * 32, gy * 32)`.

For each segment:
1. Create an `sf::RectangleShape` of size `(30.f, 30.f)` — slightly smaller than 32 to leave a 1-pixel gap
2. Set its position with `shape.setPosition(segment.x * 32.f, segment.y * 32.f)`
3. Set its colour — **make the head a different colour** from the body
4. Call `window.draw(shape)`

To know which is the head, you can either use an index-based loop and check `i == 0`, or handle the head separately.

**Range-based for loop syntax:**
```cpp
for (const auto& segment : m_segments) {
    // segment.x and segment.y
}
```

---

## 5.7 — Implement `getHeadPosition()`

Return `m_segments[0]`. You'll use this in Steps 6 and 7 to check for eating food and collision.

---

## 5.8 — Handle Keyboard Input in main.cpp

In your event polling loop, add a case for `sf::Event::KeyPressed`.

Check `event.key.code` against SFML key constants and call `snake.setDirection(...)`:

| Key pressed | Direction to set |
|-------------|-----------------|
| `sf::Keyboard::Up` or `sf::Keyboard::W` | `Direction::Up` |
| `sf::Keyboard::Down` or `sf::Keyboard::S` | `Direction::Down` |
| `sf::Keyboard::Left` or `sf::Keyboard::A` | `Direction::Left` |
| `sf::Keyboard::Right` or `sf::Keyboard::D` | `Direction::Right` |

---

## 5.9 — Connect to the Game Loop

In your timed update block (from Step 3), call `snake.move()`.

In your draw section (between `clear()` and `display()`), call `snake.draw(window)`.

---

## 5.10 — Rebuild and Test

```bash
mingw32-make
.\snake.exe
```

Or double-click `snake.exe` in File Explorer.

---

## ✅ Checkpoint

- [ ] The snake appears on screen as coloured squares
- [ ] The head is a different colour from the body
- [ ] Arrow keys (and WASD) change the direction
- [ ] The snake can't reverse direction
- [ ] The snake moves at the fixed interval from Step 3

---

## 🧠 Concepts Introduced

- **`std::vector` operations** — `push_back`, `pop_back`, `insert`, `begin`
- **Range-based for loop** — `for (const auto& item : collection)`
- **`auto`** — the compiler deduces the type for you
- **`const` reference** — `const auto&` avoids copying each element
- **`sf::RectangleShape`** — an SFML drawable rectangle
- **Keyboard events** — `sf::Event::KeyPressed` and `sf::Keyboard` key codes

---

## 💡 Experiment

- Make the cell size smaller (32 → 16). What else do you need to change?
- Can you make the snake's colour gradually shift from head to tail?
- Try different `MOVE_INTERVAL` values — how does it feel at 80ms? 300ms?

---

## 📝 Commit Your Work

```bash
git add .
git commit -m "Step 5: snake movement and keyboard input"
```

---

➡️ **Next:** [Step 6 — Food](STEP_06_food.md)
