# Compression support for cohttp-lwt using decompress

[![CI Status](https://github.com/mseri/ocaml-clz/actions/workflows/workflow.yml/badge.svg)](https://github.com/mseri/ocaml-clz/actions/workflows/workflow.yml)

The library interface tries to stay somewhat close to
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
  | _ -> Lwt.fail_with "Not Ok"
```

It provides three libraries:
- `clz`: functions to inflate and deflate strings, in case one does not need `cohttp`
- `clz.cfg`: configuration for gzip deflate, separate only because it links `unix`
- `clz.cohttp`: provides the module {!Clz_cohttp}, which contains helpers to add the necessary accept headers and to decompress the response bodies.

The documentation can be found on [www.mseri.me/ocaml-clz/](https://www.mseri.me/ocaml-clz/).

## Why CLZ

The name was supposed to be temporary.
Started as `CUZ: Cohttp U gZip`, but it really only supports `cohttp-lwt`, so it changed into `CLS: Cohttp-Lwt-Zip`, even if it supports both gzip and deflate.
I use it in a lot of scripts now, more invasive changes would be way too time-consuming :P
