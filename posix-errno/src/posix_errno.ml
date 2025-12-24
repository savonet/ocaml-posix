open Ctypes

(* Include generated constants *)
module Constants = Posix_errno_constants.Def (Posix_errno_generated_constants)

(* Errno C bindings *)
module Stubs = Posix_errno_stubs.Def (Posix_errno_generated_stubs)

(** Comprehensive errno type covering Linux, BSD, macOS, and Windows values *)
type t =
  (* Standard POSIX *)
  | E2BIG
  | EACCES
  | EADDRINUSE
  | EADDRNOTAVAIL
  | EAFNOSUPPORT
  | EAGAIN
  | EALREADY
  | EBADF
  | EBADMSG
  | EBUSY
  | ECANCELED
  | ECHILD
  | ECONNABORTED
  | ECONNREFUSED
  | ECONNRESET
  | EDEADLK
  | EDESTADDRREQ
  | EDOM
  | EDQUOT
  | EEXIST
  | EFAULT
  | EFBIG
  | EHOSTDOWN
  | EHOSTUNREACH
  | EIDRM
  | EILSEQ
  | EINPROGRESS
  | EINTR
  | EINVAL
  | EIO
  | EISCONN
  | EISDIR
  | ELOOP
  | EMFILE
  | EMLINK
  | EMSGSIZE
  | EMULTIHOP
  | ENAMETOOLONG
  | ENETDOWN
  | ENETRESET
  | ENETUNREACH
  | ENFILE
  | ENOBUFS
  | ENODATA
  | ENODEV
  | ENOENT
  | ENOEXEC
  | ENOLCK
  | ENOLINK
  | ENOMEM
  | ENOMSG
  | ENOPROTOOPT
  | ENOSPC
  | ENOSR
  | ENOSTR
  | ENOSYS
  | ENOTCONN
  | ENOTDIR
  | ENOTEMPTY
  | ENOTRECOVERABLE
  | ENOTSOCK
  | ENOTSUP
  | ENOTTY
  | ENXIO
  | EOPNOTSUPP
  | EOVERFLOW
  | EOWNERDEAD
  | EPERM
  | EPFNOSUPPORT
  | EPIPE
  | EPROTO
  | EPROTONOSUPPORT
  | EPROTOTYPE
  | ERANGE
  | EREMOTE
  | EROFS
  | ESHUTDOWN
  | ESOCKTNOSUPPORT
  | ESPIPE
  | ESRCH
  | ESTALE
  | ETIME
  | ETIMEDOUT
  | ETOOMANYREFS
  | ETXTBSY
  | EUSERS
  | EWOULDBLOCK
  | EXDEV
  (* Linux-specific *)
  | EBADE
  | EBADFD
  | EBADR
  | EBADRQC
  | EBADSLT
  | ECHRNG
  | ECOMM
  | EDEADLOCK
  | EHWPOISON
  | EISNAM
  | EKEYEXPIRED
  | EKEYREJECTED
  | EKEYREVOKED
  | EL2HLT
  | EL2NSYNC
  | EL3HLT
  | EL3RST
  | ELIBACC
  | ELIBBAD
  | ELIBEXEC
  | ELIBMAX
  | ELIBSCN
  | ELNRNG
  | EMEDIUMTYPE
  | ENOANO
  | ENOKEY
  | ENOMEDIUM
  | ENONET
  | ENOPKG
  | ENOTBLK
  | ENOTUNIQ
  | EREMCHG
  | EREMOTEIO
  | ERESTART
  | ERFKILL
  | ESTRPIPE
  | ETOOBIG
  | EUCLEAN
  | EUNATCH
  | EXFULL
  (* BSD/macOS *)
  | EAUTH
  | EBADRPC
  | EFTYPE
  | ENEEDAUTH
  | ENOCSI
  | EPROCLIM
  | EPROCUNAVAIL
  | EPROGMISMATCH
  | EPROGUNAVAIL
  | ERPCMISMATCH
  (* macOS-specific *)
  | EATTR
  | EBADARCH
  | EBADEXEC
  | EBADMACHO
  | EDEVERR
  | ENOATTR
  | ENOPOLICY
  | EPWROFF
  | ESHLIBVERS
  (* Windows *)
  | EOTHER
  (* Unknown *)
  | EUNKNOWN of int

