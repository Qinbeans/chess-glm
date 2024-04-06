import gleam/erlang/process
<<<<<<< HEAD
import mist
import chess_glm/server.{router}
=======
import gleam/bytes_builder
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import mist.{type Connection, type ResponseData}
import routes/index
import routes/somewhere
import routes/not_found
import routes/static
import gleam/http
import request as local_request

pub fn main() {
  let _ = start_server()
  process.sleep_forever()
}

pub fn start_server() {
  let assert Ok(_) =
    router
    |> mist.new
    |> mist.port(3000)
    |> mist.start_http
}
