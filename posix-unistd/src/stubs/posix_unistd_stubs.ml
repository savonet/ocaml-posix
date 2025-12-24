open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F

  let strlen_bytes = foreign "strlen_bytes" (ocaml_bytes @-> returning int)

  let memcpy_to_bytes =
    foreign "memcpy" (ocaml_bytes @-> ptr char @-> int @-> returning void)

  let memcpy_from_bytes =
    foreign "memcpy" (ptr char @-> ocaml_bytes @-> int @-> returning void)

  let ttyname_r =
    foreign "ttyname_r_bytes" (int @-> ocaml_bytes @-> int @-> returning int)

  let getlogin_r =
    foreign "getlogin_r_bytes" (ocaml_bytes @-> int @-> returning int)

  (* File descriptor operations *)
  let close = foreign "close" (int @-> returning int)
  let dup = foreign "dup" (int @-> returning int)
  let dup2 = foreign "dup2" (int @-> int @-> returning int)
  let pipe = foreign "pipe" (ptr int @-> returning int)

  (* Data synchronization *)
  let fsync = foreign "fsync" (int @-> returning int)
  let fdatasync = foreign "fdatasync" (int @-> returning int)
  let sync = foreign "sync" (void @-> returning void)

  (* File operations *)
  let link = foreign "link" (string @-> string @-> returning int)
  let symlink = foreign "symlink" (string @-> string @-> returning int)
  let unlink = foreign "unlink" (string @-> returning int)
  let rmdir = foreign "rmdir" (string @-> returning int)

  (* Directory operations *)
  let chdir = foreign "chdir" (string @-> returning int)
  let fchdir = foreign "fchdir" (int @-> returning int)
  let getcwd = foreign "getcwd" (ptr char @-> int @-> returning (ptr char))

  (* File permissions and ownership *)
  let access = foreign "access" (string @-> int @-> returning int)

  let chown =
    foreign "chown"
      (string @-> Posix_types.uid_t @-> Posix_types.gid_t @-> returning int)

  let fchown =
    foreign "fchown"
      (int @-> Posix_types.uid_t @-> Posix_types.gid_t @-> returning int)

  let lchown =
    foreign "lchown"
      (string @-> Posix_types.uid_t @-> Posix_types.gid_t @-> returning int)

  let truncate = foreign "truncate" (string @-> int @-> returning int)
  let ftruncate = foreign "ftruncate" (int @-> int @-> returning int)

  (* File locking *)
  let lockf = foreign "lockf" (int @-> int @-> int @-> returning int)
  let getpid = foreign "getpid" (void @-> returning int)
  let getppid = foreign "getppid" (void @-> returning int)
  let getpgid = foreign "getpgid" (int @-> returning int)
  let setpgid = foreign "setpgid" (int @-> int @-> returning int)
  let getpgrp = foreign "getpgrp" (void @-> returning int)
  let setpgrp = foreign "setpgrp" (void @-> returning int)
  let setsid = foreign "setsid" (void @-> returning int)
  let getsid = foreign "getsid" (int @-> returning int)

  (* User and group IDs *)
  let getuid = foreign "getuid" (void @-> returning Posix_types.uid_t)
  let geteuid = foreign "geteuid" (void @-> returning Posix_types.uid_t)
  let getgid = foreign "getgid" (void @-> returning Posix_types.gid_t)
  let getegid = foreign "getegid" (void @-> returning Posix_types.gid_t)
  let setuid = foreign "setuid" (Posix_types.uid_t @-> returning int)
  let seteuid = foreign "seteuid" (Posix_types.uid_t @-> returning int)
  let setgid = foreign "setgid" (Posix_types.gid_t @-> returning int)
  let setegid = foreign "setegid" (Posix_types.gid_t @-> returning int)

  let setreuid =
    foreign "setreuid"
      (Posix_types.uid_t @-> Posix_types.uid_t @-> returning int)

  let setregid =
    foreign "setregid"
      (Posix_types.gid_t @-> Posix_types.gid_t @-> returning int)

  (* Group membership *)
  let getgroups =
    foreign "getgroups" (int @-> ptr Posix_types.gid_t @-> returning int)

  let setgroups =
    foreign "setgroups" (int @-> ptr Posix_types.gid_t @-> returning int)

  (* System configuration *)
  let sysconf = foreign "sysconf" (int @-> returning long)
  let pathconf = foreign "pathconf" (string @-> int @-> returning long)
  let fpathconf = foreign "fpathconf" (int @-> int @-> returning long)

  (* Configuration strings - needs special handling for buffer size *)
  let confstr_ptr =
    foreign "confstr" (int @-> ptr char @-> int @-> returning int)

  (* Configuration strings - needs special handling for buffer size *)
  let confstr_bytes =
    foreign "confstr_bytes" (int @-> ocaml_bytes @-> int @-> returning int)

  (* Terminal *)
  let isatty = foreign "isatty" (int @-> returning int)
  let ttyname = foreign "ttyname" (int @-> returning string_opt)
  let ctermid = foreign "ctermid" (ptr char @-> returning (ptr char))
  let tcgetpgrp = foreign "tcgetpgrp" (int @-> returning int)
  let tcsetpgrp = foreign "tcsetpgrp" (int @-> int @-> returning int)

  (* System info *)
  let getpagesize = foreign "getpagesize" (void @-> returning int)
  let gethostid = foreign "gethostid" (void @-> returning long)
  let gethostname = foreign "gethostname" (ptr char @-> int @-> returning int)
  let sethostname = foreign "sethostname" (string @-> int @-> returning int)

  (* Login *)
  let getlogin = foreign "getlogin" (void @-> returning string_opt)
end
