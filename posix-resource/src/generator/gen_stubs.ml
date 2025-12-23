module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_resource_stubs.Def

  let c_headers =
    {|
#include <sys/resource.h>
#include <sys/time.h>
|}

  let concurrency = Cstubs.unlocked
  let prefix = "posix_resource"
end)

let () = Stubs.gen ()
