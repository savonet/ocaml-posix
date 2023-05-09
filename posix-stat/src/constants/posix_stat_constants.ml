module Def (S : Cstubs.Types.TYPE) = struct
  (* stat.h *)

  let s_ifmt = S.constant "S_IFMT" S.int
  let s_ifblk = S.constant "S_IFBLK" S.int
  let s_ifchr = S.constant "S_IFCHR" S.int
  let s_ififo = S.constant "S_IFIFO" S.int
  let s_ifreg = S.constant "S_IFREG" S.int
  let s_ifdir = S.constant "S_IFDIR" S.int
  let s_iflnk = S.constant "S_IFLNK" S.int
  let s_ifsock = S.constant "S_IFSOCK" S.int
  let s_irwxu = S.constant "S_IRWXU" S.int
  let s_irusr = S.constant "S_IRUSR" S.int
  let s_iwusr = S.constant "S_IWUSR" S.int
  let s_ixusr = S.constant "S_IXUSR" S.int
  let s_irwxg = S.constant "S_IRWXG" S.int
  let s_irgrp = S.constant "S_IRGRP" S.int
  let s_iwgrp = S.constant "S_IWGRP" S.int
  let s_ixgrp = S.constant "S_IXGRP" S.int
  let s_irwxo = S.constant "S_IRWXO" S.int
  let s_iroth = S.constant "S_IROTH" S.int
  let s_iwoth = S.constant "S_IWOTH" S.int
  let s_ixoth = S.constant "S_IXOTH" S.int
  let s_isuid = S.constant "S_ISUID" S.int
  let s_isgid = S.constant "S_ISGID" S.int
  let s_isvtx = S.constant "S_ISVTX" S.int
  let utime_now = S.constant "UTIME_NOW" S.int
  let utime_omit = S.constant "UTIME_OMIT" S.int

  (* statvfs.h *)

  let st_rdonly = S.constant "ST_RDONLY" S.int
  let st_nosuid = S.constant "ST_NOSUID" S.int

  (* fstatat *)

  (* let at_symlink_nofollow = S.constant "AT_SYMLINK_NOFOLLOW" S.int *)
  (* let at_symlink_nofollow_any = S.constant "AT_SYMLINK_NOFOLLOW_ANY" S.int *)

  (* statfs/fstatfs *)

  (*
  let mfstypenamelen = S.constant "MFSTYPENAMELEN" S.int
  let maxpathlen = S.constant "MAXPATHLEN" S.int
  let mnamelen = S.constant "MNAMELEN" S.int
  let mnt_readonly = S.constant "MNT_READONLY" S.int
  let mnt_synchronous = S.constant "MNT_SYNCHRONOUS" S.int
  let mnt_noexec = S.constant "MNT_NOEXEC" S.int
  let mnt_nosuid = S.constant "MNT_NOSUID" S.int
  let mnt_nodev = S.constant "MNT_NODEV" S.int
  let mnt_union = S.constant "MNT_UNION" S.int
  let mnt_async = S.constant "MNT_ASYNC" S.int
  let mnt_exported = S.constant "MNT_EXPORTED" S.int
  let mnt_local = S.constant "MNT_LOCAL" S.int
  let mnt_quota = S.constant "MNT_QUOTA" S.int
  let mnt_rootfs = S.constant "MNT_ROOTFS" S.int
  let mnt_dovolfs = S.constant "MNT_DOVOLFS" S.int
  let mnt_dontbrowse = S.constant "MNT_DONTBROWSE" S.int
  let mnt_unknownpermissions = S.constant "MNT_UNKNOWNPERMISSIONS" S.int
  let mnt_automounted = S.constant "MNT_AUTOMOUNTED" S.int
  let mnt_journaled = S.constant "MNT_JOURNALED" S.int
  let mnt_defwrite = S.constant "MNT_DEFWRITE" S.int
  let mnt_multilabel = S.constant "MNT_MULTILABEL" S.int
  let mnt_cprotect = S.constant "MNT_CPROTECT" S.int
  *)

  (* fstatvfs/statvfs *)
end
