open Netlist_ast;;
open Format;;

(* the option to only show the running program *)
let print_only = ref false

(* the option to specify the number of cycle on wich run the program *)
let number_steps = ref (-1)

(* the standard output for format printer *)
let fStdout = (formatter_of_out_channel stdout)

(* the error output for format printer *)
let fStderr = (formatter_of_out_channel stderr)

(* an exception thrown when a logical error from the input program is found *)
exception LogicalError of string
(* an exception thrown when a an impossible situation happens *)
exception SystemError of string

(* the size of the adresses in the ROM *)
let romAddrSize = 2;;
(* the size of a word in the ROM *)
let romWordSize = 4;;
(* the size of the adresses in the RAM *)
let ramAddrSize = 2;;
(* the size of a word in the RAM *)
let ramWordSize = 4;;

(* return the Value of an argument *)
let calculArg arg env = 
  match arg with 
    | Avar ident -> Env.find ident env
    | Aconst value -> value
;;

(* convert a Value into an adress *)
let valueToAdress v addrSize =
  (* convert a bit array into an adress *)
  let rec bitArrayToAddr arr index res max =
    match index with
    | i when i>=max -> res
    | 0 -> 
      if arr.(0) 
        then (bitArrayToAddr arr 1 "1" max)
        else (bitArrayToAddr arr 1 "0" max)
    | i when i>=0 -> 
      if arr.(i) 
        then (bitArrayToAddr arr (i+1) ("1"^res) max)
        else (bitArrayToAddr arr (i+1) ("0"^res) max)
    | _ -> raise (LogicalError "Invalid length for a VBitArray!\n")
  in
  match v with
  | VBit b -> if (addrSize<>1) 
                then raise (LogicalError "Invalid value as an adress!\n") 
                else if b then "1" else "0"
  | VBitArray arr -> let len = Array.length arr in
                if (len<>addrSize) then raise (LogicalError "Invalid value as an adress!\n")
                else (bitArrayToAddr arr 0 "" (Array.length arr))
;;  

(* get an adress from an arg *)
let argToAdress arg addrSize env =
  let value = calculArg arg env in (valueToAdress value addrSize)
;;


(* init the environment *)
let initEnv p = 
  (* Netlist.print_program stdout p; *)
  (* empty map *)
  let env = Env.empty in
  (* get all the keys from the program *)
  let (keys,ty) = (List.split (Env.bindings p.p_vars))
  in
    (* fprintf fStdout "%a@.\n" Netlist_printer.print_idents keys; *)
    (* add all these keys in the environment *)
    let rec aux keys ty env = 
      match (keys,ty) with 
      | [],_ -> env
      | (k::keys, TBit::tys) -> 
        (* initiate them to false *)
        let env = (Env.add k (VBit(false)) env)
          in (aux keys tys env)
      | (k::keys, TBitArray(len)::tys) -> 
        (* initiate them to false *)
        let env = (Env.add k (VBitArray(Array.make len false)) env)
          in (aux keys tys env)
      | _ -> raise (SystemError "Failed to initialize the environment!\n")
    in (aux keys ty env)
;;

(* return the Value of a Register *)
let calculReg ident env =
  Env.find ident env
;;

(* return the Value after a Not operation *)
let calculNot arg env =
  (* logical not *)
  let notOp e = not e in
  match (calculArg arg env) with 
  | VBit b -> VBit(not b)
  | VBitArray arr -> VBitArray(Array.map notOp arr)
;;

(* applies a binary operation *)
let binopAux arg1 arg2 env op msg = 
  match (calculArg arg1 env) with 
  | VBit b1 -> 
      begin
        match (calculArg arg2 env) with 
        | VBit b2 -> VBit(op b1 b2)
        | VBitArray arr -> raise (LogicalError ("Can't do an \'"^msg^"\' operation between a bit and a bit array!\n"))
      end
  | VBitArray arr1 -> 
      begin
        match (calculArg arg2 env) with
        | VBit b2 -> raise (LogicalError ("Can't do \'"^msg^"\' operation between a bit and a bit array!\n"))
        | VBitArray arr2  -> 
          try VBitArray(Array.map2 op arr1 arr2) with _ -> raise (LogicalError ("Can't do \'"^msg^"\' operation between bit arrays of different size!\n"))
      end
;;

(* return the Value after an Or operation between VBits*)
let orOp e1 e2 = e1 || e2;;
(* return the Value after an Xor operation between VBits*)
let xorOp e1 e2 = e1 <> e2;;
(* return the Value after an And operation between VBits*)
let andOp e1 e2 = e1 && e2;;
(* return the Value after an And operation between VBits*)
let nandOp e1 e2 = not (e1 && e2);;

