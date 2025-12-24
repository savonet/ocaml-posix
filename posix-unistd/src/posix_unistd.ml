open Ctypes
include Posix_unistd_stubs.Def (Posix_unistd_generated_stubs)
include Posix_unistd_stubs_unlocked.Def (Posix_unistd_generated_stubs_unlocked)
module Constants = Posix_unistd_constants.Def (Posix_unistd_generated_constants)
include Constants

(* Helper to convert Unix.file_descr to int *)
external fd_to_int : Unix.file_descr -> int = "%identity"

(* Helper to convert int to Unix.file_descr *)
external int_to_fd : int -> Unix.file_descr = "%identity"

let default_buf_len = 1024

(* Basic I/O operations with OCaml-friendly API *)
let read_wrapper ~name ~fn fd buf ofs len =
  if ofs < 0 || len < 0 || ofs + len > Bytes.length buf then
    invalid_arg (name ^ ": invalid offset or length");
  let fd = fd_to_int fd in
  let tmp = CArray.make char len in
  let result =
    Posix_errno.raise_on_neg ~call:name (fun () -> fn fd (CArray.start tmp) len)
  in
  memcpy_to_bytes (ocaml_bytes_start buf) (CArray.start tmp) result;
  result

let write_wrapper ~name ~fn fd buf ofs len =
  if ofs < 0 || len < 0 || ofs + len > Bytes.length buf then
    invalid_arg (name ^ ": invalid offset or length");
  let fd = fd_to_int fd in
  let tmp = CArray.make char len in
  memcpy_from_bytes (CArray.start tmp) (ocaml_bytes_start buf)
    (Bytes.length buf);
  Posix_errno.raise_on_neg ~call:name (fun () -> fn fd (CArray.start tmp) len)

let read = read_wrapper ~name:"read" ~fn:read
let write = write_wrapper ~name:"write" ~fn:write

let pread fd buf ofs len offset =
  read_wrapper ~name:"pread"
    ~fn:(fun fd buf len -> pread fd buf len offset)
    fd buf ofs len

let pwrite fd buf ofs len offset =
  write_wrapper ~name:"pwrite"
    ~fn:(fun fd buf len -> pwrite fd buf len offset)
    fd buf ofs len

(* File descriptor operations *)
let close fd =
  ignore
    (Posix_errno.raise_on_neg ~call:"close" (fun () -> close (fd_to_int fd)))

let dup fd =
  int_to_fd
    (Posix_errno.raise_on_neg ~call:"dup" (fun () -> dup (fd_to_int fd)))

let dup2 fd1 fd2 =
  let fd1 = fd_to_int fd1 in
  let fd2 = fd_to_int fd2 in
  int_to_fd (Posix_errno.raise_on_neg ~call:"dup2" (fun () -> dup2 fd1 fd2))

let pipe () =
  let fds = allocate_n int ~count:2 in
  ignore (Posix_errno.raise_on_neg ~call:"pipe" (fun () -> pipe fds));
  (int_to_fd !@fds, int_to_fd !@(fds +@ 1))

(* Data synchronization *)
let fsync fd =
  let fd = fd_to_int fd in
  ignore (Posix_errno.raise_on_neg ~call:"fsync" (fun () -> fsync fd))

let fdatasync fd =
  let fd = fd_to_int fd in
  ignore (Posix_errno.raise_on_neg ~call:"fdatasync" (fun () -> fdatasync fd))

(* File operations *)
let link ~target ~link_name =
  ignore
    (Posix_errno.raise_on_neg ~call:"link" (fun () -> link target link_name))

let symlink ~target ~link_name =
  ignore
    (Posix_errno.raise_on_neg ~call:"symlink" (fun () ->
         symlink target link_name))

let readlink ?(max_len = default_buf_len) path =
  let buf = CArray.make char max_len in
  let len =
    Posix_errno.raise_on_neg ~call:"readlink" (fun () ->
        readlink path (CArray.start buf) default_buf_len)
  in
  string_from_ptr (CArray.start buf) ~length:len

let unlink path =
  ignore (Posix_errno.raise_on_neg ~call:"unlink" (fun () -> unlink path))

let rmdir path =
  ignore (Posix_errno.raise_on_neg ~call:"rmdir" (fun () -> rmdir path))

(* Directory operations *)
let chdir path =
  ignore (Posix_errno.raise_on_neg ~call:"chdir" (fun () -> chdir path))

let fchdir fd =
  let fd = fd_to_int fd in
  ignore (Posix_errno.raise_on_neg ~call:"fchdir" (fun () -> fchdir fd))

let getcwd () =
  let buf = CArray.make char default_buf_len in
  ignore
    (Posix_errno.raise_on_null ~call:"getcwd" (fun () ->
         getcwd (CArray.start buf) default_buf_len));
  let len = strlen (CArray.start buf) in
  let bytes = Bytes.create len in
  memcpy_to_bytes (ocaml_bytes_start bytes) (CArray.start buf) len;
  Bytes.unsafe_to_string bytes

