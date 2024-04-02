import gleeunit
import chess_glm.{start_server}
import gleam/http/request
import gleam/http/response
import gleam/httpc

pub fn main() {
  // start the server
  let _ = start_server()
  gleeunit.main()
}

// test the clickme endpoint
pub fn clickme_test() {
  let assert Ok(req) = request.to("http://localhost:3000/clickme")
  let assert Ok(resp) = httpc.send(req)
  let assert 200 = resp.status
  let assert Ok("text/plain") = response.get_header(resp, "Content-Type")
  let assert "Clicked!" = resp.body
}
