module Types = Posix_base.Generators.Types (struct
  module Types = Posix_uname_types.Def

  let c_headers = "\n    #include <sys/utsname.h>\n  "
end)

let () = Types.gen ()
