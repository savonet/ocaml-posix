type eai_errno_def = {
  name : string;
  default : int;
  overrides : (string list * int) list;
}

val eai_errno_defs : eai_errno_def list
val eai_errno_defaults : (string * int) list
