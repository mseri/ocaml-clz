exception ClzError of string

let encoding_of_string = function
  | "deflate" -> `Deflate
  | "gzip" -> `Gzip
  | s -> `Unknown s

let content_encodings s =
  String.split_on_char ',' s
  |> List.map (fun x -> x |> String.trim |> String.lowercase_ascii)
  |> List.map encoding_of_string
  |> Option.some

let decompress (resp, body) =
  let rec aux algorithms content =
    match algorithms with
    | [] -> Ok content
    | (`Deflate as el) :: rest | (`Gzip as el) :: rest ->
        Result.bind (Clz.inflate_string ~algorithm:el content) (aux rest)
    | `Unknown d :: _rest ->
        Error (`Msg ("Unsopported encoding directive '" ^ d ^ "'"))
  in
  let open Lwt.Syntax in
  let* body = Cohttp_lwt.Body.to_string body in
  let algorithms =
    let headers = Cohttp_lwt.Response.headers resp in
    let algorithms = Cohttp.Header.get headers "content-encoding" in
    Option.bind algorithms content_encodings
  in
  match algorithms with
  | None -> Lwt.return body
  | Some algorithms -> (
      let body = aux algorithms body in
      match body with
      | Ok body -> Lwt.return body
      | Error (`Msg err) -> Lwt.fail (ClzError err))

let update_header ?(force = false) =
  let open Cohttp.Header in
  let gzip_h = of_list [ ("accept-encoding", "gzip,deflate") ] in
  function
  | None -> gzip_h
  | Some h ->
      let add = if force then add else add_unless_exists in
      add h "accept-encoding" "gzip,deflate"
