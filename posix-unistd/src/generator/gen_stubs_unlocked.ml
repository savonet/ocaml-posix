module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_unistd_stubs_unlocked.Def

  let c_headers =
    {|
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
|}

  let concurrency = Cstubs.unlocked
  let prefix = "posix_unistd_unlocked"
end)

let () = Stubs.gen ()
