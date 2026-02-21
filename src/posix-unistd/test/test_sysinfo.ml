open OUnit2
open Posix_unistd
open Test_helpers

let test_sysconf _ =
  test_success "sysconf" "sysconf" "Get system configuration" (fun () ->
      (* Test pagesize *)
      let size = sysconf sc_pagesize in
      assert_bool "Page size should be positive" (size > 0);
      assert_bool "Page size should be a power of 2" (size land (size - 1) = 0);

      (* Test open_max - can be -1 (unlimited) or a positive value *)
      let max = sysconf sc_open_max in
      assert_bool "Open max should be -1 or positive" (max = -1 || max > 0))

let test_pathconf _ =
  test_success "pathconf" "pathconf" "Get path configuration" (fun () ->
      with_temp_file (fun tmp ->
          let max = pathconf tmp pc_name_max in
          assert_bool "Name max should be positive" (max > 0)))

let test_confstr _ =
  test_success "confstr" "confstr" "Get configuration string" (fun () ->
      let path = confstr cs_path in
      assert_bool "PATH should not be empty" (String.length path > 0))

let test_getpagesize _ =
  test_success "getpagesize" "getpagesize" "Get system page size" (fun () ->
      let pagesize = getpagesize () in
      assert_bool "Page size should be positive" (pagesize > 0);
      assert_bool "Page size should be power of 2"
        (pagesize land (pagesize - 1) = 0))

let test_gethostname _ =
  test_success "gethostname" "gethostname" "Get hostname" (fun () ->
      let hostname = gethostname () in
      assert_bool "Hostname should not be empty" (String.length hostname > 0))

let test_gethostid _ =
  test_success "gethostid" "gethostid" "Get host ID" (fun () ->
      let hostid = gethostid () in
      (* Just verify we can call it *)
      ignore hostid)

let skip_login =
  try
    ignore (getlogin ());
    false
  with _ -> true

let test_getlogin _ =
  if skip_login then
    skip_test "getlogin" "getlogin" "Get login name"
      "getlogin not available in this environment"
  else
    test_success "getlogin" "getlogin" "Get login name" (fun () ->
        let login = getlogin () in
        assert_bool "Login name should not be empty" (String.length login > 0))

let test_getlogin_r _ =
  if skip_login then
    skip_test "getlogin_r" "getlogin_r" "Get login name (reentrant)"
      "getlogin_r not available in this environment"
  else
    test_success "getlogin_r" "getlogin_r" "Get login name (reentrant)"
      (fun () ->
        let login = getlogin_r () in
        assert_bool "Login name should not be empty" (String.length login > 0))

let suite =
  "System configuration and info tests"
  >::: [
         "test_sysconf" >:: test_sysconf;
         "test_pathconf" >:: test_pathconf;
         "test_confstr" >:: test_confstr;
         "test_getpagesize" >:: test_getpagesize;
         "test_gethostname" >:: test_gethostname;
         "test_gethostid" >:: test_gethostid;
         "test_getlogin" >:: test_getlogin;
         "test_getlogin_r" >:: test_getlogin_r;
       ]
