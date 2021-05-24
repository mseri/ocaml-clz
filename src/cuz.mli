val uncompress_string : string -> (string, [> `Msg of string ]) result
val compress_string : cfg:unit Gz.Higher.configuration -> ?level:int -> string -> string
