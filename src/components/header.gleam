import types/html.{a, div, header, nav, span}
import types/id.{Id}
import types/class.{Class}
import gleam/list
import gleam/string
import components/navbar.{type NavBar}

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
          "col-start-2 flex flex-row justify-center items-center gap-4 py-2",
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
                    "bg-blue-500/15 rounded-xl border-white border px-2 py-1",
                  ),
                  [],
                  name,
                )
              _ ->
                a(
                  id.Nil,
                  Class(
                    "hover:bg-gray-500 rounded-xl border-white border px-2 py-1",
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
