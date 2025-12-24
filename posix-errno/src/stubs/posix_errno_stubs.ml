open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F

  (* Errno access functions *)
  let posix_errno_get_errno =
    foreign "posix_errno_get_errno" (void @-> returning int)

  let posix_errno_set_errno =
    foreign "posix_errno_set_errno" (int @-> returning void)

  (* strerror_r function - POSIX version returns int (0 on success) *)
  let strerror_r =
    foreign "strerror_r" (int @-> ptr char @-> size_t @-> returning int)

  (* strlen function to get string length *)
  let strlen = foreign "strlen" (ptr char @-> returning int)
end
