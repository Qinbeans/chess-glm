import { type GlewConfig, DefaultGlewConfig } from "./scripts/types";

// inherit DefaultGlewConfig
export const config: GlewConfig = {
    ...DefaultGlewConfig,
    watch: [
        "src/**/*.gleam",
        "app.css"
    ],
    cmds: [
        "pnpm tailwind -i app.css -o assets/styles/app.css",
    ],
}