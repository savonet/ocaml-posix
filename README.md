# ocaml-posix

[![GitHub license](https://img.shields.io/github/license/savonet/ocaml-posix)](LICENSE)
[![CI](https://github.com/savonet/ocaml-posix/actions/workflows/ci.yml/badge.svg)](https://github.com/savonet/ocaml-posix/actions/workflows/ci.yml)
[![GitHub release](https://img.shields.io/github/v/release/savonet/ocaml-posix)](https://github.com/savonet/ocaml-posix/releases)

OCaml bindings to POSIX APIs.

## Overview

ocaml-posix provides comprehensive bindings to POSIX system interfaces for OCaml. Each module offers:

- **Low-level bindings** for use with [ocaml-ctypes](https://github.com/ocamllabs/ocaml-ctypes)
- **High-level OCaml APIs** for convenient, idiomatic usage

This project consolidates and extends various existing POSIX binding libraries into a single, consistent collection.

## Installation

### Via opam (recommended)

```sh
opam install posix-base posix-types posix-errno posix-socket posix-time2
```

### From source

```sh
git clone https://github.com/savonet/ocaml-posix.git
cd ocaml-posix
opam install .
```

## Quick Start

```ocaml
(* Using posix-time2 for clock operations *)
open Posix_time2

let () =
  let ts = clock_gettime `Realtime in
  Printf.printf "Current time: %Ld.%09ld seconds\n"
    ts.Timespec.tv_sec ts.Timespec.tv_nsec
```

```ocaml
(* Using posix-uname for system information *)
open Posix_uname

let () =
  let info = uname () in
  Printf.printf "System: %s %s (%s)\n"
    info.sysname info.release info.machine
```

## Available Packages

| Package | Description | Replaces |
|---------|-------------|----------|
| `posix-base` | Base tools for generating POSIX bindings | - |
| `posix-types` | POSIX type definitions | [ocaml-posix-types](https://github.com/yallop/ocaml-posix-types), [PosixTypes](http://ocamllabs.io/ocaml-ctypes/PosixTypes.html) |
| `posix-errno` | Error number handling and Unix error conversion | [unix-errno](https://github.com/xapi-project/ocaml-unix-errno) |
| `posix-socket` | Socket operations (`sys/socket.h`) | [sys-socket](https://github.com/toots/ocaml-sys-socket) |
| `posix-socket-unix` | Unix domain socket extensions | - |
| `posix-time2` | Time and clock functions | [posix-time](https://github.com/mwweissmann/ocaml-posix-time), [unix-time](https://github.com/dsheets/ocaml-unix-time), [posix-clock](https://github.com/mwweissmann/ocaml-posix-clock) |
| `posix-getopt` | Command-line option parsing | [posix-getopt](https://github.com/toots/posix-getopt) |
| `posix-uname` | System identification | - |
| `posix-unistd` | Miscellaneous POSIX functions (`unistd.h`) | - |
| `posix-resource` | Resource limits and usage (`sys/resource.h`) | [unix-sys-resource](https://github.com/dsheets/ocaml-unix-sys-resource) |
| `posix-signal` | Signal handling | - |
| `posix-stat` | File status (`sys/stat.h`) | [unix-sys-stat](https://github.com/dsheets/ocaml-unix-sys-stat) |
| `posix-math2` | Mathematical functions | - |

## Documentation

API documentation is available at: http://www.liquidsoap.info/ocaml-posix/

## Cross-compilation

ocaml-posix supports cross-compilation (e.g., building for Windows from Linux/macOS using mingw). The build system automatically detects cross-compilation scenarios and uses appropriate tooling.

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
