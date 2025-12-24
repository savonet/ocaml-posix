(** POSIX unistd.h bindings with OCaml-friendly API

    This module provides comprehensive bindings to POSIX unistd.h functions,
    with a user-friendly OCaml interface. Functions are wrapped to use standard
    OCaml types where appropriate and integrate with the Unix module.

    Most functions return [option] types: [Some value] on success, [None] on
    error (with errno set appropriately via Errno_unix). *)

(** {1 Constants} *)

(** {2 Hostname limits} *)

val max_hostname : int

(** {2 System configuration (sysconf) constants} *)

(** Commonly available sysconf names *)
val sc_arg_max : int

val sc_child_max : int
val sc_clk_tck : int
val sc_open_max : int
val sc_pagesize : int
val sc_page_size : int
val sc_nprocessors_onln : int
val sc_nprocessors_conf : int
val sc_phys_pages : int
val sc_stream_max : int
val sc_tzname_max : int
val sc_version : int
val sc_atexit_max : int
val sc_login_name_max : int
val sc_tty_name_max : int
val sc_host_name_max : int
val sc_line_max : int
val sc_getgr_r_size_max : int
val sc_getpw_r_size_max : int
val sc_ngroups_max : int
val sc_re_dup_max : int
val sc_symloop_max : int

(** POSIX options *)
val sc_job_control : int

val sc_saved_ids : int
val sc_fsync : int
val sc_mapped_files : int
val sc_memlock : int
val sc_memlock_range : int
val sc_memory_protection : int
val sc_priority_scheduling : int
val sc_synchronized_io : int
val sc_timers : int
val sc_asynchronous_io : int
val sc_prioritized_io : int
val sc_realtime_signals : int
val sc_semaphores : int
val sc_shared_memory_objects : int
val sc_message_passing : int
val sc_threads : int
val sc_thread_safe_functions : int
val sc_thread_attr_stackaddr : int
val sc_thread_attr_stacksize : int
val sc_thread_priority_scheduling : int
val sc_thread_prio_inherit : int
val sc_thread_prio_protect : int
val sc_thread_process_shared : int

(** POSIX.2 constants *)
val sc_2_version : int

val sc_2_c_bind : int
val sc_2_c_dev : int
val sc_bc_base_max : int
val sc_bc_dim_max : int
val sc_bc_scale_max : int
val sc_bc_string_max : int
val sc_coll_weights_max : int
val sc_expr_nest_max : int

(** X/Open constants *)
val sc_xopen_version : int

val sc_xopen_crypt : int
val sc_xopen_enh_i18n : int
val sc_xopen_shm : int
val sc_xopen_unix : int

(** {2 Path configuration (pathconf) constants} *)

val pc_link_max : int
val pc_max_canon : int
val pc_max_input : int
val pc_name_max : int
val pc_path_max : int
val pc_pipe_buf : int
val pc_no_trunc : int
val pc_vdisable : int
val pc_chown_restricted : int
val pc_async_io : int
val pc_prio_io : int
val pc_sync_io : int
val pc_filesizebits : int
val pc_2_symlinks : int
val pc_symlink_max : int

(** {2 File locking (lockf) commands} *)

val f_ulock : int
val f_lock : int
val f_tlock : int
val f_test : int

(** {2 Configuration strings (confstr) constants} *)

val cs_path : int

(** {2 File positioning (lseek) constants} *)

val seek_set : int
val seek_cur : int
val seek_end : int

(** {2 File access mode flags} *)

(** Read permission *)
val r_ok : int

(** Write permission *)
val w_ok : int

(** Execute permission *)
val x_ok : int

(** File exists *)
val f_ok : int

(** {2 Standard file descriptors} *)

val stdin_fileno : int
val stdout_fileno : int
val stderr_fileno : int

(** {1 Basic I/O Operations} *)

(** [read fd buf ofs len] reads up to [len] bytes from [fd] into [buf] starting
    at offset [ofs]. Returns [Some n] where [n] is the number of bytes read, or
    [None] on error. *)
val read : Unix.file_descr -> bytes -> int -> int -> int

(** [write fd buf ofs len] writes up to [len] bytes from [buf] starting at
    offset [ofs] to [fd]. Returns [Some n] where [n] is the number of bytes
    written, or [None] on error. *)
val write : Unix.file_descr -> bytes -> int -> int -> int

(** {1 Positioned I/O} *)

(** [pread fd buf ofs len offset] reads up to [len] bytes from [fd] at file
    offset [offset] into [buf] starting at [ofs]. Does not change the file
    offset. Returns [Some n] or [None] on error. *)
