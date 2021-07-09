# Compression support for cohttp-lwt using decompress

The library interface tries to stay somewhat close to
[dream-encoding](https://github.com/tmattio/dream-encoding).

Usage example:
```ocaml
let get_with_compression_support ?headers uri =
  let headers = Cuz_cohttp.update_headers headers in
  let open Lwt.Syntax in
  let* resp, body = Cohttp_lwt_unix.Client.get ~headers uri in
  let status = Cohttp_lwt.Response.status resp in
  let* () = if status <> `OK then Cohttp_lwt.Body.drain_body body else Lwt.return_unit in
  match status with
  | `OK ->
    let body = Cuz_cohttp.decompress (resp, body) in
    Lwt.return body
  | _ -> Lwt.fail_with "Not Ok"
```

## Why CUZ

The name was suposed to be temporary: `Cohttp U Gzip`, which was what the
first implementation was all about. I use it in a lot of programs now, changing it
would be way too time-consuming :P
