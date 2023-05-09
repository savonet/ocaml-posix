open Ctypes
module Constants = Posix_stat_constants.Def (Posix_stat_generated_constants)
include Constants

module Def (S : Cstubs.Types.TYPE) = struct
  module Posix_time2_types = Posix_time2_types.Def (S)

  let timespec = Posix_time2_types.Timespec.t

  module Stat = struct
    type t = unit

    let t = S.structure "stat"
    let st_dev = S.field t "st_dev" (S.lift_typ Posix_types.dev_t)
    let st_ino = S.field t "st_ino" (S.lift_typ Posix_types.ino_t)
    let st_mode = S.field t "st_mode" (S.lift_typ Posix_types.mode_t)
    let st_nlink = S.field t "st_nlink" (S.lift_typ Posix_types.nlink_t)
    let st_uid = S.field t "st_uid" (S.lift_typ Posix_types.uid_t)
    let st_gid = S.field t "st_gid" (S.lift_typ Posix_types.gid_t)
    let st_rdev = S.field t "st_rdev" (S.lift_typ Posix_types.dev_t)
    let st_size = S.field t "st_size" (S.lift_typ Posix_types.off_t)
    let st_atim = S.field t "st_atim" timespec
    let st_mtim = S.field t "st_mtim" timespec
    let st_ctim = S.field t "st_ctim" timespec
    let st_blksize = S.field t "st_blksize" (S.lift_typ Posix_types.blksize_t)
    let st_blocks = S.field t "st_blocks" (S.lift_typ Posix_types.blkcnt_t)

    (*
    let st_atimespec = S.field t "st_atimespec" timespec
    let st_mtimespec = S.field t "st_mtimespec" timespec
    let st_ctimespec = S.field t "st_ctimespec" timespec
    let st_birthtimespec = S.field t "st_birthtimespec" timespec
    let st_flags = S.field t "st_flags" S.uint32_t
    let st_gen = S.field t "st_gen" S.uint32_t
    let st_lspare = S.field t "st_lspare" S.int32_t
    let st_qspare = S.field t "st_qspare" (carray 2 S.int64_t)
    *)
    let () = S.seal t
  end

  (*
  module Statfs = struct
    let fsid_t = S.structure "fsid_t"
    let val_ = S.field t "val" (carray 2 S.uint32_t)
    let () = S.seal fsid_t
    let t = S.structure "statfs"
    let f_bsize = S.field t "f_bsize" S.uint32_t
    let f_iosize = S.field t "f_iosize" S.int32_t
    let f_blocks = S.field t "f_blocks" S.uint64_t
    let f_bfree = S.field t "f_bfree" S.uint64_t
    let f_bavail = S.field t "f_bavail" S.uint64_t
    let f_files = S.field t "f_files" S.uint64_t
    let f_ffree = S.field t "f_ffree" S.uint64_t
    let f_fsid = S.field t "f_fsid" fsid_t
    let f_owner = S.field t "f_owner" (S.lift_typ Posix_types.uid_t)
    let f_type = S.field t "f_type" S.uint32_t
    let f_flags = S.field t "f_flags" S.uint32_t
    let f_fssubtype = S.field t "f_ssubtye" S.uint32_t

    let f_fstypename =
      S.field t "f_fstypename" (carray Constants.MFSTYPENAMELEN char)

    let f_mntonname = S.field t "f_mntonname" (carray Constants.MAXPATHLEN char)

    let f_mntfromname =
      S.field t "f_mntfromname" (carray Constants.MAXPATHLEN char)

    let f_reserved = S.field t "f_reserved" S.uint32_t
    let () = S.seal t
  end
  *)

  module Statvfs = struct
    type t = unit

    let t = S.structure "statvfs"
    let f_bsize = S.field t "f_bsize" S.ulong
    let f_frsize = S.field t "f_frsize" S.ulong
    let f_blocks = S.field t "f_blocks" (S.lift_typ Posix_types.fsblkcnt_t)
    let f_bfree = S.field t "f_bfree" (S.lift_typ Posix_types.fsblkcnt_t)
    let f_bavail = S.field t "f_bavail" (S.lift_typ Posix_types.fsblkcnt_t)
    let f_files = S.field t "f_files" (S.lift_typ Posix_types.fsfilcnt_t)
    let f_ffree = S.field t "f_ffree" (S.lift_typ Posix_types.fsfilcnt_t)
    let f_favail = S.field t "f_favail" (S.lift_typ Posix_types.fsfilcnt_t)
    let f_fsid = S.field t "f_fsid" S.ulong
    let f_flag = S.field t "f_flag" S.ulong
    let f_namemax = S.field t "f_namemax" S.ulong
    let () = S.seal t
  end
end
