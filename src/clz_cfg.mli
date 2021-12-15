(**
  The implementation of [cfg] uses [ptime]. To use it with [js_of_ocaml]
  you can simply copy it and link it against [ptime.clock.js]. *)
val cfg : unit Gz.Higher.configuration
