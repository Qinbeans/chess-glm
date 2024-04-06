import mist.{type Connection, type ResponseData}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/bytes_builder

/// Render a 404 response
pub fn render(_: Request(Connection)) -> Response(ResponseData) {
  response.new(404)
  |> response.set_body(mist.Bytes(bytes_builder.from_string("Not found")))
  |> response.set_header("Content-Type", "text/plain")
}
