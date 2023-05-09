open Ctypes
open Posix_time2_types

module Def (S : Cstubs.Types.TYPE) : sig
  module Stat : sig
    type t

    val t : t structure S.typ
    val st_dev : (Posix_types.dev_t, t structure) S.field
    val st_ino : (Posix_types.ino_t, t structure) S.field
    val st_mode : (Posix_types.mode_t, t structure) S.field
    val st_nlink : (Posix_types.nlink_t, t structure) S.field
    val st_uid : (Posix_types.uid_t, t structure) S.field
    val st_gid : (Posix_types.gid_t, t structure) S.field
    val st_rdev : (Posix_types.dev_t, t structure) S.field
    val st_size : (Posix_types.off_t, t structure) S.field
    val st_atim : (Posix_time2_types.Def(S).Timespec.t typ, t structure) S.field
    val st_mtim : (Posix_time2_types.Def(S).Timespec.t typ, t structure) S.field
    val st_ctim : (Posix_time2_types.Def(S).Timespec.t typ, t structure) S.field
    val st_blksize : (Posix_types.blksize_t, t structure) S.field
    val st_blocks : (Posix_types.blkcnt_t, t structure) S.field

    (* val st_flags : (Unsigned.uint8, t structure) S.field *)
    (* val st_gen : (Unsigned.uint32, t structure) S.field *)
    (* val st_lspare : (Unsigned.uint32, t structure) S.field *)
    (* val st_qspare : (Unsigned.uint32, t structure) S.field *)
  end

  (*
  module Statfs : sig
    val fsid_t : t structure S.typ
    val val_ : (carray 2 Unsigned.uint32, fsid_t structure) S.field

    type t

    val t : t structure S.typ
    val f_bsize : (Unsigned.uint32, t structure) S.field
    val f_iosize : (Posix_types.int32_t, t structure) S.field
    val f_blocks : (Unsigned.uint64, t structure) S.field
    val f_bfree : (Unsigned.uint64, t structure) S.field
    val f_bavail : (Posix_types.uint_t, t structure) S.field
    val f_files : (Unsigned.uint64, t structure) S.field
    val f_ffree : (Unsigned.uint64, t structure) S.field
    val f_fsid : (fsid_t, t structure) S.field
    val f_owner : (Posix_types.uid_t, t structure) S.field
    val f_type : (Unsigned.uint32, t structure) S.field
    val f_flags : (Unsigned.uint32, t structure) S.field
    val f_fssubtype : (Unsigned.uint32, t structure) S.field
    val f_fstypename : (carray Constants.MFSTYPENAMELEN char, t structure) S.field
    val f_mntonname : (carray Constants.MAXPATHLEN char, t structure) S.field
    val f_mntfromname : (carray Constants.MAXPATHLEN char, t structure) S.field
    val f_reserved : (Unsigned.uint32, t structure) S.field
  end
  *)

  module Statvfs : sig
    type t

    val t : t structure S.typ
    val f_bsize : (Unsigned.ulong, t structure) S.field
    val f_frsize : (Unsigned.ulong, t structure) S.field
    val f_blocks : (Posix_types.fsblkcnt_t, t structure) S.field
    val f_bfree : (Posix_types.fsblkcnt_t, t structure) S.field
    val f_bavail : (Posix_types.fsblkcnt_t, t structure) S.field
    val f_files : (Posix_types.fsfilcnt_t, t structure) S.field
    val f_ffree : (Posix_types.fsfilcnt_t, t structure) S.field
    val f_favail : (Posix_types.fsfilcnt_t, t structure) S.field
    val f_fsid : (Unsigned.ulong, t structure) S.field
    val f_flag : (Unsigned.ulong, t structure) S.field
    val f_namemax : (Unsigned.ulong, t structure) S.field
  end
end
