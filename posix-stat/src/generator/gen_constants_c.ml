module Types = Posix_base.Generators.Types (struct
  module Types = Posix_stat_constants.Def

  let c_headers =
    {|
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
|}
end)

let () = Types.gen ()
