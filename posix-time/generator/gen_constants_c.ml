let c_headers = "
#include <time.h>
#include <sys/time.h>

#define CLOCKID_T_LEN sizeof(clockid_t)
#define FD_SET_SIZE sizeof(fd_set)
#define FD_SET_ALIGNMENT offsetof(struct { char c; fd_set x; }, x)
"

let () =
  let fname = Sys.argv.(1) in
  let oc = open_out_bin fname in
  let format =
    Format.formatter_of_out_channel oc
  in
  Format.fprintf format "%s@\n" c_headers;
  Cstubs.Types.write_c format (module Posix_time_constants.Def);
  Format.pp_print_flush format ();
  close_out oc
