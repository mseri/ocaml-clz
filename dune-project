(lang dune 2.0)

(name clz)

(generate_opam_files true)

(source
 (github mseri/ocaml-clz))

(license MIT)

(authors "Marcello Seri")

(maintainers "marcello.seri@gmail.com")

(package
 (name clz)
 (synopsis "Compression support for cohttp-lwt client using decompress")
 (description "The library interface tries to stay somewhat close to
[dream-encoding](https://github.com/tmattio/dream-encoding).

Usage example:
```ocaml
let get_with_compression_support ?headers uri =
  let headers = Clz_cohttp.update_headers headers in
  let open Lwt.Syntax in
  let* resp, body = Cohttp_lwt_unix.Client.get ~headers uri in
  let status = Cohttp_lwt.Response.status resp in
  let* () = if status <> `OK then Cohttp_lwt.Body.drain_body body else Lwt.return_unit in
  match status with
  | `OK ->
    let body = Clz_cohttp.decompress (resp, body) in
    Lwt.return body
  | _ -> Lwt.fail_with \"Not Ok\"
```")
 (documentation "https://mseri.github.io/ocaml-clz")
 (depends
  (ocaml
   (>= 4.08))
  (bigstringaf
   (>= 0.2.0))
  (cohttp-lwt
   (>= 2.5.0))
  (lwt
   (>= 5.3.0))
  (decompress
   (>= 1.4.0))
  (ptime
   (>= 0.8.0))))
