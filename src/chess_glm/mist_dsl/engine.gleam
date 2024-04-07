import gleam/bytes_builder
import html_dsl/types/html.{type Html, html_to_string}
import mist.{type ResponseData}
import gleam/http/response.{type Response}

// The DSL allows for data to be embedded in the HTML before reaching the engine
pub fn render_html(template: Html, code: Int) -> Response(ResponseData) {
  // HTML could be Html or Component which are the same type but aliased differently
  let html = html_to_string(template)
  response.new(code)
  |> response.set_header("Content-Type", "text/html")
  |> response.set_body(mist.Bytes(bytes_builder.from_string(html)))
}
