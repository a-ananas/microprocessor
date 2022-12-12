open Netlist_ast

let print_only = ref false
let number_steps = ref (-1)

exception Fail of string

(* creating RAM and ROM *)
let ram = Hashtbl.create 100
let rom = Hashtbl.create 100

(* function to initialize then env to values false *)
let ty_to_val = function 
	|TBit -> VBit false
	|TBitArray n -> VBitArray (Array.make n false)

(* get values of an argument in env *)
let fetch arg env = match arg with
	|Aconst c -> c
	|Avar v -> Env.find v env

(* binary operations on buses and bits *)
let arr_binop bop arg1 arg2 : bool array = match bop with
	|Or -> Array.map2 (fun a b -> a || b) arg1 arg2
	|And -> Array.map2 (fun a b -> a && b) arg1 arg2
	|Xor -> Array.map2 (fun a b -> a <> b) arg1 arg2
	|Nand -> Array.map2 (fun a b -> not (a && b)) arg1 arg2

let bool_binop bop arg1 arg2 : bool = match bop with
	|Or -> arg1 || arg2
	|And -> arg1 && arg2
	|Xor -> arg1 <> arg2
	|Nand -> not (arg1 && arg2) 

let eval binop arg1 arg2 = match (arg1, arg2) with
	|(VBit a, VBit b) -> (VBit(bool_binop binop a b))
	|((VBitArray a), (VBitArray b)) -> (VBitArray(arr_binop binop a b))
	|_ -> raise (Fail "operation between value and array impossible... for now...")

(* not operation *)
let eval_not = function 
	|(VBit a) -> (VBit(not (a)))
	|(VBitArray a) -> (VBitArray(Array.map (fun x -> not x) a))

(* mux CHOICE A B *)
let mux ch a b = match (ch, a, b) with
	|((VBit ch), _, _) -> if ch then b else a
	|_ -> raise (Fail "weird thing in mux... no arrays for choice... yet")

(* concatenate 2 values *)
let concat arg1 arg2 = match (arg1, arg2) with
	|(VBit a), (VBit b) -> (VBitArray [|a; b|])
	|(VBit a), (VBitArray b) -> (VBitArray (Array.append [|a|] b))
	|(VBitArray a), (VBit b) -> (VBitArray (Array.append a [|b|]))
	|(VBitArray a), (VBitArray b) -> (VBitArray (Array.append a b))

(* slice a bus *)
let slice i j arg = 
	if j < i 
	then raise(Fail "Wrong indices for slicing")
	else match arg with
		|(VBitArray arr) -> (VBitArray (Array.sub arr i j))
		|(VBit v) when i = 0 && j = 1 -> (VBit v)
        |_ -> raise(Fail "something wrong in slicing")

(* select a value in a bus *)
let select i arg = match arg with
	|(VBitArray arr) -> (VBit(Array.get arr i))
	|(VBit _) when i = 0 -> arg
	|_ -> raise (Fail "Trying to slice wrongly") 

(* function to output buses *)
let bus_to_str bus = 
	Array.fold_left (fun str b -> if b then str ^ "1" else str ^ "0") "" bus

(* function to read value in ram giving a key *)
let ram_read asize wsize raddr = match raddr with
	|(VBit _) -> raise(Fail "Expecting a bus for RAM address")
	|(VBitArray bus) when (Array.length bus) = asize -> let word = try Hashtbl.find ram bus with Not_found -> (Array.make wsize false) in (if Array.length word = wsize then VBitArray(word) else raise(Fail "Wrong word size")) 
	|_ -> raise(Fail "Wrong address size")

(* function to write value in ram giving a key (using the reg_env) *)
let ram_write asize wsize wenb waddr wdata = match wenb with    
    |VBit true -> begin     
        match waddr with    
            |VBit _ -> raise(Fail "Expecting a bus for RAM address")    
            |VBitArray bus when (Array.length bus = asize) -> begin     
                match wdata with    
                    |VBitArray data when Array.length data = wsize -> Hashtbl.replace ram bus data                                                       
                    |_ -> raise(Fail "Wrong word size")               
                end                                              
            | _ -> raise(Fail "Wrong size address")    
        end    
    |VBit false -> ()    
    | _ -> raise(Fail "Write enable must be a single bit")

