exception GzipError of string

val extract : Cohttp_lwt.Response.t * Cohttp_lwt.Body.t -> string Lwt.t
val accept_gzip : Cohttp.Header.t option -> Cohttp.Header.t
