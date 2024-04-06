/**
 * Glew Configuration
 * 
 * @interface GlewConfig
 */
export interface GlewConfig {
    watch: string[]
    cmds: string[]
    run: string
    kill: {
        unix: string
        windows: string
    }
    ignore?: RegExp // Optional: ignores regex pattern
}

/**
 * Default Glew Config
 * 
 * @type {GlewConfig}
 * @default
 * @constant
 */
export const DefaultGlewConfig: GlewConfig = {
    watch: [
        "src/**/*.gleam",
    ],
    cmds: [
        "gleam build",
    ],
    run: "gleam run",
    kill: {
        unix: "kill $(pgrep -P $run_pid)",
        windows: "taskkill /F /PID $run_pid",
    },
    ignore: /(^|[\/\\])\../ // Ignores hidden files
}