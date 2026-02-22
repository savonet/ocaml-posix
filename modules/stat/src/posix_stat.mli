(** POSIX file status and permissions.

    This module provides OCaml bindings to POSIX file status functions defined in
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_stat.h.html} sys/stat.h}.

    It includes functions for querying file metadata, changing permissions,
    and creating directories and special files.

    {2 Example}

    {[
      (* Get file information *)
      let info = stat "/etc/passwd" in
      Printf.printf "Size: %Ld bytes\n" (Posix_types.Off.to_int64 info.st_size);

      (* Check if it's a regular file *)
      if s_isreg info.st_mode then
        print_endline "Regular file"
    ]} *)

(** {1 File Type Constants}

    Constants for the file type portion of [st_mode].
    Use {!s_ifmt} to mask out the file type bits. *)

(** File type mask. Use as [Posix_types.Mode.logand mode s_ifmt]. *)
val s_ifmt : Posix_types.mode_t

(** Regular file (S_IFREG). *)
val s_ifreg : Posix_types.mode_t

(** Directory (S_IFDIR). *)
val s_ifdir : Posix_types.mode_t

(** Symbolic link (S_IFLNK). *)
val s_iflnk : Posix_types.mode_t

(** Character device (S_IFCHR). *)
val s_ifchr : Posix_types.mode_t

(** Block device (S_IFBLK). *)
val s_ifblk : Posix_types.mode_t

(** FIFO/named pipe (S_IFIFO). *)
val s_ififo : Posix_types.mode_t

(** Socket (S_IFSOCK). *)
val s_ifsock : Posix_types.mode_t

(** {1 Permission Bit Constants}

    Constants for file permission bits in [st_mode]. *)

(** {2 Special Mode Bits} *)

(** Set-user-ID on execution (S_ISUID). *)
val s_isuid : Posix_types.mode_t

(** Set-group-ID on execution (S_ISGID). *)
val s_isgid : Posix_types.mode_t

(** Sticky bit (S_ISVTX). On directories, restricts file deletion. *)
val s_isvtx : Posix_types.mode_t

(** {2 Owner Permissions} *)

(** Owner: read, write, execute (S_IRWXU = 0o700). *)
val s_irwxu : Posix_types.mode_t

(** Owner: read permission (S_IRUSR = 0o400). *)
val s_irusr : Posix_types.mode_t

(** Owner: write permission (S_IWUSR = 0o200). *)
val s_iwusr : Posix_types.mode_t

(** Owner: execute permission (S_IXUSR = 0o100). *)
val s_ixusr : Posix_types.mode_t

(** {2 Group Permissions} *)

(** Group: read, write, execute (S_IRWXG = 0o070). *)
val s_irwxg : Posix_types.mode_t

(** Group: read permission (S_IRGRP = 0o040). *)
val s_irgrp : Posix_types.mode_t

(** Group: write permission (S_IWGRP = 0o020). *)
val s_iwgrp : Posix_types.mode_t

(** Group: execute permission (S_IXGRP = 0o010). *)
val s_ixgrp : Posix_types.mode_t

(** {2 Others Permissions} *)

(** Others: read, write, execute (S_IRWXO = 0o007). *)
val s_irwxo : Posix_types.mode_t

(** Others: read permission (S_IROTH = 0o004). *)
val s_iroth : Posix_types.mode_t

(** Others: write permission (S_IWOTH = 0o002). *)
val s_iwoth : Posix_types.mode_t

(** Others: execute permission (S_IXOTH = 0o001). *)
val s_ixoth : Posix_types.mode_t

(** {1 File Type Test Functions}

    These functions test the [st_mode] field to determine file type.
    They are equivalent to the POSIX S_IS* macros. *)

(** [s_isreg mode] returns [true] if [mode] indicates a regular file. *)
val s_isreg : Posix_types.mode_t -> bool

(** [s_isdir mode] returns [true] if [mode] indicates a directory. *)
val s_isdir : Posix_types.mode_t -> bool

(** [s_islnk mode] returns [true] if [mode] indicates a symbolic link. *)
val s_islnk : Posix_types.mode_t -> bool

(** [s_ischr mode] returns [true] if [mode] indicates a character device. *)
val s_ischr : Posix_types.mode_t -> bool

(** [s_isblk mode] returns [true] if [mode] indicates a block device. *)
val s_isblk : Posix_types.mode_t -> bool

