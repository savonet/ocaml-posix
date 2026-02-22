(** POSIX unistd.h bindings.

    This module provides OCaml bindings to POSIX functions defined in
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/unistd.h.html} unistd.h}.

    It includes functions for file I/O, process control, user/group IDs,
    directory operations, and system configuration.

    {2 Example}

    {[
      (* Read from a file descriptor *)
      let buf = Bytes.create 1024 in
      let n = Posix_unistd.read fd buf 0 1024 in
      Printf.printf "Read %d bytes\n" n;

      (* Get system configuration *)
      let max_open = Posix_unistd.sysconf sc_open_max in
      Printf.printf "Max open files: %d\n" max_open
    ]} *)

(** {1 Constants} *)

(** {2 Name limits} *)

val host_name_max : int
val login_name_max : int

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

(** Read from a file descriptor.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/read.html} read(2)}.

    @return Number of bytes read.
    @raise Unix.Unix_error on failure. *)
val read : Unix.file_descr -> bytes -> int -> int -> int

(** Write to a file descriptor.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/write.html} write(2)}.

    @return Number of bytes written.
    @raise Unix.Unix_error on failure. *)
val write : Unix.file_descr -> bytes -> int -> int -> int

(** {1 Positioned I/O} *)

(** Read from a file descriptor at a given offset without changing the file offset.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/pread.html} pread(2)}.

    @return Number of bytes read.
    @raise Unix.Unix_error on failure. *)
val pread : Unix.file_descr -> bytes -> int -> int -> int -> int

(** Write to a file descriptor at a given offset without changing the file offset.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/pwrite.html} pwrite(2)}.

    @return Number of bytes written.
    @raise Unix.Unix_error on failure. *)
val pwrite : Unix.file_descr -> bytes -> int -> int -> int -> int

(** {1 File Descriptor Operations} *)

(** Close a file descriptor.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/close.html} close(2)}. *)
val close : Unix.file_descr -> unit

(** Duplicate a file descriptor.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/dup.html} dup(2)}. *)
val dup : Unix.file_descr -> Unix.file_descr

(** Duplicate a file descriptor to a specified descriptor.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/dup2.html} dup2(2)}. *)
val dup2 : Unix.file_descr -> Unix.file_descr -> Unix.file_descr

(** Create a pipe.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/pipe.html} pipe(2)}.
    @return [(read_end, write_end)]. *)
val pipe : unit -> Unix.file_descr * Unix.file_descr

(** {1 Data Synchronization} *)

(** Synchronize file data and metadata to disk.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/fsync.html} fsync(2)}. *)
val fsync : Unix.file_descr -> unit

(** Synchronize file data (but not necessarily metadata) to disk.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/fdatasync.html} fdatasync(2)}. *)
val fdatasync : Unix.file_descr -> unit

(** Schedule writes of all modified buffer cache blocks to disk.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/sync.html} sync(2)}. *)
val sync : unit -> unit

(** {1 File Operations} *)

(** Create a hard link.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/link.html} link(2)}. *)
val link : target:string -> link_name:string -> unit

(** Create a symbolic link.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/symlink.html} symlink(2)}. *)
val symlink : target:string -> link_name:string -> unit

(** Read the target of a symbolic link.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/readlink.html} readlink(2)}. *)
val readlink : ?max_len:int -> string -> string

(** Remove a file.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/unlink.html} unlink(2)}. *)
val unlink : string -> unit

(** Remove an empty directory.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/rmdir.html} rmdir(2)}. *)
val rmdir : string -> unit

(** {1 Directory Operations} *)

(** Change the current working directory.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/chdir.html} chdir(2)}. *)
val chdir : string -> unit

(** Change the current working directory to a directory referenced by a file descriptor.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/fchdir.html} fchdir(2)}. *)
val fchdir : Unix.file_descr -> unit

(** Get the current working directory.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getcwd.html} getcwd(3)}. *)
val getcwd : unit -> string

(** {1 File Positioning} *)

