import gleam/erlang/process
import mist
import chess_glm/server.{router}

pub fn main() {
  let _ = start_server()
  process.sleep_forever()
}

/// Main entry point
pub fn start_server() {
  let assert Ok(_) =
    router
    |> mist.new
    |> mist.port(3000)
    |> mist.start_http
}
