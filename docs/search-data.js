window.Gleam.initSearch([{"doc":"chess_glm","title":"chess_glm","content":"# chess_glm\n\n[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://qinbeans.github.io/chess-glm/)\n[![test](https://github.com/Qinbeans/chess-glm/actions/workflows/test.yml/badge.svg)](https://github.com/Qinbeans/chess-glm/actions/workflows/test.yml)\n\nReimplementation of my [chess-htmx](https://github.com/Qinbeans/chess-htmx) project in Gleam. The original project was written in Go and used the [htmx](https://htmx.org/) library to create a web-based chess game.\n\nThis uses my DSL library [html-dsl](https://github.com/Qinbeans/html-dsl) to generate HTML.\n\n```sh\ngleam add chess_glm\n```\n\nFurther documentation can be found at &lt;https://qinbeans.github.io/chess-glm/&gt;.\n\n## Development\n\n```sh\ngleam run   # Run the project\ngleam test  # Run the tests\ngleam shell # Run an Erlang shell\n```\n","url":"index.html"},{"doc":"components/navbar","title":"NavBar","content":"pub opaque type NavBar\n A struct that represents a navigation bar item\n  - `name` is the name of the item\n  - `url` is the url of the item\n\nSynonyms:\ncomponents/navbar.NavBar\ncomponents/navbar NavBar","url":"components/navbar.html#NavBar"},{"doc":"components/navbar","title":"get_name","content":"pub fn get_name(nav: NavBar) -&gt; String\n\nSynonyms:\ncomponents/navbar.get_name\ncomponents/navbar get_name","url":"components/navbar.html#get_name"},{"doc":"components/navbar","title":"get_url","content":"pub fn get_url(nav: NavBar) -&gt; String\n\nSynonyms:\ncomponents/navbar.get_url\ncomponents/navbar get_url","url":"components/navbar.html#get_url"},{"doc":"components/navbar","title":"new","content":"pub fn new(name: String, url: String) -&gt; NavBar\n A function that creates a `NavBar` item\n  - `@param` name: the name of the item\n  - `@param` url: the url of the item\n  - `@returns` the `NavBar` item\nSynonyms:\ncomponents/navbar.new\ncomponents/navbar new","url":"components/navbar.html#new"},{"doc":"components/navbar","title":"components/navbar","content":"","url":"components/navbar.html"},{"doc":"components/header","title":"header_component","content":"pub fn header_component(\n  current: String,\n  nav_list: List(NavBar),\n) -&gt; String\n A header component that takes a list of `NavBar` items and the current page\n  - `@param` current: the current page\n  - `@param` nav_list: the list of `NavBar` items\n  - `@returns` the header component\n &#39;@example&#39;\n \n let nav_list = [NavBar(&quot;Home&quot;, &quot;/&quot;), NavBar(&quot;Somewhere&quot;, &quot;/somewhere&quot;)]\n header_component(&quot;/&quot;, nav_list)\n \nSynonyms:\ncomponents/header.header_component\ncomponents/header header_component","url":"components/header.html#header_component"},{"doc":"components/header","title":"components/header","content":"","url":"components/header.html"},{"doc":"layouts/base","title":"base","content":"pub fn base(\n  current: String,\n  is_component: Bool,\n  children: String,\n) -&gt; Html\n A base component that changes state based on the `is_component` parameter, resulting in an enum of either a `Component` or a `Html`\n  - `@param` current: the current page\n  - `@param` is_component: a boolean that indicates if the page is a component\n  - `@param` children: the children of the page\n  - `@returns` the base component\n &#39;@example&#39;\n \n base(&quot;/&quot;,True, &quot;This is the content&quot;)\n \nSynonyms:\nlayouts/base.base\nlayouts/base base","url":"layouts/base.html#base"},{"doc":"layouts/base","title":"layouts/base","content":"","url":"layouts/base.html"},{"doc":"mist_dsl/engine","title":"render_html","content":"pub fn render_html(\n  template: Html,\n  code: Int,\n) -&gt; Response(ResponseData)\n\nSynonyms:\nmist_dsl/engine.render_html\nmist_dsl/engine render_html","url":"mist_dsl/engine.html#render_html"},{"doc":"mist_dsl/engine","title":"mist_dsl/engine","content":"","url":"mist_dsl/engine.html"},{"doc":"routes/index","title":"render","content":"pub fn render(req: Request(Connection)) -&gt; Response(ResponseData)\n Renders the page for index\nSynonyms:\nroutes/index.render\nroutes/index render","url":"routes/index.html#render"},{"doc":"routes/index","title":"routes/index","content":"","url":"routes/index.html"},{"doc":"routes/somewhere","title":"render","content":"pub fn render(req: Request(Connection)) -&gt; Response(ResponseData)\n Render the page\nSynonyms:\nroutes/somewhere.render\nroutes/somewhere render","url":"routes/somewhere.html#render"},{"doc":"routes/somewhere","title":"routes/somewhere","content":"","url":"routes/somewhere.html"},{"doc":"routes/not_found","title":"render","content":"pub fn render(: Request(Connection)) -&gt; Response(ResponseData)\n Render a 404 response\nSynonyms:\nroutes/not_found.render\nroutes/not_found render","url":"routes/not_found.html#render"},{"doc":"routes/not_found","title":"routes/not_found","content":"","url":"routes/not_found.html"},{"doc":"routes/static","title":"serve_static","content":"pub fn serve_static(\n  req: Request(Connection),\n  path: String,\n) -&gt; Response(ResponseData)\n\nSynonyms:\nroutes/static.serve_static\nroutes/static serve_static","url":"routes/static.html#serve_static"},{"doc":"routes/static","title":"routes/static","content":"","url":"routes/static.html"},{"doc":"chess_glm","title":"main","content":"pub fn main() -&gt; Nil\n\nSynonyms:\nchess_glm.main\nchess_glm main","url":"chess_glm.html#main"},{"doc":"chess_glm","title":"start_server","content":"pub fn start_server() -&gt; Result(Subject(Message), StartError)\n\nSynonyms:\nchess_glm.start_server\nchess_glm start_server","url":"chess_glm.html#start_server"},{"doc":"chess_glm","title":"chess_glm","content":"","url":"chess_glm.html"}]);