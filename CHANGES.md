# 4.0.0 (unreleased)
* Add `posix-errno`, remove all use of `unix_errno`.
* Add `posix-stat`.
* Add support for `posix-socket` `EAI_*` errors.

# 3.1.0 (22-12-2025)
* all: Bump dune to 3.20
* posix-socket: Remove sa_data.
* posix-socket: Fix ai_family field type of struct addrinfo. Thanks to @glondu
* posix-math2: Remove dependency on unix-errno, finish porting to proper windows/cross build.
* Fix CHANGES, sorry!