(** File positioning commands for {!lseek}. *)
type seek_command =
  | Seek_set  (** Set offset to the given value *)
  | Seek_cur  (** Set offset relative to current position *)
  | Seek_end  (** Set offset relative to end of file *)

(** Reposition the file offset.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/lseek.html} lseek(2)}. *)
val lseek : Unix.file_descr -> int -> seek_command -> int

(** {1 File Permissions and Ownership} *)

(** Access permission flags for {!access}. *)
type access_permission = [ `Read | `Write | `Execute | `Exists ]

(** Check file accessibility.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/access.html} access(2)}. *)
val access : string -> access_permission list -> bool

(** Change file ownership.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/chown.html} chown(2)}. *)
val chown : string -> int -> int -> unit

(** Change file ownership using a file descriptor.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/fchown.html} fchown(2)}. *)
val fchown : Unix.file_descr -> int -> int -> unit

(** Change ownership of a symbolic link itself.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/lchown.html} lchown(2)}. *)
val lchown : string -> int -> int -> unit

(** Truncate a file to a specified length.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/truncate.html} truncate(2)}. *)
val truncate : string -> int -> unit

(** Truncate a file to a specified length using a file descriptor.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/ftruncate.html} ftruncate(2)}. *)
val ftruncate : Unix.file_descr -> int -> unit

(** {1 File Locking} *)

(** File locking commands for {!lockf}. *)
type lock_command = [ `Unlock | `Lock | `Test_lock | `Try_lock ]

(** Apply, test, or remove a POSIX lock on a section of a file.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/lockf.html} lockf(3)}. *)
val lockf : Unix.file_descr -> lock_command -> int -> unit

(** {1 Process Operations} *)

(** Create a new process.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/fork.html} fork(2)}.
    @return 0 in the child, child's PID in the parent. *)
val fork : unit -> int

(** Get the process ID of the calling process.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getpid.html} getpid(2)}. *)
val getpid : unit -> int

(** Get the parent process ID.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getppid.html} getppid(2)}. *)
val getppid : unit -> int

(** Get the process group ID of a process.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getpgid.html} getpgid(2)}. *)
val getpgid : int -> int

(** Set the process group ID.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/setpgid.html} setpgid(2)}. *)
val setpgid : int -> int -> unit

(** Get the process group ID of the calling process.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getpgrp.html} getpgrp(2)}. *)
val getpgrp : unit -> int

(** Set the process group ID to the process ID.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/setpgrp.html} setpgrp(3)}. *)
val setpgrp : unit -> unit

(** Create a new session.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/setsid.html} setsid(2)}.
    @return The session ID. *)
val setsid : unit -> int

(** Get the session ID of a process.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getsid.html} getsid(2)}. *)
val getsid : int -> int

(** {1 User and Group IDs} *)

(** Get the real user ID.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getuid.html} getuid(2)}. *)
val getuid : unit -> int

(** Get the effective user ID.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/geteuid.html} geteuid(2)}. *)
val geteuid : unit -> int

(** Get the real group ID.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getgid.html} getgid(2)}. *)
val getgid : unit -> int

(** Get the effective group ID.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getegid.html} getegid(2)}. *)
val getegid : unit -> int

(** Set the user ID.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/setuid.html} setuid(2)}. *)
val setuid : int -> unit

(** Set the effective user ID.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/seteuid.html} seteuid(2)}. *)
val seteuid : int -> unit

(** Set the group ID.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/setgid.html} setgid(2)}. *)
val setgid : int -> unit

(** Set the effective group ID.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/setegid.html} setegid(2)}. *)
val setegid : int -> unit

(** Set real and effective user IDs.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/setreuid.html} setreuid(2)}. *)
val setreuid : int -> int -> unit

(** Set real and effective group IDs.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/setregid.html} setregid(2)}. *)
val setregid : int -> int -> unit

(** {1 Group Membership} *)

(** Get the list of supplementary group IDs.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getgroups.html} getgroups(2)}. *)
val getgroups : unit -> int list