(** Convert errno code to variant *)
let of_int n =
  let open Int64 in
  let open Constants in
  let n64 = of_int n in
  if n64 = e_2big then E2BIG
  else if n64 = e_acces then EACCES
  else if n64 = e_addrinuse then EADDRINUSE
  else if n64 = Constants.e_addrnotavail then EADDRNOTAVAIL
  else if n64 = Constants.e_afnosupport then EAFNOSUPPORT
  else if n64 = Constants.e_again then EAGAIN
  else if n64 = Constants.e_already then EALREADY
  else if n64 = Constants.e_bade then EBADE
  else if n64 = Constants.e_badf then EBADF
  else if n64 = Constants.e_badfd then EBADFD
  else if n64 = Constants.e_badmsg then EBADMSG
  else if n64 = Constants.e_badr then EBADR
  else if n64 = Constants.e_badrqc then EBADRQC
  else if n64 = Constants.e_badslt then EBADSLT
  else if n64 = Constants.e_busy then EBUSY
  else if n64 = Constants.e_canceled then ECANCELED
  else if n64 = Constants.e_child then ECHILD
  else if n64 = Constants.e_chrng then ECHRNG
  else if n64 = Constants.e_comm then ECOMM
  else if n64 = Constants.e_connaborted then ECONNABORTED
  else if n64 = Constants.e_connrefused then ECONNREFUSED
  else if n64 = Constants.e_connreset then ECONNRESET
  else if n64 = Constants.e_deadlk then EDEADLK
  else if n64 = Constants.e_deadlock then EDEADLOCK
  else if n64 = Constants.e_destaddrreq then EDESTADDRREQ
  else if n64 = Constants.e_dom then EDOM
  else if n64 = Constants.e_dquot then EDQUOT
  else if n64 = Constants.e_exist then EEXIST
  else if n64 = Constants.e_fault then EFAULT
  else if n64 = Constants.e_fbig then EFBIG
  else if n64 = Constants.e_hostdown then EHOSTDOWN
  else if n64 = Constants.e_hostunreach then EHOSTUNREACH
  else if n64 = Constants.e_hwpoison then EHWPOISON
  else if n64 = Constants.e_idrm then EIDRM
  else if n64 = Constants.e_ilseq then EILSEQ
  else if n64 = Constants.e_inprogress then EINPROGRESS
  else if n64 = Constants.e_intr then EINTR
  else if n64 = Constants.e_inval then EINVAL
  else if n64 = Constants.e_io then EIO
  else if n64 = Constants.e_isconn then EISCONN
  else if n64 = Constants.e_isdir then EISDIR
  else if n64 = Constants.e_isnam then EISNAM
  else if n64 = Constants.e_keyexpired then EKEYEXPIRED
  else if n64 = Constants.e_keyrejected then EKEYREJECTED
  else if n64 = Constants.e_keyrevoked then EKEYREVOKED
  else if n64 = Constants.e_l2hlt then EL2HLT
  else if n64 = Constants.e_l2nsync then EL2NSYNC
  else if n64 = Constants.e_l3hlt then EL3HLT
  else if n64 = Constants.e_l3rst then EL3RST
  else if n64 = Constants.e_libacc then ELIBACC
  else if n64 = Constants.e_libbad then ELIBBAD
  else if n64 = Constants.e_libmax then ELIBMAX
  else if n64 = Constants.e_libscn then ELIBSCN
  else if n64 = Constants.e_libexec then ELIBEXEC
  else if n64 = Constants.e_lnrng then ELNRNG
  else if n64 = Constants.e_loop then ELOOP
  else if n64 = Constants.e_mediumtype then EMEDIUMTYPE
  else if n64 = Constants.e_mfile then EMFILE
  else if n64 = Constants.e_mlink then EMLINK
  else if n64 = Constants.e_msgsize then EMSGSIZE
  else if n64 = Constants.e_multihop then EMULTIHOP
  else if n64 = Constants.e_nametoolong then ENAMETOOLONG
  else if n64 = Constants.e_netdown then ENETDOWN
  else if n64 = Constants.e_netreset then ENETRESET
  else if n64 = Constants.e_netunreach then ENETUNREACH
  else if n64 = Constants.e_nfile then ENFILE
  else if n64 = Constants.e_noano then ENOANO
  else if n64 = Constants.e_nobufs then ENOBUFS
  else if n64 = Constants.e_nodata then ENODATA
  else if n64 = Constants.e_nodev then ENODEV
  else if n64 = Constants.e_noent then ENOENT
  else if n64 = Constants.e_noexec then ENOEXEC
  else if n64 = Constants.e_nokey then ENOKEY
  else if n64 = Constants.e_nolck then ENOLCK
  else if n64 = Constants.e_nolink then ENOLINK
  else if n64 = Constants.e_nomedium then ENOMEDIUM
  else if n64 = Constants.e_nomem then ENOMEM
  else if n64 = Constants.e_nomsg then ENOMSG
  else if n64 = Constants.e_nonet then ENONET
  else if n64 = Constants.e_nopkg then ENOPKG
  else if n64 = Constants.e_noprotoopt then ENOPROTOOPT
  else if n64 = Constants.e_nospc then ENOSPC
  else if n64 = Constants.e_nosr then ENOSR
  else if n64 = Constants.e_nostr then ENOSTR
  else if n64 = Constants.e_nosys then ENOSYS
  else if n64 = Constants.e_notblk then ENOTBLK
  else if n64 = Constants.e_notconn then ENOTCONN
  else if n64 = Constants.e_notdir then ENOTDIR
  else if n64 = Constants.e_notempty then ENOTEMPTY
  else if n64 = Constants.e_notrecoverable then ENOTRECOVERABLE
  else if n64 = Constants.e_notsock then ENOTSOCK
  else if n64 = Constants.e_notsup then ENOTSUP
  else if n64 = Constants.e_notty then ENOTTY
  else if n64 = Constants.e_notuniq then ENOTUNIQ
  else if n64 = Constants.e_nxio then ENXIO
  else if n64 = Constants.e_opnotsupp then EOPNOTSUPP
  else if n64 = Constants.e_overflow then EOVERFLOW
  else if n64 = Constants.e_ownerdead then EOWNERDEAD
  else if n64 = Constants.e_perm then EPERM
  else if n64 = Constants.e_pfnosupport then EPFNOSUPPORT
  else if n64 = Constants.e_pipe then EPIPE
  else if n64 = Constants.e_proto then EPROTO
  else if n64 = Constants.e_protonosupport then EPROTONOSUPPORT
  else if n64 = Constants.e_prototype then EPROTOTYPE
  else if n64 = Constants.e_range then ERANGE
  else if n64 = Constants.e_remchg then EREMCHG
  else if n64 = Constants.e_remote then EREMOTE
  else if n64 = Constants.e_remoteio then EREMOTEIO
  else if n64 = Constants.e_restart then ERESTART
  else if n64 = Constants.e_rfkill then ERFKILL
  else if n64 = Constants.e_rofs then EROFS
  else if n64 = Constants.e_shutdown then ESHUTDOWN
  else if n64 = Constants.e_socktnosupport then ESOCKTNOSUPPORT
  else if n64 = Constants.e_spipe then ESPIPE
  else if n64 = Constants.e_srch then ESRCH
  else if n64 = Constants.e_stale then ESTALE
  else if n64 = Constants.e_strpipe then ESTRPIPE
  else if n64 = Constants.e_time then ETIME
  else if n64 = Constants.e_timedout then ETIMEDOUT
  else if n64 = Constants.e_toobig then ETOOBIG
  else if n64 = Constants.e_toomanyrefs then ETOOMANYREFS
  else if n64 = Constants.e_txtbsy then ETXTBSY
  else if n64 = Constants.e_uclean then EUCLEAN
  else if n64 = Constants.e_unatch then EUNATCH
  else if n64 = Constants.e_users then EUSERS
  else if n64 = Constants.e_wouldblock then EWOULDBLOCK
  else if n64 = Constants.e_xdev then EXDEV
  else if n64 = Constants.e_xfull then EXFULL (* BSD/macOS *)
  else if n64 = Constants.e_auth then EAUTH
  else if n64 = Constants.e_badrpc then EBADRPC
  else if n64 = Constants.e_ftype then EFTYPE
  else if n64 = Constants.e_needauth then ENEEDAUTH
  else if n64 = Constants.e_nocsi then ENOCSI
  else if n64 = Constants.e_proclim then EPROCLIM
  else if n64 = Constants.e_procunavail then EPROCUNAVAIL
  else if n64 = Constants.e_progmismatch then EPROGMISMATCH
  else if n64 = Constants.e_progunavail then EPROGUNAVAIL
  else if n64 = Constants.e_rpcmismatch then ERPCMISMATCH (* macOS *)
  else if n64 = Constants.e_attr then EATTR
  else if n64 = Constants.e_badarch then EBADARCH
  else if n64 = Constants.e_badexec then EBADEXEC
  else if n64 = Constants.e_badmacho then EBADMACHO
  else if n64 = Constants.e_devpwroff then EDEVERR
  else if n64 = Constants.e_noattr then ENOATTR
  else if n64 = Constants.e_nopolicy then ENOPOLICY
  else if n64 = Constants.e_pwroff then EPWROFF
  else if n64 = Constants.e_shlibvers then ESHLIBVERS (* Windows *)
  else if n64 = Constants.e_other then EOTHER
  else EUNKNOWN n

