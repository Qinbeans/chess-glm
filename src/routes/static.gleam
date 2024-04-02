import mist.{type Connection, type ResponseData}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/string
import gleam/list
import routes/not_found
import gleam/option.{None}
import gleam/result
import gleam/io

pub fn serve_static(
  req: Request(Connection),
  path: String,
) -> Response(ResponseData) {
  case string.split(path, "/") {
    ["", "assets", ..rest] -> {
      let asset_path =
        list.append(["assets"], rest)
        |> string.join("/")
      mist.send_file(asset_path, offset: 0, limit: None)
      |> result.map(fn(file) {
        let content_type = guess_content_type(asset_path)
        response.new(200)
        |> response.set_header("Content-Type", content_type)
        |> response.set_body(file)
      })
      |> result.lazy_unwrap(fn() {
        io.println("Failed to serve asset: " <> asset_path)
        not_found.render(req)
      })
    }
    _ -> {
      io.println("Unknown path: " <> path)
      not_found.render(req)
    }
  }
}

fn guess_content_type(file_path: String) -> String {
  case string.split(file_path, ".") {
    [_, "css"] -> "text/css"
    [_, "js"] -> "application/javascript"
    [_, "html"] -> "text/html"
    [_, "png"] -> "image/png"
    [_, "jpg"] -> "image/jpeg"
    [_, "jpeg"] -> "image/jpeg"
    [_, "gif"] -> "image/gif"
    [_, "svg"] -> "image/svg+xml"
    _ -> "text/plain"
  }
}
