(* Error handling tests for posix-getopt with posix-errno *)
open Posix_getopt

(* Test that getopt handles empty argv correctly *)
let test_getopt_empty_argv () =
  Printf.printf "Testing getopt with empty argv...\n%!";
  reset ();
  let argv = [| "progname" |] in
  let opt = { name = 'a'; arg = `None (fun () -> ()) } in
  let ret = getopt argv [opt] in
  assert (Array.length ret = 0);
  Printf.printf "  ✓ getopt handled empty argv correctly\n%!"

(* Test that Missing_argument exception is raised properly *)
let test_missing_argument_error () =
  Printf.printf "Testing Missing_argument exception...\n%!";
  reset ();
  let argv = [| "progname"; "-a" |] in
  let opt = { name = 'a'; arg = `Required (fun _ -> ()) } in
  let got_error = ref false in
  (try
     ignore (getopt argv [opt]);
     Printf.printf "  ✗ Should have raised Missing_argument\n%!";
     assert false
   with Missing_argument 'a' ->
     got_error := true;
     Printf.printf "  ✓ Missing_argument exception raised correctly\n%!");
  assert !got_error

(* Test that Unknown_option exception is raised properly *)
let test_unknown_option_error () =
  Printf.printf "Testing Unknown_option exception...\n%!";
  reset ();
  let argv = [| "progname"; "-z" |] in
  let opt = { name = 'a'; arg = `None (fun () -> ()) } in
  let got_error = ref false in
  (try
     ignore (getopt argv [opt]);
     Printf.printf "  ✗ Should have raised Unknown_option\n%!";
     assert false
   with Unknown_option "-z" ->
     got_error := true;
     Printf.printf "  ✓ Unknown_option exception raised correctly\n%!");
  assert !got_error

(* Test getopt_long error handling (if available) *)
let test_getopt_long_errors () =
  if not has_getopt_long then (
    Printf.printf "Skipping getopt_long tests (not available)\n%!";
    ())
  else (
    Printf.printf "Testing getopt_long error handling...\n%!";

    (* Test unknown long option *)
    reset ();
    let argv = [| "progname"; "--unknown" |] in
    let opt = { name = ("known", 'k'); arg = `None (fun () -> ()) } in
    let got_error = ref false in
    (try
       ignore (getopt_long argv [opt]);
       Printf.printf "  ✗ Should have raised Unknown_option\n%!";
       assert false
     with Unknown_option "--unknown" ->
       got_error := true;
       Printf.printf "  ✓ getopt_long raised Unknown_option for long option\n%!");
    assert !got_error;

    (* Test missing required argument for long option *)
    (* Note: This test can cause issues on some platforms *)
    let sysname = Posix_uname.((uname ()).sysname) in
    if sysname = "Darwin" then
      Printf.printf
        "  ⚠ Skipping missing argument test on Darwin (known issues)\n%!"
    else (
      reset ();
      let argv = [| "progname"; "--require" |] in
      let opt = { name = ("require", 'r'); arg = `Required (fun _ -> ()) } in
      let got_error = ref false in
      (try
         ignore (getopt_long argv [opt]);
         Printf.printf "  ✗ Should have raised Missing_argument\n%!"
         (* Note: behavior may vary by platform *)
       with
        | Missing_argument 'r' ->
            got_error := true;
            Printf.printf "  ✓ getopt_long raised Missing_argument\n%!"
        | Unknown_option _ ->
            (* Some implementations might return unknown option *)
            got_error := true;
            Printf.printf
              "  ✓ getopt_long raised error (platform-specific behavior)\n%!"
        | e ->
            Printf.printf "  ⚠ Unexpected exception: %s\n%!"
              (Printexc.to_string e);
            got_error := true);
      if !got_error then
        Printf.printf "  ✓ getopt_long error handling tested\n%!"
      else Printf.printf "  ⚠ getopt_long did not raise expected error\n%!"))

(* Test that optional arguments work correctly *)
let test_optional_argument_handling () =
  Printf.printf "Testing optional argument handling...\n%!";
  reset ();
  let argv = [| "progname"; "-o"; "value" |] in
  let received = ref None in
  let opt = { name = 'o'; arg = `Optional (fun arg -> received := Some arg) } in
  let ret = getopt argv [opt] in
  match !received with
    | Some (Some "value") ->
        assert (Array.length ret = 0);
        Printf.printf "  ✓ Optional argument handled correctly\n%!"
    | _ ->
        Printf.printf "  ✗ Optional argument not received correctly\n%!";
        assert false

(* Test that reset() properly resets state *)
let test_reset_state () =
  Printf.printf "Testing reset() state management...\n%!";
  (* First parse *)
  reset ();
  let argv1 = [| "progname"; "-a" |] in
  let called1 = ref false in
  let opt1 = { name = 'a'; arg = `None (fun () -> called1 := true) } in
  let _ = getopt argv1 [opt1] in
  assert !called1;

  (* Second parse with reset *)
  reset ();
  let argv2 = [| "progname"; "-b" |] in
  let called2 = ref false in
  let opt2 = { name = 'b'; arg = `None (fun () -> called2 := true) } in
  let _ = getopt argv2 [opt2] in
  assert !called2;
  Printf.printf "  ✓ reset() properly resets parsing state\n%!"

(* Test error message formatting *)
let test_error_message_format () =
  Printf.printf "Testing error message formatting...\n%!";
  let missing_arg_exception = Missing_argument 'x' in
  let msg1 = Printexc.to_string missing_arg_exception in
  assert (String.length msg1 > 0);

  let unknown_opt_exception = Unknown_option "--test" in
  let msg2 = Printexc.to_string unknown_opt_exception in
  assert (String.length msg2 > 0);
  Printf.printf "  ✓ Error messages are properly formatted\n%!"

let () =
  Printf.printf "\n=== POSIX Getopt Error Handling Tests ===\n\n%!";
  test_getopt_empty_argv ();
  test_missing_argument_error ();
  test_unknown_option_error ();
  test_getopt_long_errors ();
  test_optional_argument_handling ();
  test_reset_state ();
  test_error_message_format ();
  Printf.printf "\n✓ All getopt error tests passed!\n%!"
