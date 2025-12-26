module Def (S : Cstubs.Types.TYPE) = struct
  let host_name_max = S.constant "HOST_NAME_MAX" S.int
  let login_name_max = S.constant "LOGIN_NAME_MAX" S.int

  (* sysconf names - commonly available ones *)
  let sc_arg_max = S.constant "_SC_ARG_MAX" S.int
  let sc_child_max = S.constant "_SC_CHILD_MAX" S.int
  let sc_clk_tck = S.constant "_SC_CLK_TCK" S.int
  let sc_open_max = S.constant "_SC_OPEN_MAX" S.int
  let sc_pagesize = S.constant "_SC_PAGESIZE" S.int
  let sc_page_size = S.constant "_SC_PAGE_SIZE" S.int (* alias for PAGESIZE *)
  let sc_nprocessors_onln = S.constant "_SC_NPROCESSORS_ONLN" S.int
  let sc_nprocessors_conf = S.constant "_SC_NPROCESSORS_CONF" S.int
  let sc_phys_pages = S.constant "_SC_PHYS_PAGES" S.int
  let sc_stream_max = S.constant "_SC_STREAM_MAX" S.int
  let sc_tzname_max = S.constant "_SC_TZNAME_MAX" S.int
  let sc_version = S.constant "_SC_VERSION" S.int
  let sc_atexit_max = S.constant "_SC_ATEXIT_MAX" S.int
  let sc_login_name_max = S.constant "_SC_LOGIN_NAME_MAX" S.int
  let sc_tty_name_max = S.constant "_SC_TTY_NAME_MAX" S.int
  let sc_host_name_max = S.constant "_SC_HOST_NAME_MAX" S.int
  let sc_line_max = S.constant "_SC_LINE_MAX" S.int
  let sc_getgr_r_size_max = S.constant "_SC_GETGR_R_SIZE_MAX" S.int
  let sc_getpw_r_size_max = S.constant "_SC_GETPW_R_SIZE_MAX" S.int
  let sc_ngroups_max = S.constant "_SC_NGROUPS_MAX" S.int
  let sc_re_dup_max = S.constant "_SC_RE_DUP_MAX" S.int
  let sc_symloop_max = S.constant "_SC_SYMLOOP_MAX" S.int

  (* POSIX options *)
  let sc_job_control = S.constant "_SC_JOB_CONTROL" S.int
  let sc_saved_ids = S.constant "_SC_SAVED_IDS" S.int
  let sc_fsync = S.constant "_SC_FSYNC" S.int
  let sc_mapped_files = S.constant "_SC_MAPPED_FILES" S.int
  let sc_memlock = S.constant "_SC_MEMLOCK" S.int
  let sc_memlock_range = S.constant "_SC_MEMLOCK_RANGE" S.int
  let sc_memory_protection = S.constant "_SC_MEMORY_PROTECTION" S.int
  let sc_priority_scheduling = S.constant "_SC_PRIORITY_SCHEDULING" S.int
  let sc_synchronized_io = S.constant "_SC_SYNCHRONIZED_IO" S.int
  let sc_timers = S.constant "_SC_TIMERS" S.int
  let sc_asynchronous_io = S.constant "_SC_ASYNCHRONOUS_IO" S.int
  let sc_prioritized_io = S.constant "_SC_PRIORITIZED_IO" S.int
  let sc_realtime_signals = S.constant "_SC_REALTIME_SIGNALS" S.int
  let sc_semaphores = S.constant "_SC_SEMAPHORES" S.int
  let sc_shared_memory_objects = S.constant "_SC_SHARED_MEMORY_OBJECTS" S.int
  let sc_message_passing = S.constant "_SC_MESSAGE_PASSING" S.int
  let sc_threads = S.constant "_SC_THREADS" S.int
  let sc_thread_safe_functions = S.constant "_SC_THREAD_SAFE_FUNCTIONS" S.int
  let sc_thread_attr_stackaddr = S.constant "_SC_THREAD_ATTR_STACKADDR" S.int
  let sc_thread_attr_stacksize = S.constant "_SC_THREAD_ATTR_STACKSIZE" S.int

  let sc_thread_priority_scheduling =
    S.constant "_SC_THREAD_PRIORITY_SCHEDULING" S.int

  let sc_thread_prio_inherit = S.constant "_SC_THREAD_PRIO_INHERIT" S.int
  let sc_thread_prio_protect = S.constant "_SC_THREAD_PRIO_PROTECT" S.int
  let sc_thread_process_shared = S.constant "_SC_THREAD_PROCESS_SHARED" S.int

  (* POSIX.2 constants *)
  let sc_2_version = S.constant "_SC_2_VERSION" S.int
  let sc_2_c_bind = S.constant "_SC_2_C_BIND" S.int
  let sc_2_c_dev = S.constant "_SC_2_C_DEV" S.int
  let sc_bc_base_max = S.constant "_SC_BC_BASE_MAX" S.int
  let sc_bc_dim_max = S.constant "_SC_BC_DIM_MAX" S.int
  let sc_bc_scale_max = S.constant "_SC_BC_SCALE_MAX" S.int
  let sc_bc_string_max = S.constant "_SC_BC_STRING_MAX" S.int
  let sc_coll_weights_max = S.constant "_SC_COLL_WEIGHTS_MAX" S.int
  let sc_expr_nest_max = S.constant "_SC_EXPR_NEST_MAX" S.int

  (* X/Open constants *)
  let sc_xopen_version = S.constant "_SC_XOPEN_VERSION" S.int
  let sc_xopen_crypt = S.constant "_SC_XOPEN_CRYPT" S.int
  let sc_xopen_enh_i18n = S.constant "_SC_XOPEN_ENH_I18N" S.int
  let sc_xopen_shm = S.constant "_SC_XOPEN_SHM" S.int
  let sc_xopen_unix = S.constant "_SC_XOPEN_UNIX" S.int

  (* pathconf names *)
  let pc_link_max = S.constant "_PC_LINK_MAX" S.int
  let pc_max_canon = S.constant "_PC_MAX_CANON" S.int
  let pc_max_input = S.constant "_PC_MAX_INPUT" S.int
  let pc_name_max = S.constant "_PC_NAME_MAX" S.int
  let pc_path_max = S.constant "_PC_PATH_MAX" S.int
  let pc_pipe_buf = S.constant "_PC_PIPE_BUF" S.int
  let pc_no_trunc = S.constant "_PC_NO_TRUNC" S.int
  let pc_vdisable = S.constant "_PC_VDISABLE" S.int
  let pc_chown_restricted = S.constant "_PC_CHOWN_RESTRICTED" S.int
  let pc_async_io = S.constant "_PC_ASYNC_IO" S.int
  let pc_prio_io = S.constant "_PC_PRIO_IO" S.int
  let pc_sync_io = S.constant "_PC_SYNC_IO" S.int
  let pc_filesizebits = S.constant "_PC_FILESIZEBITS" S.int
  let pc_2_symlinks = S.constant "_PC_2_SYMLINKS" S.int
  let pc_symlink_max = S.constant "_PC_SYMLINK_MAX" S.int

  (* lockf commands *)
  let f_ulock = S.constant "F_ULOCK" S.int
  let f_lock = S.constant "F_LOCK" S.int
  let f_tlock = S.constant "F_TLOCK" S.int
  let f_test = S.constant "F_TEST" S.int

  (* confstr names *)
  let cs_path = S.constant "_CS_PATH" S.int

  (* whence values for lseek (also in Unix but good to have) *)
  let seek_set = S.constant "SEEK_SET" S.int
  let seek_cur = S.constant "SEEK_CUR" S.int
  let seek_end = S.constant "SEEK_END" S.int

  (* access mode flags *)
  let r_ok = S.constant "R_OK" S.int
  let w_ok = S.constant "W_OK" S.int
  let x_ok = S.constant "X_OK" S.int
  let f_ok = S.constant "F_OK" S.int

  (* Standard file descriptors *)
  let stdin_fileno = S.constant "STDIN_FILENO" S.int
  let stdout_fileno = S.constant "STDOUT_FILENO" S.int
  let stderr_fileno = S.constant "STDERR_FILENO" S.int

  (* NULL constant (for completeness, though not typically needed in OCaml) *)
  (* let null = S.constant "NULL" S.int *)
  (* Not needed - use from_voidp *)
end
