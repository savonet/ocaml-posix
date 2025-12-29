module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_unistd_stubs.Def

  let c_headers =
    {|
#include <string.h>
#include <unistd.h>

static inline size_t confstr_bytes(int name, unsigned char* buf, size_t len) {
    return confstr(name, (char*)buf, len);
}
|}

  let concurrency = Cstubs.sequential
  let prefix = "posix_unistd"
end)

let () = Stubs.gen ()
