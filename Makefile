all:
	@printf "\n\n\n########## BUILDING ASSEMBLER ##########\n\n\n"
	@$(MAKE) compiler -C assembler
	@printf "\n\n\n########## BUILDING SIMULATOR ##########\n\n\n"
	@$(MAKE) simulator -C netlist_simulator
	@printf "\n\n\n########## BUILDING NETLIST ##########\n\n\n"
	@$(MAKE) tofile -C proc_netlist
	@printf "\n\n\n########## DONE BUILDING EVERYTHING ##########\n\n\n"
