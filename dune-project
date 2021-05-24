(lang dune 2.7)

(name cuz)

(generate_opam_files true)

(source
 (github mseri/ocaml-cuz))

(license MIT)

(authors "Marcello Seri")

(maintainers "marcello.seri@gmail.com")

(package
 (name cuz)
 (synopsis "Gzip compression support for cohttp-lwt-unix")
 (depends
  (ocaml
   (>= 4.08))
  (astring
   (>= 0.8.0))
  (cohttp-lwt-unix
   (>= 2.5.0))
  (decompress
   (>= 1.3.0))
  (tls
   (>= 0.12.0))))
