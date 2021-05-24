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
 (synopsis "Gzip compression support for cohttp-lwt using decompress")
 (depends
  (ocaml
   (>= 4.08))
  (cohttp-lwt
   (>= 2.5.0))
  (decompress
   (>= 1.3.0))))
