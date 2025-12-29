(** Shared helper functions for posix-unistd tests *)

(* Verbose output flag - opt-out via OCAML_POSIX_NO_VERBOSE_TEST *)
let verbose =
  try
    ignore (Sys.getenv "OCAML_POSIX_NO_VERBOSE_TEST");
    false
  with Not_found -> true

(* Record to store test results *)
type test_result = {
  test_name : string;
  function_tested : string;
  expected : string;
  actual : string;
  status : string;
}

(* List to collect test results *)
let test_results = ref []

let add_test_result test_name function_tested expected actual status =
  if verbose then
    test_results :=
      { test_name; function_tested; expected; actual; status } :: !test_results

(* Flush the test results as a table *)
let flush_verbose () =
  if verbose && !test_results <> [] then (
    let results = List.rev !test_results in
    (* Separate passed/failed from skipped *)
    let passed_failed, skipped =
      List.partition (fun r -> r.status <> "SKIP") results
    in

    (* Print pass/fail table *)
    if passed_failed <> [] then (
      Printf.printf "\n=== Test Results ===\n";
      let max_test_name =
        List.fold_left
          (fun acc r -> max acc (String.length r.test_name))
          10 passed_failed
      in
      let max_function =
        List.fold_left
          (fun acc r -> max acc (String.length r.function_tested))
          8 passed_failed
      in
      let max_expected =
        List.fold_left
          (fun acc r -> max acc (String.length r.expected))
          8 passed_failed
      in
      let max_actual =
        List.fold_left
          (fun acc r -> max acc (String.length r.actual))
          6 passed_failed
      in
      let max_status = 6 in
      let line_len =
        max_test_name + max_function + max_expected + max_actual + max_status
        + 13
      in
      Printf.printf "%s\n" (String.make line_len '-');
      Printf.printf "| %-*s | %-*s | %-*s | %-*s | %-*s |\n" max_test_name
        "Test Name" max_function "Function" max_expected "Expected" max_actual
        "Actual" max_status "Status";
      Printf.printf "%s\n" (String.make line_len '-');
      List.iter
        (fun r ->
          Printf.printf "| %-*s | %-*s | %-*s | %-*s | %-*s |\n" max_test_name
            r.test_name max_function r.function_tested max_expected r.expected
            max_actual r.actual max_status r.status)
        passed_failed;
      Printf.printf "%s\n%!" (String.make line_len '-'));

    (* Print skipped table *)
    if skipped <> [] then (
      Printf.printf "\n=== Skipped Tests ===\n";
      let max_test_name =
        List.fold_left
          (fun acc r -> max acc (String.length r.test_name))
          10 skipped
      in
      let max_function =
        List.fold_left
          (fun acc r -> max acc (String.length r.function_tested))
          8 skipped
      in
      let max_reason =
        List.fold_left (fun acc r -> max acc (String.length r.actual)) 6 skipped
      in
      let line_len = max_test_name + max_function + max_reason + 7 in
      Printf.printf "%s\n" (String.make line_len '-');
      Printf.printf "| %-*s | %-*s | %-*s |\n" max_test_name "Test Name"
        max_function "Function" max_reason "Reason";
      Printf.printf "%s\n" (String.make line_len '-');
      List.iter
        (fun r ->
          Printf.printf "| %-*s | %-*s | %-*s |\n" max_test_name r.test_name
            max_function r.function_tested max_reason r.actual)
        skipped;
      Printf.printf "%s\n%!" (String.make line_len '-'));

    test_results := [])

(* Helper to create temporary files *)
let with_temp_file f =
  let tmp = Filename.temp_file "posix_unistd_test" ".tmp" in
  try
    let result = f tmp in
    (try Sys.remove tmp with _ -> ());
    result
  with e ->
    (try Sys.remove tmp with _ -> ());
    raise e

(* Helper to create temporary directory *)
let with_temp_dir f =
  let tmp = Filename.temp_file "posix_unistd_test" ".dir" in
  Unix.unlink tmp;
  Unix.mkdir tmp 0o755;
  try
    let result = f tmp in
    (try Unix.rmdir tmp with _ -> ());
    result
  with e ->
    (try Unix.rmdir tmp with _ -> ());
    raise e

(* Helper to check if an exception matches an errno
   Errno-unix raises Unix.Unix_error, this helper verifies the errno matches *)
let assert_raises_errno errno call f =
  let expected = Unix.error_message errno in
  try
    f ();
    add_test_result call call expected "No exception" "FAIL";
    OUnit2.assert_failure
      (Printf.sprintf "Expected exception with errno %s for call %s" expected
         call)
  with Unix.Unix_error (err, c, _) ->
    let actual = Printf.sprintf "%s (%s)" (Unix.error_message err) c in
    if errno = err && call = c then
      add_test_result call call expected actual "PASS"
    else (
      add_test_result call call expected actual "FAIL";
      if errno <> err then
        OUnit2.assert_equal
          ~msg:
            (Printf.sprintf "Wrong errno (expected %s, got %s)" expected
               (Unix.error_message err))
          errno err;
      if call <> c then
        OUnit2.assert_equal
          ~msg:(Printf.sprintf "Wrong call (expected %s, got %s)" call c)
          call c)

(* Helper to skip a test and record it in the table *)
let skip_test test_name function_name expected reason =
  add_test_result test_name function_name expected reason "SKIP";
  OUnit2.skip_if true reason

(* Helper to record a successful test *)
let record_success test_name function_name description =
  add_test_result test_name function_name description "Success" "PASS"

(* Wrapper for success tests *)
let test_success test_name function_name description f =
  try
    f ();
    record_success test_name function_name description
  with exn ->
    let error_msg = Printexc.to_string exn in
    add_test_result test_name function_name description error_msg "FAIL";
    raise exn

(* Verbose wrapper for OUnit2.assert_raises *)
let assert_raises_verbose expected_exn test_name f =
  let expected_str =
    match expected_exn with
      | Unix.Unix_error (err, call, _) ->
          Printf.sprintf "%s (%s)" (Unix.error_message err) call
      | _ -> Printexc.to_string expected_exn
  in
  let function_name =
    match expected_exn with
      | Unix.Unix_error (_, call, _) -> call
      | _ -> test_name
  in
  try
    ignore (f ());
    add_test_result test_name function_name expected_str "No exception" "FAIL";
    OUnit2.assert_failure
      (Printf.sprintf "Expected exception %s but none was raised"
         (Printexc.to_string expected_exn))
  with exn ->
    let actual_str =
      match exn with
        | Unix.Unix_error (err, call, _) ->
            Printf.sprintf "%s (%s)" (Unix.error_message err) call
        | _ -> Printexc.to_string exn
    in
    if exn = expected_exn then
      add_test_result test_name function_name expected_str actual_str "PASS"
    else (
      add_test_result test_name function_name expected_str actual_str "FAIL";
      raise exn)
