module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_time_stubs.Def

  let c_headers =
    "\n\
     #include <time.h>\n\
     #include <sys/time.h>\n\n\
     static inline void ocaml_posix_time_fd_zero(fd_set *fdset) {\n\
    \  FD_ZERO(fdset);\n\
     }\n\n\
     static inline void ocaml_posix_time_fd_set(int fd, fd_set *fdset) {\n\
    \  FD_SET(fd, fdset);\n\
     }\n\n\
     static inline int ocaml_posix_time_fd_isset(int fd, fd_set *fdset) {\n\
    \  return FD_ISSET(fd, fdset);\n\
     }\n\n\
     static inline void ocaml_posix_time_fd_clr(int fd, fd_set *fdset) {\n\
    \  FD_CLR(fd, fdset);\n\
     }\n"

  let concurrency = Cstubs.unlocked
  let prefix = "posix_time"
end)

let () = Stubs.gen ()
