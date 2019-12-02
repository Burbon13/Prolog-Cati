/* Exercise 2 - 15-puzzle */


/* state(X) is True if X is a term that represents a state of the problem
 * 15-puzzle */
state([List, Position]):-
    list_contains_right_values(List),
    empty_cell_correct_position(List, Position).


/* list_contains_right_values(List) is True if List contains all values from
 * 0 to 15, each value only once*/
list_contains_right_values(List):-
    verify_content(List, [], 0).


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
