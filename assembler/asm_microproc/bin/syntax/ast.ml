type file = File of instr list

and instr = Instr of instr_type

and instr_type = 
  | R of opcode*reg*reg*reg
  | I of opcode*reg*jmp*reg
  | U of opcode*jmp*reg
  | Lab_def of lab

(* the bits are encoded in a string *)
and opcode = Opc of string
and reg = string
and jmp = Label of lab | Imm of imm
and imm = int
and lab = string*int
