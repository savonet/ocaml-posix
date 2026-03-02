# 4.0.2 (2026-03-02)
* Fixed segfault on 32bit architecture with enabled. LFS is enabled by default
  now on 32bit architectures.
* Fix crash when passing wrong socketlen in getnameinfo. Thanks to @glondu
* Fix `optopt` type in `posix-getopt` (should be `int`, not `char`). Thanks to @glondu
* Fix `utimes` in `posix-time2`: it now takes separate `~last_access` and
  `~last_modification` arguments instead of a single `Timeval.t`. Thanks to @glondu
* Fix Hurd support: `errno` is a `nativeint` on Hurd, `clock_nanosleep` and
  `PROCESS_CPUTIME` are not available on Hurd. Thanks to @glondu
* Reorganize internal build: all modules moved under `modules/` with improved
  cflags handling

# 4.0.1 (2026-01-10)
* Add wrapper for freebsd's non-posix compliant `setpgrp`.

# 4.0.0 (2026-01-01)
* Add `posix-errno`, remove all use of `unix_errno`.
* Add `posix-stat`.
* Add `posix-resource`.
* Add `posix-unistd`.
* Add support for `posix-socket` `EAI_*` errors.

# 3.1.0 (2025-12-22)
* all: Bump dune to 3.20
* posix-socket: Remove sa_data.
* posix-socket: Fix ai_family field type of struct addrinfo. Thanks to @glondu
* posix-math2: Remove dependency on unix-errno, finish porting to proper windows/cross build.
* Fix CHANGES, sorry!
