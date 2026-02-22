# posix-socket-unix

This module provides OCaml ctypes bindings to system-specific low-level socket structure and data-types.

The interface is implemented using [ocaml-ctypes](https://github.com/ocamllabs/ocaml-ctypes) and is intended
to exposed the machine-specific, low-level details of the most important parts of socket implementations.

[Posix_socket_unix](src/posix_socket_unix.mli) provides the API specific to `Unix` systems, mostly the `sockaddr_u` structure.
API common to both `Unix` and `Win32` systems are defined in the parent `posix-socket` module.

Happy hacking!
