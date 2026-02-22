(** POSIX command-line option parsing bindings.

    This module provides OCaml bindings to the POSIX getopt functions defined in
    {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getopt.html} unistd.h}.

    It supports short options (single character), long options (GNU extension),
    and various argument handling modes. *)

(** {1 Option Types} *)

(** Short option: a single character (e.g., ['v'] for [-v]). *)
type short = char

(** Long option: a pair of (long name, short equivalent).
    For example, [("verbose", 'v')] matches both [--verbose] and [-v]. *)
type long = string * char

(** Argument specification for an option.
    - [`None f] - Option takes no argument. [f ()] is called when matched.
    - [`Optional f] - Option has an optional argument. [f (Some arg)] or [f None].
    - [`Required f] - Option requires an argument. [f arg] is called with the value. *)
type arg =
  [ `None of unit -> unit
  | `Optional of string option -> unit
  | `Required of string -> unit ]

(** Option specification combining name and argument handler. *)
type 'a opt = { name : 'a; arg : arg }

(** {1 Exceptions} *)

(** Raised when an unknown option is encountered. *)
exception Unknown_option of string

(** Raised when a required argument is missing for the given option. *)
exception Missing_argument of char

(** {1 Feature Detection} *)

(** [true] if the system supports GNU-style long options via [getopt_long]. *)
val has_getopt_long : bool

(** [true] if the system supports [getopt_long_only] (long options with single dash). *)
val has_getopt_long_only : bool

(** {1 Configuration} *)

(** Enable or disable error messages printed to stderr by getopt.
    Default is [true] (errors are printed). *)
val print_error : bool -> unit

(** Reset the getopt state for parsing a new set of arguments.
    Call this before parsing a new argv if you've already parsed arguments. *)
val reset : unit -> unit

(** {1 Parsing Functions} *)

(** Parse command-line arguments using short options only.

    See {{:https://pubs.opengroup.org/onlinepubs/9699919799/functions/getopt.html} getopt(3)}.

    @param argv The argument array to parse (typically [Sys.argv]).
    @param opts List of short option specifications.
    @return Array of non-option arguments (positional arguments).
    @raise Unknown_option if an unrecognized option is found.
    @raise Missing_argument if a required argument is missing.

    Example:
    {[
      let verbose = ref false in
      let output = ref "out.txt" in
      let opts = [
        { name = 'v'; arg = `None (fun () -> verbose := true) };
        { name = 'o'; arg = `Required (fun s -> output := s) };
      ] in
      let args = getopt Sys.argv opts in
      (* args contains non-option arguments *)
    ]} *)
val getopt : string array -> short opt list -> string array

(** Parse command-line arguments using long options (GNU extension).

    See getopt_long(3).

    Long options are specified as [--name] or [--name=value].
    Each long option also has a short equivalent.

    @param argv The argument array to parse.
    @param opts List of long option specifications.
    @return Array of non-option arguments.
    @raise Unknown_option if an unrecognized option is found.
    @raise Missing_argument if a required argument is missing. *)
val getopt_long : string array -> long opt list -> string array

(** Like {!getopt_long} but also accepts long options with a single dash.

    For example, [-verbose] is treated the same as [--verbose].

    @param argv The argument array to parse.
    @param opts List of long option specifications.
    @return Array of non-option arguments. *)
val getopt_long_only : string array -> long opt list -> string array
