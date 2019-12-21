module Constants = Posix_base.Generators.Types(struct
  module Types = Posix_time_constants.Def
  let c_headers = "
#include <time.h>
#include <sys/time.h>

#define CLOCKID_T_LEN sizeof(clockid_t)
#define FD_SET_SIZE sizeof(fd_set)
#define FD_SET_ALIGNMENT offsetof(struct { char c; fd_set x; }, x)
"
end)

let () =
  Constants.gen ()
