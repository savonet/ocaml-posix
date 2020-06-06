module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_time_stubs.Def

  let c_headers =
    {|
#include <time.h>
#include <sys/time.h>

static inline void ocaml_posix_time_fd_zero(fd_set *fdset) {
  FD_ZERO(fdset);
}

static inline void ocaml_posix_time_fd_set(int fd, fd_set *fdset) {
  FD_SET(fd, fdset);
}

static inline int ocaml_posix_time_fd_isset(int fd, fd_set *fdset) {
  return FD_ISSET(fd, fdset);
}

static inline void ocaml_posix_time_fd_clr(int fd, fd_set *fdset) {
  FD_CLR(fd, fdset);
}
|}

  let concurrency = Cstubs.unlocked
  let prefix = "posix_time"
end)

let () = Stubs.gen ()
