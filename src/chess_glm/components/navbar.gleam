/// A struct that represents a navigation bar item
///  - `name` is the name of the item
///  - `url` is the url of the item
pub opaque type NavBar {
  NavBar(name: String, url: String)
}

/// A function that creates a `NavBar` item
///  - `@param` name: the name of the item
///  - `@param` url: the url of the item
///  - `@returns` the `NavBar` item
pub fn new(name: String, url: String) -> NavBar {
  NavBar(name, url)
}

pub fn get_name(nav: NavBar) -> String {
  nav.name
}

pub fn get_url(nav: NavBar) -> String {
  nav.url
}
