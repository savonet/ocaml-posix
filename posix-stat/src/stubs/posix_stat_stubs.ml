open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F
  module Types = Posix_stat_types.Def (Posix_stat_generated_types)
  open Types

  (* stat family *)
  let stat = foreign "stat" (string @-> ptr Stat.t @-> returning int)
  let fstat = foreign "fstat" (int @-> ptr Stat.t @-> returning int)
  let lstat = foreign "lstat" (string @-> ptr Stat.t @-> returning int)

  (* chmod family *)
  let chmod = foreign "chmod" (string @-> Posix_types.mode_t @-> returning int)
  let fchmod = foreign "fchmod" (int @-> Posix_types.mode_t @-> returning int)

  (* Directory and special file creation *)
  let mkdir = foreign "mkdir" (string @-> Posix_types.mode_t @-> returning int)
  let mkfifo = foreign "mkfifo" (string @-> Posix_types.mode_t @-> returning int)

  (* umask *)
  let umask =
    foreign "umask" (Posix_types.mode_t @-> returning Posix_types.mode_t)

  (* *at functions *)
  let fstatat =
    foreign "fstatat" (int @-> string @-> ptr Stat.t @-> int @-> returning int)

  let fchmodat =
    foreign "fchmodat"
      (int @-> string @-> Posix_types.mode_t @-> int @-> returning int)

  let mkdirat =
    foreign "mkdirat" (int @-> string @-> Posix_types.mode_t @-> returning int)

  let mkfifoat =
    foreign "mkfifoat" (int @-> string @-> Posix_types.mode_t @-> returning int)
end
