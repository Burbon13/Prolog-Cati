/* Exercise 2 - Circuits */


/* Verifies that List is a valid List which describes a circuit */
circuit(List):-
    circuit_verifier(List, 1).


/*  */
circuit_verifier([], _):-!.
circuit_verifier([H|T], 1):-
    is_gate(H),
    circuit_verifier(T,0),
    !.
circuit_verifier([H|T], 0):-
    is_gate(H),
    circuit_verifier(T,0),
    !.
circuit_verifier([H|T], 0):-
    is_comment(H),
    circuit_verifier(T,1),
    !.


/* is_gate(X) verifies if X is a gate (according to the definition from the
 * task) */
is_gate(gate(Name, or, [_,_|_], Output)):-
    !,
    list_of_atoms([Name, Output]).
is_gate(gate(Name, and, [_,_|_], Output)):-
    !,
    list_of_atoms([Name, Output]).
is_gate(gate(Name, xor, [_,_|_], Output)):-
    !,
    list_of_atoms([Name, Output]).
is_gate(gate(Name, nor, [_,_|_], Output)):-
    !,
    list_of_atoms([Name, Output]).
is_gate(gate(Name, nand, [_,_|_], Output)):-
    !,
    list_of_atoms([Name, Output]).
is_gate(gate(Name, not, Inputs, Output)):-
    !,
    list_of_atoms([Name, Inputs, Output]).


/**/
is_comment(com(Text)):-
    atom(Text).


/* list_of_atoms(List) verifies that every element inside List is an atom */
list_of_atoms([]):-!.
list_of_atoms([H|T]):-
    atom(H),
    list_of_atoms(T).
