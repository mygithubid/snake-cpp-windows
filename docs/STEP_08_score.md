# Step 8 — Score & Text Rendering

**Goal:** Display the score on screen and show a "Game Over" message with the final score.

---

## 8.1 — Download a Font

SFML can't render text without a font file. A great choice for a retro game is **"Press Start 2P"** — a pixel-art style font.

**How to get it on Windows:**
1. Go to: https://fonts.google.com/specimen/Press+Start+2P
2. Click the **"Download family"** button (top right)
3. Unzip the downloaded file
4. Copy `PressStart2P-Regular.ttf` into your project's `assets\` folder
5. Rename it to `font.ttf`

The CMakeLists.txt already copies the `assets\` folder into `build\` automatically when you compile, so `snake.exe` will always find it.

---

## 8.2 — Load the Font in main.cpp

In SFML 3, fonts are loaded with `sf::Font::openFromFile`, which returns a `std::optional<sf::Font>`. Declare the font and load it **before** the game loop:

```cpp
auto fontResult = sf::Font::openFromFile("assets/font.ttf");
if (!fontResult) {
    // If this fails, the game can't show any text.
    return -1;
}
sf::Font& font = *fontResult;
```

> **Always check whether file loading succeeds.** Forgetting this is one of the most common beginner mistakes — it causes mysterious crashes that are hard to debug. If `fontResult` is empty (the optional has no value), the font file wasn't found.

> **SFML 3 note:** In SFML 3, the old `font.loadFromFile(...)` member function was replaced by `sf::Font::openFromFile(...)`, a static factory function that returns a `std::optional<sf::Font>`. Check the optional before using the font.

Note: Even on Windows, use forward slashes (`/`) in SFML file paths. SFML handles this correctly.

---

## 8.3 — Track the Score

Add `int score = 0;` before the game loop.

Each time the snake eats food, increment it:
```cpp
score++;
```

When the player restarts (presses R), reset it:
```cpp
score = 0;
```

---

## 8.4 — Display the Live Score

In SFML 3, `sf::Text` requires you to pass the font at construction time — there is no default constructor. Create the text object once before the game loop:

```cpp
sf::Text scoreText(font, "", 20);
scoreText.setFillColor(sf::Color::White);
scoreText.setPosition({10.f, 10.f});
```

Inside the draw section, update the displayed string and draw it:

```cpp
scoreText.setString("Score: " + std::to_string(score));
window.draw(scoreText);
```

`std::to_string()` converts an integer into a `std::string`. Include `<string>` at the top of `main.cpp` if you get a compile error about it.

> **SFML 3 note:** In SFML 3, `sf::Text(font, string, characterSize)` replaces the old pattern of creating a default `sf::Text` and calling `setFont`. The font must be passed in the constructor.

---

## 8.5 — Display "Game Over" Text

When `gameOver` is true, show two pieces of text:

1. A large **"GAME OVER"** heading (character size ~48)
2. A smaller line with the score and **"Press R to restart"** (character size ~20)

**Centring text on screen:**

SFML text is positioned by its top-left corner by default. To centre it, use `getLocalBounds()` to find its size and then set the origin to its centre.

In SFML 3, `sf::FloatRect` uses `.position` and `.size` fields instead of the SFML 2 `.left`/`.top`/`.width`/`.height` fields:

```cpp
sf::FloatRect bounds = myText.getLocalBounds();
myText.setOrigin({bounds.position.x + bounds.size.x / 2.f,
                  bounds.position.y + bounds.size.y / 2.f});
myText.setPosition({320.f, 280.f});   // centre of 640×640 window
```

Do this every time you update the string, because the text dimensions change when the content changes.

Draw these texts inside the `if (gameOver)` block, **after** the dark overlay rectangle so they appear on top.

---

## 8.6 — (Optional) High Score

Add `int highScore = 0;` before the loop. When the game ends:

```cpp
if (score > highScore)
    highScore = score;
```

Display the high score alongside the current score, both during gameplay and on the game over screen.

---

## 8.7 — Rebuild and Test

```bash
mingw32-make
.\snake.exe
```

Confirm the score goes up as food is eaten, and the game over screen shows the final score.

> **Troubleshooting:** If the text doesn't appear and you see a black screen or instant crash, the font file probably wasn't found. Check that `build\assets\font.ttf` exists. If not, the `POST_BUILD` copy step in CMakeLists.txt may not have run — try running `mingw32-make` again after placing the font in `assets\`.

---

## Checkpoint

- [ ] The score appears top-left during gameplay and increases when food is eaten
- [ ] "GAME OVER" text appears when the game ends
- [ ] The final score is shown on the game over screen
- [ ] "Press R to restart" is displayed and works

---

## Concepts Introduced

- **`sf::Font`** — loads a font file from disk; in SFML 3, use `sf::Font::openFromFile`
- **`std::optional<T>`** — a type that either holds a value or is empty; used for fallible operations
- **`sf::Text`** — renders text to the screen; in SFML 3, requires a font in the constructor
- **`std::to_string()`** — converts numbers to strings
- **String concatenation** — joining strings with `+`
- **`getLocalBounds()` / `setOrigin()`** — centring text
- **`sf::FloatRect`** — a rectangle described by `.position` (top-left) and `.size`

---

## Experiment

- Can you make the score text briefly flash green when it increases?
- What if the game sped up every 5 points? (Decrease `MOVE_INTERVAL` at score milestones)
- Try a different font — Google Fonts has hundreds of free `.ttf` files

---

## Commit Your Work

```bash
git add .
git commit -m "Step 8: score display and game over screen"
```

---

➡️ **Next:** [Step 9 — Polish & Ideas](STEP_09_polish.md)
