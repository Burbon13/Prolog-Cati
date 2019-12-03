/* Exercise 2 - Circuits */

/* signal(Connection, Circuit, Inputs, Value) */
signal(Connection, Circuit, Inputs, Value):-
    signal_calculator(Circuit, Inputs, [], Outputs),
    has_value(Outputs, Connection, Value).


/* signal_calculator(Circuit, Inputs, Intermediary, Outputs) */
signal_calculator([], _, Outputs, Outputs):-!.
signal_calculator([H|T], Inputs, Intermediary, Outputs):-
    execute_gate(H, Inputs, Intermediary, NewIntermediary),
    signal_calculator(T, Inputs, NewIntermediary, Outputs).


/* execute_gate(Gate, Inputs, Intermediary, Result) */
execute_gate(gate(Name, Operation, Input, Output), Inputs, Intermediary, Result):-
    bit_ops_result(Inputs, Operation, Input, BitOpsResult),
    insert_output(Intermediary, Output, BitOpsResult, Result).


/* bit_ops_result(Inputs, Operation, Bits, Result) */
/* OR operation */
bit_ops_result(_, or, [], 0):-!.
bit_ops_result(Inputs, or, [H|_], 1):-
    is_true(Inputs, H),
    !.
bit_ops_result(Inputs, or, [_|T], Result):-
    bit_ops_result(Inputs, or, T, Result),
    !.
/* AND operation */
bit_ops_result(_, and, [], 1):-!.
bit_ops_result(Inputs, and, [H|T], Result):-
    is_true(Inputs, H),
    bit_ops_result(Inputs, and, T, Result),
    !.
bit_ops_result(_, and, _, 0):-!.
/* NOR operation */
bit_ops_result(Inputs, nor, Bits, Result):-
    bit_ops_result(Inputs, or, Bits, NotResult),
    negate(NotResult, Result),
    !.
/* NAND operation */
bit_ops_result(Inputs, nand, Bits, Result):-
    bit_ops_result(Inputs, and, Bits, NotResult),
    negate(NotResult, Result),
    !.
/* NOT operation*/
bit_ops_result(Inputs, not, Bit, 1):-
    not(is_true(Inputs, Bit)),
    !.
bit_ops_result(_, not, _, 0):-!.
/* XOR operation */
bit_ops_result(Inputs, xor, [T], 1):-
    is_true(Inputs, T),
    !.
bit_ops_result(_, xor, [T], 0):-!.
bit_ops_result(Inputs, xor, [H|T], Result):-
    not(is_true(Inputs, H)),
    bit_ops_result(Inputs, xor, T, Result),
    !.
bit_ops_result(Inputs, xor, [_|T], Result):-
    bit_ops_result(Inputs, xor, T, ResultNeg),
    negate(ResultNeg, Result).


/* negate */
negate(1, 0):-!.
negate(0, 1).


/* is_true(Inputs, Term) */
is_true([sig(Name, 1)|_], Name):-!.
is_true([_|T], Name):-
    is_true(T, Name).


/* insert_output(List, Output, BitOpsResult, Result) returns List with the
 * newly inserter or updated signal(Output, BitOpsResult) */
insert_output([], Output, BitOpsResult, [sig(Output, BitOpsResult)]):-!.
insert_output([sig(Output, _)|T], Output, BitOpsResult, [sig(Output, BitOpsResult)|T]):-!.
insert_output([H|T], Output, BitOpsResult, [H|Result]):-
    insert_output(T, Output, BitOpsResult, Result).


/* has_value(List, Connection, Value) verifies if there is any signal inside
 * Signals that has the given Connection and Value */
has_value([H|_], Connection, Value):-
    signal_value_equals(H, Connection, Value),
    !.
has_value([_|T], Connection, Value):-
    has_value(T, Connection, Value).


/* signal_value_equals(Signal, Connection, Value) verifies that Signal has
 * the Connection and the Value set*/
signal_value_equals(sig(Connection, Value), Connection, Value).


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
