#!/bin/bash

# Constants
BLACK=$(tput -Txterm setaf 0);
RED=$(tput -Txterm setaf 1);
GREEN=$(tput -Txterm setaf 2);
YELLOW=$(tput -Txterm setaf 3);
BLUE=$(tput -Txterm setaf 4);
MAGENTA=$(tput -Txterm setaf 5);
CYAN=$(tput -Txterm setaf 6);
WHITE=$(tput -Txterm setaf 7);
RESET=$(tput -Txterm sgr0);
    
TESTFILES=$(ls test/*.net);

printf "\n${CYAN}########## BEGIN TESTS ##########${RESET}\n\n";

printf "\n${CYAN}##### TESTS GRAPH #####\n${RESET}";
./bin/graph_test.byte;
printf "\n${GREEN}##### DONE #####${RESET}\n\n"

printf "\n${CYAN}##### TESTS SCHEDULER #####\n\n${RESET}";
for testFile in ${TESTFILES}; do
    printf "Testing on ${YELLOW}${testFile}${RESET}:";
	./bin/scheduler_test.byte -print ${testFile};
	schFile=$(echo ${testFile} | sed 's/.net/_sch.net/');
	printf "\n${MAGENTA}Before scheduling: \n\n${RESET}";
    cat ${testFile};
	printf "\n${MAGENTA}After scheduling: \n\n${RESET}";
    cat ${schFile};
    rm ${schFile};
	printf "\n${GREEN}DONE${RESET}\n";
done;


printf "\n\n${CYAN}########## TESTS DONE ##########\n\n${RESET}"