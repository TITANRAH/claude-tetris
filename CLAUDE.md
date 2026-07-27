# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Vanilla JavaScript implementation of Tetris using HTML5 Canvas. No build step, no bundler, no dependencies, no `package.json` — the game runs directly from static files.

## Running the game

There is no build/lint/test tooling. To run:

```bash
open index.html                # macOS, opens directly
# or serve statically:
python3 -m http.server 8000
npx serve .
```

Then visit `http://localhost:8000` if using a server. Verifying changes means opening the game in a browser and playing it — there are no automated tests.

## Architecture

Three files, no modules: `index.html` loads `style.css` and `game.js` (a single classic script, `'use strict'`, no imports/exports). All game logic lives in `game.js` as top-level functions operating on module-level `let` state (`board`, `current`, `next`, `score`, `lines`, `level`, `paused`, `gameOver`, `dropInterval`, etc.) — there are no classes and no encapsulation, so any function can read/mutate global state directly.

Key pieces in `game.js`:

- **Board model**: `ROWS × COLS` matrix (`board[r][c]`), each cell is `0` (empty) or a color index `1–7` identifying the piece that occupies it.
- **Pieces**: `PIECES` array of square matrices (index 0 unused, 1–7 = I/O/T/S/Z/J/L). Rotation is computed on the fly via `rotateCW` (transpose + reverse rows), not pre-stored rotation states.
- **Collision** (`collide`): checks board bounds and overlap with locked cells for a given shape/offset.
- **Wall kicks** (`tryRotate`): after rotating, tries offsets `[0, -1, 1, -2, 2]` until one doesn't collide, else the rotation is discarded.
- **Game loop** (`loop`): driven by `requestAnimationFrame`, accumulates elapsed time in `dropAccum` and advances the piece one row once `dropInterval` is exceeded; otherwise calls `lockPiece()`.
- **Line clearing** (`clearLines`): scans bottom-to-top, splices out full rows and unshifts empty ones at the top; updates score/level/`dropInterval`.
- **Scoring**: `LINE_SCORES = [0, 100, 300, 500, 800]` multiplied by `level`; hard drop adds 2 pts/row dropped, soft drop adds 1 pt/row.
- **Leveling/speed**: level = `floor(lines / 10) + 1`; `dropInterval = max(100, 1000 - (level - 1) * 90)` ms.
- **Ghost piece** (`ghostY`): projects the current piece straight down to its landing row; drawn with `globalAlpha = 0.2`.
- **Rendering**: `draw()` redraws the whole board canvas every frame (grid, locked cells, ghost, current piece); `drawNext()` renders the preview canvas for `next`. No dirty-rect optimization.

Control flow: `init()` builds a fresh board/state and kicks off `requestAnimationFrame(loop)`. `spawn()` promotes `next` to `current` and generates a new `next`; if the newly spawned piece immediately collides, `endGame()` fires and shows the Game Over overlay. `keydown` listener handles movement/rotation/drop/pause; `KeyP` toggles pause independent of the `paused`/`gameOver` guard that blocks other input.

## Tunable constants (top of `game.js`)

`COLS`, `ROWS`, `BLOCK` (cell size in px), `COLORS`, `LINE_SCORES`, initial `dropInterval`. If `COLS`/`ROWS`/`BLOCK` change, the `#board` canvas `width`/`height` in `index.html` must be updated to match (`COLS × BLOCK`, `ROWS × BLOCK`).

## Language

The README and in-game UI/comments are in Spanish (`lang="es"`); match this when adding user-facing text or documentation.

Todas las respuestas al usuario en el chat deben ser siempre en español, incluso cuando esté activo algún skill de compresión de estilo (p. ej. `/caveman`). Esos skills solo comprimen la forma (tono, longitud, gramática), nunca deben cambiar el idioma de respuesta.
