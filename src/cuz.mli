(**
  The implementation is mostly out of deflate.gz documentation.
  It should be possible, is somebody wants to give it a try, to abstract
  the current interfaces over Cohttp and Lwt and have an implementation
  that can work with streamed response bodies and that does direct output
  to file.
  The current dumb implementation is more than enough for my limited needs.

  [compress_string] takes an external configuration only because I was playing
  around with this also in js_of_ocaml. If you don't mind linking against [unix]
  you can use {!Cuz_unix.cfg}, this is part of the [cuz.unix] sub-library.

  The [cuz.cohttp] library contains the module {!Cuz_cohttp}, which provides
  some helpers to add the right headers and to extact gzipped response bodies.
*)

val uncompress_string : string -> (string, [> `Msg of string ]) result
val compress_string : cfg:unit Gz.Higher.configuration -> ?level:int -> string -> string