(* ROM : problem, how to initialize it ? *)
let rom_read asize wsize raddr = match raddr with
	|(VBit _) -> raise(Fail "Expecting a bus for ROM address")
	|(VBitArray bus) when (Array.length bus) = asize -> let word = try Hashtbl.find rom bus with Not_found -> (Array.make wsize false) in (if Array.length word = wsize then VBitArray(word) else raise(Fail "Wrong word size")) 
	|_ -> raise(Fail "Wrong address size")

(* evaluate an equation to execute the right function with the right values *)
let eval_eq eq env reg_env =
	let (id, exp) = eq in 
	match exp with
		|Earg arg -> Env.add id (fetch arg env) env
		|Ereg id_reg -> Env.add id (Env.find id_reg reg_env) env
		|Enot arg -> Env.add id (eval_not (fetch arg env)) env
		|Ebinop(op, arg1, arg2) -> Env.add id (eval op (fetch arg1 env) (fetch arg2 env)) env
		|Emux(ch, a, b) -> Env.add id (mux (fetch ch env) (fetch a env) (fetch b env)) env
		|Erom(asz, wsz, arg) -> Env.add id (rom_read asz wsz (fetch arg env)) env
		|Eram(asz, wsz, rad, wen, wad, wdt) -> let () = ram_write asz wsz (fetch wen reg_env) (fetch wad reg_env) (fetch wdt reg_env) in Env.add id (ram_read asz wsz (fetch rad env)) env
		|Econcat(arg1, arg2) -> Env.add id (concat (fetch arg1 env) (fetch arg2 env)) env
		|Eslice(i1, i2, arg) -> Env.add id (slice i1 i2 (fetch arg env)) env
		|Eselect(i, arg) -> Env.add id (select i (fetch arg env)) env

(* function to transform input in bool *)
let char_to_bool = function
	| '0' -> false
 	| '1' -> true
 	|  _  -> raise (Fail "Wrong input : must be 0 or 1")
	
(* recoded fold left for a string *)
let str_fold_left f x a =    
  let r = ref x in    
  for i = 0 to String.length a - 1 do    
      r := f !r a.[i]    
  done;    
  !r  

(* transform a string into a bus *)
let string_to_bool_arr str = str_fold_left (fun arr c -> Array.append arr [|char_to_bool c|]) [||] str

(* choose between bit or bus considering the size of the input *)
let str_to_bool str = 
 	if String.length str = 1
 	then VBit(char_to_bool str.[0])
 	else VBitArray(string_to_bool_arr str)


(* settings the input in the environnement *)
let rec set_inputs inp env = match inp with 
	|[] -> env
	|i::q -> Format.printf "%s: " i ; Format.print_flush () ; let a = read_line () in let new_env = Env.add i (str_to_bool a) env in set_inputs q new_env

(* print the values of the outputs *)
let print_vals id value = match value with
	|VBit x -> Format.printf "%s : %d \n" id (Bool.to_int x)
	|VBitArray arr -> Format.printf "%s;\n" (Array.fold_left (fun a b -> a ^ (string_of_int (Bool.to_int b))) (id ^ ": ") arr)

let rec fch_prt_outputs out env = match out with 
	|[] -> ()
	|id::q -> let value = Env.find id env in print_vals id value ; fch_prt_outputs q env

let simulator program number_steps = 
	let env = Env.map ty_to_val program.p_vars in
	let rec follow_prog eq env reg_env = match eq with
		| [] -> env
		| eq::q -> let new_env = eval_eq eq env reg_env in follow_prog q new_env reg_env
	in
	let rec sim prog env n = match n with
		| 0 -> ()
		| n -> Format.print_string "\n###INPUTS###\n" ;let inp_env = set_inputs prog.p_inputs env in 
							let new_env = follow_prog prog.p_eqs inp_env env in 
							(Format.print_string "\n###OUTPUTS###\n" ; fch_prt_outputs prog.p_outputs new_env ; sim prog new_env (n-1))
	in 
	sim program env number_steps


let compile filename =
  try
    let p = Netlist.read_file filename in
    begin try
        let p = Scheduler.schedule p in
        simulator p !number_steps
      with
        | Scheduler.Combinational_cycle ->
            Format.eprintf "The netlist has a combinatory cycle.@.";
    end;
  with
    | Netlist.Parse_error s -> Format.eprintf "An error accurred: %s@." s; exit 2

let main () =
  Arg.parse
    ["-n", Arg.Set_int number_steps, "Number of steps to simulate"]
    compile
    ""
;;

main ()