(** [s_isfifo mode] returns [true] if [mode] indicates a FIFO/named pipe. *)
val s_isfifo : Posix_types.mode_t -> bool

(** [s_issock mode] returns [true] if [mode] indicates a socket. *)
val s_issock : Posix_types.mode_t -> bool

(** {1 File Status Structure} *)

(** File status information returned by {!stat}, {!fstat}, and {!lstat}.
    Corresponds to POSIX [struct stat]. *)
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

(** {1 File Status Functions} *)

(** Get file status, following symbolic links.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/stat.html} stat(2)}.

    @raise Unix.Unix_error on failure. *)
val stat : string -> stat

(** Get file status for an open file descriptor.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/fstat.html} fstat(2)}.

    @raise Unix.Unix_error on failure. *)
val fstat : Unix.file_descr -> stat

(** Get file status without following symbolic links.

    Returns information about the symbolic link itself, not its target.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/lstat.html} lstat(2)}.

    @raise Unix.Unix_error on failure. *)
val lstat : string -> stat

(** {1 Permission Functions} *)

(** Change file permissions.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/chmod.html} chmod(2)}.

    @raise Unix.Unix_error on failure. *)
val chmod : string -> Posix_types.mode_t -> unit

(** Change file permissions using a file descriptor.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/fchmod.html} fchmod(2)}.

    @raise Unix.Unix_error on failure. *)
val fchmod : Unix.file_descr -> Posix_types.mode_t -> unit

(** {1 File Creation} *)

(** Create a directory.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/mkdir.html} mkdir(2)}.

    @raise Unix.Unix_error on failure. *)
val mkdir : string -> Posix_types.mode_t -> unit

(** Create a FIFO (named pipe).

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/mkfifo.html} mkfifo(3)}.

    @raise Unix.Unix_error on failure. *)
val mkfifo : string -> Posix_types.mode_t -> unit

(** {1 File Creation Mask} *)

(** Set the file mode creation mask.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/umask.html} umask(2)}.

    The umask is used to turn off permission bits when creating files.
    For example, [umask (Mode.of_int 0o022)] prevents group and others
    write permissions on newly created files.

    @return The previous umask value. *)
val umask : Posix_types.mode_t -> Posix_types.mode_t

(** {1 Directory-Relative Operations}

    These functions operate relative to a directory file descriptor,
    providing protection against certain race conditions (TOCTOU).

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/fstatat.html} *at(2)} functions. *)

(** Use current working directory as the base for relative paths.
    Pass this as [dirfd] to use CWD like the non-[*at] functions. *)
val at_fdcwd : int

(** Flag: do not follow symbolic links. *)
val at_symlink_nofollow : int

(** Flag: remove directory instead of file (for unlinkat). *)
val at_removedir : int

(** Flag: use effective IDs for access checks (for faccessat). *)
val at_eaccess : int

(** Like {!stat}/{!lstat} but relative to a directory file descriptor.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/fstatat.html} fstatat(2)}.

    @param dirfd Base directory (default: current working directory).
    @param flags May include {!at_symlink_nofollow} to not follow symlinks.
    @raise Unix.Unix_error on failure. *)
val fstatat : ?dirfd:Unix.file_descr -> ?flags:int list -> string -> stat

(** Like {!chmod} but relative to a directory file descriptor.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/fchmodat.html} fchmodat(2)}.

    @param dirfd Base directory (default: current working directory).
    @param flags Optional flags.
    @raise Unix.Unix_error on failure. *)
val fchmodat :
  ?dirfd:Unix.file_descr ->
  ?flags:int list ->
  string ->
  Posix_types.mode_t ->
  unit

(** Like {!mkdir} but relative to a directory file descriptor.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/mkdirat.html} mkdirat(2)}.

    @param dirfd Base directory (default: current working directory).
    @raise Unix.Unix_error on failure. *)
val mkdirat : ?dirfd:Unix.file_descr -> string -> Posix_types.mode_t -> unit

(** Like {!mkfifo} but relative to a directory file descriptor.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/mkfifoat.html} mkfifoat(3)}.

    @param dirfd Base directory (default: current working directory).
    @raise Unix.Unix_error on failure. *)
val mkfifoat : ?dirfd:Unix.file_descr -> string -> Posix_types.mode_t -> unit
