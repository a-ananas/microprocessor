(** The netlist simulator *)

(** the option to only show the running program *)

val print_only : bool ref



(** the option to specify the number of cycle on wich run the program *)

val number_steps : int ref



(** the standard output for format printer *)

val fStdout : Format.formatter



(** the error output for format printer *)

val fStderr : Format.formatter



(** an exception thrown when a logical error from the input program is found *)

exception LogicalError of string



(** an exception thrown when a an impossible situation happens *)

exception SystemError of string



(** the size of the adresses in the ROM *)

val romAddrSize : int



(** the size of a word in the ROM *)

val romWordSize : int



(** the size of the adresses in the RAM *)

val ramAddrSize : int



(** the size of a word in the RAM *)

val ramWordSize : int



(** return the Value of an argument *)

val calculArg :
  Netlist_ast.arg -> Netlist_ast.value Netlist_ast.Env.t -> Netlist_ast.value



(** convert a Value into an address *)

val valueToAdress : Netlist_ast.value -> int -> string



(** get an address from an arg *)

val argToAdress :
  Netlist_ast.arg -> int -> Netlist_ast.value Netlist_ast.Env.t -> string



(** init the environment *)

val initEnv : Netlist_ast.program -> Netlist_ast.value Netlist_ast.Env.t



(** return the Value of a Register *)

val calculReg : Netlist_ast.Env.key -> 'a Netlist_ast.Env.t -> 'a



(** return the Value after a Not operation *)

val calculNot :
  Netlist_ast.arg -> Netlist_ast.value Netlist_ast.Env.t -> Netlist_ast.value



(** applies a binary operation *)

val binopAux :
  Netlist_ast.arg ->
  Netlist_ast.arg ->
  Netlist_ast.value Netlist_ast.Env.t ->
  (bool -> bool -> bool) -> string -> Netlist_ast.value



(** return the Value after an Or operation between VBits*)

val orOp : bool -> bool -> bool



(** return the Value after an Xor operation between VBits*)

val xorOp : 'a -> 'a -> bool



(** return the Value after an And operation between VBits*)

val andOp : bool -> bool -> bool



(** return the Value after an And operation between VBits*)

val nandOp : bool -> bool -> bool



(** return the Value after a binary operation *)

val calculBinop :
  Netlist_ast.binop ->
  Netlist_ast.arg ->
  Netlist_ast.arg -> Netlist_ast.value Netlist_ast.Env.t -> Netlist_ast.value



(** return the Value after a multiplexor operation *)

val calculMux :
  Netlist_ast.arg ->
  Netlist_ast.arg ->
  Netlist_ast.arg -> Netlist_ast.value Netlist_ast.Env.t -> Netlist_ast.value



(** return the Value after a concatenation *)

val calculConcat :
  Netlist_ast.arg ->
  Netlist_ast.arg -> Netlist_ast.value Netlist_ast.Env.t -> Netlist_ast.value



(** return the Value after a slice *)

val calculSlice :
  int ->
  int ->
  Netlist_ast.arg -> Netlist_ast.value Netlist_ast.Env.t -> Netlist_ast.value



(** return the Value after a bit selection *)

val calculSelect :
  int ->
  Netlist_ast.arg -> Netlist_ast.value Netlist_ast.Env.t -> Netlist_ast.value



(** read a value from a memory *)

val readValueFromMemory :
  int ->
  int ->
  Netlist_ast.arg ->
  Netlist_ast.value Netlist_ast.Env.t -> 'a Netlist_ast.Env.t -> int -> 'a



(** return the Value after a ROM access *)

val calculRom :
  int ->
  int ->
  Netlist_ast.arg ->
  Netlist_ast.value Netlist_ast.Env.t -> 'a Netlist_ast.Env.t -> 'a



(** return the Value after a RAM access and the modified ram it's been modified *)

val calculRam :
  int ->
  int ->
  Netlist_ast.arg ->
  Netlist_ast.arg ->
  Netlist_ast.arg ->
  Netlist_ast.arg ->
  Netlist_ast.value Netlist_ast.Env.t ->
  Netlist_ast.value Netlist_ast.Env.t ->
  'a Netlist_ast.Env.t -> 'a * Netlist_ast.value Netlist_ast.Env.t



(** simulate an expression *)

val calculExp :
  Netlist_ast.exp ->
  Netlist_ast.value Netlist_ast.Env.t ->
  Netlist_ast.value Netlist_ast.Env.t ->
  Netlist_ast.value Netlist_ast.Env.t ->
  Netlist_ast.value Netlist_ast.Env.t ->
  Netlist_ast.value Netlist_ast.Env.t ->
  Netlist_ast.value * Netlist_ast.value Netlist_ast.Env.t



(** simulate an equation *)

val doEq :
  Netlist_ast.Env.key * Netlist_ast.exp ->
  Netlist_ast.value Netlist_ast.Env.t ->
  Netlist_ast.value Netlist_ast.Env.t ->
  Netlist_ast.value Netlist_ast.Env.t ->
  Netlist_ast.value Netlist_ast.Env.t ->
  Netlist_ast.value Netlist_ast.Env.t ->
  Netlist_ast.value Netlist_ast.Env.t * Netlist_ast.value Netlist_ast.Env.t *
  Netlist_ast.value Netlist_ast.Env.t * Netlist_ast.value Netlist_ast.Env.t



(** print the results *)

val showResults :
  Netlist_ast.program -> Netlist_ast.value Netlist_ast.Env.t -> unit



(** check input correctness *)

val checkInput : string -> bool



(** cast a char to a boolean *)

val charToBool : char -> bool



(** cast a string to a boolean array *)

val stringToArray : string -> int -> bool array



(** cast a string to a Value *)

val stringToValue : string -> Netlist_ast.value



(** read a user input *)

val askInput :
  Netlist_ast.Env.key ->
  Netlist_ast.value Netlist_ast.Env.t -> Netlist_ast.value Netlist_ast.Env.t



(** read the user's value for the inputs *)

val askForInputs :
  Netlist_ast.Env.key list ->
  Netlist_ast.value Netlist_ast.Env.t -> Netlist_ast.value Netlist_ast.Env.t



(** exception handler *)

val catchException : exn -> 'a



(** raise an integer n to the power of a *)

val pow : int -> int -> int



(** cast an integer into a binary string *)

val intToBin : int -> int -> string



(** init an empty memory *)

val initMemEmpty : int -> Netlist_ast.value Netlist_ast.Env.t



(** init the RAM *)

val initRAM : int -> Netlist_ast.value Netlist_ast.Env.t



(** init the ROM (empty for the moment) *)

val initROM : int -> Netlist_ast.value Netlist_ast.Env.t



(** simulate a netlist *)

val simulator : Netlist_ast.program -> int -> unit



(** get a netlist program from a .net file and run the simulator on that program *)

val compile : string -> unit



(** parse the command line arguments before running the compile function *)

val main : unit -> unit