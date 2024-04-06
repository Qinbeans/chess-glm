/** @type {import('tailwindcss').Config} */
module.exports = {
  content: {
    files: ['./src/chess_glm/routes/**/*.gleam', './src/chess_glm/components/**/*.gleam', './src/chess_glm/layouts/**/*.gleam'],
  },
  theme: {
    extend: {},
  },
  plugins: [],
}

