open OUnit2
open Posix_unistd
open Test_helpers

(* Test error handling for file operations *)

let test_link_nonexistent _ =
  (* Linking to nonexistent file should raise ENOENT *)
  with_temp_file (fun tmp ->
      assert_raises_verbose
        (Unix.Unix_error (Unix.ENOENT, "link", ""))
        "link with nonexistent target"
        (fun () -> link ~target:"/nonexistent/source" ~link_name:tmp))

let test_link_permission_denied _ =
  (* Trying to create link in restricted directory should raise EACCES, EPERM, or EROFS *)
  (* Only test if we don't have root privileges *)
  if getuid () = 0 then
    skip_test "link permission denied" "link" "Permission denied (link)"
      "Running as root"
  else
    with_temp_file (fun tmp ->
        try
          link ~target:tmp ~link_name:"/root/testlink";
          (* Some systems might allow this or /root might not exist *)
          skip_test "link permission denied" "link" "Permission denied (link)"
            "Link succeeded or /root not protected"
        with
        | Unix.Unix_error
            ((Unix.EACCES | Unix.EPERM | Unix.EROFS | Unix.ENOENT), "link", _)
          as exn
        ->
          (* Expected - permission denied or /root doesn't exist *)
          let err_msg =
            match exn with
              | Unix.Unix_error (err, call, _) ->
                  Printf.sprintf "%s (%s)" (Unix.error_message err) call
              | _ -> Printexc.to_string exn
          in
          add_test_result "link permission denied" "link" "Permission denied"
            err_msg "PASS")

let test_symlink_nonexistent_dir _ =
  (* Creating symlink in nonexistent directory should raise ENOENT *)
  assert_raises_verbose
    (Unix.Unix_error (Unix.ENOENT, "symlink", ""))
    "symlink in nonexistent dir"
    (fun () -> symlink ~target:"/tmp/test" ~link_name:"/nonexistent/dir/link")

let test_readlink_nonexistent _ =
  (* Reading nonexistent symlink should raise ENOENT *)
  assert_raises_verbose
    (Unix.Unix_error (Unix.ENOENT, "readlink", ""))
    "readlink on nonexistent"
    (fun () -> readlink "/nonexistent/symlink")

let test_readlink_not_symlink _ =
  (* Reading a regular file with readlink should raise EINVAL *)
  with_temp_file (fun tmp ->
      assert_raises_verbose
        (Unix.Unix_error (Unix.EINVAL, "readlink", ""))
        "readlink on regular file"
        (fun () -> readlink tmp))

let test_unlink_nonexistent _ =
  (* Unlinking nonexistent file should raise ENOENT *)
  assert_raises_verbose
    (Unix.Unix_error (Unix.ENOENT, "unlink", ""))
    "unlink nonexistent"
    (fun () -> unlink "/nonexistent/file")

let test_unlink_directory _ =
  (* Unlinking a directory should raise EPERM or EISDIR *)
  with_temp_dir (fun tmpdir ->
      try
        unlink tmpdir;
        assert_failure "Unexpected success - should have failed"
      with Unix.Unix_error ((Unix.EPERM | Unix.EISDIR), "unlink", _) -> ())

let test_truncate_nonexistent _ =
  (* Truncating nonexistent file should raise ENOENT *)
  assert_raises_verbose
    (Unix.Unix_error (Unix.ENOENT, "truncate", ""))
    "truncate nonexistent"
    (fun () -> truncate "/nonexistent/file" 0)

let test_truncate_directory _ =
  (* Truncating a directory should raise EISDIR *)
  with_temp_dir (fun tmpdir ->
      assert_raises_verbose
        (Unix.Unix_error (Unix.EISDIR, "truncate", ""))
        "truncate directory"
        (fun () -> truncate tmpdir 0))

let test_chown_nonexistent _ =
  (* chown on nonexistent file should raise ENOENT *)
  let uid = getuid () in
  let gid = getgid () in
  assert_raises_verbose
    (Unix.Unix_error (Unix.ENOENT, "chown", ""))
    "chown nonexistent"
    (fun () -> chown "/nonexistent/file" uid gid)

let test_lchown_nonexistent _ =
  (* lchown on nonexistent file should raise ENOENT *)
  let uid = getuid () in
  let gid = getgid () in
  assert_raises_verbose
    (Unix.Unix_error (Unix.ENOENT, "lchown", ""))
    "lchown nonexistent"
    (fun () -> lchown "/nonexistent/file" uid gid)

let test_lockf_bad_fd _ =
  (* lockf on closed fd should raise EBADF *)
  with_temp_file (fun tmp ->
      let bad_fd = Unix.openfile tmp [Unix.O_RDWR] 0o644 in
      Unix.close bad_fd;
      assert_raises_verbose
        (Unix.Unix_error (Unix.EBADF, "lockf", ""))
        "lockf on bad fd"
        (fun () -> lockf bad_fd `Lock 0))

let suite =
  "File operation error tests"
  >::: [
         "test_link_nonexistent" >:: test_link_nonexistent;
         "test_link_permission_denied" >:: test_link_permission_denied;
         "test_symlink_nonexistent_dir" >:: test_symlink_nonexistent_dir;
         "test_readlink_nonexistent" >:: test_readlink_nonexistent;
         "test_readlink_not_symlink" >:: test_readlink_not_symlink;
         "test_unlink_nonexistent" >:: test_unlink_nonexistent;
         "test_unlink_directory" >:: test_unlink_directory;
         "test_truncate_nonexistent" >:: test_truncate_nonexistent;
         "test_truncate_directory" >:: test_truncate_directory;
         "test_chown_nonexistent" >:: test_chown_nonexistent;
         "test_lchown_nonexistent" >:: test_lchown_nonexistent;
         "test_lockf_bad_fd" >:: test_lockf_bad_fd;
       ]
