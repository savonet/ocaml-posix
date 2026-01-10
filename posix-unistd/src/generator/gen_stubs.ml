module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_unistd_stubs.Def

  let c_headers =
    {|
#include <string.h>
#include <unistd.h>
#include <grp.h>
#include <stdio.h>

static inline size_t confstr_bytes(int name, unsigned char* buf, size_t len) {
    return confstr(name, (char*)buf, len);
}

#ifdef __FreeBSD__
static inline pid_t _setpgrp() {
    setpgrp(0, 0);
    return getpgid(0);
}

#define setpgrp _setpgrp
#endif
|}

  let concurrency = Cstubs.sequential
  let prefix = "posix_unistd"
end)

let () = Stubs.gen ()
