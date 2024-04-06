import { exec, spawn } from 'child_process'
import chokidar from 'chokidar'
import { config } from '../glew.config'

/**
 * Color constants for console output
 */
const C = {
    "R": "\x1b[31m",
    "G": "\x1b[32m",
    "Y": "\x1b[33m",
    "B": "\x1b[34m",
    "M": "\x1b[35m",
    "C": "\x1b[0m"
}

let is_running = false;
let processes_finished = 0;
let pid: number = -1;

/**
 * Check if the tools are installed
 */
const checkTools = () => {
    const tools = new Set()
    config.cmds.forEach(command => {
        const tool = command.split(' ')[0] + ' --version'
        // run the command with --version to check if the tool is installed
        exec(tool, (err, _stdout, stderr) => {
            if (err) {
                console.error(`<${C.R}Error${C.C}> ${err}`)
                console.error(`<${C.R}Error${C.C}> ${tool.split(' ')[0]} is not installed`)
                process.exit(1)
            }
            if (stderr) {
                console.error(`<${C.R}Error${C.C}> ${stderr}`)
                console.error(`<${C.R}Error${C.C}> ${command.split(' ')[0]} is not installed`)
                process.exit(1)
            }
            tools.add(command.split(' ')[0])
        })
    })
}

/**
 * Run the commands and restart the process
 */
const runCommands = () => {
    processes_finished = 0
    config.cmds.forEach(command => {
        exec(command, (err, stdout, stderr) => {
            if (err) {
                console.error(`<${C.R}Error${C.C}> ${err}`)
                processes_finished++
                return
            }
            if (stderr) {
                console.debug(`<${C.Y}Warning${C.C}> ${stderr}`)
                processes_finished++
                return
            }
            console.debug(stdout)
            console.debug(`<${C.G}Success${C.C}> \`${command}\` has been executed`)
            processes_finished++
        })
    })
    prerun()
}

// takes in some function
const kill = (func: () => void) => {
    if (is_running) {
        if (pid === -1) {
            console.error(`<${C.R}Error${C.C}> No running process to kill`)
            return
        }
        // replace $run_pid with the pid of the running process
        if (process.platform === 'win32') {
            console.debug(`<${C.M}Kill${C.C}> performing \`${config.kill.windows}\``)
            // get child processes of the running process
            const tasklist = `wmic process where (ParentProcessId=${pid}) get ProcessId`
            exec(tasklist, (err, stdout, _stderr) => {
                if (err) {
                    console.error(`<${C.R}Error${C.C}> ${err}`)
                    return
                }
                const pid = stdout.split('\n').slice(1).filter(Boolean)[0]
                console.debug(`<${C.M}Kill${C.C}>\tChild: ${pid}`)
                const kill = config.kill.windows.replace('$run_pid', pid.trim())
                exec(kill, (err, _stdout, _stderr) => {
                    if (err) {
                        console.error(`<${C.R}Error${C.C}> ${err}`)
                        return
                    }
                    console.debug(`<${C.G}Success${C.C}> \`${config.kill}\` has been executed`)
                })
                func()
            })
            return
        }
        console.debug(`<${C.M}Kill${C.C}> performing \`${config.kill.unix}\``)
        const kill = config.kill.unix.replace('$run_pid', pid.toString())
        exec(kill, (err, _stdout, _stderr) => {
            if (err) {
                console.error(`<${C.R}Error${C.C}> ${err}`)
                return
            }
            console.debug(`<${C.G}Success${C.C}> \`${config.kill}\` has been executed`)
            func()
        })
    } else {
        func()
    }
}

const prerun = () => {
    if (processes_finished < config.cmds.length) {
        setTimeout(prerun, 100)
        return
    }
    kill(run)
}

const run = () => {
    if (is_running) {
        setTimeout(run, 100)
        return
    }
    is_running = true
    const [command, ...args] = config.run.split(/\s+/);
    // block stdin but allow stdout and stderr to be inherited
    const gleam = spawn(command, args, { stdio: ['ignore', 'inherit', 'inherit'] })
    if (!gleam.pid) {
        console.error(`<${C.R}Error${C.C}> Failed to start \`${config.run}\``)
        process.exit(1)
    }
    pid = gleam.pid
    console.debug(`<${C.M}Launch${C.C}> \`${config.run}\` is ${pid}`)
    gleam.on('close', () => {
        is_running = false
    })
}

/**
 * Watch for file changes
 */
const watcher = chokidar.watch(config.watch, {
    ignored: config.ignore,
    persistent: true
})

// Watcher events: add, change, unlink
watcher
.on('add', path => {
    console.log(`<${C.B}Info${C.C}> ${path} has been added`)
})
.on('change', path => {
    console.log(`<${C.B}Info${C.C}> ${path} has been changed`)
    runCommands()
})
.on('unlink', path => {
    console.log(`<${C.B}Info${C.C}> ${path} has been removed`)
})

// intercept SIGINT and SIGTERM signals
process.on('SIGINT', () => {
    console.log(`<${C.M}Stop${C.C}> Watcher is stopping`)
    if (is_running) {
        kill(() => {
            watcher.close()
            process.exit(0)
        })
    }
    watcher.close()
    process.exit(0)
})

checkTools()
console.log(`<${C.M}Start${C.C}> Watcher is running`)
runCommands()