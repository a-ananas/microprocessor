type ident = string 

let char_to_bool = function 
  | '0' -> false
  | '1' -> true
  | _ -> assert false

let string_to_bitarr s = 
  String.fold_left (fun arr c -> Array.append arr [|(char_to_bool c)|]) [||] s 

let rom = let read_lines name : string list =
  let ic = open_in name in
  let try_read () =
    try Some (input_line ic) with End_of_file -> None in
  let rec loop acc = match try_read () with
    | Some s -> loop (s :: acc)
    | None -> close_in ic; List.rev acc in
  loop [] in 

let lst = (read_lines "test.i") in 
let l' = List.map (fun l -> string_to_bitarr l) lst in 
List.iter (fun arr -> (Array.iter (fun b -> Format.print_bool b) arr))  l' 

