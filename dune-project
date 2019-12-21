(lang dune 2.0)
(source (github savonet/ocaml-posix))
(license MIT)
(authors "Romain Beauxis")
(maintainers "romain.beauxis@gmail.com")

(package
 (name posix-base)
 (synopsis "Base module for the posix bindings")
 (description "posix-base provides base tools for the posix binding modules.")
 (depends
  (dune (> 2.0))
  ctypes)
)

(package
 (name posix-time)
 (synopsis "Bindings for posix time functions")
 (description "posix-time provides the types and bindings for posix time APIs.")
 (depends
  (dune (> 2.0))
  ctypes
  unix-errno)
)

(package
 (name posix-socket)
 (synopsis "Bindings for posix sockets")
 (description "posix-socket provides the types and bindings of posix sockets APIs available on both unix and windows.")
 (depends
  (dune (> 2.0))
  ctypes)
)

(package
 (name posix-socket-unix)
 (synopsis "Bindings for posix sockets")
 (description "posix-socket-unix provides unix-specific types and bindings for posix sockets.")
 (depends
  (dune (> 2.0))
  ctypes
  posix-socket
  unix-errno)
)
