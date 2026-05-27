# Assets Folder

Place your game assets here:

- **font.ttf** — required in Step 8. Download "Press Start 2P" from Google Fonts:
  https://fonts.google.com/specimen/Press+Start+2P
  Click "Download family", unzip the archive, and copy `PressStart2P-Regular.ttf`
  into this folder. Rename it to `font.ttf`.

- Any sound effects you add in Step 9 go here too (.wav or .ogg format works best with SFML).

The build system (CMakeLists.txt) automatically copies this entire folder into the
`build\` directory when you compile, so the running game can always find its files.