(* return the Value after a binary operation *)
let calculBinop binop arg1 arg2 env =
  match binop with
    | Or   -> (binopAux arg1 arg2 env orOp "Or")
    | Xor  -> (binopAux arg1 arg2 env xorOp "Xor")
    | And  -> (binopAux arg1 arg2 env andOp "And")
    | Nand -> (binopAux arg1 arg2 env nandOp "Nand")
;;

(* return the Value after a multiplexor operation *)
let calculMux bit arg1 arg2 env =
  match (calculArg bit env) with 
    | VBit false -> (calculArg arg1 env)
    | VBit true  -> (calculArg arg2 env)
    (* test if the first argument is corect *)
    | _ -> raise (LogicalError "Can't have a VBitArray as the multiplexor selector input!\n")
;;


(* return the Value after a concatenation *)
let calculConcat arg1 arg2 env = 
  match (calculArg arg1 env) with
  | VBit b1 ->
    begin
      match (calculArg arg2 env) with
      | VBitArray arr2 -> let arr1 = Array.make 1 false in
        begin
          arr1.(0) <- b1;
          try 
            VBitArray((Array.append arr1 arr2))
          with _ -> raise (SystemError "Bit arrays are too big to be concatenate!\n")
        end
      | VBit b2 -> let arr = Array.make 2 false in 
        begin
          arr.(0) <- b1;
          arr.(1) <- b2;
          VBitArray(arr)
        end
    end
  | VBitArray arr1 ->
    match (calculArg arg2 env) with
    | VBit b2 -> let arr2 = Array.make 1 false in
      begin
        arr2.(0) <- b2;
        try 
          VBitArray((Array.append arr1 arr2))
        with _ -> raise (SystemError "Bit arrays are too big to be concatenate!\n")
      end
    | VBitArray arr2 -> 
        try 
          VBitArray((Array.append arr1 arr2))
        with _ -> raise (SystemError "Bit arrays are too big to be concatenate!\n")
;; 


(* return the Value after a slice *)
let calculSlice i1 i2 arg env =
  match (calculArg arg env) with
  | VBit b -> if((i1<>0) && (i2<>0)) 
                then raise (LogicalError "Can't slice a bit!\n") 
                else VBit b
  | VBitArray arr -> 
    try
      if (i1 = i2) 
        then VBit (arr.(i1))
        else VBitArray((Array.sub arr i1 (i2-i1+1)))
    with _ -> raise (LogicalError "Invalid indices for slicing the array!\n")
;;


(* return the Value after a bit selection *)
let calculSelect i arg env = 
  match (calculArg arg env) with
  | VBit b -> if (i<>0) then raise (LogicalError "Can't select from a bit!\n") else (VBit b)
  | VBitArray arr -> 
    try
      VBit((Array.get arr i))
    with _ -> raise (LogicalError "Invalid index for selecting in the array!\n")
;;


(* read a value from a memory *)
let readValueFromMemory addrSize wordSize readAddr glblEnv memoryEnv memoryAddrSize =
  (* get the word in the ROM *)
  if(wordSize <= 0 || addrSize <= 0) then raise (LogicalError "Word's and addresse's sizes must be greater than 0!\n")
  else
    (* get the adress *)
    let raddr = (argToAdress readAddr memoryAddrSize glblEnv) in
      (Env.find raddr memoryEnv)
;;

(* return the Value after a ROM access *)
let calculRom addrSize wordSize readAddr env romEnv =
  (* get the word in the ROM *)
  (readValueFromMemory addrSize wordSize readAddr env romEnv romAddrSize)
;;


