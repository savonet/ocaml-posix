(* Generate C program that outputs OCaml is_native pattern matching *)
let generate_is_native_detector_c () =
  let names = List.map fst Eai_errno_defaults.eai_errno_defaults in
  let cases =
    List.map
      (fun name ->
        Printf.sprintf
          {|#ifdef EAI_%s
  printf("  | `%s -> true\n");
#else
  printf("  | `%s -> false\n");
#endif|}
          name name name)
      names
  in
  Printf.sprintf
    {|#include <stdio.h>

#ifdef _WIN32
  #include <winsock2.h>
  #include <ws2tcpip.h>
#else
  #include <netdb.h>
#endif

int main() {
  printf("(* Auto-generated file - do not edit manually *)\n\n");
  printf("let is_native = function\n");
%s
  printf("  | `UNKNOWN _ -> false\n");
  return 0;
}|}
    (String.concat "\n" cases)

let () =
  let c_code = generate_is_native_detector_c () in
  print_endline c_code
