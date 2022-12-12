file = fulladder
list = "clock_div cm2 fulladder nadder ram"
n = 
print = 


all: netlist_simulator.byte
ifndef n
	dune exec ./netlist_simulator.exe test/$(file).net
else
	dune exec -- ./netlist_simulator.exe -n $(n)  test/$(file).net
endif

sched: scheduler_test.byte
ifdef n
	dune exec -- ./scheduler_test.exe -n $(n)  test/$(file).net
else ifndef print
	dune exec ./scheduler_test.exe test/$(file).net
else
	dune exec -- ./scheduler_test.exe -print test/$(file).net
	cat test/$(file)_sch.net
endif

graph: graph.byte
	dune exec ./graph_test.exe

netlist_simulator.byte: netlist_simulator.ml
	dune build netlist_simulator.exe

graph.byte: graph.ml
	dune build netlist_simulator.exe

scheduler_test.byte: scheduler.ml graph.ml
	dune build scheduler_test.exe

list: 
	@echo "liste des valeurs possibles pour \`file\` : "$(list)

help:
	@echo "aide pour le projet de simulateur :\n\
		\e[1;7mhelp\e[0m: affiche cette aide\n\
		\e[2;3mdéfaut\e[0m : exécute netlist_simulator sur fulladder\n\
			variables :\n\
				file : fichier à exécuter\n\
				n : nombres de cycles\n\
		\e[1;7msched\e[0m : exécute le test de scheduler sur fulladder\n\
			variables :\n\
				file : fichier à exécuter\n\
				n : nombres de cycles\n\
				print : option print\n\
		\e[1;7mgraph\e[0m : exécute les tests du tri topologique\n\
		\e[1;7mlist\e[0m : affiche la liste des fichier disponibles\n\
		\e[1;7mclean\e[0m : passer un petit coup de balai"

clean:
	dune clean
	rm -f test/*_sch*.net

.PHONY: all sched graph list help clean 



