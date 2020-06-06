module Types = Posix_base.Generators.Types (struct
  module Types = Posix_time2_types.Def

  let c_headers = {|
#include <time.h>
#include <sys/time.h>
|}
end)

let () = Types.gen ()
