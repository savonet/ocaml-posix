module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_errno_stubs.Def

  let c_headers =
    {|
#define _POSIX_C_SOURCE 200112L
#include <errno.h>
#include <string.h>
#include <caml/mlvalues.h>
#include <caml/fail.h>

/* Get current errno value */
static inline int posix_errno_get_errno(void) {
  return errno;
}

/* Set errno value */
static inline void posix_errno_set_errno(int value) {
  errno = value;
}

/* strerror_r wrapper - raises Invalid_argument on Windows */
static inline int posix_errno_strerror_r(int errnum, char *buf, size_t buflen) {
#ifdef _WIN32
  caml_invalid_argument("strerror_r not available on Windows");
  return EINVAL; /* Never reached */
#else
  return strerror_r(errnum, buf, buflen);
#endif
}
|}

  let concurrency = Cstubs.unlocked
  let prefix = "posix_errno"
end)

let () = Stubs.gen ()
