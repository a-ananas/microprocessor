type file = File of instr list

and instr = Instr of instr_type

and instr_type = 
  | R of opcode*reg*reg*reg
  | I of opcode*reg*imm*reg
  | U of opcode*imm*reg

(* the bits are encoded in a string *)
and opcode = Opc of string
and reg = string
and imm = string
