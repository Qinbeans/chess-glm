import types/html.{
  type Html, Component, body, div, footer, head, html, meta, script, style,
  title,
}
import types/id.{Id}
import types/class.{Class}
import components/navbar
import components/header.{header_component}

/// A base component that changes state based on the `is_component` parameter, resulting in an enum of either a `Component` or a `Html`
///  - `@param` current: the current page
///  - `@param` is_component: a boolean that indicates if the page is a component
///  - `@param` children: the children of the page
///  - `@returns` the base component
/// '@example'
/// ```gleam
/// base("/",True, "This is the content")
/// ```
pub fn base(current: String, is_component: Bool, children: String) -> Html {
  let nav_list = [
    navbar.new("Home", "/"),
    navbar.new("Somewhere", "/somewhere"),
  ]
  case is_component {
    True -> Component(header_component(current, nav_list) <> children)
    False ->
      html(
        "en",
        head([
            meta("viewport", "width=device-width, initial-scale=1"),
            title("Hello, Gleam!"),
            script("https://unpkg.com/htmx.org@1.9.11"),
            style("/assets/styles/app.css"),
          ])
          <> body(
            id.Nil,
            Class("bg-black text-white"),
            [],
            div(
                Id("main_content"),
                Class("h-dvh w-dvw"),
                [],
                header_component(current, nav_list) <> children,
              )
              <> footer(
                Id("footer"),
                Class("bg-white/15"),
                [],
                "This is the footer",
              ),
          ),
      )
  }
}
