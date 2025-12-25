module System_detect : sig
  val system : string
end

type errno_def = {
  name : string;
  default : int;
  overrides : (string list * int) list;
}

val errno_defs : errno_def list
val errno_aliases : (string * string) list
val get_value_for_system : string -> errno_def -> int
val get_errno_defaults : string -> (string * int) list
val errno_defaults : (string * int) list
