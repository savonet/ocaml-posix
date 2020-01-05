# ocaml-posix

Ocaml-posix provides various bindings to POSIX APIS.

Each package consists of a low-level APIs to be used with [ocaml-ctypes](https://github.com/ocamllabs/ocaml-ctypes) and high-level APIs that can be used in OCaml projects.

The purpose of this repository is to aggregate all existing POSIX bindings into a single, consistent umbrella. 

Currently, it contains:
* `posix-types`, replacing and extending [ocaml-posix-types](https://github.com/yallop/ocaml-posix-types) as well as [PosixTypes](http://ocamllabs.io/ocaml-ctypes/PosixTypes.html) from `ocaml-ctypes`
* `posix-posix-socket` and `posix-socket-unix`, replacing and extending [sys-socket](https://github.com/toots/ocaml-sys-socket)
* `posix-time`, replacing and extending [posix-time](https://github.com/mwweissmann/ocaml-posix-time) and replacing [unix-time](https://github.com/dsheets/ocaml-unix-time) and [posix-clock](https://github.com/mwweissmann/ocaml-posix-clock)
* `posix-getopt`, replacing [posix-getopt](	https://github.com/toots/posix-getopt)
* `posix-uname`

## How to build

```
dune install
```

## How to install

Via `opam`:
```
opam install .
```

Via `dune`:
```
dune install
```

## TODO

* Convert [posix-math](https://github.com/mwweissmann/ocaml-posix-math)
* Convert [posix-mqueue](https://github.com/mwweissmann/ocaml-posix-mqueue)
* Convert [posix-semaphore](https://github.com/mwweissmann/ocaml-posix-semaphore)
* Convert [unix-sys-resource](https://github.com/dsheets/ocaml-unix-sys-resource)
* Convert [unix-sys-stat](https://github.com/dsheets/ocaml-unix-sys-stat)
