module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_errno_stubs.Def

  let c_headers =
    {|
#define _POSIX_C_SOURCE 200112L
#include <errno.h>
#include <string.h>

/* Get current errno value */
static inline int posix_errno_get_errno(void) {
  return errno;
}

/* Set errno value */
static inline void posix_errno_set_errno(int value) {
  errno = value;
}
|}

  let concurrency = Cstubs.unlocked
  let prefix = "posix_errno"
end)

let () = Stubs.gen ()