val pread : Unix.file_descr -> bytes -> int -> int -> int -> int

(** [pwrite fd buf ofs len offset] writes up to [len] bytes to [fd] at file
    offset [offset] from [buf] starting at [ofs]. Does not change the file
    offset. Returns [Some n] or [None] on error. *)
val pwrite : Unix.file_descr -> bytes -> int -> int -> int -> int

(** {1 File Descriptor Operations} *)

(** [close fd] closes the file descriptor [fd]. *)
val close : Unix.file_descr -> unit

(** [dup fd] duplicates the file descriptor [fd]. *)
val dup : Unix.file_descr -> Unix.file_descr

(** [dup2 fd1 fd2] duplicates [fd1] to [fd2], closing [fd2] first if necessary.
*)
val dup2 : Unix.file_descr -> Unix.file_descr -> Unix.file_descr

(** [pipe ()] creates a pipe and returns [(read_end, write_end)]. *)
val pipe : unit -> Unix.file_descr * Unix.file_descr

(** {1 Data Synchronization} *)

(** [fsync fd] synchronizes file data and metadata to disk. *)
val fsync : Unix.file_descr -> unit

(** [fdatasync fd] synchronizes file data (but not necessarily metadata) to
    disk. *)
val fdatasync : Unix.file_descr -> unit

(** [sync ()] schedules writes of all modified buffer cache blocks to disk. *)
val sync : unit -> unit

(** {1 File Operations} *)

(** [link ~target ~link_name] creates a hard link. *)
val link : target:string -> link_name:string -> unit

(** [symlink ~target ~link_name] creates a symbolic link. *)
val symlink : target:string -> link_name:string -> unit

(** [readlink path] reads the target of a symbolic link. *)
val readlink : ?max_len:int -> string -> string

(** [unlink path] removes a file. *)
val unlink : string -> unit

(** [rmdir path] removes an empty directory. *)
val rmdir : string -> unit

(** {1 Directory Operations} *)

(** [chdir path] changes the current working directory. *)
val chdir : string -> unit

(** [fchdir fd] changes the current working directory to the directory
    referenced by [fd]. *)
val fchdir : Unix.file_descr -> unit

(** [getcwd ()] returns the current working directory. *)
val getcwd : unit -> string

(** {1 File Positioning} *)

type seek_command =
  | Seek_set
  | Seek_cur
  | Seek_end  (** File positioning commands for [lseek]. *)

(** [lseek fd offset whence] repositions the file offset. *)
val lseek : Unix.file_descr -> int -> seek_command -> int

(** {1 File Permissions and Ownership} *)

(** Access permission flags for [access]. *)
type access_permission = [ `Read | `Write | `Execute | `Exists ]

(** [access path perms] checks whether the calling process can access the file
    [path] with the specified permissions. *)
val access : string -> access_permission list -> bool

(** [chown path uid gid] changes file ownership. *)
val chown : string -> int -> int -> unit

(** [fchown fd uid gid] changes file ownership using a file descriptor. *)
val fchown : Unix.file_descr -> int -> int -> unit

(** [lchown path uid gid] changes ownership of a symbolic link itself. *)
val lchown : string -> int -> int -> unit

(** [truncate path length] truncates a file to specified length. *)
val truncate : string -> int -> unit

(** [ftruncate fd length] truncates a file to specified length using a file
    descriptor. *)
val ftruncate : Unix.file_descr -> int -> unit

(** {1 File Locking} *)

(** File locking commands for [lockf]. *)
type lock_command = [ `Unlock | `Lock | `Test_lock | `Try_lock ]

(** [lockf fd cmd size] applies, tests, or removes a POSIX lock on a section of
    a file. *)
val lockf : Unix.file_descr -> lock_command -> int -> unit

(** {1 Process Operations} *)

