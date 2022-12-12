exception Cycle
type mark = NotVisited | InProgress | Visited

type 'a graph =
    { mutable g_nodes : 'a node list }
and 'a node = {
  n_label : 'a;
  mutable n_mark : mark;
  mutable n_link_to : 'a node list;
  mutable n_linked_by : 'a node list;
}

let mk_graph () = { g_nodes = [] }

let add_node g x =
  let n = { n_label = x; n_mark = NotVisited; n_link_to = []; n_linked_by = [] } in
  g.g_nodes <- n :: g.g_nodes

let node_of_label g x =
  List.find (fun n -> n.n_label = x) g.g_nodes

let add_edge g id1 id2 =
  try
    let n1 = node_of_label g id1 in
    let n2 = node_of_label g id2 in
    n1.n_link_to   <- n2 :: n1.n_link_to;
    n2.n_linked_by <- n1 :: n2.n_linked_by
  with Not_found -> Format.eprintf "Tried to add an edge between non-existing nodes"; raise Not_found

let clear_marks g =
  List.iter (fun n -> n.n_mark <- NotVisited) g.g_nodes

let find_roots g =
  List.filter (fun n -> n.n_linked_by = []) g.g_nodes

let has_cycle g =
clear_marks g;
let lst = g.g_nodes in
	let rec exp lst = match lst with
		|[] -> false
		|r::q when r.n_mark = NotVisited -> r.n_mark <- InProgress ; if (exp r.n_link_to) then true else ((r.n_mark <- Visited) ; exp q)
		|r::q when r.n_mark = Visited -> exp q
		|_ -> true
in exp lst

let topological g = 
	if has_cycle g then raise Cycle;
	clear_marks g;
	let rlst = ref [] in
	let rec match_mark n = match n.n_mark with
		|Visited -> ()
		|InProgress -> ()
		|NotVisited -> n.n_mark <- InProgress;
									 voisins n.n_link_to;
									 n.n_mark <- Visited;
									 rlst := n.n_label :: !rlst
	and voisins lst = match lst with
		|[] -> ()
		|t::q -> match_mark t; voisins q
	in
	voisins (find_roots g);
	!rlst
		
