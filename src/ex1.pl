/* Exercise 2 - Circuits */


/* remove_comments(List, Res) removes the comments from List and saves the
 * result inside Res */
delete_comments([], []):-!.
delete_comments([H|T], Res):-
    is_comment(H),
    delete_comments(T, Res),
    !.
delete_comments([H|T], [H|Res]):-
    is_gate(H),
    delete_comments(T, Res).


/* circuit(X) is True if X is a term that representa a combinational
 * logic circuit, in the form of a list of circuits */
circuit(List):-
    circuit_verifier(List, 1).


/* Ask author for further explanations */
circuit_verifier([], _):-!.
circuit_verifier([H|T], 1):-
    is_gate(H),
    !,
    circuit_verifier(T,0).
circuit_verifier([H|T], 0):-
    is_gate(H),
    !,
    circuit_verifier(T,0).
circuit_verifier([H|T], 0):-
    is_comment(H),
    circuit_verifier(T,1).


/* is_gate(X) verifies if X is a gate (according to the definition from the
 * task) */
is_gate(gate(Name, Operator, [_,_|_], Output)):-
    !,
    is_binary_operator(Operator),
    list_of_atoms([Name, Output]).
is_gate(gate(Name, not, Inputs, Output)):-
    !,
    list_of_atoms([Name, Inputs, Output]).


/* is_binary_operator(Operator) verifies if Operator is or, and, xor, nor or nand */
is_binary_operator(or):-!.
is_binary_operator(and):-!.
is_binary_operator(xor):-!.
is_binary_operator(nor):-!.
is_binary_operator(nand):-!.


/* is_comment(X) verifies that X has the form com(Text), where Text must be
 * a String */
is_comment(com(Text)):-
    string(Text).


/* list_of_atoms(List) verifies that every element inside List is an atom */
list_of_atoms([]):-!.
list_of_atoms([H|T]):-
    atom(H),
    list_of_atoms(T).
