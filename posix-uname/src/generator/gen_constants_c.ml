module Types = Posix_base.Generators.Types (struct
  module Types = Posix_uname_constants.Def

  let c_headers =
    "\n\
    \    #include <sys/utsname.h>\n\n\
    \    #define SYSNAME_LEN (sizeof(((struct utsname*)0)->sysname))\n\
    \    #define NODENAME_LEN (sizeof(((struct utsname*)0)->nodename))\n\
    \    #define RELEASE_LEN (sizeof(((struct utsname*)0)->release))\n\
    \    #define VERSION_LEN (sizeof(((struct utsname*)0)->version))\n\
    \    #define MACHINE_LEN (sizeof(((struct utsname*)0)->machine))\n\
    \  "
end)

let () = Types.gen ()