(** [fork ()] creates a new process. Returns [Some 0] in the child, [Some pid]
    in the parent where [pid] is the child's process ID. *)
val fork : unit -> int

(** [getpid ()] returns the process ID of the calling process. *)
val getpid : unit -> int

(** [getppid ()] returns the parent process ID. *)
val getppid : unit -> int

(** [getpgid pid] gets the process group ID of the specified process. *)
val getpgid : int -> int

(** [setpgid pid pgid] sets the process group ID. *)
val setpgid : int -> int -> unit

(** [getpgrp ()] returns the process group ID of the calling process. *)
val getpgrp : unit -> int

(** [setpgrp ()] sets the process group ID to the process ID. *)
val setpgrp : unit -> unit

(** [setsid ()] creates a new session and returns the session ID. *)
val setsid : unit -> int

(** [getsid pid] gets the session ID of the specified process. *)
val getsid : int -> int

(** {1 User and Group IDs} *)

(** [getuid ()] returns the real user ID. *)
val getuid : unit -> int

(** [geteuid ()] returns the effective user ID. *)
val geteuid : unit -> int

(** [getgid ()] returns the real group ID. *)
val getgid : unit -> int

(** [getegid ()] returns the effective group ID. *)
val getegid : unit -> int

(** [setuid uid] sets the user ID. *)
val setuid : int -> unit

(** [seteuid uid] sets the effective user ID. *)
val seteuid : int -> unit

(** [setgid gid] sets the group ID. *)
val setgid : int -> unit

(** [setegid gid] sets the effective group ID. *)
val setegid : int -> unit

(** [setreuid ruid euid] sets real and effective user IDs. *)
val setreuid : int -> int -> unit

(** [setregid rgid egid] sets real and effective group IDs. *)
val setregid : int -> int -> unit

(** {1 Group Membership} *)

(** [getgroups ()] returns the list of supplementary group IDs. *)
val getgroups : unit -> int list

(** [setgroups groups] sets the supplementary group IDs. *)
val setgroups : int list -> unit

(** {1 System Configuration} *)

(** [sysconf name] gets system configuration value. Use [sc_*] constants. *)
val sysconf : int -> int

(** [pathconf path name] gets path configuration value. Use [pc_*] constants. *)
val pathconf : string -> int -> int

(** [fpathconf fd name] gets path configuration value for an open file. *)
val fpathconf : Unix.file_descr -> int -> int

(** [confstr name] gets configuration string value. Use [cs_*] constants. *)
val confstr : int -> string

(** {1 Process Priority} *)

(** [nice incr] adjusts process priority by [incr]. Returns new priority. *)
val nice : int -> int

(** {1 Sleep Operations} *)

(** [sleep seconds] sleeps for specified number of seconds. Returns 0 on
    completion, or number of seconds remaining if interrupted. *)
val sleep : int -> int

(** [usleep microseconds] sleeps for specified number of microseconds. *)
val usleep : int -> unit

(** {1 Signal and Timer} *)

(** [pause ()] waits until a signal is caught. Always returns [None]. *)
val pause : unit -> unit

(** [alarm seconds] sets an alarm clock. Returns seconds remaining from a
    previous alarm, or 0 if no previous alarm. *)
val alarm : int -> int

(** {1 Terminal Operations} *)

(** [isatty fd] tests whether [fd] refers to a terminal. *)
val isatty : Unix.file_descr -> bool

(** [ttyname fd] returns the name of the terminal device. *)
val ttyname : Unix.file_descr -> string

(** [ttyname_r fd] thread-safe version of [ttyname]. *)
val ttyname_r : Unix.file_descr -> bytes -> bytes

(** [ctermid ()] returns the path to the controlling terminal. *)
val ctermid : unit -> string

(** [tcgetpgrp fd] returns the process group ID of the foreground process group
    associated with the terminal. *)
val tcgetpgrp : Unix.file_descr -> int

(** [tcsetpgrp fd pgrp] sets the foreground process group ID associated with the
    terminal to [pgrp]. *)
val tcsetpgrp : Unix.file_descr -> int -> unit

(** {1 System Information} *)

(** [getpagesize ()] returns the system page size in bytes. *)
val getpagesize : unit -> int

(** [gethostid ()] returns the unique identifier of the current host. *)
val gethostid : unit -> int64

(** [gethostname ()] returns the host name. *)
val gethostname : unit -> string

(** [sethostname name] sets the host name. *)
val sethostname : string -> unit

(** {1 Login Information} *)

(** [getlogin ()] returns the login name of the user. *)
val getlogin : unit -> string

(** [getlogin_r ()] thread-safe version of [getlogin]. *)
val getlogin_r : bytes -> bytes

(** {1 Program Execution} *)

(** [execv path args] executes a program with specified arguments. Only returns
    on error (by raising an exception). *)
val execv : string -> string list -> unit

(** [execve path args env] executes a program with specified arguments and
    environment. Only returns on error (by raising an exception). *)
val execve : string -> string list -> string list -> unit

(** [execvp file args] executes a program using PATH to find the executable.
    Only returns on error (by raising an exception). *)
val execvp : string -> string list -> unit

(** {1 Process Termination} *)

(** [_exit status] terminates the calling process immediately without cleanup.
    Use [Stdlib.exit] for normal termination. *)
val _exit : int -> unit
