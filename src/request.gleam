import gleam/http
import gleam/http/response.{type Response}
import mist.{type Connection}

pub fn get_method(req: Request(Connection)) -> String {
  case req.method {
    http.Get -> "GET"
    http.Post -> "POST"
    http.Head -> "HEAD"
    http.Put -> "PUT"
    http.Delete -> "DELETE"
    http.Trace -> "TRACE"
    http.Connect -> "CONNECT"
    http.Options -> "OPTIONS"
    http.Patch -> "PATCH"
    _ -> "UNKNOWN"
  }
}
