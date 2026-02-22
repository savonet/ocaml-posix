(** POSIX system identification bindings.

    This module provides OCaml bindings to the POSIX uname function defined in
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_utsname.h.html} sys/utsname.h}.

    It allows retrieval of system identification information such as the
    operating system name, version, and hardware architecture. *)

(** System identification information returned by {!uname}.

    This record corresponds to the POSIX [struct utsname]. *)
type utsname = {
  sysname : string;   (** Operating system name (e.g., "Linux", "Darwin") *)
  nodename : string;  (** Network node hostname *)
  release : string;   (** Operating system release (e.g., "5.4.0") *)
  version : string;   (** Operating system version *)
  machine : string;   (** Hardware architecture (e.g., "x86_64", "arm64") *)
}

(** Return system identification information.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/uname.html} uname(2)}.

    @return A record containing system identification information.
    @raise Unix.Unix_error on failure.

    Example:
    {[
      let info = uname () in
      Printf.printf "Running on %s %s (%s)\n"
        info.sysname info.release info.machine
    ]} *)
val uname : unit -> utsname
