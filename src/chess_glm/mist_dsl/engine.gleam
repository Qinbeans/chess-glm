import gleam/bytes_builder
import html_dsl/types/html.{
  type Html, body, div, force, h1, html, html_to_string, p,
}
import html_dsl/types/html/head.{charset, head, link, meta, script, style, title}
import html_dsl/types/attribute.{class, id}
import mist.{type ResponseData}
import gleam/http/response.{type Response}
import gleam/int
import gleam/option.{None}

// The DSL allows for data to be embedded in the HTML before reaching the engine
pub fn render_html(template: Html, code: Int) -> Response(ResponseData) {
  // HTML could be Html or Component which are the same type but aliased differently
  let html = html_to_string(template)
  response.new(code)
  |> response.set_header("Content-Type", "text/html")
  |> response.set_body(mist.Bytes(bytes_builder.from_string(html)))
}

// Renders error pages
pub fn render_error(message: String, code: Int) -> Response(ResponseData) {
  let html =
    html(
      lang: "en",
      head: head()
        |> meta("viewport", "width=device-width, initial-scale=1")
        |> meta("description", message)
        |> charset("utf-8")
        |> title(
          "Error"
          <> code
          |> int.to_string(),
        )
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
          div(
            id(None, "error-page")
              |> class("flex flex-col justify-center items-center h-full"),
            h1(
                id(None, "error-title")
                  |> class("text-5xl font-bold"),
                "Error: "
                  <> code
                  |> int.to_string(),
              )
              <> p(
                id(None, "error-message")
                  |> class("text-2xl font-semibold"),
                message,
              ),
          ),
        ),
      ),
    )
    |> force()
    |> html_to_string()
  response.new(code)
  |> response.set_header("Content-Type", "text/html")
  |> response.set_body(mist.Bytes(bytes_builder.from_string(html)))
}
