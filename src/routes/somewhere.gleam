import mist.{type Connection, type ResponseData}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import layouts/base
import types/html.{Attribute, br, button}
import types/id.{Id}
import types/class.{Class}
import mist_dsl/engine

/// Render the page
pub fn render(req: Request(Connection)) -> Response(ResponseData) {
  let current = request.to_uri(req).path
  case request.get_header(req, "Hx-boosted") {
    Ok(_) -> True
    Error(_) -> False
  }
  |> base.base(
    current,
    _,
    "You are somewhere!"
      <> br()
      <> button(
        Id("click_me"),
        Class(""),
        [
          Attribute("hx-post", "/clickme"),
          Attribute("hx-trigger", "click"),
          Attribute("hx-swap", "outerHTML"),
        ],
        "Click me!",
      ),
  )
  |> engine.render_html(200)
}
