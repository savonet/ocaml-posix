
(** Bindings to <sys/utsname.h> *)

type utsname = {
  sysname : string;
  nodename : string;
  release : string;
  version : string;
  machine : string;
}

val uname : unit -> utsname
