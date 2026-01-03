module Types = Posix_base.Generators.Types (struct
  module Types = Posix_resource_types.Def

  let c_headers =
    {|
#include <sys/resource.h>
#include <sys/time.h>
#include <time.h>
|}
end)

let () = Types.gen ()
