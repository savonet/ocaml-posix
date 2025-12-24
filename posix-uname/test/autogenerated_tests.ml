(* Error handling tests for posix-uname *)
open Posix_uname

(* Test uname basic functionality *)
let test_uname_success () =
  Printf.printf "Testing uname (success case)...\n%!";
  let { sysname; nodename; release; version; machine } = uname () in
  Printf.printf "  System information:\n%!";
  Printf.printf "    sysname:  %s\n%!" sysname;
  Printf.printf "    nodename: %s\n%!" nodename;
  Printf.printf "    release:  %s\n%!" release;
  Printf.printf "    version:  %s\n%!" version;
  Printf.printf "    machine:  %s\n%!" machine;
  (* Validate that fields are non-empty *)
  assert (String.length sysname > 0);
  assert (String.length machine > 0);
  Printf.printf "  ✓ uname succeeded with valid data\n%!"

(* Test that repeated calls return consistent results *)
let test_uname_consistency () =
  Printf.printf "Testing uname consistency...\n%!";
  let info1 = uname () in
  let info2 = uname () in
  (* System name and machine should be consistent *)
  assert (info1.sysname = info2.sysname);
  assert (info1.machine = info2.machine);
  Printf.printf "  ✓ uname returns consistent results\n%!"

(* Test expected values on common systems *)
let test_uname_expected_values () =
  Printf.printf "Testing uname expected values...\n%!";
  let { sysname; machine; _ } = uname () in
  (* Check for common Unix-like system names *)
  let known_systems =
    [ "Linux"; "Darwin"; "FreeBSD"; "OpenBSD"; "NetBSD"; "SunOS" ]
  in
  let is_known_system = List.mem sysname known_systems in
  if is_known_system then
    Printf.printf "  ✓ Recognized system: %s\n%!" sysname
  else
    Printf.printf "  ⚠ Unknown system name (not an error): %s\n%!" sysname;

  (* Check that machine architecture looks reasonable *)
  let known_arches =
    [
      "x86_64";
      "amd64";
      "i386";
      "i686";
      "arm64";
      "aarch64";
      "armv7l";
      "ppc64le";
      "s390x";
      "riscv64";
    ]
  in
  let is_known_arch = List.mem machine known_arches in
  if is_known_arch then Printf.printf "  ✓ Recognized architecture: %s\n%!" machine
  else Printf.printf "  ⚠ Unknown architecture (not an error): %s\n%!" machine

(* Note: uname() rarely fails in practice. According to POSIX, it can only fail with:
   - EFAULT: Invalid buffer pointer (but we control this in the binding)

   Since we allocate the buffer correctly in our binding, there's no practical
   way to trigger an error without corrupting memory, which we cannot safely
   test. The error handling in the binding ensures that if the C function
   somehow returns an error, it will be properly raised as a Unix_error.
*)

let () =
  Printf.printf "\n=== POSIX Uname Error Handling Tests ===\n\n%!";
  Printf.printf
    "Note: uname() has very limited error cases in POSIX (only EFAULT)\n%!";
  Printf.printf
    "and our binding handles buffer allocation safely, so we focus on\n%!";
  Printf.printf "testing success cases and data validity.\n\n%!";
  test_uname_success ();
  test_uname_consistency ();
  test_uname_expected_values ();
  Printf.printf "\n✓ All uname tests passed!\n%!"
