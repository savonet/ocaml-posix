(lang dune 2.0)
(name posix-bindings)
(source (github savonet/ocaml-posix))
(license MIT)
(authors "Romain Beauxis")
(maintainers "romain.beauxis@gmail.com")

(generate_opam_files true)

(package
 (name posix-base)
 (synopsis "Base module for the posix bindings")
 (description "posix-base provides base tools for the posix binding modules.")
 (depends
  (dune (> 2.0))
  integers
  ctypes)
)

(package
 (name posix-types)
 (synopsis "Bindings for the types defined in <sys/types.h>")
 (description "posix-types provides an API to the types defines in <sys/types.h>")
 (depends
  (dune (> 2.0))
  posix-base
  ctypes)
)

(package
 (name posix-time)
 (synopsis "Bindings for posix time functions")
 (description "posix-time provides the types and bindings for posix time APIs.")
 (depends
  (dune (> 2.0))
  ctypes
  posix-base
  posix-types
  unix-errno)
)

(package
 (name posix-socket)
 (synopsis "Bindings for posix sockets")
 (description "posix-socket provides the types and bindings of posix sockets APIs available on both unix and windows.")
 (depends
  (dune (> 2.0))
  posix-base
  ctypes)
)

(package
 (name posix-socket-unix)
 (synopsis "Bindings for posix sockets")
 (description "posix-socket-unix provides unix-specific types and bindings for posix sockets.")
 (depends
  (dune (> 2.0))
  ctypes
  posix-base
  posix-socket
  unix-errno)
)

(package
 (name posix-uname)
 (synopsis "Bindings for posix uname")
 (description "posix-getopt provides a simple interface for POSIX uname.")
 (depends
  (dune (> 2.0))
  ctypes
  posix-base
  unix-errno)
)

(package
 (name posix-getopt)
 (synopsis "Bindings for posix getopt/getopt_long")
 (description "posix-getopt provides a simple interface for the POSIX getopt and its extensions, getopt_long and getopt_long_only.")
 (depends
  (dune (> 2.0))
  dune-configurator
  (ounit2 :with-test)
  (posix-uname :with-test)
  ctypes
  posix-base
  unix-errno)
)

(package
 (name posix-bindings)
 (synopsis "POSIX bindings")
 (description "install all available posix bindings")
 (depends
  (dune (> 2.0))
  ctypes
  posix-base
  posix-types
  posix-socket
  posix-socket-unix
  posix-uname
  posix-getopt)
)
