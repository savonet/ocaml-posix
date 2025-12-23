module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_stat_stubs.Def

  let c_headers =
    {|
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
|}

  let concurrency = Cstubs.unlocked
  let prefix = "posix_stat"
end)

let () = Stubs.gen ()
