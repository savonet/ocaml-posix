let types = [
  "blkcnt_t"; "blksize_t"; "clock_t";
  "clockid_t"; "dev_t"; "fsblkcnt_t"; "fsfilcnt_t";
  "gid_t"; "id_t"; "ino_t"; "key_t";
  "mode_t"; "nlink_t"; "off_t"; "pid_t";
  "size_t"; "ssize_t"; "suseconds_t";
  "time_t"; "uid_t"; "useconds_t"
]

module Def (S : Cstubs.Types.TYPE) = struct
  let blkcnt_t_size = S.constant "BLKCNT_T_SIZE" S.int
  let blksize_t_size = S.constant "BLKSIZE_T_SIZE" S.int
  let clock_t_size = S.constant "CLOCK_T_SIZE" S.int
  let clockid_t_size = S.constant "CLOCKID_T_SIZE" S.int
  let is_clock_t_float = S.constant "IS_CLOCK_T_FLOAT" S.bool
  let dev_t_size = S.constant "DEV_T_SIZE" S.int
  let fsblkcnt_t_size = S.constant "FSBLKCNT_T_SIZE" S.int
  let fsfilcnt_t_size = S.constant "FSFILCNT_T_SIZE" S.int
  let gid_t_size = S.constant "GID_T_SIZE" S.int
  let id_t_size = S.constant "ID_T_SIZE" S.int
  let ino_t_size = S.constant "INO_T_SIZE" S.int
  let key_t_size = S.constant "KEY_T_SIZE" S.int
  let is_key_t_float = S.constant "IS_KEY_T_FLOAT" S.bool
  let mode_t_size = S.constant "MODE_T_SIZE" S.int
  let nlink_t_size = S.constant "NLINK_T_SIZE" S.int
  let off_t_size = S.constant "OFF_T_SIZE" S.int
  let pid_t_size = S.constant "PID_T_SIZE" S.int
  let size_t_size = S.constant "SIZE_T_SIZE" S.int
  let ssize_t_size = S.constant "SSIZE_T_SIZE" S.int
  let suseconds_t_size = S.constant "SUSECONDS_T_SIZE" S.int
  let time_t_size = S.constant "TIME_T_SIZE" S.int
  let is_time_t_float = S.constant "IS_TIME_T_FLOAT" S.bool
  let uid_t_size = S.constant "UID_T_SIZE" S.int
  let useconds_t_size = S.constant "USECONDS_T_SIZE" S.int
end
