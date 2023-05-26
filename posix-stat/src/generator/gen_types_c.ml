module Types = Posix_base.Generators.Types (struct
  module Types = Posix_stat_types.Def

  let c_headers =
    {|
#define _POSIX_C_SOURCE 200809L
#include <sys/stat.h>
#include <sys/statvfs.h>
|}
end)

let () = Types.gen ()
