
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | XOR
    | VAR
    | SLICE
    | SELECT
    | ROM
    | REG
    | RAM
    | OUTPUT
    | OR
    | NOT
    | NAND
    | NAME of (
# 27 "src/netlist_parser.mly"
       (string)
# 26 "src/netlist_parser.ml"
  )
    | MUX
    | INPUT
    | IN
    | EQUAL
    | EOF
    | CONST of (
# 26 "src/netlist_parser.mly"
       (string)
# 36 "src/netlist_parser.ml"
  )
    | CONCAT
    | COMMA
    | COLON
    | AND
  
end

include MenhirBasics

# 1 "src/netlist_parser.mly"
  
 open Netlist_ast

 let bool_of_string s = match s with
  | "t" | "1" -> true
  | "f" | "0" -> false
  | _ -> raise Parsing.Parse_error

 let bool_array_of_string s =
   let a = Array.make (String.length s) false in
   for i = 0 to String.length s - 1 do
     a.(i) <- bool_of_string (String.sub s i 1)
   done;
   a

 let value_of_const s =
   let n = String.length s in
   if n = 0 then
     raise Parsing.Parse_error
   else if n = 1 then
     VBit (bool_of_string s)
   else
     VBitArray (bool_array_of_string s)

# 72 "src/netlist_parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState01 : ('s, _menhir_box_program) _menhir_state
    (** State 01.
        Stack shape : .
        Start symbol: program. *)

  | MenhirState03 : (('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_state
    (** State 03.
        Stack shape : NAME.
        Start symbol: program. *)

  | MenhirState07 : (('s, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_state
    (** State 07.
        Stack shape : loption(separated_nonempty_list(COMMA,NAME)).
        Start symbol: program. *)

  | MenhirState09 : ((('s, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_state
    (** State 09.
        Stack shape : loption(separated_nonempty_list(COMMA,NAME)) loption(separated_nonempty_list(COMMA,NAME)).
        Start symbol: program. *)

  | MenhirState11 : (('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_state
    (** State 11.
        Stack shape : NAME.
        Start symbol: program. *)

  | MenhirState16 : (('s, _menhir_box_program) _menhir_cell1_var, _menhir_box_program) _menhir_state
    (** State 16.
        Stack shape : var.
        Start symbol: program. *)

  | MenhirState20 : (((('s, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_var__, _menhir_box_program) _menhir_state
    (** State 20.
        Stack shape : loption(separated_nonempty_list(COMMA,NAME)) loption(separated_nonempty_list(COMMA,NAME)) loption(separated_nonempty_list(COMMA,var)).
        Start symbol: program. *)

  | MenhirState22 : (('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_state
    (** State 22.
        Stack shape : NAME.
        Start symbol: program. *)

  | MenhirState23 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_XOR, _menhir_box_program) _menhir_state
    (** State 23.
        Stack shape : NAME XOR.
        Start symbol: program. *)

  | MenhirState26 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_XOR, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 26.
        Stack shape : NAME XOR arg.
        Start symbol: program. *)

  | MenhirState28 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SLICE, _menhir_box_program) _menhir_state
    (** State 28.
        Stack shape : NAME SLICE.
        Start symbol: program. *)

  | MenhirState29 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SLICE, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 29.
        Stack shape : NAME SLICE int.
        Start symbol: program. *)

  | MenhirState30 : ((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SLICE, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 30.
        Stack shape : NAME SLICE int int.
        Start symbol: program. *)

  | MenhirState32 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SELECT, _menhir_box_program) _menhir_state
    (** State 32.
        Stack shape : NAME SELECT.
        Start symbol: program. *)

  | MenhirState33 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SELECT, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 33.
        Stack shape : NAME SELECT int.
        Start symbol: program. *)

  | MenhirState35 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_ROM, _menhir_box_program) _menhir_state
    (** State 35.
        Stack shape : NAME ROM.
        Start symbol: program. *)

  | MenhirState36 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_ROM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 36.
        Stack shape : NAME ROM int.
        Start symbol: program. *)

  | MenhirState37 : ((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_ROM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 37.
        Stack shape : NAME ROM int int.
        Start symbol: program. *)

  | MenhirState41 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_state
    (** State 41.
        Stack shape : NAME RAM.
        Start symbol: program. *)

  | MenhirState42 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 42.
        Stack shape : NAME RAM int.
        Start symbol: program. *)

  | MenhirState43 : ((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_state
    (** State 43.
        Stack shape : NAME RAM int int.
        Start symbol: program. *)

  | MenhirState44 : (((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 44.
        Stack shape : NAME RAM int int arg.
        Start symbol: program. *)

  | MenhirState45 : ((((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 45.
        Stack shape : NAME RAM int int arg arg.
        Start symbol: program. *)

  | MenhirState46 : (((((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 46.
        Stack shape : NAME RAM int int arg arg arg.
        Start symbol: program. *)

  | MenhirState48 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_OR, _menhir_box_program) _menhir_state
    (** State 48.
        Stack shape : NAME OR.
        Start symbol: program. *)

  | MenhirState49 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_OR, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 49.
        Stack shape : NAME OR arg.
        Start symbol: program. *)

  | MenhirState51 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_NOT, _menhir_box_program) _menhir_state
    (** State 51.
        Stack shape : NAME NOT.
        Start symbol: program. *)

  | MenhirState53 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_NAND, _menhir_box_program) _menhir_state
    (** State 53.
        Stack shape : NAME NAND.
        Start symbol: program. *)

  | MenhirState54 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_NAND, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 54.
        Stack shape : NAME NAND arg.
        Start symbol: program. *)

  | MenhirState56 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_MUX, _menhir_box_program) _menhir_state
    (** State 56.
        Stack shape : NAME MUX.
        Start symbol: program. *)

  | MenhirState57 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_MUX, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 57.
        Stack shape : NAME MUX arg.
        Start symbol: program. *)

  | MenhirState58 : ((((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_MUX, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 58.
        Stack shape : NAME MUX arg arg.
        Start symbol: program. *)

  | MenhirState60 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_CONCAT, _menhir_box_program) _menhir_state
    (** State 60.
        Stack shape : NAME CONCAT.
        Start symbol: program. *)

  | MenhirState61 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_CONCAT, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 61.
        Stack shape : NAME CONCAT arg.
        Start symbol: program. *)

  | MenhirState63 : ((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_AND, _menhir_box_program) _menhir_state
    (** State 63.
        Stack shape : NAME AND.
        Start symbol: program. *)

  | MenhirState64 : (((('s, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_AND, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_state
    (** State 64.
        Stack shape : NAME AND arg.
        Start symbol: program. *)

  | MenhirState70 : (('s, _menhir_box_program) _menhir_cell1_equ, _menhir_box_program) _menhir_state
    (** State 70.
        Stack shape : equ.
        Start symbol: program. *)


and ('s, 'r) _menhir_cell1_arg = 
  | MenhirCell1_arg of 's * ('s, 'r) _menhir_state * (Netlist_ast.arg)

and ('s, 'r) _menhir_cell1_equ = 
  | MenhirCell1_equ of 's * ('s, 'r) _menhir_state * (Netlist_ast.equation)

and ('s, 'r) _menhir_cell1_int = 
  | MenhirCell1_int of 's * ('s, 'r) _menhir_state * (int)

and ('s, 'r) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__ = 
  | MenhirCell1_loption_separated_nonempty_list_COMMA_NAME__ of 's * ('s, 'r) _menhir_state * (Netlist_ast.ident list)

and ('s, 'r) _menhir_cell1_loption_separated_nonempty_list_COMMA_var__ = 
  | MenhirCell1_loption_separated_nonempty_list_COMMA_var__ of 's * ('s, 'r) _menhir_state * ((Netlist_ast.Env.key * Netlist_ast.ty) list)

and ('s, 'r) _menhir_cell1_var = 
  | MenhirCell1_var of 's * ('s, 'r) _menhir_state * (Netlist_ast.Env.key * Netlist_ast.ty)

and ('s, 'r) _menhir_cell1_AND = 
  | MenhirCell1_AND of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CONCAT = 
  | MenhirCell1_CONCAT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MUX = 
  | MenhirCell1_MUX of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NAME = 
  | MenhirCell1_NAME of 's * ('s, 'r) _menhir_state * (
# 27 "src/netlist_parser.mly"
       (string)
# 292 "src/netlist_parser.ml"
)

and ('s, 'r) _menhir_cell1_NAND = 
  | MenhirCell1_NAND of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NOT = 
  | MenhirCell1_NOT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_OR = 
  | MenhirCell1_OR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RAM = 
  | MenhirCell1_RAM of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ROM = 
  | MenhirCell1_ROM of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SELECT = 
  | MenhirCell1_SELECT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SLICE = 
  | MenhirCell1_SLICE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_XOR = 
  | MenhirCell1_XOR of 's * ('s, 'r) _menhir_state

and _menhir_box_program = 
  | MenhirBox_program of (Netlist_ast.program) [@@unboxed]

let _menhir_action_01 =
  fun n ->
    (
# 67 "src/netlist_parser.mly"
            ( Aconst (value_of_const n) )
# 327 "src/netlist_parser.ml"
     : (Netlist_ast.arg))

let _menhir_action_02 =
  fun id ->
    (
# 68 "src/netlist_parser.mly"
            ( Avar id )
# 335 "src/netlist_parser.ml"
     : (Netlist_ast.arg))

let _menhir_action_03 =
  fun e x ->
    (
# 44 "src/netlist_parser.mly"
                     ( (x, e) )
# 343 "src/netlist_parser.ml"
     : (Netlist_ast.equation))

let _menhir_action_04 =
  fun a ->
    (
# 47 "src/netlist_parser.mly"
          ( Earg a )
# 351 "src/netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_05 =
  fun x ->
    (
# 48 "src/netlist_parser.mly"
              ( Enot x )
# 359 "src/netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_06 =
  fun x ->
    (
# 49 "src/netlist_parser.mly"
               ( Ereg x )
# 367 "src/netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_07 =
  fun x y ->
    (
# 50 "src/netlist_parser.mly"
                    ( Ebinop(And, x, y) )
# 375 "src/netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_08 =
  fun x y ->
    (
# 51 "src/netlist_parser.mly"
                   ( Ebinop(Or, x, y) )
# 383 "src/netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_09 =
  fun x y ->
    (
# 52 "src/netlist_parser.mly"
                     ( Ebinop(Nand, x, y) )
# 391 "src/netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_10 =
  fun x y ->
    (
# 53 "src/netlist_parser.mly"
                    ( Ebinop(Xor, x, y) )
# 399 "src/netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_11 =
  fun x y z ->
    (
# 54 "src/netlist_parser.mly"
                          ( Emux(x, y, z) )
# 407 "src/netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_12 =
  fun addr ra word ->
    (
# 56 "src/netlist_parser.mly"
    ( Erom(addr, word, ra) )
# 415 "src/netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_13 =
  fun addr data ra wa we word ->
    (
# 58 "src/netlist_parser.mly"
    ( Eram(addr, word, ra, we, wa, data) )
# 423 "src/netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_14 =
  fun x y ->
    (
# 60 "src/netlist_parser.mly"
     ( Econcat(x, y) )
# 431 "src/netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_15 =
  fun idx x ->
    (
# 62 "src/netlist_parser.mly"
     ( Eselect (idx, x) )
# 439 "src/netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_16 =
  fun max min x ->
    (
# 64 "src/netlist_parser.mly"
     ( Eslice (min, max, x) )
# 447 "src/netlist_parser.ml"
     : (Netlist_ast.exp))

let _menhir_action_17 =
  fun c ->
    (
# 76 "src/netlist_parser.mly"
            ( int_of_string c )
# 455 "src/netlist_parser.ml"
     : (int))

let _menhir_action_18 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 463 "src/netlist_parser.ml"
     : (Netlist_ast.equation list))

let _menhir_action_19 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 471 "src/netlist_parser.ml"
     : (Netlist_ast.equation list))

let _menhir_action_20 =
  fun () ->
    (
# 139 "<standard.mly>"
    ( [] )
# 479 "src/netlist_parser.ml"
     : (Netlist_ast.ident list))

let _menhir_action_21 =
  fun x ->
    (
# 141 "<standard.mly>"
    ( x )
# 487 "src/netlist_parser.ml"
     : (Netlist_ast.ident list))

let _menhir_action_22 =
  fun () ->
    (
# 139 "<standard.mly>"
    ( [] )
# 495 "src/netlist_parser.ml"
     : ((Netlist_ast.Env.key * Netlist_ast.ty) list))

let _menhir_action_23 =
  fun x ->
    (
# 141 "<standard.mly>"
    ( x )
# 503 "src/netlist_parser.ml"
     : ((Netlist_ast.Env.key * Netlist_ast.ty) list))

let _menhir_action_24 =
  fun eqs xs xs_inlined1 xs_inlined2 ->
    let vars =
      let xs = xs_inlined2 in
      
# 229 "<standard.mly>"
    ( xs )
# 513 "src/netlist_parser.ml"
      
    in
    let out =
      let xs = xs_inlined1 in
      
# 229 "<standard.mly>"
    ( xs )
# 521 "src/netlist_parser.ml"
      
    in
    let inp = 
# 229 "<standard.mly>"
    ( xs )
# 527 "src/netlist_parser.ml"
     in
    (
# 41 "src/netlist_parser.mly"
    ( { p_eqs = eqs; p_vars = Env.of_list vars; p_inputs = inp; p_outputs = out; } )
# 532 "src/netlist_parser.ml"
     : (Netlist_ast.program))

let _menhir_action_25 =
  fun x ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 540 "src/netlist_parser.ml"
     : (Netlist_ast.ident list))

let _menhir_action_26 =
  fun x xs ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 548 "src/netlist_parser.ml"
     : (Netlist_ast.ident list))

let _menhir_action_27 =
  fun x ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 556 "src/netlist_parser.ml"
     : ((Netlist_ast.Env.key * Netlist_ast.ty) list))

let _menhir_action_28 =
  fun x xs ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 564 "src/netlist_parser.ml"
     : ((Netlist_ast.Env.key * Netlist_ast.ty) list))

let _menhir_action_29 =
  fun () ->
    (
# 72 "src/netlist_parser.mly"
              ( TBit )
# 572 "src/netlist_parser.ml"
     : (Netlist_ast.ty))

let _menhir_action_30 =
  fun n ->
    (
# 73 "src/netlist_parser.mly"
                ( TBitArray n )
# 580 "src/netlist_parser.ml"
     : (Netlist_ast.ty))

let _menhir_action_31 =
  fun ty x ->
    (
# 70 "src/netlist_parser.mly"
                      ( (x, ty) )
# 588 "src/netlist_parser.ml"
     : (Netlist_ast.Env.key * Netlist_ast.ty))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | AND ->
        "AND"
    | COLON ->
        "COLON"
    | COMMA ->
        "COMMA"
    | CONCAT ->
        "CONCAT"
    | CONST _ ->
        "CONST"
    | EOF ->
        "EOF"
    | EQUAL ->
        "EQUAL"
    | IN ->
        "IN"
    | INPUT ->
        "INPUT"
    | MUX ->
        "MUX"
    | NAME _ ->
        "NAME"
    | NAND ->
        "NAND"
    | NOT ->
        "NOT"
    | OR ->
        "OR"
    | OUTPUT ->
        "OUTPUT"
    | RAM ->
        "RAM"
    | REG ->
        "REG"
    | ROM ->
        "ROM"
    | SELECT ->
        "SELECT"
    | SLICE ->
        "SLICE"
    | VAR ->
        "VAR"
    | XOR ->
        "XOR"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_68 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_var__ -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let MenhirCell1_loption_separated_nonempty_list_COMMA_var__ (_menhir_stack, _, xs_inlined2) = _menhir_stack in
      let MenhirCell1_loption_separated_nonempty_list_COMMA_NAME__ (_menhir_stack, _, xs_inlined1) = _menhir_stack in
      let MenhirCell1_loption_separated_nonempty_list_COMMA_NAME__ (_menhir_stack, _, xs) = _menhir_stack in
      let eqs = _v in
      let _v = _menhir_action_24 eqs xs xs_inlined1 xs_inlined2 in
      MenhirBox_program _v
  
  let rec _menhir_run_71 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_equ -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let MenhirCell1_equ (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_19 x xs in
      _menhir_goto_list_equ_ _menhir_stack _v _menhir_s
  
  and _menhir_goto_list_equ_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState70 ->
          _menhir_run_71 _menhir_stack _v
      | MenhirState20 ->
          _menhir_run_68 _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_21 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_NAME (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | EQUAL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | XOR ->
              let _menhir_stack = MenhirCell1_XOR (_menhir_stack, MenhirState22) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v_0 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let id = _v_0 in
                  let _v = _menhir_action_02 id in
                  _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState23 _tok
              | CONST _v_2 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let n = _v_2 in
                  let _v = _menhir_action_01 n in
                  _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState23 _tok
              | _ ->
                  _eRR ())
          | SLICE ->
              let _menhir_stack = MenhirCell1_SLICE (_menhir_stack, MenhirState22) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CONST _v_4 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v_5 =
                    let c = _v_4 in
                    _menhir_action_17 c
                  in
                  let _menhir_stack = MenhirCell1_int (_menhir_stack, MenhirState28, _v_5) in
                  (match (_tok : MenhirBasics.token) with
                  | CONST _v_6 ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      let _v_7 =
                        let c = _v_6 in
                        _menhir_action_17 c
                      in
                      let _menhir_stack = MenhirCell1_int (_menhir_stack, MenhirState29, _v_7) in
                      (match (_tok : MenhirBasics.token) with
                      | NAME _v_8 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let id = _v_8 in
                          let _v = _menhir_action_02 id in
                          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
                      | CONST _v_10 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let n = _v_10 in
                          let _v = _menhir_action_01 n in
                          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
                      | _ ->
                          _eRR ())
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | SELECT ->
              let _menhir_stack = MenhirCell1_SELECT (_menhir_stack, MenhirState22) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CONST _v_12 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v_13 =
                    let c = _v_12 in
                    _menhir_action_17 c
                  in
                  let _menhir_stack = MenhirCell1_int (_menhir_stack, MenhirState32, _v_13) in
                  (match (_tok : MenhirBasics.token) with
                  | NAME _v_14 ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      let id = _v_14 in
                      let _v = _menhir_action_02 id in
                      _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
                  | CONST _v_16 ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      let n = _v_16 in
                      let _v = _menhir_action_01 n in
                      _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | ROM ->
              let _menhir_stack = MenhirCell1_ROM (_menhir_stack, MenhirState22) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CONST _v_18 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v_19 =
                    let c = _v_18 in
                    _menhir_action_17 c
                  in
                  let _menhir_stack = MenhirCell1_int (_menhir_stack, MenhirState35, _v_19) in
                  (match (_tok : MenhirBasics.token) with
                  | CONST _v_20 ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      let _v_21 =
                        let c = _v_20 in
                        _menhir_action_17 c
                      in
                      let _menhir_stack = MenhirCell1_int (_menhir_stack, MenhirState36, _v_21) in
                      (match (_tok : MenhirBasics.token) with
                      | NAME _v_22 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let id = _v_22 in
                          let _v = _menhir_action_02 id in
                          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
                      | CONST _v_24 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let n = _v_24 in
                          let _v = _menhir_action_01 n in
                          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
                      | _ ->
                          _eRR ())
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | REG ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v_26 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let x = _v_26 in
                  let _v = _menhir_action_06 x in
                  _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | _ ->
                  _eRR ())
          | RAM ->
              let _menhir_stack = MenhirCell1_RAM (_menhir_stack, MenhirState22) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | CONST _v_28 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let _v_29 =
                    let c = _v_28 in
                    _menhir_action_17 c
                  in
                  let _menhir_stack = MenhirCell1_int (_menhir_stack, MenhirState41, _v_29) in
                  (match (_tok : MenhirBasics.token) with
                  | CONST _v_30 ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      let _v_31 =
                        let c = _v_30 in
                        _menhir_action_17 c
                      in
                      let _menhir_stack = MenhirCell1_int (_menhir_stack, MenhirState42, _v_31) in
                      (match (_tok : MenhirBasics.token) with
                      | NAME _v_32 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let id = _v_32 in
                          let _v = _menhir_action_02 id in
                          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState43 _tok
                      | CONST _v_34 ->
                          let _tok = _menhir_lexer _menhir_lexbuf in
                          let n = _v_34 in
                          let _v = _menhir_action_01 n in
                          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState43 _tok
                      | _ ->
                          _eRR ())
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | OR ->
              let _menhir_stack = MenhirCell1_OR (_menhir_stack, MenhirState22) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v_36 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let id = _v_36 in
                  let _v = _menhir_action_02 id in
                  _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState48 _tok
              | CONST _v_38 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let n = _v_38 in
                  let _v = _menhir_action_01 n in
                  _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState48 _tok
              | _ ->
                  _eRR ())
          | NOT ->
              let _menhir_stack = MenhirCell1_NOT (_menhir_stack, MenhirState22) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v_40 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let id = _v_40 in
                  let _v = _menhir_action_02 id in
                  _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | CONST _v_42 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let n = _v_42 in
                  let _v = _menhir_action_01 n in
                  _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | _ ->
                  _eRR ())
          | NAND ->
              let _menhir_stack = MenhirCell1_NAND (_menhir_stack, MenhirState22) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v_44 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let id = _v_44 in
                  let _v = _menhir_action_02 id in
                  _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState53 _tok
              | CONST _v_46 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let n = _v_46 in
                  let _v = _menhir_action_01 n in
                  _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState53 _tok
              | _ ->
                  _eRR ())
          | NAME _v_48 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let id = _v_48 in
              let _v = _menhir_action_02 id in
              _menhir_run_67_spec_22 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | MUX ->
              let _menhir_stack = MenhirCell1_MUX (_menhir_stack, MenhirState22) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v_50 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let id = _v_50 in
                  let _v = _menhir_action_02 id in
                  _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState56 _tok
              | CONST _v_52 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let n = _v_52 in
                  let _v = _menhir_action_01 n in
                  _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState56 _tok
              | _ ->
                  _eRR ())
          | CONST _v_54 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let n = _v_54 in
              let _v = _menhir_action_01 n in
              _menhir_run_67_spec_22 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | CONCAT ->
              let _menhir_stack = MenhirCell1_CONCAT (_menhir_stack, MenhirState22) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v_56 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let id = _v_56 in
                  let _v = _menhir_action_02 id in
                  _menhir_run_61 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState60 _tok
              | CONST _v_58 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let n = _v_58 in
                  let _v = _menhir_action_01 n in
                  _menhir_run_61 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState60 _tok
              | _ ->
                  _eRR ())
          | AND ->
              let _menhir_stack = MenhirCell1_AND (_menhir_stack, MenhirState22) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | NAME _v_60 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let id = _v_60 in
                  let _v = _menhir_action_02 id in
                  _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState63 _tok
              | CONST _v_62 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let n = _v_62 in
                  let _v = _menhir_action_01 n in
                  _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState63 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_26 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_XOR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let id = _v_0 in
          let _v = _menhir_action_02 id in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | CONST _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_2 in
          let _v = _menhir_action_01 n in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_27 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_XOR, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_XOR (_menhir_stack, _) = _menhir_stack in
      let y = _v in
      let _v = _menhir_action_10 x y in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_exp : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_NAME -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      _menhir_run_66 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_66 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_NAME -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NAME (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_03 e x in
      let _menhir_stack = MenhirCell1_equ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState70
      | EOF ->
          let _v = _menhir_action_18 () in
          _menhir_run_71 _menhir_stack _v
      | _ ->
          _eRR ()
  
  and _menhir_run_31 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SLICE, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_int (_menhir_stack, _, max) = _menhir_stack in
      let MenhirCell1_int (_menhir_stack, _, min) = _menhir_stack in
      let MenhirCell1_SLICE (_menhir_stack, _) = _menhir_stack in
      let x = _v in
      let _v = _menhir_action_16 max min x in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_34 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_SELECT, _menhir_box_program) _menhir_cell1_int -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_int (_menhir_stack, _, idx) = _menhir_stack in
      let MenhirCell1_SELECT (_menhir_stack, _) = _menhir_stack in
      let x = _v in
      let _v = _menhir_action_15 idx x in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_38 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_ROM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_int (_menhir_stack, _, word) = _menhir_stack in
      let MenhirCell1_int (_menhir_stack, _, addr) = _menhir_stack in
      let MenhirCell1_ROM (_menhir_stack, _) = _menhir_stack in
      let ra = _v in
      let _v = _menhir_action_12 addr ra word in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_44 : type  ttv_stack. (((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let id = _v_0 in
          let _v = _menhir_action_02 id in
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState44 _tok
      | CONST _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_2 in
          let _v = _menhir_action_01 n in
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState44 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_45 : type  ttv_stack. ((((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_arg as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let id = _v_0 in
          let _v = _menhir_action_02 id in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState45 _tok
      | CONST _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_2 in
          let _v = _menhir_action_01 n in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState45 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_46 : type  ttv_stack. (((((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let id = _v_0 in
          let _v = _menhir_action_02 id in
          _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | CONST _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_2 in
          let _v = _menhir_action_01 n in
          _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_47 : type  ttv_stack. (((((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_RAM, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_int, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, wa) = _menhir_stack in
      let MenhirCell1_arg (_menhir_stack, _, we) = _menhir_stack in
      let MenhirCell1_arg (_menhir_stack, _, ra) = _menhir_stack in
      let MenhirCell1_int (_menhir_stack, _, word) = _menhir_stack in
      let MenhirCell1_int (_menhir_stack, _, addr) = _menhir_stack in
      let MenhirCell1_RAM (_menhir_stack, _) = _menhir_stack in
      let data = _v in
      let _v = _menhir_action_13 addr data ra wa we word in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_49 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_OR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let id = _v_0 in
          let _v = _menhir_action_02 id in
          _menhir_run_50 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | CONST _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_2 in
          let _v = _menhir_action_01 n in
          _menhir_run_50 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_50 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_OR, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_OR (_menhir_stack, _) = _menhir_stack in
      let y = _v in
      let _v = _menhir_action_08 x y in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_52 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_NOT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NOT (_menhir_stack, _) = _menhir_stack in
      let x = _v in
      let _v = _menhir_action_05 x in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_54 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_NAND as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let id = _v_0 in
          let _v = _menhir_action_02 id in
          _menhir_run_55 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | CONST _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_2 in
          let _v = _menhir_action_01 n in
          _menhir_run_55 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_55 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_NAND, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_NAND (_menhir_stack, _) = _menhir_stack in
      let y = _v in
      let _v = _menhir_action_09 x y in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_67_spec_22 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_NAME -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let a = _v in
      let _v = _menhir_action_04 a in
      _menhir_run_66 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_57 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_MUX as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let id = _v_0 in
          let _v = _menhir_action_02 id in
          _menhir_run_58 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState57 _tok
      | CONST _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_2 in
          let _v = _menhir_action_01 n in
          _menhir_run_58 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState57 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_58 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_MUX, _menhir_box_program) _menhir_cell1_arg as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let id = _v_0 in
          let _v = _menhir_action_02 id in
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | CONST _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_2 in
          let _v = _menhir_action_01 n in
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_59 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_MUX, _menhir_box_program) _menhir_cell1_arg, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, y) = _menhir_stack in
      let MenhirCell1_arg (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_MUX (_menhir_stack, _) = _menhir_stack in
      let z = _v in
      let _v = _menhir_action_11 x y z in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_61 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_CONCAT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let id = _v_0 in
          let _v = _menhir_action_02 id in
          _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | CONST _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_2 in
          let _v = _menhir_action_01 n in
          _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_62 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_CONCAT, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_CONCAT (_menhir_stack, _) = _menhir_stack in
      let y = _v in
      let _v = _menhir_action_14 x y in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_64 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_AND as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_arg (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | NAME _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let id = _v_0 in
          let _v = _menhir_action_02 id in
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | CONST _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_2 in
          let _v = _menhir_action_01 n in
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_65 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_NAME, _menhir_box_program) _menhir_cell1_AND, _menhir_box_program) _menhir_cell1_arg -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_arg (_menhir_stack, _, x) = _menhir_stack in
      let MenhirCell1_AND (_menhir_stack, _) = _menhir_stack in
      let y = _v in
      let _v = _menhir_action_07 x y in
      _menhir_goto_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  let rec _menhir_run_19 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_var__ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | NAME _v ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState20
      | EOF ->
          let _v = _menhir_action_18 () in
          _menhir_run_68 _menhir_stack _v
      | _ ->
          _eRR ()
  
  let rec _menhir_run_18_spec_09 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_23 x in
      _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState09
  
  let rec _menhir_goto_separated_nonempty_list_COMMA_var_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState09 ->
          _menhir_run_18_spec_09 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState16 ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_17 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_var -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_var (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_28 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_var_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  let rec _menhir_run_10 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_NAME (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | CONST _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v_1 =
                let c = _v_0 in
                _menhir_action_17 c
              in
              let n = _v_1 in
              let _v = _menhir_action_30 n in
              _menhir_goto_ty_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | COMMA | IN ->
          let _v = _menhir_action_29 () in
          _menhir_goto_ty_exp _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_ty_exp : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_NAME -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NAME (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let ty = _v in
      let _v = _menhir_action_31 ty x in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_var (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NAME _v ->
              _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState16
          | _ ->
              _eRR ())
      | IN ->
          let x = _v in
          let _v = _menhir_action_27 x in
          _menhir_goto_separated_nonempty_list_COMMA_var_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  let rec _menhir_run_08 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_NAME__ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | VAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NAME _v ->
              _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState09
          | IN ->
              let _v = _menhir_action_22 () in
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState09
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  let rec _menhir_run_05_spec_07 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_NAME__ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let x = _v in
      let _v = _menhir_action_21 x in
      _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState07 _tok
  
  let rec _menhir_run_02 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_NAME (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NAME _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState03
          | _ ->
              _eRR ())
      | OUTPUT | VAR ->
          let x = _v in
          let _v = _menhir_action_25 x in
          _menhir_goto_separated_nonempty_list_COMMA_NAME_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_NAME_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState07 ->
          _menhir_run_05_spec_07 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState01 ->
          _menhir_run_05_spec_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState03 ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_05_spec_01 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let x = _v in
      let _v = _menhir_action_21 x in
      _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState01 _tok
  
  and _menhir_run_06 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_NAME__ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | OUTPUT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NAME _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState07
          | VAR ->
              let _v = _menhir_action_20 () in
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState07 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_04 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_NAME -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NAME (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_26 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_NAME_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | INPUT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | NAME _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState01
          | OUTPUT ->
              let _v = _menhir_action_20 () in
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState01 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
end

let program =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_program v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
