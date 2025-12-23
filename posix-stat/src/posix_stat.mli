(** High-level API to <sys/stat.h>. See:
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_stat.h.html}
     sys/stat.h} for details on data structures and functions. *)

(** {2 File mode constants} *)

(** {3 File type constants} *)

val s_ifmt : Posix_types.mode_t
(** File type mask *)

val s_ifreg : Posix_types.mode_t
(** Regular file *)

val s_ifdir : Posix_types.mode_t
(** Directory *)

val s_iflnk : Posix_types.mode_t
(** Symbolic link *)

val s_ifchr : Posix_types.mode_t
(** Character device *)

val s_ifblk : Posix_types.mode_t
(** Block device *)

val s_ififo : Posix_types.mode_t
(** FIFO/pipe *)

val s_ifsock : Posix_types.mode_t
(** Socket *)

(** {3 Permission bit constants} *)

val s_isuid : Posix_types.mode_t
(** Set-user-ID on execution *)

val s_isgid : Posix_types.mode_t
(** Set-group-ID on execution *)

val s_isvtx : Posix_types.mode_t
(** Sticky bit *)

val s_irwxu : Posix_types.mode_t
(** Owner: read, write, execute *)

val s_irusr : Posix_types.mode_t
(** Owner: read permission *)

val s_iwusr : Posix_types.mode_t
(** Owner: write permission *)

val s_ixusr : Posix_types.mode_t
(** Owner: execute permission *)

val s_irwxg : Posix_types.mode_t
(** Group: read, write, execute *)

val s_irgrp : Posix_types.mode_t
(** Group: read permission *)

val s_iwgrp : Posix_types.mode_t
(** Group: write permission *)

val s_ixgrp : Posix_types.mode_t
(** Group: execute permission *)

val s_irwxo : Posix_types.mode_t
(** Others: read, write, execute *)

val s_iroth : Posix_types.mode_t
(** Others: read permission *)

val s_iwoth : Posix_types.mode_t
(** Others: write permission *)

val s_ixoth : Posix_types.mode_t
(** Others: execute permission *)

(** {2 File type test functions} *)

(** File type test functions (equivalent to POSIX S_IS* macros).
    These test the st_mode field to determine file type. *)

val s_isreg : Posix_types.mode_t -> bool
(** Test for regular file *)

val s_isdir : Posix_types.mode_t -> bool
(** Test for directory *)

val s_islnk : Posix_types.mode_t -> bool
(** Test for symbolic link *)

val s_ischr : Posix_types.mode_t -> bool
(** Test for character device *)

val s_isblk : Posix_types.mode_t -> bool
(** Test for block device *)

val s_isfifo : Posix_types.mode_t -> bool
(** Test for FIFO/pipe *)

val s_issock : Posix_types.mode_t -> bool
(** Test for socket *)

(** {2 File status structure} *)

(** High-level representation of struct stat. All fields are accessible
    as record fields. Timestamps use {!Posix_time2.Timespec.t}. *)
type stat = {
  st_dev : Posix_types.dev_t;  (** Device ID of device containing file *)
  st_ino : Posix_types.ino_t;  (** File serial number *)
  st_mode : Posix_types.mode_t;  (** File mode (type and permissions) *)
  st_nlink : Posix_types.nlink_t;  (** Number of hard links *)
  st_uid : Posix_types.uid_t;  (** User ID of file owner *)
  st_gid : Posix_types.gid_t;  (** Group ID of file owner *)
  st_rdev : Posix_types.dev_t;  (** Device ID (if special file) *)
  st_size : Posix_types.off_t;  (** File size in bytes *)
  st_atim : Posix_time2.Timespec.t;  (** Time of last access *)
  st_mtim : Posix_time2.Timespec.t;  (** Time of last modification *)
  st_ctim : Posix_time2.Timespec.t;  (** Time of last status change *)
  st_blksize : Posix_types.blksize_t;  (** Optimal block size for I/O *)
  st_blocks : Posix_types.blkcnt_t;  (** Number of 512-byte blocks allocated *)
}

(** {2 File status functions} *)

val stat : string -> stat
(** [stat path] returns file status for the file at [path].
    Follows symbolic links.
    @raise Unix.Unix_error on failure *)

val fstat : Unix.file_descr -> stat
(** [fstat fd] returns file status for the open file descriptor [fd].
    @raise Unix.Unix_error on failure *)

val lstat : string -> stat
(** [lstat path] returns file status for the file at [path].
    Does not follow symbolic links (returns info about the link itself).
    @raise Unix.Unix_error on failure *)

(** {2 Permission change functions} *)

val chmod : string -> Posix_types.mode_t -> unit
(** [chmod path mode] changes the file mode (permissions) of [path].
    @raise Unix.Unix_error on failure *)

val fchmod : Unix.file_descr -> Posix_types.mode_t -> unit
(** [fchmod fd mode] changes the file mode of the open file descriptor [fd].
    @raise Unix.Unix_error on failure *)

(** {2 Directory and special file creation} *)

val mkdir : string -> Posix_types.mode_t -> unit
(** [mkdir path mode] creates a new directory at [path] with permissions [mode].
    @raise Unix.Unix_error on failure *)

val mkfifo : string -> Posix_types.mode_t -> unit
(** [mkfifo path mode] creates a FIFO special file at [path] with permissions [mode].
    @raise Unix.Unix_error on failure *)

(** {2 File creation mask} *)

val umask : Posix_types.mode_t -> Posix_types.mode_t
(** [umask mask] sets the file mode creation mask and returns the previous value.
    The mask determines which permission bits are turned off when creating new files. *)

(** {2 Advanced *at functions} *)

(** Constants for *at functions *)
val at_fdcwd : int
(** Use current working directory *)

val at_symlink_nofollow : int
(** Don't follow symbolic links *)

val at_removedir : int
(** Remove directory instead of file *)

val at_eaccess : int
(** Use effective IDs for access check *)

val fstatat : ?dirfd:Unix.file_descr -> ?flags:int list -> string -> stat
(** [fstatat ?dirfd ?flags path] is like {!stat} but interprets [path]
    relative to directory [dirfd]. If [dirfd] is omitted, uses current
    working directory. [flags] may include {!at_symlink_nofollow}.
    @raise Unix.Unix_error on failure *)

val fchmodat :
  ?dirfd:Unix.file_descr ->
  ?flags:int list ->
  string ->
  Posix_types.mode_t ->
  unit
(** [fchmodat ?dirfd ?flags path mode] is like {!chmod} but interprets
    [path] relative to directory [dirfd].
    @raise Unix.Unix_error on failure *)

val mkdirat : ?dirfd:Unix.file_descr -> string -> Posix_types.mode_t -> unit
(** [mkdirat ?dirfd path mode] is like {!mkdir} but interprets [path]
    relative to directory [dirfd].
    @raise Unix.Unix_error on failure *)

val mkfifoat : ?dirfd:Unix.file_descr -> string -> Posix_types.mode_t -> unit
(** [mkfifoat ?dirfd path mode] is like {!mkfifo} but interprets [path]
    relative to directory [dirfd].
    @raise Unix.Unix_error on failure *)
