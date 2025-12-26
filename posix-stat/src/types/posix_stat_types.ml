open Ctypes
module Constants = Posix_stat_constants.Def (Posix_stat_generated_constants)

(* Re-export constants *)
let s_ifmt = Constants.s_ifmt
let s_ifreg = Constants.s_ifreg
let s_ifdir = Constants.s_ifdir
let s_iflnk = Constants.s_iflnk
let s_ifchr = Constants.s_ifchr
let s_ifblk = Constants.s_ifblk
let s_ififo = Constants.s_ififo
let s_ifsock = Constants.s_ifsock
let s_isuid = Constants.s_isuid
let s_isgid = Constants.s_isgid
let s_isvtx = Constants.s_isvtx
let s_irwxu = Constants.s_irwxu
let s_irusr = Constants.s_irusr
let s_iwusr = Constants.s_iwusr
let s_ixusr = Constants.s_ixusr
let s_irwxg = Constants.s_irwxg
let s_irgrp = Constants.s_irgrp
let s_iwgrp = Constants.s_iwgrp
let s_ixgrp = Constants.s_ixgrp
let s_irwxo = Constants.s_irwxo
let s_iroth = Constants.s_iroth
let s_iwoth = Constants.s_iwoth
let s_ixoth = Constants.s_ixoth
let at_fdcwd = Constants.at_fdcwd
let at_symlink_nofollow = Constants.at_symlink_nofollow
let at_removedir = Constants.at_removedir
let at_eaccess = Constants.at_eaccess

module Def (S : Cstubs.Types.TYPE) = struct
  (* Import timespec type from posix-time2 *)
  module Time2_types = Posix_time2_types.Def (S)

  module Stat = struct
    type t = unit

    let t = S.structure "stat"

    (* Required POSIX fields *)
    let st_dev = S.field t "st_dev" (S.lift_typ Posix_types.dev_t)
    let st_ino = S.field t "st_ino" (S.lift_typ Posix_types.ino_t)
    let st_mode = S.field t "st_mode" (S.lift_typ Posix_types.mode_t)
    let st_nlink = S.field t "st_nlink" (S.lift_typ Posix_types.nlink_t)
    let st_uid = S.field t "st_uid" (S.lift_typ Posix_types.uid_t)
    let st_gid = S.field t "st_gid" (S.lift_typ Posix_types.gid_t)
    let st_rdev = S.field t "st_rdev" (S.lift_typ Posix_types.dev_t)
    let st_size = S.field t "st_size" (S.lift_typ Posix_types.off_t)

    (* Timespec timestamps *)
    let st_atim = S.field t "st_atim" Time2_types.Timespec.t
    let st_mtim = S.field t "st_mtim" Time2_types.Timespec.t
    let st_ctim = S.field t "st_ctim" Time2_types.Timespec.t

    (* XSI optional fields *)
    let st_blksize = S.field t "st_blksize" (S.lift_typ Posix_types.blksize_t)
    let st_blocks = S.field t "st_blocks" (S.lift_typ Posix_types.blkcnt_t)
    let () = S.seal t
  end

  type stat = Stat.t structure

  let stat_t : stat S.typ = Stat.t
end
