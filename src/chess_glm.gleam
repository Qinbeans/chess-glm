import gleam/erlang/process
import gleam/bytes_builder
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import mist.{type Connection, type ResponseData}
import routes/index
import routes/somewhere
import routes/not_found
import routes/static
import gleam/http

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

fn router(req: Request(Connection)) -> Response(ResponseData) {
  let method = case req.method {
    http.Get -> "GET"
    http.Post -> "POST"
    http.Head -> "HEAD"
    http.Put -> "PUT"
    http.Delete -> "DELETE"
    http.Trace -> "TRACE"
    http.Connect -> "CONNECT"
    http.Options -> "OPTIONS"
    http.Patch -> "PATCH"
    _ -> "UNKNOWN"
  }
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
