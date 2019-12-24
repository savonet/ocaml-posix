module Constants = Posix_base.Generators.Types(struct
  module Types = Posix_types_constants.Def
  
  let defines = String.concat "\n"
    (List.map (fun t ->
      let name = String.uppercase_ascii t in
      Printf.sprintf "
#define %s_SIZE sizeof(%s)
#define IS_%s_FLOAT ((float)((%s)1.23) == 1.23)"
        name t name t) Posix_types_constants.types)

  let c_headers = Printf.sprintf "
#include <sys/types.h>
#include <sys/time.h>

%s" defines
end)

let () =
  Constants.gen ()
