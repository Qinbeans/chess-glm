import mist.{type Connection, type ResponseData}
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import chess_glm/layouts/base
import html_dsl/types/html.{br, button, div}
import html_dsl/types/attribute.{class}
import chess_glm/mist_dsl/engine

/// Renders the page for index
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
      "Chess GLM - Home",
      div(
        attribute.new()
          |> class("px-10"),
        "Extra power"
          <> br()
          <> button(
            attribute.new()
              |> attribute.add("hx-post", "/clickme")
              |> attribute.add("hx-trigger", "click")
              |> attribute.add("hx-swap", "outerHTML"),
            "Click me!",
          ),
      ),
    )
  case res {
    Ok(html) -> {
      engine.render_html(html, 200)
    }
    Error(err) -> {
      engine.render_error(err, 500)
    }
  }
}
