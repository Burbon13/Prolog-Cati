/* Exercise 2 - Circuits */


/* connections_list(C, Connections) is True if Connections is the list of all
 * the connections names of Circuit C */
connections_list([], []):-!.
connections_list([H|T], Connections):-
    is_comment(H),
    connections_list(T, Connections),
    !.
connections_list([H|T], Connections):-
    is_gate(H),
    get_name(H, GateName),
    is_in(Connections, GateName),
    remove_val(Connections, GateName, NewConnections),
    connections_list(T, NewConnections).


/* get_name(Gate, Name) saves the name of the gate inside Name */
get_name(gate(Name, _, _, _), Name).


/* is_in(List, Value) verifies if Value exists inside List */
is_in([H|_], H):-!.
is_in([_|T], Val):-
    is_in(T, Val).


/* remove_val(List, Val, NewList) removes Val from List and stores it to NewList */
remove_val([],_,[]):-!.
remove_val([H|T], H, T):-!.
remove_val([H|T], Val, [H|Res]):-
    remove_val(T, Val, Res).


/* delete_comments(List, Res) removes the comments from List and saves the
 * result inside Res OR checks if Res equals to List withous comments */
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
