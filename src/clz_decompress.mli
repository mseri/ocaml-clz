(** The implementation of the functions below is mostly extracted from the [decompress] library documentation.*)

val inflate_string_de : string -> (string, [> `Msg of string ]) result
(** [inflate_string_de s] inflates a string using the deflate algorithm. *)

val deflate_string_de : string -> string
(** [deflate_string_de s] deflates a string using the deflate algorithm. *)

val inflate_string_gz : string -> (string, [> `Msg of string ]) result
(** [inflate_string_gz s] inflates a string using the gzip algorithm. *)

val deflate_string_gz :
  cfg:unit Gz.Higher.configuration -> ?level:int -> string -> string
(** [inflate_string_gz ~cfg ?(level=4) s] deflates a string using the gzip algorithm. *)
