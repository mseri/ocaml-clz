(**
  The [clz.cohttp] library contains the module {!Clz_cohttp}, which provides
  some helpers to add the necessary accept headers and to decompress the response
  bodies.
  It is possible to make the implementation seamlessly work with streamed response
  bodies and direct output to file, PRs are always welcome.
*)

val inflate_string :
  algorithm:[< `Deflate | `Gzip ] ->
  string ->
  (string, [> `Msg of string ]) result
(**
  [inflate_string ~algorithm body] returns [body] compressed using [algorithm]
  or the respective error message. *)

val deflate_string :
  algorithm:[< `Deflate | `Gzip ] ->
  cfg:unit Gz.Higher.configuration ->
  ?level:int ->
  string ->
  string
(**
  [deflate_string ~algorithm ~cfg ?level body] extract the content of [body]
  using [algorithm] or the respective error message. If the algorithm is gzip, it
  will use [cfg] and [level] for the decompression. 

  [deflate_string] requires an external configuration to make the library
  compatible with [mirage] and [js_of_ocaml]. If you don't mind linking
  against [unix] you can use {!Clz_cfg.cfg}, part of the [clz.cfg] sub-library.*)
