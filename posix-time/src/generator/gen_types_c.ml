module Types = Posix_base.Generators.Types (struct
  module Types = Posix_time_types.Def

  let c_headers = "\n#include <time.h>\n#include <sys/time.h>\n"
end)

let () = Types.gen ()
