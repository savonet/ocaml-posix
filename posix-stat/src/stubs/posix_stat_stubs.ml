open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F
  module Types = Posix_stat_types.Def (Posix_stat_generated_types)
  open Types

  (* stat.h *)

  let s_isblk = foreign "s_isblk" (Posix_types.mode_t @-> returning int)
  let s_ischr = foreign "s_ischr" (Posix_types.mode_t @-> returning int)
  let s_isdir = foreign "s_isdir" (Posix_types.mode_t @-> returning int)
  let s_isfifo = foreign "s_isfifo" (Posix_types.mode_t @-> returning int)
  let s_isreg = foreign "s_isreg" (Posix_types.mode_t @-> returning int)
  let s_islnk = foreign "s_islnk" (Posix_types.mode_t @-> returning int)
  let s_issock = foreign "s_issock" (Posix_types.mode_t @-> returning int)
  let s_typeismq = foreign "s_typeismq" (ptr Stat.t @-> returning int)
  let s_typeissem = foreign "s_typeissem" (ptr Stat.t @-> returning int)
  let s_typeisshm = foreign "s_typeisshm" (ptr Stat.t @-> returning int)
  let s_typeistmo = foreign "s_typeistmo" (ptr Stat.t @-> returning int)
  let chmod = foreign "chmod" (string @-> Posix_types.mode_t @-> returning int)
  let fchmod = foreign "fchmod" (int @-> Posix_types.mode_t @-> returning int)

  let fchmodat =
    foreign "fchmodat"
      (int @-> string @-> Posix_types.mode_t @-> int @-> returning int)

  let fstat = foreign "fstat" (int @-> ptr Stat.t @-> returning int)

  let fstatat =
    foreign "fstatat" (int @-> string @-> ptr Stat.t @-> int @-> returning int)

  let futimens =
    foreign "futimens" (int @-> carray 2 Timespec.t @-> returning int)

  let lstat = foreign "lstat" (string @-> ptr Stat.t @-> returning int)
  let mkdir = foreign "mkdir" (string @-> Posix_types.mode_t @-> returning int)

  let mkdirat =
    foreign "mkdirat" (int @-> string @-> Posix_types.mode_t @-> returning int)

  let mkfifo = foreign "mkfifo" (string @-> Posix_types.mode_t @-> returning int)

  let mkfifoat =
    foreign "mkfifoat" (int @-> string @-> Posix_types.mode_t @-> returning int)

  let mknod =
    foreign "mknod"
      (string @-> Posix_types.mode_t @-> Posix_types.dev_t @-> returning int)

  let mknodat =
    foreign "mknodat"
      (int @-> string @-> Posix_types.mode_t @-> Posix_types.dev_t
     @-> returning int)

  let stat = foreign "stat" (string @-> ptr Stat.t @-> returning int)

  let umask =
    foreign "umask" (Posix_types.mode_t @-> returning Posix_types.mode_t)

  let utimensat =
    foreign "utimensat"
      (int @-> string @-> carray 2 Timespec.t @-> int @-> returning int)

  (* statvfs.h *)

  let statvfs = foreign "statvfs" (string @-> ptr Statvfs.t @-> returning int)
  let fstatvfs = foreign "fstatvfs" (int @-> ptr Statvfs.t @-> returning int)
end
