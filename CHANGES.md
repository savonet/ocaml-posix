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
