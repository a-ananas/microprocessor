(** A basic graph *)

(** an exception thrown when a cycle is found in the graph *)

exception Cycle



(** a type to caracterize a node *)

type mark = NotVisited | InProgress | Visited



(** the type for a graph *)

type 'a graph = { mutable g_nodes : 'a node list; }


(** the type for a node in the graph *)

and 'a node = {
  n_label : 'a;
  mutable n_mark : mark;
  mutable n_link_to : 'a node list;
  mutable n_linked_by : 'a node list;
}



(** create a graph *)

val mk_graph : unit -> 'a graph



(** add a node to an existing graph *)

val add_node : 'a graph -> 'a -> unit



(** get a nore from a graph given its label *)

val node_of_label : 'a graph -> 'a -> 'a node



(** add an edge to a graph *)

val add_edge : 'a graph -> 'a -> 'a -> unit



(** set to NOT_VISITED all the graph's nodes *)

val clear_marks : 'a graph -> unit



(** get a list of the graph's roots *)

val find_roots : 'a graph -> 'a node list



(** return true if the given graph has a cycle, false otherwise *)

val has_cycle : 'a graph -> bool



(** print to the standard output a list of integers *)

val print_list_int : int list -> unit



(** print to the standard output a list of strings *)

val print_list_string : string list -> unit



(** create a list of the graph's nodes by ordering them topologically *)

val topological : 'a graph -> 'a list