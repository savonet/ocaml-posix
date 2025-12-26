module Def (S : Cstubs.Types.TYPE) = struct
  let mode_t = S.lift_typ Posix_types.mode_t

  (* File type mask and constants *)
  let s_ifmt = S.constant "S_IFMT" mode_t
  let s_ifreg = S.constant "S_IFREG" mode_t
  let s_ifdir = S.constant "S_IFDIR" mode_t
  let s_iflnk = S.constant "S_IFLNK" mode_t
  let s_ifchr = S.constant "S_IFCHR" mode_t
  let s_ifblk = S.constant "S_IFBLK" mode_t
  let s_ififo = S.constant "S_IFIFO" mode_t
  let s_ifsock = S.constant "S_IFSOCK" mode_t

  (* Special mode bits *)
  let s_isuid = S.constant "S_ISUID" mode_t
  let s_isgid = S.constant "S_ISGID" mode_t
  let s_isvtx = S.constant "S_ISVTX" mode_t

  (* Owner permissions *)
  let s_irwxu = S.constant "S_IRWXU" mode_t
  let s_irusr = S.constant "S_IRUSR" mode_t
  let s_iwusr = S.constant "S_IWUSR" mode_t
  let s_ixusr = S.constant "S_IXUSR" mode_t

  (* Group permissions *)
  let s_irwxg = S.constant "S_IRWXG" mode_t
  let s_irgrp = S.constant "S_IRGRP" mode_t
  let s_iwgrp = S.constant "S_IWGRP" mode_t
  let s_ixgrp = S.constant "S_IXGRP" mode_t

  (* Other permissions *)
  let s_irwxo = S.constant "S_IRWXO" mode_t
  let s_iroth = S.constant "S_IROTH" mode_t
  let s_iwoth = S.constant "S_IWOTH" mode_t
  let s_ixoth = S.constant "S_IXOTH" mode_t

  (* *at function flags *)
  let at_fdcwd = S.constant "AT_FDCWD" S.int
  let at_symlink_nofollow = S.constant "AT_SYMLINK_NOFOLLOW" S.int
  let at_removedir = S.constant "AT_REMOVEDIR" S.int
  let at_eaccess = S.constant "AT_EACCESS" S.int
end