(** Convert variant to errno code *)
let to_int = function
  | E2BIG -> Int64.to_int Constants.e_2big
  | EACCES -> Int64.to_int Constants.e_acces
  | EADDRINUSE -> Int64.to_int Constants.e_addrinuse
  | EADDRNOTAVAIL -> Int64.to_int Constants.e_addrnotavail
  | EAFNOSUPPORT -> Int64.to_int Constants.e_afnosupport
  | EAGAIN -> Int64.to_int Constants.e_again
  | EALREADY -> Int64.to_int Constants.e_already
  | EBADE -> Int64.to_int Constants.e_bade
  | EBADF -> Int64.to_int Constants.e_badf
  | EBADFD -> Int64.to_int Constants.e_badfd
  | EBADMSG -> Int64.to_int Constants.e_badmsg
  | EBADR -> Int64.to_int Constants.e_badr
  | EBADRQC -> Int64.to_int Constants.e_badrqc
  | EBADSLT -> Int64.to_int Constants.e_badslt
  | EBUSY -> Int64.to_int Constants.e_busy
  | ECANCELED -> Int64.to_int Constants.e_canceled
  | ECHILD -> Int64.to_int Constants.e_child
  | ECHRNG -> Int64.to_int Constants.e_chrng
  | ECOMM -> Int64.to_int Constants.e_comm
  | ECONNABORTED -> Int64.to_int Constants.e_connaborted
  | ECONNREFUSED -> Int64.to_int Constants.e_connrefused
  | ECONNRESET -> Int64.to_int Constants.e_connreset
  | EDEADLK -> Int64.to_int Constants.e_deadlk
  | EDEADLOCK -> Int64.to_int Constants.e_deadlock
  | EDESTADDRREQ -> Int64.to_int Constants.e_destaddrreq
  | EDOM -> Int64.to_int Constants.e_dom
  | EDQUOT -> Int64.to_int Constants.e_dquot
  | EEXIST -> Int64.to_int Constants.e_exist
  | EFAULT -> Int64.to_int Constants.e_fault
  | EFBIG -> Int64.to_int Constants.e_fbig
  | EHOSTDOWN -> Int64.to_int Constants.e_hostdown
  | EHOSTUNREACH -> Int64.to_int Constants.e_hostunreach
  | EHWPOISON -> Int64.to_int Constants.e_hwpoison
  | EIDRM -> Int64.to_int Constants.e_idrm
  | EILSEQ -> Int64.to_int Constants.e_ilseq
  | EINPROGRESS -> Int64.to_int Constants.e_inprogress
  | EINTR -> Int64.to_int Constants.e_intr
  | EINVAL -> Int64.to_int Constants.e_inval
  | EIO -> Int64.to_int Constants.e_io
  | EISCONN -> Int64.to_int Constants.e_isconn
  | EISDIR -> Int64.to_int Constants.e_isdir
  | EISNAM -> Int64.to_int Constants.e_isnam
  | EKEYEXPIRED -> Int64.to_int Constants.e_keyexpired
  | EKEYREJECTED -> Int64.to_int Constants.e_keyrejected
  | EKEYREVOKED -> Int64.to_int Constants.e_keyrevoked
  | EL2HLT -> Int64.to_int Constants.e_l2hlt
  | EL2NSYNC -> Int64.to_int Constants.e_l2nsync
  | EL3HLT -> Int64.to_int Constants.e_l3hlt
  | EL3RST -> Int64.to_int Constants.e_l3rst
  | ELIBACC -> Int64.to_int Constants.e_libacc
  | ELIBBAD -> Int64.to_int Constants.e_libbad
  | ELIBMAX -> Int64.to_int Constants.e_libmax
  | ELIBSCN -> Int64.to_int Constants.e_libscn
  | ELIBEXEC -> Int64.to_int Constants.e_libexec
  | ELNRNG -> Int64.to_int Constants.e_lnrng
  | ELOOP -> Int64.to_int Constants.e_loop
  | EMEDIUMTYPE -> Int64.to_int Constants.e_mediumtype
  | EMFILE -> Int64.to_int Constants.e_mfile
  | EMLINK -> Int64.to_int Constants.e_mlink
  | EMSGSIZE -> Int64.to_int Constants.e_msgsize
  | EMULTIHOP -> Int64.to_int Constants.e_multihop
  | ENAMETOOLONG -> Int64.to_int Constants.e_nametoolong
  | ENETDOWN -> Int64.to_int Constants.e_netdown
  | ENETRESET -> Int64.to_int Constants.e_netreset
  | ENETUNREACH -> Int64.to_int Constants.e_netunreach
  | ENFILE -> Int64.to_int Constants.e_nfile
  | ENOANO -> Int64.to_int Constants.e_noano
  | ENOBUFS -> Int64.to_int Constants.e_nobufs
  | ENODATA -> Int64.to_int Constants.e_nodata
  | ENODEV -> Int64.to_int Constants.e_nodev
  | ENOENT -> Int64.to_int Constants.e_noent
  | ENOEXEC -> Int64.to_int Constants.e_noexec
  | ENOKEY -> Int64.to_int Constants.e_nokey
  | ENOLCK -> Int64.to_int Constants.e_nolck
  | ENOLINK -> Int64.to_int Constants.e_nolink
  | ENOMEDIUM -> Int64.to_int Constants.e_nomedium
  | ENOMEM -> Int64.to_int Constants.e_nomem
  | ENOMSG -> Int64.to_int Constants.e_nomsg
  | ENONET -> Int64.to_int Constants.e_nonet
  | ENOPKG -> Int64.to_int Constants.e_nopkg
  | ENOPROTOOPT -> Int64.to_int Constants.e_noprotoopt
  | ENOSPC -> Int64.to_int Constants.e_nospc
  | ENOSR -> Int64.to_int Constants.e_nosr
  | ENOSTR -> Int64.to_int Constants.e_nostr
  | ENOSYS -> Int64.to_int Constants.e_nosys
  | ENOTBLK -> Int64.to_int Constants.e_notblk
  | ENOTCONN -> Int64.to_int Constants.e_notconn
  | ENOTDIR -> Int64.to_int Constants.e_notdir
  | ENOTEMPTY -> Int64.to_int Constants.e_notempty
  | ENOTRECOVERABLE -> Int64.to_int Constants.e_notrecoverable
  | ENOTSOCK -> Int64.to_int Constants.e_notsock
  | ENOTSUP -> Int64.to_int Constants.e_notsup
  | ENOTTY -> Int64.to_int Constants.e_notty
  | ENOTUNIQ -> Int64.to_int Constants.e_notuniq
  | ENXIO -> Int64.to_int Constants.e_nxio
  | EOPNOTSUPP -> Int64.to_int Constants.e_opnotsupp
  | EOVERFLOW -> Int64.to_int Constants.e_overflow
  | EOWNERDEAD -> Int64.to_int Constants.e_ownerdead
  | EPERM -> Int64.to_int Constants.e_perm
  | EPFNOSUPPORT -> Int64.to_int Constants.e_pfnosupport
  | EPIPE -> Int64.to_int Constants.e_pipe
  | EPROTO -> Int64.to_int Constants.e_proto
  | EPROTONOSUPPORT -> Int64.to_int Constants.e_protonosupport
  | EPROTOTYPE -> Int64.to_int Constants.e_prototype
  | ERANGE -> Int64.to_int Constants.e_range
  | EREMCHG -> Int64.to_int Constants.e_remchg
  | EREMOTE -> Int64.to_int Constants.e_remote
  | EREMOTEIO -> Int64.to_int Constants.e_remoteio
  | ERESTART -> Int64.to_int Constants.e_restart
  | ERFKILL -> Int64.to_int Constants.e_rfkill
  | EROFS -> Int64.to_int Constants.e_rofs
  | ESHUTDOWN -> Int64.to_int Constants.e_shutdown
  | ESOCKTNOSUPPORT -> Int64.to_int Constants.e_socktnosupport
  | ESPIPE -> Int64.to_int Constants.e_spipe
  | ESRCH -> Int64.to_int Constants.e_srch
  | ESTALE -> Int64.to_int Constants.e_stale
  | ESTRPIPE -> Int64.to_int Constants.e_strpipe
  | ETIME -> Int64.to_int Constants.e_time
  | ETIMEDOUT -> Int64.to_int Constants.e_timedout
  | ETOOBIG -> Int64.to_int Constants.e_toobig
  | ETOOMANYREFS -> Int64.to_int Constants.e_toomanyrefs
  | ETXTBSY -> Int64.to_int Constants.e_txtbsy
  | EUCLEAN -> Int64.to_int Constants.e_uclean
  | EUNATCH -> Int64.to_int Constants.e_unatch
  | EUSERS -> Int64.to_int Constants.e_users
  | EWOULDBLOCK -> Int64.to_int Constants.e_wouldblock
  | EXDEV -> Int64.to_int Constants.e_xdev
  | EXFULL -> Int64.to_int Constants.e_xfull
  (* BSD/macOS *)
  | EAUTH -> Int64.to_int Constants.e_auth
  | EBADRPC -> Int64.to_int Constants.e_badrpc
  | EFTYPE -> Int64.to_int Constants.e_ftype
  | ENEEDAUTH -> Int64.to_int Constants.e_needauth
  | ENOCSI -> Int64.to_int Constants.e_nocsi
  | EPROCLIM -> Int64.to_int Constants.e_proclim
  | EPROCUNAVAIL -> Int64.to_int Constants.e_procunavail
  | EPROGMISMATCH -> Int64.to_int Constants.e_progmismatch
  | EPROGUNAVAIL -> Int64.to_int Constants.e_progunavail
  | ERPCMISMATCH -> Int64.to_int Constants.e_rpcmismatch
  (* macOS *)
  | EATTR -> Int64.to_int Constants.e_attr
  | EBADARCH -> Int64.to_int Constants.e_badarch
  | EBADEXEC -> Int64.to_int Constants.e_badexec
  | EBADMACHO -> Int64.to_int Constants.e_badmacho
  | EDEVERR -> Int64.to_int Constants.e_devpwroff
  | ENOATTR -> Int64.to_int Constants.e_noattr
  | ENOPOLICY -> Int64.to_int Constants.e_nopolicy
  | EPWROFF -> Int64.to_int Constants.e_pwroff
  | ESHLIBVERS -> Int64.to_int Constants.e_shlibvers
  (* Windows *)
  | EOTHER -> Int64.to_int Constants.e_other
  (* Unknown *)
  | EUNKNOWN n -> n

