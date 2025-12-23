open Ctypes
include Posix_stat_stubs.Def (Posix_stat_generated_stubs)

(* Re-export constants *)
let s_ifmt = Posix_stat_types.s_ifmt
let s_ifreg = Posix_stat_types.s_ifreg
let s_ifdir = Posix_stat_types.s_ifdir
let s_iflnk = Posix_stat_types.s_iflnk
let s_ifchr = Posix_stat_types.s_ifchr
let s_ifblk = Posix_stat_types.s_ifblk
let s_ififo = Posix_stat_types.s_ififo
let s_ifsock = Posix_stat_types.s_ifsock

let s_isuid = Posix_stat_types.s_isuid
let s_isgid = Posix_stat_types.s_isgid
let s_isvtx = Posix_stat_types.s_isvtx

let s_irwxu = Posix_stat_types.s_irwxu
let s_irusr = Posix_stat_types.s_irusr
let s_iwusr = Posix_stat_types.s_iwusr
let s_ixusr = Posix_stat_types.s_ixusr

let s_irwxg = Posix_stat_types.s_irwxg
let s_irgrp = Posix_stat_types.s_irgrp
let s_iwgrp = Posix_stat_types.s_iwgrp
let s_ixgrp = Posix_stat_types.s_ixgrp

let s_irwxo = Posix_stat_types.s_irwxo
let s_iroth = Posix_stat_types.s_iroth
let s_iwoth = Posix_stat_types.s_iwoth
let s_ixoth = Posix_stat_types.s_ixoth

let at_fdcwd = Posix_stat_types.at_fdcwd
let at_symlink_nofollow = Posix_stat_types.at_symlink_nofollow
let at_removedir = Posix_stat_types.at_removedir
let at_eaccess = Posix_stat_types.at_eaccess

(* File type test functions - implement as OCaml functions *)
let s_isreg mode =
  Posix_types.Mode.(equal (logand mode s_ifmt) s_ifreg)

let s_isdir mode =
  Posix_types.Mode.(equal (logand mode s_ifmt) s_ifdir)

let s_islnk mode =
  Posix_types.Mode.(equal (logand mode s_ifmt) s_iflnk)

let s_ischr mode =
  Posix_types.Mode.(equal (logand mode s_ifmt) s_ifchr)

let s_isblk mode =
  Posix_types.Mode.(equal (logand mode s_ifmt) s_ifblk)

let s_isfifo mode =
  Posix_types.Mode.(equal (logand mode s_ifmt) s_ififo)

let s_issock mode =
  Posix_types.Mode.(equal (logand mode s_ifmt) s_ifsock)

(* High-level stat type *)
type stat = {
  st_dev : Posix_types.dev_t;
  st_ino : Posix_types.ino_t;
  st_mode : Posix_types.mode_t;
  st_nlink : Posix_types.nlink_t;
  st_uid : Posix_types.uid_t;
  st_gid : Posix_types.gid_t;
  st_rdev : Posix_types.dev_t;
  st_size : Posix_types.off_t;
  st_atim : Posix_time2.Timespec.t;
  st_mtim : Posix_time2.Timespec.t;
  st_ctim : Posix_time2.Timespec.t;
  st_blksize : Posix_types.blksize_t;
  st_blocks : Posix_types.blkcnt_t;
}

(* Helper to convert C struct stat to OCaml record *)
let from_stat stat_ptr =
  let get f = getf stat_ptr f in
  let get_timespec f =
    let ts = get f in
    let tv_sec = Posix_types.Time.to_int64 (getf ts Types.Time2_types.Timespec.tv_sec) in
    let tv_nsec = Signed.Long.to_int64 (getf ts Types.Time2_types.Timespec.tv_nsec) in
    Posix_time2.Timespec.create tv_sec tv_nsec
  in
  {
    st_dev = get Types.Stat.st_dev;
    st_ino = get Types.Stat.st_ino;
    st_mode = get Types.Stat.st_mode;
    st_nlink = get Types.Stat.st_nlink;
    st_uid = get Types.Stat.st_uid;
    st_gid = get Types.Stat.st_gid;
    st_rdev = get Types.Stat.st_rdev;
    st_size = get Types.Stat.st_size;
    st_atim = get_timespec Types.Stat.st_atim;
    st_mtim = get_timespec Types.Stat.st_mtim;
    st_ctim = get_timespec Types.Stat.st_ctim;
    st_blksize = get Types.Stat.st_blksize;
    st_blocks = get Types.Stat.st_blocks;
  }

(* Helper to convert Unix.file_descr to int *)
external fd_to_int : Unix.file_descr -> int = "%identity"

(* stat functions *)
let stat path =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let st = make Types.Stat.t in
          match stat path (addr st) with
          | x when x < 0 -> None
          | _ -> Some (from_stat st)))

let fstat fd =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let st = make Types.Stat.t in
          match fstat (fd_to_int fd) (addr st) with
          | x when x < 0 -> None
          | _ -> Some (from_stat st)))

let lstat path =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let st = make Types.Stat.t in
          match lstat path (addr st) with
          | x when x < 0 -> None
          | _ -> Some (from_stat st)))

(* chmod functions *)
let chmod path mode =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          match chmod path mode with
          | x when x < 0 -> None
          | _ -> Some ()))

let fchmod fd mode =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          match fchmod (fd_to_int fd) mode with
          | x when x < 0 -> None
          | _ -> Some ()))

(* Directory and special file creation *)
let mkdir path mode =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          match mkdir path mode with
          | x when x < 0 -> None
          | _ -> Some ()))

let mkfifo path mode =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          match mkfifo path mode with
          | x when x < 0 -> None
          | _ -> Some ()))

(* umask - note: doesn't fail, returns previous mask *)
let umask mask = umask mask

(* *at functions with optional arguments *)
let fstatat ?(dirfd = Unix.stdin) ?(flags = []) path =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let st = make Types.Stat.t in
          let fd_int =
            if dirfd = Unix.stdin then at_fdcwd else fd_to_int dirfd
          in
          let flags_int = List.fold_left ( lor ) 0 flags in
          match fstatat fd_int path (addr st) flags_int with
          | x when x < 0 -> None
          | _ -> Some (from_stat st)))

let fchmodat ?(dirfd = Unix.stdin) ?(flags = []) path mode =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let fd_int =
            if dirfd = Unix.stdin then at_fdcwd else fd_to_int dirfd
          in
          let flags_int = List.fold_left ( lor ) 0 flags in
          match fchmodat fd_int path mode flags_int with
          | x when x < 0 -> None
          | _ -> Some ()))

let mkdirat ?(dirfd = Unix.stdin) path mode =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let fd_int =
            if dirfd = Unix.stdin then at_fdcwd else fd_to_int dirfd
          in
          match mkdirat fd_int path mode with
          | x when x < 0 -> None
          | _ -> Some ()))

let mkfifoat ?(dirfd = Unix.stdin) path mode =
  Errno_unix.with_unix_exn (fun () ->
      Errno_unix.raise_on_errno (fun () ->
          let fd_int =
            if dirfd = Unix.stdin then at_fdcwd else fd_to_int dirfd
          in
          match mkfifoat fd_int path mode with
          | x when x < 0 -> None
          | _ -> Some ()))
