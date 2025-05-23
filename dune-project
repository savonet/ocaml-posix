(lang dune 2.9)
(name posix-bindings)
(source (github savonet/ocaml-posix))
(license MIT)
(authors "Romain Beauxis")
(maintainers "romain.beauxis@gmail.com")

(generate_opam_files true)

(package
 (name posix-base)
 (version 2.2.0)
 (synopsis "Base module for the posix bindings")
 (description "posix-base provides base tools for the posix binding modules.")
 (depends
  (ocaml (>= 4.08))
  integers
  (ctypes (>= 0.14.0)))
)

(package
 (name posix-signal)
 (version 2.2.0)
 (synopsis "Bindings for the types defined in <signal.h>")
 (description "posix-signal provides an API to the types and bindings defined in <signal.h>")
 (depends
  (posix-base (= :version))
  ctypes
  unix-errno)
)

(package
 (name posix-types)
 (version 2.2.0)
 (synopsis "Bindings for the types defined in <sys/types.h>")
 (description "posix-types provides an API to the types defined in <sys/types.h>")
 (depends
  (ocaml (>= 4.03))
  (posix-base (= :version))
  ctypes)
)

(package
 (name posix-time2)
 (version 2.2.0)
 (synopsis "Bindings for posix time functions")
 (description "posix-time2 provides the types and bindings for posix time APIs.")
 (depends
  ctypes
  (posix-base (= :version))
  (posix-types (= :version))
  unix-errno)
)

(package
 (name posix-socket)
 (version 3.0.0)
 (synopsis "Bindings for posix sockets")
 (description "posix-socket provides the types and bindings of posix sockets APIs available on both unix and windows.")
 (depends
  (ocaml (>= 4.12))
  dune-configurator
  (posix-base (>= 2.2))
  ctypes)
)

(package
 (name posix-socket-unix)
 (version 3.0.0)
 (synopsis "Bindings for posix sockets")
 (description "posix-socket-unix provides unix-specific types and bindings for posix sockets.")
 (depends
  ctypes
  (posix-base (>= 2.2))
  (posix-socket (= :version))
  unix-errno)
)

(package
 (name posix-uname)
 (version 2.2.0)
 (synopsis "Bindings for posix uname")
 (description "posix-uname provides a simple interface for POSIX uname.")
 (depends
  ctypes
  (posix-base (= :version))
  unix-errno)
)

(package
 (name posix-getopt)
 (version 2.2.0)
 (synopsis "Bindings for posix getopt/getopt_long")
 (description "posix-getopt provides a simple interface for the POSIX getopt and its extensions, getopt_long and getopt_long_only.")
 (depends
  dune-configurator
  (ounit2 :with-test)
  (process :with-test)
  (posix-uname (and :with-test (= :version)))
  ctypes
  (posix-base (= :version))
  unix-errno)
)

(package
 (name posix-math2)
 (version 2.2.0)
 (synopsis "Bindings for posix math")
 (description "posix-math2 provides a simple interface for POSIX math functions.")
 (depends
  ctypes
  (posix-base (= :version))
  unix-errno)
)

(package
 (name posix-bindings)
 (version 3)
 (synopsis "POSIX bindings")
 (description "install all available posix bindings")
 (depends
  posix-types
  posix-socket
  posix-socket-unix
  posix-uname
  posix-math2
  posix-getopt)
)
