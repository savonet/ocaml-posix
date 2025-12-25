(* Generate C program that outputs OCaml is_native pattern matching *)
let generate_is_native_detector_c () =
  let all_names =
    List.map fst Errno_defaults.errno_defaults
    @ List.map fst Errno_defaults.errno_aliases
  in
  let cases =
    List.map
      (fun name ->
        Printf.sprintf
          {|#ifdef %s
  printf("  | `%s -> true\n");
#else
  printf("  | `%s -> false\n");
#endif|}
          name name name)
      all_names
  in
  Printf.sprintf
    {|#include <stdio.h>
#include <errno.h>

int main() {
  printf("(* Auto-generated file - do not edit manually *)\n\n");
  printf("let is_native_t = function\n");
%s
  printf("  | `EUNKNOWN _ -> false\n");
  return 0;
}|}
    (String.concat "\n" cases)

let () =
  let c_code = generate_is_native_detector_c () in
  print_endline c_code
