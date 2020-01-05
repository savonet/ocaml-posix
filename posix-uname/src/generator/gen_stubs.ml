module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_uname_stubs.Def

  let c_headers = {|
#include <sys/utsname.h>
#include <string.h>
|}

  let concurrency = Cstubs.unlocked
  let prefix = "posix_uname"
end)

let () = Stubs.gen ()
