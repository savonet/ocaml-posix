module Stubs = Posix_base.Generators.Stubs (struct
  module Stubs = Posix_uname_stubs.Def

  let c_headers =
    "\n    #include <sys/utsname.h>\n    #include <string.h>\n  "

  let concurrency = Cstubs.unlocked
  let prefix = "posix_uname"
end)

let () = Stubs.gen ()
