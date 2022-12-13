(* an exception thrown when a cycle is found in the graph *)
exception Cycle

(* a type to caracterize a node *)
type mark = NotVisited | InProgress | Visited

(* the type for a graph *)
type 'a graph =
    { mutable g_nodes : 'a node list }
(* the type for a node in the graph *)
and 'a node = {
  n_label : 'a;
  mutable n_mark : mark;
  mutable n_link_to : 'a node list;
  mutable n_linked_by : 'a node list;
}

(* create a graph *)
let mk_graph () = { g_nodes = [] }

(* add a node to an existing graph *)
let add_node g x =
  let n = { n_label = x; n_mark = NotVisited; n_link_to = []; n_linked_by = [] } in
  g.g_nodes <- n :: g.g_nodes

(* get a nore from a graph given its label *)
let node_of_label g x =
  List.find (fun n -> n.n_label = x) g.g_nodes

(* add an edge to a graph *)
let add_edge g id1 id2 =
  try
    let n1 = node_of_label g id1 in
    let n2 = node_of_label g id2 in
    n1.n_link_to   <- n2 :: n1.n_link_to;
    n2.n_linked_by <- n1 :: n2.n_linked_by
  with Not_found -> Format.eprintf "Tried to add an edge between non-existing nodes"; raise Not_found

(* set to NOT_VISITED all the graph's nodes *)
let clear_marks g =
  List.iter (fun n -> n.n_mark <- NotVisited) g.g_nodes

(* get a list of the graph's roots *)
let find_roots g =
  List.filter (fun n -> n.n_linked_by = []) g.g_nodes

(* return true if the given graph has a cycle, false otherwise *)
let has_cycle g = 
  let rec visit_node_list nl =
    match nl with
    | [] -> false
    | h::t -> if (visit_node h) then true else (visit_node_list t)
  and visit_neighbours nl n =
    match nl with
    | [] -> n.n_mark <- Visited; false
    | h::t -> if (visit_node h) then true else (visit_neighbours t n)
  and visit_node n = 
    match n.n_mark with
    | Visited -> false
    | InProgress -> true
    | NotVisited -> begin
                      n.n_mark <- InProgress;
                      (visit_neighbours n.n_link_to n);
                    end
  in (clear_marks g);(visit_node_list g.g_nodes);;
    

(* print to the standard output a list of integers *)
let print_list_int l =
  begin
    print_string "[";
    let rec aux l =
      match l with
      | [] -> print_string "]\n"
      | h::[] -> begin print_int h; aux [] end
      | h::t -> begin print_int h; print_string ", "; aux t; end
    in (aux l)
  end


(* print to the standard output a list of strings *)
let print_list_string l =
  begin
    print_string "[";
    let rec aux l =
      match l with
      | [] -> print_string "]\n"
      | h::[] -> begin print_string h; aux [] end
      | h::t -> begin print_string h; print_string ", "; aux t; end
    in (aux l)
  end

  
(* create a list of the graph's nodes by ordering them topologically *)
let topological g =
  let res = ref [] 
    in
      let rec visit_node_list nl =
        match nl with
        | [] -> !res
        | h::t -> (visit_node h); (visit_node_list t)
      and visit_node n =
        match n.n_mark with
        | Visited -> res := !res
        | InProgress -> raise Cycle
        | NotVisited -> begin
                          n.n_mark <- InProgress;
                          (visit_neighbours n.n_link_to n);
                        end
      and visit_neighbours nl n =
        match nl with
        | [] -> n.n_mark <- Visited; res := n.n_label::!res
        | h::t -> (visit_node h); (visit_neighbours t n)

    in print_string "\n"; 
      (clear_marks g); 
      (visit_node_list g.g_nodes)
;;