(* File positioning *)
type seek_command = Seek_set | Seek_cur | Seek_end

let lseek fd offset whence =
  let fd = fd_to_int fd in
  let whence =
    match whence with
      | Seek_set -> seek_set
      | Seek_cur -> seek_cur
      | Seek_end -> seek_end
  in
  Posix_errno.raise_on_neg ~call:"lseek" (fun () -> lseek fd offset whence)

(* File permissions and ownership *)
type access_permission = [ `Read | `Write | `Execute | `Exists ]

let access path perms =
  let mode =
    List.fold_left
      (fun acc perm ->
        acc
        lor
          match perm with
          | `Read -> r_ok
          | `Write -> w_ok
          | `Execute -> x_ok
          | `Exists -> f_ok)
      0 perms
  in
  access path mode = 0

let chown path uid gid =
  let uid = Posix_types.Uid.of_int uid in
  let gid = Posix_types.Gid.of_int gid in
  ignore (Posix_errno.raise_on_neg ~call:"chown" (fun () -> chown path uid gid))

let fchown fd uid gid =
  let fd = fd_to_int fd in
  let uid = Posix_types.Uid.of_int uid in
  let gid = Posix_types.Gid.of_int gid in
  ignore (Posix_errno.raise_on_neg ~call:"fchown" (fun () -> fchown fd uid gid))

let lchown path uid gid =
  let uid = Posix_types.Uid.of_int uid in
  let gid = Posix_types.Gid.of_int gid in
  ignore
    (Posix_errno.raise_on_neg ~call:"lchown" (fun () -> lchown path uid gid))

let truncate path length =
  ignore
    (Posix_errno.raise_on_neg ~call:"truncate" (fun () -> truncate path length))

let ftruncate fd length =
  let fd = fd_to_int fd in
  ignore
    (Posix_errno.raise_on_neg ~call:"ftruncate" (fun () -> ftruncate fd length))

(* File locking *)
type lock_command = [ `Unlock | `Lock | `Test_lock | `Try_lock ]

let lockf fd cmd size =
  let fd = fd_to_int fd in
  let cmd =
    match cmd with
      | `Unlock -> f_ulock
      | `Lock -> f_lock
      | `Try_lock -> f_tlock
      | `Test_lock -> f_test
  in
  ignore (Posix_errno.raise_on_neg ~call:"lockf" (fun () -> lockf fd cmd size))

(* Process operations *)
let fork () = Posix_errno.raise_on_neg ~call:"fork" fork

let getpgid pid =
  Posix_errno.raise_on_neg ~call:"getpgid" (fun () -> getpgid pid)

let setpgid pid pgid =
  ignore (Posix_errno.raise_on_neg ~call:"setpgid" (fun () -> setpgid pid pgid))

let setpgrp () = ignore (Posix_errno.raise_on_neg ~call:"setpgrp" setpgrp)
let setsid () = Posix_errno.raise_on_neg ~call:"setsid" setsid
let getsid pid = Posix_errno.raise_on_neg ~call:"getsid" (fun () -> getsid pid)

(* User and group IDs *)
let getuid () = Posix_types.Uid.to_int (getuid ())
let geteuid () = Posix_types.Uid.to_int (geteuid ())
let getgid () = Posix_types.Gid.to_int (getgid ())
let getegid () = Posix_types.Gid.to_int (getegid ())

let setuid uid =
  let uid = Posix_types.Uid.of_int uid in
  ignore (Posix_errno.raise_on_neg ~call:"setuid" (fun () -> setuid uid))

let seteuid uid =
  let uid = Posix_types.Uid.of_int uid in
  ignore (Posix_errno.raise_on_neg ~call:"seteuid" (fun () -> seteuid uid))

let setgid gid =
  let gid = Posix_types.Gid.of_int gid in
  ignore (Posix_errno.raise_on_neg ~call:"setgid" (fun () -> setgid gid))

let setegid gid =
  let gid = Posix_types.Gid.of_int gid in
  ignore (Posix_errno.raise_on_neg ~call:"setegid" (fun () -> setegid gid))

let setreuid ruid euid =
  let ruid = Posix_types.Uid.of_int ruid in
  let euid = Posix_types.Uid.of_int euid in
  ignore
    (Posix_errno.raise_on_neg ~call:"setreuid" (fun () -> setreuid ruid euid))

let setregid rgid egid =
  let rgid = Posix_types.Gid.of_int rgid in
  let egid = Posix_types.Gid.of_int egid in
  ignore
    (Posix_errno.raise_on_neg ~call:"setregid" (fun () -> setregid rgid egid))

