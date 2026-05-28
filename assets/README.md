# Assets Folder

Place your game assets here:

- **font.ttf** — required in Step 8. Download "Press Start 2P" from Google Fonts:
  https://fonts.google.com/specimen/Press+Start+2P
  Click "Download family", unzip the archive, and copy `PressStart2P-Regular.ttf`
  into this folder. Rename it to `font.ttf`.

- Any sound effects you add in Step 9 go here too. SFML 3 works best with **.wav** or **.ogg** files.
  Avoid .mp3 — SFML does not support it.

The build system (CMakeLists.txt) automatically copies this entire folder into the
`build\` directory when you compile, so the running game can always find its files.
If your font or sounds aren't being found at runtime, run `mingw32-make` once more
to trigger the copy step.
