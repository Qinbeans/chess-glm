import html_dsl/types/html.{type Html, body, component, div, footer, html}
import html_dsl/types/html/head.{charset, head, link, meta, script, style, title}
import html_dsl/types/attribute.{class, id}
import chess_glm/components/navbar
import chess_glm/components/header.{header_component}
import gleam/option.{None}

/// A base component that changes state based on the `is_component` parameter, resulting in an enum of either a `Component` or a `Html`
///  - `@param` current: the current page
///  - `@param` is_component: a boolean that indicates if the page is a component
///  - `@param` children: the children of the page
///  - `@returns` the base component
/// '@example'
/// ```gleam
/// base("/",True, "This is the content")
/// ```
pub fn base(
  current: String,
  is_component: Bool,
  description: String,
  children: String,
) -> Result(Html, String) {
  let nav_list = [
    navbar.new("Home", "/"),
    navbar.new("Somewhere", "/somewhere"),
  ]
  case is_component {
    True -> Ok(component(header_component(current, nav_list) <> children))
    False ->
      html(
        lang: "en",
        head: head()
          |> meta("viewport", "width=device-width, initial-scale=1")
          |> meta("description", description)
          |> charset("utf-8")
          |> title("Hello, Gleam!")
          |> script("https://unpkg.com/htmx.org@1.9.11")
          |> link(
            "icon",
            "https://ajawtrubycbmbqfwkiyw.supabase.co/storage/v1/object/public/pub_imgs/chess-htmx/favicon.webp",
            None,
          )
          |> style("/assets/styles/app.css")
          |> head.end(),
        body: body(
          attribute.new()
            |> class("bg-black text-white"),
          div(
              id(None, "main-content")
                |> class("h-dvh w-dvw"),
              header_component(current, nav_list) <> children,
            )
            <> footer(
              id(None, "footer")
                |> class("bg-white/15"),
              "This is the footer",
            ),
        ),
      )
  }
}
