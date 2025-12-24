module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_unistd_stubs.Def

  let c_headers =
    {|
#include <string.h>
#include <unistd.h>

/* Static inline wrappers to handle unsigned char* to char* conversions */
static inline size_t strlen_bytes(const unsigned char* s) {
    return strlen((const char*)s);
}

static inline int ttyname_r_bytes(int fd, unsigned char* buf, size_t len) {
    return ttyname_r(fd, (char*)buf, len);
}

static inline int getlogin_r_bytes(unsigned char* buf, size_t len) {
    return getlogin_r((char*)buf, len);
}

static inline size_t confstr_bytes(int name, unsigned char* buf, size_t len) {
    return confstr(name, (char*)buf, len);
}
|}

  let concurrency = Cstubs.sequential
  let prefix = "posix_unistd"
end)

let () = Stubs.gen ()
