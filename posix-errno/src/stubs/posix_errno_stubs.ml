open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F

  (* Errno access functions *)
  let posix_errno_get_errno =
    foreign "posix_errno_get_errno" (void @-> returning int)

  let posix_errno_set_errno =
    foreign "posix_errno_set_errno" (int @-> returning void)
end
