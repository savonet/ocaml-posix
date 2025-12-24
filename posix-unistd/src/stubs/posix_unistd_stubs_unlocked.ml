open Ctypes

module Def (F : Cstubs.FOREIGN) = struct
  open F

  (* Type alias to fix const char ** vs char *const * mismatch *)
  let argv_t = typedef (ptr string) "char*const*"
  let strlen = foreign "strlen" (ptr char @-> returning int)

  (* Basic I/O operations *)
  let read = foreign "read" (int @-> ptr char @-> int @-> returning int)
  let write = foreign "write" (int @-> ptr char @-> int @-> returning int)

  (* Positioned I/O *)
  let pread =
    foreign "pread" (int @-> ptr char @-> int @-> int @-> returning int)

  let pwrite =
    foreign "pwrite" (int @-> ptr char @-> int @-> int @-> returning int)

  let readlink =
    foreign "readlink" (string @-> ptr char @-> int @-> returning int)

  (* File positioning *)
  let lseek = foreign "lseek" (int @-> int @-> int @-> returning int)

  (* Process operations *)
  let fork = foreign "fork" (void @-> returning int)

  (* Process priority *)
  let nice = foreign "nice" (int @-> returning int)

  (* Sleep operations *)
  let sleep = foreign "sleep" (int @-> returning int)
  let usleep = foreign "usleep" (int @-> returning int)

  (* Signal/timer *)
  let pause = foreign "pause" (void @-> returning int)
  let alarm = foreign "alarm" (int @-> returning int)

  (* Program execution *)
  let execv = foreign "execv" (string @-> argv_t @-> returning int)
  let execve = foreign "execve" (string @-> argv_t @-> argv_t @-> returning int)
  let execvp = foreign "execvp" (string @-> argv_t @-> returning int)

  (* Process termination *)
  let _exit = foreign "_exit" (int @-> returning void)
end
