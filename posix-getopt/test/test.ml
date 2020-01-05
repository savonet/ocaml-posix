open OUnit2
open Posix_getopt

let sysname = Posix_uname.((uname ()).sysname)

let test_short_flag _ =
  reset ();
  let argv = [| "progname"; "-b" |] in
  let test = ref false in
  let opt = { name = 'b'; arg = `None (fun () -> test := true) } in
  let ret = getopt argv [opt] in
  assert !test;
  assert (Array.length ret = 0)

let test_short_required _ =
  reset ();
  let argv = [| "progname"; "-b"; "arg" |] in
  let test = ref "" in
  let opt = { name = 'b'; arg = `Required (fun arg -> test := arg) } in
  let ret = getopt argv [opt] in
  assert_equal "arg" !test;
  assert (Array.length ret = 0)

let test_long_required_long _ =
  skip_if (not has_getopt_long) "Doesn't support getopt_long";
  reset ();
  let argv = [| "progname"; "--bla"; "arg" |] in
  let test = ref "" in
  let opt = { name = ("bla", 'b'); arg = `Required (fun arg -> test := arg) } in
  let ret = getopt_long argv [opt] in
  assert_equal "arg" !test;
  assert (Array.length ret = 0)

let test_long_required_short _ =
  skip_if (not has_getopt_long) "Doesn't support getopt_long";
  reset ();
  let argv = [| "progname"; "-b"; "arg" |] in
  let test = ref "" in
  let opt = { name = ("bla", 'b'); arg = `Required (fun arg -> test := arg) } in
  let ret = getopt_long argv [opt] in
  assert_equal "arg" !test;
  assert (Array.length ret = 0)

let test_short_required_no_arg _ =
  reset ();
  let argv = [| "progname"; "-b" |] in
  let opt = { name = 'b'; arg = `Required (fun _ -> ()) } in
  let test = ref false in
  begin
    try ignore (getopt argv [opt]) with Missing_argument 'b' -> test := true
  end;
  assert !test

let test_long_required_no_long_arg _ =
  skip_if (not has_getopt_long) "Doesn't support getopt_long";
  skip_if (sysname = "Darwin") "Doesn't work on OSX";
  reset ();
  let argv = [| "progname"; "--bla" |] in
  let opt = { name = ("bla", 'b'); arg = `Required (fun _ -> ()) } in
  let test = ref false in
  begin
    try ignore (getopt_long argv [opt])
    with Missing_argument 'b' -> test := true
  end;
  assert !test

let test_long_required_no_short_arg _ =
  skip_if (not has_getopt_long) "Doesn't support getopt_long";
  reset ();
  let argv = [| "progname"; "-b" |] in
  let opt = { name = ("bla", 'b'); arg = `Required (fun _ -> ()) } in
  let test = ref false in
  begin
    try ignore (getopt_long argv [opt])
    with Missing_argument 'b' -> test := true
  end;
  assert !test

let test_short_optional_no_arg _ =
  reset ();
  let argv = [| "progname"; "-b" |] in
  let test = ref false in
  let opt = { name = 'b'; arg = `Optional (fun arg -> test := arg = None) } in
  let ret = getopt argv [opt] in
  assert !test;
  assert (Array.length ret = 0)

let test_short_optional_arg _ =
  reset ();
  let argv = [| "progname"; "-b"; "yup" |] in
  let test = ref false in
  let opt =
    { name = 'b'; arg = `Optional (fun arg -> test := arg = Some "yup") }
  in
  let ret = getopt argv [opt] in
  assert !test;
  assert (Array.length ret = 0)

let test_remaining_arg _ =
  reset ();
  let argv = [| "progname"; "--"; "-b" |] in
  let opt = { name = 'b'; arg = `None (fun () -> ()) } in
  let ret = getopt argv [opt] in
  assert_equal [| "-b" |] ret

let test_permuted_remaining_arg _ =
  skip_if (sysname = "Darwin") "Doesn't work on OSX";
  reset ();
  let argv = [| "progname"; "bla"; "-b" |] in
  let opt = { name = 'b'; arg = `None (fun () -> ()) } in
  let ret = getopt argv [opt] in
  assert_equal [| "bla" |] ret

let test_complex_scenario _ =
  skip_if (not has_getopt_long) "Doesn't support getopt_long";
  reset ();
  let argv =
    [|
      "progname";
      "-a";
      "-cret";
      "-bopt";
      "--gno";
      "gna";
      "--foo";
      "--foo";
      "--";
      "bla";
    |]
  in
  let a = ref false in
  let b = ref "" in
  let c = ref (Some "value") in
  let gno = ref "" in
  let foo = ref false in
  let opts =
    [
      { name = ("aa", 'a'); arg = `None (fun () -> a := true) };
      { name = ("bb", 'b'); arg = `Required (fun v -> b := v) };
      { name = ("cc", 'c'); arg = `Optional (fun v -> c := v) };
      { name = ("gno", 'g'); arg = `Required (fun v -> gno := v) };
      { name = ("foo", 'f'); arg = `None (fun () -> foo := true) };
    ]
  in
  let ret = getopt_long argv opts in
  assert !a;
  assert_equal "opt" !b;
  assert_equal (Some "ret") !c;
  assert_equal "gna" !gno;
  assert_equal true !foo;
  assert_equal [| "bla" |] ret

let suite =
  "getopt tests"
  >::: [
         "test_short_flag" >:: test_short_flag;
         "test_short_required" >:: test_short_required;
         "test_long_required_long" >:: test_long_required_long;
         "test_long_required_short" >:: test_long_required_short;
         "test_short_required_no_arg" >:: test_short_required_no_arg;
         "test_long_required_no_short_arg" >:: test_long_required_no_short_arg;
         "test_long_required_no_long_arg" >:: test_long_required_no_long_arg;
         "test_short_optional_no_arg" >:: test_short_optional_no_arg;
         "test_short_optional_arg" >:: test_short_optional_arg;
         "test_remaining_arg" >:: test_remaining_arg;
         "test_permuted_remaining_arg" >:: test_permuted_remaining_arg;
         "test_complex_scenario" >:: test_complex_scenario;
       ]

let () = run_test_tt_main suite
