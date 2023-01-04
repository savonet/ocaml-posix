(lang dune 2.5)
(version 2.0.1)
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
  (dune (> 2.5))
  integers
  (odoc :with-doc)
  (ctypes (>= 0.12.1)))
)

(package
 (name posix-signal)
 (synopsis "Bindings for the types defined in <signal.h>")
 (description "posix-signal provides an API to the types and bindings defined in <signal.h>")
 (depends
  (dune (> 2.5))
  (posix-base (= :version))
  (odoc :with-doc)
  ctypes
  unix-errno)
)

(package
 (name posix-types)
 (synopsis "Bindings for the types defined in <sys/types.h>")
 (description "posix-types provides an API to the types defined in <sys/types.h>")
 (depends
  (ocaml (>= 4.03))
  (dune (> 2.5))
  (odoc :with-doc)
  (posix-base (= :version))
  ctypes)
)

(package
 (name posix-time2)
 (version 2.1.0)
 (synopsis "Bindings for posix time functions")
 (description "posix-time2 provides the types and bindings for posix time APIs.")
 (depends
  (dune (> 2.5))
  ctypes
  (odoc :with-doc)
  (posix-base (>= 2.0.1))
  (posix-types (>= 2.0.1))
  unix-errno)
)

(package
 (name posix-socket)
 (synopsis "Bindings for posix sockets")
 (description "posix-socket provides the types and bindings of posix sockets APIs available on both unix and windows.")
 (depends
  (dune (> 2.5))
  (odoc :with-doc)
  (posix-base (= :version))
  ctypes)
)

(package
 (name posix-socket-unix)
 (synopsis "Bindings for posix sockets")
 (description "posix-socket-unix provides unix-specific types and bindings for posix sockets.")
 (depends
  (dune (> 2.5))
  (odoc :with-doc)
  ctypes
  (posix-base (= :version))
  (posix-socket (= :version))
  unix-errno)
)

(package
 (name posix-uname)
 (synopsis "Bindings for posix uname")
 (description "posix-uname provides a simple interface for POSIX uname.")
 (depends
  (dune (> 2.5))
  (odoc :with-doc)
  ctypes
  (posix-base (= :version))
  unix-errno)
)

(package
 (name posix-getopt)
 (synopsis "Bindings for posix getopt/getopt_long")
 (description "posix-getopt provides a simple interface for the POSIX getopt and its extensions, getopt_long and getopt_long_only.")
 (depends
  (dune (> 2.5))
  (odoc :with-doc)
  dune-configurator
  (ounit2 :with-test)
  (process :with-test)
  (posix-uname (and :with-test (= :version)))
  ctypes
  (posix-base (= :version))
  unix-errno)
)

(package
 (name posix-bindings)
 (synopsis "POSIX bindings")
 (description "install all available posix bindings")
 (depends
  (dune (> 2.5))
  (odoc :with-doc)
  ctypes
  (posix-base (= :version))
  (posix-types (= :version))
  (posix-socket (= :version))
  (posix-socket-unix (= :version))
  (posix-uname (= :version))
  (posix-getopt (= :version)))
)
