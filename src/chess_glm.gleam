import types/html.{
  Attribute, Component, a, body, br, button, head, header, html, meta, nav,
  script, section, span, title,
}
import types/id.{Id}
import types/class.{Class}
import mist_dsl/engine
import gleam/bytes_builder
import gleam/erlang/process
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import mist.{type Connection, type ResponseData}

pub fn main() {
  let _ = start_server()
  process.sleep_forever()
}

pub fn start_server() {
  let assert Ok(_) =
    fn(req: Request(Connection)) -> Response(ResponseData) {
      case request.to_uri(req).path {
        "/" -> render_index(req)
        "/somewhere" -> render_somewhere(req)
        "/clickme" -> {
          response.new(200)
          |> response.set_body(
            mist.Bytes(bytes_builder.from_string("Clicked!")),
          )
          |> response.set_header("Content-Type", "text/plain")
        }
        _ -> render_not_found(req)
      }
    }
    |> mist.new
    |> mist.port(3000)
    |> mist.start_http
}

fn render_not_found(_: Request(Connection)) -> Response(ResponseData) {
  response.new(404)
  |> response.set_body(mist.Bytes(bytes_builder.from_string("Not found")))
  |> response.set_header("Content-Type", "text/plain")
}

fn render_index(req: Request(Connection)) -> Response(ResponseData) {
  let current = request.to_uri(req).path
  case request.get_header(req, "Hx-boosted") {
    Ok(_) ->
      Component(
        header(
          Id("header"),
          Class("header"),
          [],
          nav(
            Id("nav"),
            Class("nav"),
            [],
            case current {
                "/" -> span(Id("current"), Class("nav-link"), [], "Home")
                _ -> a(Id("home"), Class("nav-link"), "/", [], "Home")
              }
              <> case current {
                "/somewhere" ->
                  span(Id("current"), Class("nav-link"), [], "Somewhere")
                _ ->
                  a(
                    Id("somewhere"),
                    Class("nav-link"),
                    "/somewhere",
                    [],
                    "Somewhere",
                  )
              },
          ),
        )
        <> section(
          Id("content"),
          Class("content"),
          [],
          button(
            Id("click_me"),
            Class("click-me"),
            [
              Attribute("hx-get", "/clickme"),
              Attribute("hx-trigger", "click"),
              Attribute("hx-swap", "outerHTML"),
            ],
            "Click me!",
          ),
        ),
      )
    Error(_) ->
      html(
        "en",
        head([
            meta("viewport", "width=device-width, initial-scale=1"),
            title("Hello, Gleam!"),
            script("https://unpkg.com/htmx.org@1.9.11"),
          ])
          <> body(
            Id("main_content"),
            Class("container"),
            [],
            header(
                Id("header"),
                Class("header"),
                [],
                nav(
                  Id("nav"),
                  Class("nav"),
                  [],
                  case current {
                      "/" -> span(Id("current"), Class("nav-link"), [], "Home")
                      _ -> a(Id("home"), Class("nav-link"), "/", [], "Home")
                    }
                    <> case current {
                      "/somewhere" ->
                        span(Id("current"), Class("nav-link"), [], "Somewhere")
                      _ ->
                        a(
                          Id("somewhere"),
                          Class("nav-link"),
                          "/somewhere",
                          [],
                          "Somewhere",
                        )
                    },
                ),
              )
              <> section(
                Id("content"),
                Class("content"),
                [],
                button(
                  Id("click_me"),
                  Class("click-me"),
                  [
                    Attribute("hx-get", "/clickme"),
                    Attribute("hx-trigger", "click"),
                    Attribute("hx-swap", "outerHTML"),
                  ],
                  "Click me!",
                ),
              ),
          ),
      )
  }
  |> engine.render_html(200)
}

fn render_somewhere(req: Request(Connection)) -> Response(ResponseData) {
  let current = request.to_uri(req).path
  case request.get_header(req, "Hx-boosted") {
    Ok(_) ->
      Component(
        header(
          Id("header"),
          Class("header"),
          [],
          nav(
            Id("nav"),
            Class("nav"),
            [],
            case current {
                "/" -> span(Id("current"), Class("nav-link"), [], "Home")
                _ -> a(Id("home"), Class("nav-link"), "/", [], "Home")
              }
              <> case current {
                "/somewhere" ->
                  span(Id("current"), Class("nav-link"), [], "Somewhere")
                _ ->
                  a(
                    Id("somewhere"),
                    Class("nav-link"),
                    "/somewhere",
                    [],
                    "Somewhere",
                  )
              },
          ),
        )
        <> section(
          Id("content"),
          Class("content"),
          [],
          "You are somewhere!"
            <> br()
            <> button(
              Id("click_me"),
              Class("click-me"),
              [
                Attribute("hx-get", "/clickme"),
                Attribute("hx-trigger", "click"),
                Attribute("hx-swap", "outerHTML"),
              ],
              "Click me!",
            ),
        ),
      )
    Error(_) ->
      html(
        "en",
        head([
            meta("viewport", "width=device-width, initial-scale=1"),
            title("Hello, Gleam!"),
            script("https://unpkg.com/htmx.org@1.9.11"),
          ])
          <> body(
            Id("main_content"),
            Class("container"),
            [],
            header(
                Id("header"),
                Class("header"),
                [],
                nav(
                  Id("nav"),
                  Class("nav"),
                  [],
                  case current {
                      "/" -> span(Id("current"), Class("nav-link"), [], "Home")
                      _ -> a(Id("home"), Class("nav-link"), "/", [], "Home")
                    }
                    <> case current {
                      "/somewhere" ->
                        span(Id("current"), Class("nav-link"), [], "Somewhere")
                      _ ->
                        a(
                          Id("somewhere"),
                          Class("nav-link"),
                          "/somewhere",
                          [],
                          "Somewhere",
                        )
                    },
                ),
              )
              <> section(
                Id("content"),
                Class("content"),
                [],
                "You are somewhere!"
                  <> br()
                  <> button(
                    Id("click_me"),
                    Class("click-me"),
                    [
                      Attribute("hx-get", "/clickme"),
                      Attribute("hx-trigger", "click"),
                      Attribute("hx-swap", "outerHTML"),
                    ],
                    "Click me!",
                  ),
              ),
          ),
      )
  }
  |> engine.render_html(200)
}
