open Posix_errno

let () =
  Printf.printf "=== POSIX Errno strerror Tests ===\n\n";

  Printf.printf "Testing strerror with common errno values:\n";

  (* Test with errno integers *)
  let test_errno errnum err_variant =
    Printf.printf "  %s (errno %d): %s\n"
      (match err_variant with
        | `EPERM -> "EPERM"
        | `ENOENT -> "ENOENT"
        | `ESRCH -> "ESRCH"
        | `EINTR -> "EINTR"
        | `EIO -> "EIO"
        | `ENXIO -> "ENXIO"
        | `EBADF -> "EBADF"
        | `EAGAIN -> "EAGAIN"
        | `ENOMEM -> "ENOMEM"
        | `EACCES -> "EACCES"
        | `EFAULT -> "EFAULT"
        | `EBUSY -> "EBUSY"
        | `EEXIST -> "EEXIST"
        | `ENOTDIR -> "ENOTDIR"
        | `EISDIR -> "EISDIR"
        | `EINVAL -> "EINVAL"
        | `EMFILE -> "EMFILE"
        | `ENOSPC -> "ENOSPC"
        | `EPIPE -> "EPIPE"
        | `ERANGE -> "ERANGE"
        | _ -> "OTHER")
      errnum
      (strerror (of_int errnum))
  in

  (* Test common POSIX errors *)
  test_errno (to_int `EPERM) `EPERM;
  test_errno (to_int `ENOENT) `ENOENT;
  test_errno (to_int `ESRCH) `ESRCH;
  test_errno (to_int `EINTR) `EINTR;
  test_errno (to_int `EIO) `EIO;
  test_errno (to_int `ENXIO) `ENXIO;
  test_errno (to_int `EBADF) `EBADF;
  test_errno (to_int `EAGAIN) `EAGAIN;
  test_errno (to_int `ENOMEM) `ENOMEM;
  test_errno (to_int `EACCES) `EACCES;
  test_errno (to_int `EFAULT) `EFAULT;
  test_errno (to_int `EBUSY) `EBUSY;
  test_errno (to_int `EEXIST) `EEXIST;
  test_errno (to_int `ENOTDIR) `ENOTDIR;
  test_errno (to_int `EISDIR) `EISDIR;
  test_errno (to_int `EINVAL) `EINVAL;
  test_errno (to_int `EMFILE) `EMFILE;
  test_errno (to_int `ENOSPC) `ENOSPC;
  test_errno (to_int `EPIPE) `EPIPE;
  test_errno (to_int `ERANGE) `ERANGE;

  Printf.printf "\nTesting strerror_of_t with errno variants:\n";

  (* Test with errno variants *)
  let test_errno_t err name = Printf.printf "  %s: %s\n" name (strerror err) in

  test_errno_t `ECONNREFUSED "ECONNREFUSED";
  test_errno_t `EADDRINUSE "EADDRINUSE";
  test_errno_t `ETIMEDOUT "ETIMEDOUT";
  test_errno_t `ENOTCONN "ENOTCONN";
  test_errno_t `EHOSTUNREACH "EHOSTUNREACH";

  Printf.printf "\nTesting strerror (cross-platform, not thread-safe):\n";
  Printf.printf "  EPERM: %s\n" (strerror `EPERM);
  Printf.printf "  ENOENT: %s\n" (strerror `ENOENT);

  Printf.printf "\nTesting strerror_r with custom buffer length:\n";

  (* Skip strerror_r tests on Windows where it's not available *)
  if Sys.os_type = "Win32" then
    Printf.printf "  (Skipped on Windows - strerror_r not available)\n"
  else (
    (* Test with small buffer *)
    Printf.printf "  EPERM (buflen=50): %s\n" (strerror_r ~buflen:50 `EPERM);
    Printf.printf "  EACCES (buflen=50): %s\n" (strerror_r ~buflen:50 `EACCES));

  Printf.printf "\n✓ All strerror tests completed successfully!\n"
