open Ctypes

(** File type constants *)
val s_ifmt : Posix_types.mode_t
val s_ifreg : Posix_types.mode_t
val s_ifdir : Posix_types.mode_t
val s_iflnk : Posix_types.mode_t
val s_ifchr : Posix_types.mode_t
val s_ifblk : Posix_types.mode_t
val s_ififo : Posix_types.mode_t
val s_ifsock : Posix_types.mode_t

(** Special mode bits *)
val s_isuid : Posix_types.mode_t
val s_isgid : Posix_types.mode_t
val s_isvtx : Posix_types.mode_t

(** Permission bits *)
val s_irwxu : Posix_types.mode_t
val s_irusr : Posix_types.mode_t
val s_iwusr : Posix_types.mode_t
val s_ixusr : Posix_types.mode_t

val s_irwxg : Posix_types.mode_t
val s_irgrp : Posix_types.mode_t
val s_iwgrp : Posix_types.mode_t
val s_ixgrp : Posix_types.mode_t

val s_irwxo : Posix_types.mode_t
val s_iroth : Posix_types.mode_t
val s_iwoth : Posix_types.mode_t
val s_ixoth : Posix_types.mode_t

(** *at function flags *)
val at_fdcwd : int
val at_symlink_nofollow : int
val at_removedir : int
val at_eaccess : int

(** Structure definitions *)
module Def (S : Cstubs.Types.TYPE) : sig
  module Time2_types : module type of Posix_time2_types.Def (S)

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
    val st_atim :
      (Time2_types.Timespec.t structure, t structure) S.field

    val st_mtim :
      (Time2_types.Timespec.t structure, t structure) S.field

    val st_ctim :
      (Time2_types.Timespec.t structure, t structure) S.field

    val st_blksize : (Posix_types.blksize_t, t structure) S.field
    val st_blocks : (Posix_types.blkcnt_t, t structure) S.field
  end

  type stat = Stat.t structure

  val stat_t : stat S.typ
end