(** Get current errno value *)
let get_errno () = of_int (Stubs.posix_errno_get_errno ())

(** Get current errno as int *)
let get_errno_int () = Stubs.posix_errno_get_errno ()

(** Set errno value *)
let set_errno e = Stubs.posix_errno_set_errno (to_int e)

(** Set errno from int *)
let set_errno_int n = Stubs.posix_errno_set_errno n

(** Reset errno to 0 *)
let reset_errno () = Stubs.posix_errno_set_errno 0

(** Convert errno variant to Unix.error *)
let to_unix_error = function
  | E2BIG -> Unix.E2BIG
  | EACCES -> Unix.EACCES
  | EAGAIN -> Unix.EAGAIN
  | EBADF -> Unix.EBADF
  | EBUSY -> Unix.EBUSY
  | ECHILD -> Unix.ECHILD
  | EDEADLK -> Unix.EDEADLK
  | EDOM -> Unix.EDOM
  | EEXIST -> Unix.EEXIST
  | EFAULT -> Unix.EFAULT
  | EFBIG -> Unix.EFBIG
  | EINTR -> Unix.EINTR
  | EINVAL -> Unix.EINVAL
  | EIO -> Unix.EIO
  | EISDIR -> Unix.EISDIR
  | EMFILE -> Unix.EMFILE
  | EMLINK -> Unix.EMLINK
  | ENAMETOOLONG -> Unix.ENAMETOOLONG
  | ENFILE -> Unix.ENFILE
  | ENODEV -> Unix.ENODEV
  | ENOENT -> Unix.ENOENT
  | ENOEXEC -> Unix.ENOEXEC
  | ENOLCK -> Unix.ENOLCK
  | ENOMEM -> Unix.ENOMEM
  | ENOSPC -> Unix.ENOSPC
  | ENOSYS -> Unix.ENOSYS
  | ENOTDIR -> Unix.ENOTDIR
  | ENOTEMPTY -> Unix.ENOTEMPTY
  | ENOTTY -> Unix.ENOTTY
  | ENXIO -> Unix.ENXIO
  | EPERM -> Unix.EPERM
  | EPIPE -> Unix.EPIPE
  | ERANGE -> Unix.ERANGE
  | EROFS -> Unix.EROFS
  | ESPIPE -> Unix.ESPIPE
  | ESRCH -> Unix.ESRCH
  | EXDEV -> Unix.EXDEV
  | EWOULDBLOCK -> Unix.EWOULDBLOCK
  | EINPROGRESS -> Unix.EINPROGRESS
  | EALREADY -> Unix.EALREADY
  | ENOTSOCK -> Unix.ENOTSOCK
  | EDESTADDRREQ -> Unix.EDESTADDRREQ
  | EMSGSIZE -> Unix.EMSGSIZE
  | EPROTOTYPE -> Unix.EPROTOTYPE
  | ENOPROTOOPT -> Unix.ENOPROTOOPT
  | EPROTONOSUPPORT -> Unix.EPROTONOSUPPORT
  | ESOCKTNOSUPPORT -> Unix.ESOCKTNOSUPPORT
  | EOPNOTSUPP -> Unix.EOPNOTSUPP
  | EPFNOSUPPORT -> Unix.EPFNOSUPPORT
  | EAFNOSUPPORT -> Unix.EAFNOSUPPORT
  | EADDRINUSE -> Unix.EADDRINUSE
  | EADDRNOTAVAIL -> Unix.EADDRNOTAVAIL
  | ENETDOWN -> Unix.ENETDOWN
  | ENETUNREACH -> Unix.ENETUNREACH
  | ENETRESET -> Unix.ENETRESET
  | ECONNABORTED -> Unix.ECONNABORTED
  | ECONNRESET -> Unix.ECONNRESET
  | ENOBUFS -> Unix.ENOBUFS
  | EISCONN -> Unix.EISCONN
  | ENOTCONN -> Unix.ENOTCONN
  | ESHUTDOWN -> Unix.ESHUTDOWN
  | ETOOMANYREFS -> Unix.ETOOMANYREFS
  | ETIMEDOUT -> Unix.ETIMEDOUT
  | ECONNREFUSED -> Unix.ECONNREFUSED
  | EHOSTDOWN -> Unix.EHOSTDOWN
  | EHOSTUNREACH -> Unix.EHOSTUNREACH
  | ELOOP -> Unix.ELOOP
  | EOVERFLOW -> Unix.EOVERFLOW
  | _ -> Unix.EUNKNOWNERR (to_int (get_errno ()))

(** Convert errno int to Unix.error *)
let int_to_unix_error n = to_unix_error (of_int n)

(** Generic error-raising function *)
let raise_on_error ?call f check =
  reset_errno ();
  let result = f () in
  if check result then (
    let errno = get_errno () in
    let unix_err = to_unix_error errno in
    let call_name = match call with Some c -> c | None -> "" in
    raise (Unix.Unix_error (unix_err, call_name, "")))
  else result

(** Check for negative integer return *)
let raise_on_neg ?call f = raise_on_error ?call f (fun x -> x < 0)

(** Check for null pointer return *)
let raise_on_null ?call f = raise_on_error ?call f (fun ptr -> is_null ptr)

(** Check for zero return value *)
let raise_on_zero ?call f = raise_on_error ?call f (fun x -> x = 0)

let raise_on_none ?call f =
  Option.get (raise_on_error ?call f (fun x -> x = None))
