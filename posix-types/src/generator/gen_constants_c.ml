module Constants = Posix_base.Generators.Types (struct
  module Types = Posix_types_constants.Def

  let defines =
    String.concat "\n"
      ( List.map
          (fun t ->
            let name = String.uppercase_ascii t in
            Printf.sprintf
              "\n\
               #define %s_SIZE sizeof(%s)\n\
               #define IS_%s_FLOAT ((float)((%s)1.23) == 1.23)" name t name t)
          Posix_types_constants.number_types
      @ List.map
          (fun t ->
            let name = String.uppercase_ascii t in
            Printf.sprintf
              "\n\
               #define %s_SIZE sizeof(%s)\n\
               #define %s_ALIGNMENT offsetof(struct { char c; %s x; }, x)" name
              t name t)
          Posix_types_constants.abstract_types )

  let c_headers =
    Printf.sprintf
      "\n\
       #include <sys/types.h>\n\
       #include <sys/time.h>\n\
       #include <unistd.h>\n\n\
       %s"
      defines
end)

let () = Constants.gen ()
