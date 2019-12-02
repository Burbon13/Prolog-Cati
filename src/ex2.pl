/* Exercise 2 - 15-puzzle */

/* neighbours(S0, LS1) is true if LS1 is a list of upcoming states from
 * the state S0 */
 neighbours(S0, [NextLeft, NextTop, NextRight, NextBottom]):-
    left_neighbour(S0, NextLeft),
    top_neighbour(S0, NextTop),
    right_neighbour(S0, NextRight),
    bottom_neighbour(S0, NextBottom).


/* top_neighbour(S0, S1) verifies that S1 is an upcoming state of S0 by one
 * move to top; S0 and S1 should be valid states */
top_neighbour([List, Position], [ListNeighbour, PositionNeighbour]):-
    Position > 4,
    NextPosition is Position - 4,
    NextPosition =:= PositionNeighbour,
    swap_elems(List, Position, NextPosition, ListNeighbour),
    !.
top_neighbour([_, Position], -1):-
    Position < 5.


/* left_neighbour(S0, S1) verifies that S1 is an upcoming state of S0 by one
 * move to left; S0 and S1 should be valid states */
left_neighbour([List, Position], [ListNeighbour, PositionNeighbour]):-
    Position =\= 1,
    Position =\= 5,
    Position =\= 9,
    Position =\= 13,
    NextPosition is Position - 1,
    NextPosition =:= PositionNeighbour,
    swap_elems(List, Position, NextPosition, ListNeighbour),
    !.
left_neighbour([_, 1], -1):-!.
left_neighbour([_, 5], -1):-!.
left_neighbour([_, 9], -1):-!.
left_neighbour([_, 13], -1):-!.


/* swap_elems(List1, Pos1, Pos2, List2) swapps elements on positions Pos1 and Pos2
 * Also checks if List2 is equal to List1 after the swap between Pos1 and Pos2*/
swap_elems(List, Pos1, Pos2, Result):-
    get_elem_at(List, Pos1, Elem1),
    get_elem_at(List, Pos2, Elem2),
    set_elem_at(List, Pos1, Elem2, AuxResult),
    set_elem_at(AuxResult, Pos2, Elem1, Result).


/* get_elem_at(List, Pos, Elem) gets the element at position Pos from List */
get_elem_at([H|_], 1, H):-!.
get_elem_at([_|T], Pos, Elem):-
    Pos > 1,
    NextPos is Pos - 1,
    get_elem_at(T, NextPos, Elem).


/* set_elem_at(List, Pos, Elem, Result) sets the element at position Pos to
 * value Elem */
set_elem_at([_|T], 1, Elem, [Elem|T]):-!.
set_elem_at([H|T], Pos, Elem, Result):-
    Pos > 1,
    NextPos is Pos - 1,
    set_elem_at(T, NextPos, Elem, ResultAux),
    Result = [H|ResultAux].


/* state(X) is True if X is a term that represents a state of the problem
 * 15-puzzle */
state([List, Position]):-
    list_contains_right_values(List),
    empty_cell_correct_position(List, Position).


/* list_contains_right_values(List) is True if List contains all values from
 * 0 to 15, each value only once*/
list_contains_right_values(List):-
    verify_content(List, [], 0).


/* empty_cell_correct_position(List, Pos) verifies that the empty cell (0) is
 * at position Pos inside the list */
 empty_cell_correct_position([0|_], 1):-!.
 empty_cell_correct_position([H|T], Pos):-
    H =\= 0,
    Pos > 1,
    NewPos is Pos - 1,
    empty_cell_correct_position(T, NewPos).


/* verify_content(List, Bucket, Size) verifies at each step that the Head of
 * List is not inside Bucket and that its value is between 0 and 15. Then it
 * adds the Head to the Bucket and proceeds to do the same verification for
 * the Tail of the list with the new Bucket list. The last condition is that
 * the final size of the Bucket to be 16.*/
verify_content([], _, 16):-!.
verify_content([H|T], Bucket, Size):-
    Size < 16,
    valid_value(H),
    not(list_contains(Bucket, H)),
    NewSize is Size + 1,
    verify_content(T, [H|Bucket], NewSize).


/* valid_value(X) verifies that X is between 0 and 15 (inclusive) */
valid_value(X):-
    X >= 0,
    X =< 15.


/* list_contains_val(List, Val) verifies that Val exists inside List */
list_contains([Val|_], Val):-!.
list_contains([_|T], Val):-
    list_contains(T, Val).
