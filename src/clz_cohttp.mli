exception ClzError of string

val decompress : Cohttp_lwt.Response.t * Cohttp_lwt.Body.t -> string Lwt.t
(** [decompress (resp, body)] returns the contents of body, decompressed
  using the information from the "content-encoding" header or fails with
  [ClzError msg] if there are decompression issues or an unknown algorithm
  is required.
*)

val update_header : ?force:bool -> Cohttp.Header.t option -> Cohttp.Header.t
(** [update_header h] returns a new header including "accept-encoding: gzip,deflate"
  if [h=None] or [force=true]. When [force=false] (default) it adds the header
  only if was not already present. *)
