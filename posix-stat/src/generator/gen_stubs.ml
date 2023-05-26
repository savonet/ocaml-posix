module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_socket_stubs.Def

  let c_headers =
    {|
#define _POSIX_C_SOURCE 200809L
#include <sys/stat.h>
#include <sys/statvfs.h>
|}

  let concurrency = Cstubs.unlocked
  let prefix = "posix_stat"
end)

let () = Stubs.gen ()
