# chess_glm

[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://qinbeans.github.io/chess-glm/)
[![test](https://github.com/Qinbeans/chess-glm/actions/workflows/test.yml/badge.svg)](https://github.com/Qinbeans/chess-glm/actions/workflows/test.yml)

Reimplementation of my [chess-htmx](https://github.com/Qinbeans/chess-htmx) project in Gleam. The original project was written in Go and used the [htmx](https://htmx.org/) library to create a web-based chess game.

This uses my DSL library [html-dsl](https://github.com/Qinbeans/html-dsl) to generate HTML.

```sh
gleam add chess_glm
```

Further documentation can be found at <https://qinbeans.github.io/chess-glm/>.

## Development

```sh
gleam run       # Run the project
gleam test      # Run the tests
gleam shell     # Run an Erlang shell

# some project specific commands
pnpm dev        # Run the development server with live reload
pnpm build      # Build the project
pnpm build:docs # Run the tests
```
