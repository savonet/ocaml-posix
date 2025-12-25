let generate_errno_defaults () =
  let regular_defs =
    List.map
      (fun (name, value) ->
        Printf.sprintf "#ifndef %s\n#define %s %d\n#endif\n" name name value)
      Errno_defaults.errno_defaults
  in
  let alias_defs =
    List.map
      (fun (name, alias) ->
        Printf.sprintf "#ifndef %s\n#define %s %s\n#endif\n" name name alias)
      Errno_defaults.errno_aliases
  in
  String.concat "\n" (regular_defs @ alias_defs)

module Constants = Posix_base.Generators.Types (struct
  module Types = Posix_errno_constants.Def

  let c_headers =
    Printf.sprintf
      {|
#include <errno.h>

/* Provide default values for errno constants that might not be defined on all platforms */

%s
|}
      (generate_errno_defaults ())
end)

let () = Constants.gen ()
