import gleam/bytes_builder
import types/html.{type Html, Component, Html}
import mist.{type ResponseData}
import gleam/http/response.{type Response}

// The DSL allows for data to be embedded in the HTML before reaching the engine
pub fn render_html(template: Html, code: Int) -> Response(ResponseData) {
  // HTML could be Html or Component which are the same type but aliased differently
  let html = case template {
    Html(html) -> html
    Component(component) -> component
  }
  response.new(code)
  |> response.set_header("Content-Type", "text/html")
  |> response.set_body(mist.Bytes(bytes_builder.from_string(html)))
}
