(** The netlist scheduler *)

(** an exception thrown when a cycle is found on the netlist program *)

exception Combinational_cycle



(** get identifiers that should not cause a combinational cycle from an expression *)

val read_exp : 'a * Netlist_ast.exp -> Netlist_ast.ident list



(** get all the keys from a program's environment *)

val getKeys : 'a Netlist_ast.Env.t -> Netlist_ast.Env.key list



(** initiate a graph containing for nodes all the keys from a program's environment *)

val initGraph : Netlist_ast.program -> Netlist_ast.Env.key Graph.graph



(** add edges in a graph to a list of node having the same output *)

val addEdges : 'a Graph.graph -> 'a list -> 'a -> 'a Graph.graph



(** turn a program into a graph *)

val program_to_graph : Netlist_ast.program -> Netlist_ast.ident Graph.graph



(** get all the equation of a list that have the given identifier as identifier *)

val getEq : 'a -> ('a * 'b) list -> 'a * 'b



(** transform a list of identifiers into a list of equations *)

val identList_to_equationList :
  Netlist_ast.ident list ->
  Netlist_ast.program -> (Netlist_ast.ident * Netlist_ast.exp) list



(** transform a program into the same program but with its netlist topologically sorted *)

val schedule : Netlist_ast.program -> Netlist_ast.program