(lang dune 2.0)

(package
 (name posix-time)
 (synopsis "Bindings for posix time functions")
 (description "\| posix-time provides the types and bindings
              "\| for posix time APIs.
))

(package
 (name posix-socket)
 (synopsis "Bindings for posix sockets")
 (description "\| posix-sockets provides the types and bindings
              "\| of posix sockets APIs available on both unix
              "\| and windows.
))

(package
 (name posix-socket-unix)
 (synopsis "Bindings for posix sockets")
 (description "\| posix-sockets provides unix-specific types and bindings
              "\| for posix sockets
))