(** Set the supplementary group IDs.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/setgroups.html} setgroups(2)}. *)
val setgroups : int list -> unit

(** {1 System Configuration} *)

(** Get system configuration value.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/sysconf.html} sysconf(3)}.
    Use [sc_*] constants. *)
val sysconf : int -> int

(** Get path configuration value.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/pathconf.html} pathconf(3)}.
    Use [pc_*] constants. *)
val pathconf : string -> int -> int

(** Get path configuration value for an open file.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/fpathconf.html} fpathconf(3)}. *)
val fpathconf : Unix.file_descr -> int -> int

(** Get configuration string value.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/confstr.html} confstr(3)}.
    Use [cs_*] constants. *)
val confstr : int -> string

(** {1 Process Priority} *)

(** Adjust process priority.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/nice.html} nice(2)}.
    @return The new priority. *)
val nice : int -> int

(** {1 Sleep Operations} *)

(** Sleep for a number of seconds.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/sleep.html} sleep(3)}.
    @return 0 on completion, or seconds remaining if interrupted. *)
val sleep : int -> int

(** Sleep for a number of microseconds.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/usleep.html} usleep(3)}. *)
val usleep : int -> unit

(** {1 Signal and Timer} *)

(** Wait until a signal is caught.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/pause.html} pause(2)}. *)
val pause : unit -> unit

(** Set an alarm clock.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/alarm.html} alarm(2)}.
    @return Seconds remaining from previous alarm, or 0 if none. *)
val alarm : int -> int

(** {1 Terminal Operations} *)

(** Test whether a file descriptor refers to a terminal.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/isatty.html} isatty(3)}. *)
val isatty : Unix.file_descr -> bool

(** Get the name of a terminal device.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/ttyname.html} ttyname(3)}. *)
val ttyname : Unix.file_descr -> string

(** Thread-safe version of {!ttyname}.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/ttyname.html} ttyname_r(3)}. *)
val ttyname_r : ?len:int -> Unix.file_descr -> string

(** Get the pathname of the controlling terminal.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/ctermid.html} ctermid(3)}. *)
val ctermid : unit -> string

(** Get the foreground process group ID associated with a terminal.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/tcgetpgrp.html} tcgetpgrp(3)}. *)
val tcgetpgrp : Unix.file_descr -> int

(** Set the foreground process group ID associated with a terminal.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/tcsetpgrp.html} tcsetpgrp(3)}. *)
val tcsetpgrp : Unix.file_descr -> int -> unit

(** {1 System Information} *)

(** Get the system page size in bytes.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getpagesize.html} getpagesize(2)}. *)
val getpagesize : unit -> int

(** Get the unique identifier of the current host.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/gethostid.html} gethostid(3)}. *)
val gethostid : unit -> int64

(** Get the host name.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/gethostname.html} gethostname(2)}. *)
val gethostname : unit -> string

(** Set the host name.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/sethostname.html} sethostname(2)}. *)
val sethostname : string -> unit

(** {1 Login Information} *)

(** Get the login name of the user.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getlogin.html} getlogin(3)}. *)
val getlogin : unit -> string

(** Thread-safe version of {!getlogin}.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getlogin.html} getlogin_r(3)}. *)
val getlogin_r : ?len:int -> unit -> string

(** {1 Program Execution} *)

(** Execute a program with specified arguments.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html} execv(2)}.
    Only returns on error (by raising an exception). *)
val execv : string -> string list -> unit

(** Execute a program with specified arguments and environment.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html} execve(2)}.
    Only returns on error (by raising an exception). *)
val execve : string -> string list -> string list -> unit

(** Execute a program using PATH to find the executable.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html} execvp(2)}.
    Only returns on error (by raising an exception). *)
val execvp : string -> string list -> unit

(** {1 Process Termination} *)

(** Terminate the calling process immediately without cleanup.
    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/_exit.html} _exit(2)}.
    Use [Stdlib.exit] for normal termination. *)
val _exit : int -> unit
