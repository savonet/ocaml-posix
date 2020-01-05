module Types = Posix_base.Generators.Types (struct
  module Types = Posix_uname_constants.Def

  let c_headers =
    {|
#include <sys/utsname.h>

#define SYSNAME_LEN (sizeof(((struct utsname*)0)->sysname))
#define NODENAME_LEN (sizeof(((struct utsname*)0)->nodename))
#define RELEASE_LEN (sizeof(((struct utsname*)0)->release))
#define VERSION_LEN (sizeof(((struct utsname*)0)->version))
#define MACHINE_LEN (sizeof(((struct utsname*)0)->machine))
|}
end)

let () = Types.gen ()
