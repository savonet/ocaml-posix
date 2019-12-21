let c_headers = "
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
"

let () =
  let mode = Sys.argv.(1) in
  let fname = Sys.argv.(2) in
  let oc = open_out_bin fname in
  let format =
    Format.formatter_of_out_channel oc
  in
  let fn =
    match mode with
      | "ml" -> Cstubs.write_ml
      | "c"  ->
         Format.fprintf format "%s@\n" c_headers;
         Cstubs.write_c
      | _    -> assert false
  in
  fn ~concurrency:Cstubs.unlocked format ~prefix:"posix_time" (module Posix_time_stubs.Def);
  Format.pp_print_flush format ();
  close_out oc
