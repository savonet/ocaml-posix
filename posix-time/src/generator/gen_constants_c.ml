module Constants = Posix_base.Generators.Types (struct
  module Types = Posix_time_constants.Def

  let c_headers =
    "\n\
     #include <time.h>\n\
     #include <sys/time.h>\n\n\
     #define FD_SET_SIZE sizeof(fd_set)\n\
     #define FD_SET_ALIGNMENT offsetof(struct { char c; fd_set x; }, x)\n"
end)

let () = Constants.gen ()