(* Group membership *)
let getgroups () =
  let ngroups =
    Posix_errno.raise_on_neg ~call:"getgroups" (fun () ->
        getgroups 0 (from_voidp Posix_types.gid_t null))
  in
  let groups = allocate_n Posix_types.gid_t ~count:ngroups in
  let n =
    Posix_errno.raise_on_neg ~call:"getgroups" (fun () ->
        getgroups ngroups groups)
  in
  let result = Array.init n (fun i -> Posix_types.Gid.to_int !@(groups +@ i)) in
  Array.to_list result

let setgroups groups =
  let ngroups = List.length groups in
  let groups_arr =
    CArray.of_list Posix_types.gid_t (List.map Posix_types.Gid.of_int groups)
  in
  ignore
    (Posix_errno.raise_on_neg ~call:"setgroups" (fun () ->
         setgroups ngroups (CArray.start groups_arr)))

(* System configuration *)
let sysconf name = Signed.Long.to_int (sysconf name)
let pathconf path name = Signed.Long.to_int (pathconf path name)

let fpathconf fd name =
  let fd_int = fd_to_int fd in
  Signed.Long.to_int (fpathconf fd_int name)

let confstr name =
  let size =
    Posix_errno.raise_on_neg ~call:"confstr" (fun () ->
        confstr_ptr name (from_voidp char null) 0)
  in
  let buf = Bytes.create size in
  let ret = confstr_bytes name (ocaml_bytes_start buf) size in
  assert (ret = size);
  Bytes.unsafe_to_string buf

(* Signal/timer *)
let pause () =
  ignore (Posix_errno.raise_on_neg ~call:"pause" (fun () -> pause ()))

let usleep n =
  ignore (Posix_errno.raise_on_neg ~call:"usleep" (fun () -> usleep n))

(* Terminal *)
let isatty fd =
  let fd = fd_to_int fd in
  isatty fd <> 0

let ttyname fd =
  let fd = fd_to_int fd in
  Posix_errno.raise_on_none ~call:"ttyname" (fun () -> ttyname fd)

let ttyname_r fd buf =
  let fd = fd_to_int fd in
  match ttyname_r fd (ocaml_bytes_start buf) (Bytes.length buf) with
    | 0 -> Bytes.sub buf 0 (strlen_bytes (ocaml_bytes_start buf))
    | n ->
        raise
          (Unix.Unix_error (Posix_errno.int_to_unix_error n, "ttyname_r", ""))

let ctermid () =
  let buf = CArray.make char max_hostname in
  let result =
    Posix_errno.raise_on_null ~call:"ctermid" (fun () ->
        ctermid (CArray.start buf))
  in
  string_from_ptr result ~length:max_hostname

let tcgetpgrp fd =
  let fd = fd_to_int fd in
  Posix_errno.raise_on_neg ~call:"tcgetpgrp" (fun () -> tcgetpgrp fd)

let tcsetpgrp fd pgrp =
  let fd = fd_to_int fd in
  ignore
    (Posix_errno.raise_on_neg ~call:"tcsetpgrp" (fun () -> tcsetpgrp fd pgrp))

(* System info *)
let gethostid () = Signed.Long.to_int64 (gethostid ())

let gethostname () =
  let buf = CArray.make char max_hostname in
  ignore
    (Posix_errno.raise_on_neg ~call:"gethostname" (fun () ->
         gethostname (CArray.start buf) max_hostname));
  string_from_ptr (CArray.start buf) ~length:max_hostname

let sethostname name =
  ignore
    (Posix_errno.raise_on_neg ~call:"sethostname" (fun () ->
         sethostname name (String.length name)))

(* Login *)
let getlogin () =
  Posix_errno.raise_on_none ~call:"getlogin" (fun () -> getlogin ())

let getlogin_r buf =
  match getlogin_r (ocaml_bytes_start buf) (Bytes.length buf) with
    | 0 -> Bytes.sub buf 0 (strlen_bytes (ocaml_bytes_start buf))
    | n ->
        raise
          (Unix.Unix_error (Posix_errno.int_to_unix_error n, "getlogin_r", ""))

(* Program execution *)
let execv path args =
  let args_arr = CArray.of_list string ((path :: args) @ [""]) in
  ignore
    (Posix_errno.raise_on_neg ~call:"execv" (fun () ->
         execv path (CArray.start args_arr)))

let execve path args env =
  let args_arr = CArray.of_list string ((path :: args) @ [""]) in
  let env_arr = CArray.of_list string (env @ [""]) in
  ignore
    (Posix_errno.raise_on_neg ~call:"execve" (fun () ->
         execve path (CArray.start args_arr) (CArray.start env_arr)))

let execvp file args =
  let args_arr = CArray.of_list string ((file :: args) @ [""]) in
  ignore
    (Posix_errno.raise_on_neg ~call:"execvp" (fun () ->
         execvp file (CArray.start args_arr)))