(* return the Value after a RAM access and the modified ram it's been modified *)
let calculRam addrSize wordSize readAddr writeEnable writeAddr data env envRAM prevEnvRAM =
  (* read a word in the RAM *)
  let readValue = (readValueFromMemory addrSize wordSize readAddr env prevEnvRAM ramAddrSize) in
    (* write a word in the RAM *)
    let we = match (calculArg writeEnable env) with
      | VBit false -> false
      | VBit true -> true
      | _ -> raise (LogicalError "write_enable value must be a const of 0 or 1!\n")
    in
    if (not we)
      (* no writting *)
      then (readValue, envRAM)
      (* writting *)
      else
        let waddr = (argToAdress writeAddr ramAddrSize env) in
        (* check data size *)
        match (calculArg data env) with
        | VBit b -> let newEnvRAM = (Env.add waddr (VBit b) envRAM) in (readValue, newEnvRAM)
        | VBitArray arr -> let newEnvRAM = (Env.add waddr (VBitArray arr) envRAM) in 
          (readValue, newEnvRAM)
;;


(* simulate an expression *)
let calculExp exp env prevEnv envROM envRAM prevEnvRAM =
  (* recognize the expression *)
  match exp with
    | Earg arg                 -> ((calculArg arg env), envRAM)
    | Ereg ident               -> ((calculReg ident prevEnv), envRAM) (* prevEnv is env but delayed by one cycle *)
    | Enot arg                 -> ((calculNot arg env), envRAM)
    | Ebinop (binop,arg1,arg2) -> ((calculBinop binop arg1 arg2 env), envRAM)
    | Emux (bit, arg0, arg1)   -> ((calculMux bit arg0 arg1 env), envRAM)
    | Econcat (arg1, arg2)     -> ((calculConcat arg1 arg2 env), envRAM)
    | Eslice (i1, i2, arg)     -> ((calculSlice i1 i2 arg env), envRAM)
    | Eselect (i, arg)         -> ((calculSelect i arg env), envRAM)
    | Erom(addrSize, wordSize, readAddr) 
                               -> ((calculRom addrSize wordSize readAddr env envROM), envRAM)
    | Eram(addrSize, wordSize, readAddr, writeEnable, writeAddr, data) 
                               -> (calculRam addrSize wordSize readAddr writeEnable writeAddr data env envRAM prevEnvRAM)
    (* | _ -> raise (SystemError "Unknown expression!\n") *)
;;

(* simulate an equation *)
let doEq eq env prevEnv envROM envRAM prevEnvRAM =
  (* decompose the equation *)
  let (ident, exp) = eq in
    (* calcul the expression value *)
    let (value, newEnvRAM) = (calculExp exp env prevEnv envROM envRAM prevEnvRAM) in
      (* return updated environments, prevEnv is unchanged because one step delayed *)
      let newEnv = Env.add ident value env in (newEnv, prevEnv, newEnvRAM, prevEnvRAM)
;;

(* print the results *)
let showResults program env =
  let outputs = program.p_outputs in
  begin
    let rec aux outs =
      match outs with
      | [] -> ()
      | out::outs ->
        begin
          let value = Env.find out env in
              fprintf fStdout "=> %a = %a@." Netlist_printer.print_idents [out] Netlist_printer.print_value value;
          aux outs
        end
    in (aux outputs)
  end
;;


(* check input correctness *)
let checkInput input =
  if (String.length input = 0) then false else
  let charCorrect c = (c=='0' || c=='1') in
    let len = String.length input in
      let rec aux len = 
        match len with 
        | 0 -> true
        | i -> if (not (charCorrect input.[i-1])) then false
                else (aux (len-1))
      in (aux len)
;;

(* cast a char to a boolean *)
let charToBool c =
  match c with
  | '0' -> false
  | '1' -> true
  | _ -> raise (SystemError "Unexpecter character!\n")
;;

(* cast a string to a boolean array *)
let stringToArray s len =
  let arr = Array.make len false in
  let rec aux len =
    match len with 
    | 0 -> arr 
    | i -> 
      begin
        arr.(i-1) <- (charToBool s.[i-1]);
        (aux (len-1))
      end
  in (aux len)
;;

(* cast a string to a Value *)
let stringToValue s = 
  let len = (String.length s) in
    match len with
    | 1 -> let b = charToBool s.[0] in VBit(b)
    | l when (l > 1) -> let arr = (stringToArray s l) in VBitArray(arr)
    | _ -> raise (SystemError "Invalid user input!\n")
;;


(* read a user input *)
let askInput ident env =
  (* get the user input *)
  let rec ask () =
      fprintf fStdout "%s = ?@." ident;
      flush stdout;
      let userInput = read_line() in
        (* fprintf fStdout "your input : %s\n@." userInput; *)
        (* check if correct *)
        if(checkInput userInput)
          (* if correct then update env *)
          then
            begin 
              (* fprintf fStdout "your input : %s\n@." userInput; *)
              let value = stringToValue userInput in
                (* return the updated env *)
                Env.add ident value env
            end
          (* else ask for the input again *)
          else
            begin
              fprintf fStdout "Wrong input@.";
              ask()
            end
    in ask()
;;


(* read the user's value for the inputs *)
let askForInputs inputIdents env =
  (* ask for each of the program's inputs *)
  let rec aux inputIdents env =
    match inputIdents with 
    | [] -> env
    | ident::inputIdents ->
      let env = askInput ident env in (aux inputIdents env)
  in (aux inputIdents env)
;;


(* exception handler *)
let catchException exc = 
  let manageException exc excName msg =
    begin
      fprintf fStderr "\n##### ERROR #####\n\n%s error: %s\n@." excName msg;
      failwith ""
    end
  in
  match exc with
    | LogicalError msg -> (manageException (LogicalError "") "Logical" msg)
    | SystemError  msg -> (manageException (SystemError  "") "System"  msg)
    | _ -> raise exc
;;

(* raise an integer n to the power of a *)
let rec pow a = function
  | 0 -> 1
  | 1 -> a
  | n -> 
    let b = pow a (n / 2) in
    b * b * (if n mod 2 = 0 then 1 else a)
;;


(* cast an integer into a binary string *)
let intToBin x len =
  let rec d2b y res = match y with 
    | 0 -> res
    | _ -> let tmp = if ((y mod 2) = 1) then "1" else "0" in 
      (d2b (y/2) (tmp^res))
  in
  let bin = (d2b x "") in
  let deltaSize = len - (String.length bin) in
  let deltaStr = String.make deltaSize '0' in
    deltaStr^bin
;;


(* init an empty memory *)
let initMemEmpty addrSize = 
  (* empty map *)
  let env = Env.empty in
  (* create all possible adresses *)
  let maxAddr = (pow 2 addrSize) in
  (* fprintf fStdout "maxAddr: %d\n@." maxAddr; *)
  let rec forAllAdresses curAddr env = 
    (* add the current adress to the env *)
    match curAddr with
    | addr when addr>=maxAddr -> env
    | _ -> 
      (* initiate to false buses of size addrSize *)
      let env = (Env.add (intToBin curAddr addrSize) (VBitArray(Array.make ramWordSize false)) env)
        in (forAllAdresses (curAddr+1) env)
    in (forAllAdresses 0 env)
;;

(* init the RAM *)
let initRAM addrSize =
  (* RAM is initiate empy *)
  (initMemEmpty addrSize)
;;

(* init the ROM (empty for the moment) *)
let initROM addrSize =
  (initMemEmpty addrSize)
;;

(* simulate a netlist *)
let simulator program number_steps = 
  (* Netlist.print_program stdout program; *)
  (* creating environments *)
  let env = (initEnv program) in
  (* empty ROM for the moment *)
  let envROM = (initROM romAddrSize) in
  (* init the RAM *)
  let envRAM = (initRAM ramAddrSize) in
  (* fprintf fStdout "nbsteps = %d\n@." number_steps; *)
  if (number_steps < (-1)) then catchException (LogicalError "Number of steps can't be a negative value!\n")
  else
    (* for i in range nbSteps *)
    let rec forNbStep numSteps env envRAM = 
      if (numSteps == 0) 
        then 
          begin
            fprintf fStdout "\n\nDone, final output:\n";
            (showResults program env)
          end
      else
        begin
          fprintf fStdout "Step %d:\n" (number_steps - (numSteps-1));
          (* ask for inputs *)
          let env = askForInputs program.p_inputs env in
            (* for eq in equations *)
            let eqs = program.p_eqs in
              let rec forEqs eqs env prevEnv envRAM prevEnvRAM =
                match eqs with
                | [] -> (env, envRAM)
                | eq::eqs ->
                  (* treats an equation *)
                  try
                    let (env, prevEnv, envRAM, prevEnvRAM) = (doEq eq env prevEnv envROM envRAM prevEnvRAM) in (forEqs eqs env prevEnv envRAM prevEnvRAM)
                  with exc -> (catchException exc)
              in
                let (env, envRAM) = (forEqs eqs env env envRAM envRAM) 
            in 
              begin 
                (showResults program env);
                (forNbStep (numSteps-1) env envRAM)
              end
          end
    in
    (forNbStep number_steps env envRAM)
;;

(* get a netlist program from a .net file and run the simulator on that program *)
let compile filename =
  try
    let p = Netlist.read_file filename in
    begin try
        let p = Scheduler.schedule p in
        (* print only option *)
        if (!print_only)
          then Netlist.print_program stdout p
          else
            simulator p !number_steps
      with
        | Scheduler.Combinational_cycle ->
            Format.eprintf "The netlist has a combinatory cycle.@.";
    end;
  with
    | Netlist.Parse_error s -> Format.eprintf "An error accurred: %s@." s; exit 2

let main () =
  Arg.parse
    [
      "-n", Arg.Set_int number_steps, "Number of steps to simulate";
      "--print", Arg.Set print_only, "Only prints the program"
    ]
    compile
    ""
;;

main ()
