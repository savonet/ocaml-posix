# ocaml-posix

![GitHub](https://img.shields.io/github/license/savonet/ocaml-posix)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/savonet/ocaml-posix/CI)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/savonet/ocaml-posix)


Ocaml-posix provides various bindings to POSIX APIS.

Each package consists of a low-level APIs to be used with [ocaml-ctypes](https://github.com/ocamllabs/ocaml-ctypes) and high-level APIs that can be used in OCaml projects.

The purpose of this repository is to aggregate all existing POSIX bindings into a single, consistent umbrella. 

Currently, it contains:
* `posix-types`, replacing and extending [ocaml-posix-types](https://github.com/yallop/ocaml-posix-types) as well as [PosixTypes](http://ocamllabs.io/ocaml-ctypes/PosixTypes.html) from `ocaml-ctypes`
* `posix-errno`, replacing and extending [unix-unix-errno](https://github.com/xapi-project/ocaml-unix-errno)
* `posix-posix-socket` and `posix-socket-unix`, replacing and extending [sys-socket](https://github.com/toots/ocaml-sys-socket)
* `posix-time2`, replacing and extending [posix-time](https://github.com/mwweissmann/ocaml-posix-time) and replacing [unix-time](https://github.com/dsheets/ocaml-unix-time) and [posix-clock](https://github.com/mwweissmann/ocaml-posix-clock)
* `posix-getopt`, replacing [posix-getopt](	https://github.com/toots/posix-getopt)
* `posix-uname`
* `posix-resource`, replacing and extending [unix-sys-resource](https://github.com/dsheets/ocaml-unix-sys-resource)
* `posix-signal`
* `posix-stat`, replacing and extending [unix-sys-stat](https://github.com/dsheets/ocaml-unix-sys-stat)
* `posix-math2`

## API

The API documentation can be consulted [here](http://www.liquidsoap.info/ocaml-posix/)

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

* Convert [posix-mqueue](https://github.com/mwweissmann/ocaml-posix-mqueue)
* Convert [posix-semaphore](https://github.com/mwweissmann/ocaml-posix-semaphore)
