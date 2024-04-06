import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import mist.{type Connection, type ResponseData}
import chess_glm/method.{get_method}
import chess_glm/routes/index
import chess_glm/routes/somewhere
import chess_glm/routes/not_found
import chess_glm/routes/static
import gleam/bytes_builder

pub fn router(req: Request(Connection)) -> Response(ResponseData) {
  let method = get_method(req)
  case [request.to_uri(req).path, method] {
    ["/", "GET"] -> index.render(req)
    ["/somewhere", "GET"] -> somewhere.render(req)
    ["/clickme", "POST"] -> {
      response.new(200)
      |> response.set_body(mist.Bytes(bytes_builder.from_string("Clicked!")))
      |> response.set_header("Content-Type", "text/plain")
    }
    [path, "GET"] -> static.serve_static(req, path)
    _ -> not_found.render(req)
  }
}
