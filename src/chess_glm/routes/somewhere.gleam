import mist.{type Connection, type ResponseData}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import chess_glm/layouts/base
import html_dsl/types/html.{Attribute, br, button}
import html_dsl/types/id.{Id}
import html_dsl/types/class.{Class}
import chess_glm/mist_dsl/engine

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
    "This is somewhere!",
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
