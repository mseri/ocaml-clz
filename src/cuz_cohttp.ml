exception GzipError of string

let extract (resp, body) =
  let open Lwt.Syntax in
  let* body = Cohttp_lwt.Body.to_string body in
  let is_gzipped =
    Cohttp_lwt.Response.headers resp
    |> fun resp -> Cohttp.Header.get resp "content-encoding" = Some "gzip"
  in
  let body = if is_gzipped then Cuz.uncompress_string body else Ok body in
  match body with
  | Ok content -> Lwt.return content
  | Error (`Msg error) -> Lwt.fail (GzipError error)


let accept_gzip =
  let open Cohttp.Header in
  let gzip_h = of_list [ "accept-encoding", "gzip" ] in
  function
  | None -> gzip_h
  | Some h -> add h "accept-encoding" "gzip"
