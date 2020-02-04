module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_signal_stubs.Def

  let c_headers = {|
#include <signal.h>
|}

  let concurrency = Cstubs.unlocked
  let prefix = "posix_signal"
end)

let () = Stubs.gen ()
