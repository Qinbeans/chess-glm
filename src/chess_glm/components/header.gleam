import html_dsl/types/html.{a, div, header, nav, span}
import html_dsl/types/id.{Id}
import html_dsl/types/class.{Class}
import gleam/list
import gleam/string
import chess_glm/components/navbar.{type NavBar}

/// A header component that takes a list of `NavBar` items and the current page
///  - `@param` current: the current page
///  - `@param` nav_list: the list of `NavBar` items
///  - `@returns` the header component
/// '@example'
/// ```gleam
/// let nav_list = [NavBar("Home", "/"), NavBar("Somewhere", "/somewhere")]
/// header_component("/", nav_list)
/// ```
pub fn header_component(current: String, nav_list: List(NavBar)) -> String {
  header(
    Id("header"),
    Class("header"),
    [],
    nav(
      id.Nil,
      Class("grid grid-cols-3 gap-1"),
      [],
      div(
        id.Nil,
        Class(
          "col-start-2 flex flex-row justify-center items-center gap-4 py-2 text-center",
        ),
        [],
        nav_list
          |> list.map(fn(nav) {
            let url = navbar.get_url(nav)
            let name = navbar.get_name(nav)
            case current {
              c if c == url ->
                span(
                  id.Nil,
                  Class(
                    "bg-blue-500/15 rounded-xl border-purple-600 bg-purple-300 border px-2 py-1 w-32 text-gray-800",
                  ),
                  [],
                  name,
                )
              _ ->
                a(
                  id.Nil,
                  Class(
                    "hover:bg-purple-400 rounded-xl border-purple-600 bg-purple-500 border px-2 py-1 w-32 transition duration-300 ease-in-out",
                  ),
                  url,
                  [],
                  name,
                )
            }
          })
          |> string.join(""),
      ),
    ),
  )
}
