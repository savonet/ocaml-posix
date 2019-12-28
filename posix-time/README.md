# posix-time

This module provides OCaml ctypes bindings to system-specific low-level time-related structures, functions and data-types.

The interface is implemented using [ocaml-ctypes](https://github.com/ocamllabs/ocaml-ctypes) and is intended
to exposed the machine-specific, low-level details of the most important parts of socket implementations.

The C API bound in this module are defined on POSIX systems by the following files:
* [time.h](https://pubs.opengroup.org/onlinepubs/009695399/basedefs/time.h.html)
* [sys/time.h](https://pubs.opengroup.org/onlinepubs/7908799/xsh/systime.h.html)

The low-level API mirrors as much as possible the original POSIX definitions. It is defined in [src/types/posix_time_types.mli](types/posix_time_types.mli). This API can be used to build further C bindings using `ocaml-ctypes`.

[src/Posix_time.mli](posix_time.mli) provides a high-level API compatible exported from the low-level bindings.

Happy hacking!
