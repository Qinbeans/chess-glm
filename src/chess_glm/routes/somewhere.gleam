import mist.{type Connection, type ResponseData}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import chess_glm/layouts/base
import html_dsl/types/html.{br, button}
import html_dsl/types/attribute.{add, id}
import chess_glm/mist_dsl/engine
import gleam/option.{None}

/// Render the page
pub fn render(req: Request(Connection)) -> Response(ResponseData) {
  let current = request.to_uri(req).path
  let res =
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
          id(None, "click_me")
            |> add("hx-post", "/clickme")
            |> add("hx-trigger", "click")
            |> add("hx-swap", "outerHTML"),
          "Click me!",
        ),
    )
  case res {
    Ok(html) -> engine.render_html(html, 200)
    Error(err) -> engine.render_error(err, 500)
  }
}
