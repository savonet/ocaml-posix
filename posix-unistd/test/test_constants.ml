open OUnit2
open Posix_unistd
open Test_helpers

let test_constants _ =
  test_success "constants" "constants" "Verify POSIX constants" (fun () ->
      (* Standard file descriptors *)
      assert_equal 0 stdin_fileno;
      assert_equal 1 stdout_fileno;
      assert_equal 2 stderr_fileno;

      (* Access modes *)
      assert (r_ok >= 0);
      assert (w_ok >= 0);
      assert (x_ok >= 0);
      assert (f_ok >= 0);

      (* Seek constants *)
      assert (seek_set >= 0);
      assert (seek_cur >= 0);
      assert (seek_end >= 0);

      (* Lockf constants *)
      assert (f_lock >= 0);
      assert (f_ulock >= 0);
      assert (f_test >= 0);
      assert (f_tlock >= 0);

      (* sysconf constants - just check they're defined *)
      assert (sc_pagesize > 0);
      assert (sc_open_max > 0);
      assert (sc_arg_max >= 0))

let suite = "Constants tests" >::: ["test_constants" >:: test_constants]
