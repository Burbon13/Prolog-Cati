/* ====================== EXTENDEN MONKEY DEVOIR ====================== */
/* To run, use the following code:

canget_wrapper(RoomNr, Position).

RoomNr - can be 1, 2, 3 or 4
Position - can be middle, window or door

Examples:

canget_wrapper(4, window).
canget_wrapper(2, door).
canget_wrapper(3, middle).
*/


/* Wrapper predicate for canget so that the user only has to specify
 * the start room number and the position of the monkey.
 * At the end it will print the executed moves that led the monkey to
 * the bananas.
 * It is guaranteed that there will always be a solution (if valid params
 * are userd). */
canget_wrapper(RoomNr, Position):-
    canget(
        state(
            posM(RoomNr, Position),
            onfloor,
            boxes(
                posM(1, window),
                posM(2, window),
                posM(3, window),
                posM(4, window)
            ),
            hasnot
        ),
        R
    ),
    pretty_print(R).

/* Prints a list, each element on a new line. */
pretty_print([H|T]):-
    writeln(H),
    pretty_print(T).

/* canget(S) True if S is a state from which the monkey can get the banana */
canget(state(_, _, _, has),[]):-!.
canget(State1, [Move | Res]):-
    move(State1, Move, State2),
    canget(State2, Res),
    !.


/* The goal of the game: a situation in which the monkey has the banana.
 * Structure: state(Monkey position, onfloor/onboxes, Box positions, has/hasnot
 * banana) */
state(_, _, _, has).


/* ===================== MOVES ======================== */
/* move(Initial state, Type of move, After move state) */

/* === Grasp banana === */
/* All of the boxes are put into place and the monkey is on top of them.
 * We can get that banana! */
move(
    state(
        posM(4, middle),
        onbox,
        boxes(
            posM(4, middle),
            posM(4, middle),
            posM(4, middle),
            posM(4, middle)
        ),
        hasnot
        ),
    grasp,
    state(
        posM(4, middle),
        onbox,
        boxes(
            posM(4, middle),
            posM(4, middle),
            posM(4, middle),
            posM(4, middle)
        ),
        has
    )
):-!.

/* === Climb box === */
/* All of the boxes are put into place and the monkey is on next to them.
 * We can climb those boxes! */
move(
    state(
        posM(4, middle),
        onfloor,
        boxes(
            posM(4, middle),
            posM(4, middle),
            posM(4, middle),
            posM(4, middle)
        ),
        hasnot
        ),
    climb,
    state(
        posM(4, middle),
        onbox,
        boxes(
            posM(4, middle),
            posM(4, middle),
            posM(4, middle),
            posM(4, middle)
        ),
        hasnot
    )
):-!.

/* === Push box === */
/* Box nr. 1: will be the first box to be pushed */
move(
    state(
        MonkeyPos1,
        onfloor,
        boxes(
            MonkeyPos1,
            posM(2, window),
            posM(3, window),
            posM(4, window)
        ),
        hasnot
    ),
    pushBox(1, MonkeyPos1, MonkeyPos2),
    state(
        MonkeyPos2,
        onfloor,
        boxes(
            MonkeyPos2,
            posM(2, window),
            posM(3, window),
            posM(4, window)
        ),
        hasnot
    )
):-
    next_push(MonkeyPos1, MonkeyPos2).

/* Box nr. 2: will be able to push it only after box nr. 1 is placed in
 * room 4, middle */
move(
    state(
        MonkeyPos1,
        onfloor,
        boxes(
            posM(4, middle),
            MonkeyPos1,
            posM(3, window),
            posM(4, window)
        ),
        hasnot
    ),
    pushBox(2, MonkeyPos1, MonkeyPos2),
    state(
        MonkeyPos2,
        onfloor,
        boxes(
            posM(4, middle),
            MonkeyPos2,
            posM(3, window),
            posM(4, window)
        ),
        hasnot
    )
):-
    next_push(MonkeyPos1, MonkeyPos2).

/* Box nr. 3: will be able to push it only after box nr. 2 is placed in
 * room 4, middle */
move(
    state(
        MonkeyPos1,
        onfloor,
        boxes(
            posM(4, middle),
            posM(4, middle),
            MonkeyPos1,
            posM(4, window)
        ),
        hasnot
    ),
    pushBox(3, MonkeyPos1, MonkeyPos2),
    state(
        MonkeyPos2,
        onfloor,
        boxes(
            posM(4, middle),
            posM(4, middle),
            MonkeyPos2,
            posM(4, window)
        ),
        hasnot
    )
):-
    next_push(MonkeyPos1, MonkeyPos2).

/* Box nr. 4: will be able to push it only after box nr. 3 is placed in
 * room 4, middle */
move(
    state(
        MonkeyPos1,
        onfloor,
        boxes(
            posM(4, middle),
            posM(4, middle),
            posM(4, middle),
            MonkeyPos1
        ),
        hasnot
    ),
    pushBox(4, MonkeyPos1, MonkeyPos2),
    state(
        MonkeyPos2,
        onfloor,
        boxes(
            posM(4, middle),
            posM(4, middle),
            posM(4, middle),
            MonkeyPos2
        ),
        hasnot
    )
):-
    next_push(MonkeyPos1, MonkeyPos2).

/* === Monkey walk === */
move(
    state(
        MonkeyPos1,
        onfloor,
        BoxPos,
        hasnot
    ),
    walk(MonkeyPos1, MonkeyPos2),
    state(
        MonkeyPos2,
        onfloor,
        BoxPos,
        hasnot
    )
):-
    next_pos(MonkeyPos1, BoxPos, MonkeyPos2).

/* == Next walking position generator   */
/* middle -> door: (same room) */
next_pos(posM(Room, middle), _, posM(Room, door)).
/* middle -> window: only if box nr. 1 was not moved (room nr 1) */
next_pos(
    posM(1, middle),
    boxes(
        posM(1, window),
        posM(2, window),
        posM(3, window),
        posM(4, window)
    ),
    posM(1, window)
).
/* door -> window: only if box nr. 1 was not moved (room nr 1) */
next_pos(
    posM(1, door),
    boxes(
        posM(1, window),
        posM(2, window),
        posM(3, window),
        posM(4, window)
    ),
    posM(1, window)
).
/* middle -> window: only if box nr. 2 was not moved (room nr 2) and box nr. 1
 * is placed at middle, room 4*/
next_pos(
    posM(2, middle),
    boxes(
        posM(4, middle),
        posM(2, window),
        posM(3, window),
        posM(4, window)
    ),
    posM(2, window)
).
/* door -> window: only if box nr. 2 was not moved (room nr 2) and box nr. 1
 * is placed at middle, room 4*/
next_pos(
    posM(2, door),
    boxes(
        posM(4, middle),
        posM(2, window),
        posM(3, window),
        posM(4, window)
    ),
    posM(2, window)
).
/* middle -> window: only if box nr. 3 was not moved (room nr 3) and boxes
 * nr. 1 & 2 are placed at middle, room 4*/
next_pos(
    posM(3, middle),
    boxes(
        posM(4, middle),
        posM(4, middle),
        posM(3, window),
        posM(4, window)
    ),
    posM(3, window)
).
/* door -> window: only if box nr. 3 was not moved (room nr 3) and boxes
 * nr. 1 & 2 are placed at middle, room 4*/
next_pos(
    posM(3, door),
    boxes(
        posM(4, middle),
        posM(4, middle),
        posM(3, window),
        posM(4, window)
    ),
    posM(3, window)
).
/* middle -> window: only if box nr. 4 was not moved (room nr 4) and boxes
 * nr. 1 & 2 & 3 are placed at middle, room 4*/
next_pos(
    posM(4, middle),
    boxes(
        posM(4, middle),
        posM(4, middle),
        posM(4, middle),
        posM(4, window)
    ),
    posM(4, window)
).
/* door -> window: only if box nr. 4 was not moved (room nr 4) and boxes
 * nr. 1 & 2 & 3 are placed at middle, room 4*/
next_pos(
    posM(4, door),
    boxes(
        posM(4, middle),
        posM(4, middle),
        posM(4, middle),
        posM(4, window)
    ),
    posM(4, window)
).
/* Move from window to door (same room) */
next_pos(posM(Room, window), _, posM(Room, door)).
/* Move from room 4 to 1 if no box was moved */
next_pos(
    posM(4, door),
    boxes(
        posM(1, window),
        posM(2, window),
        posM(3, window),
        posM(4, window)
    ),
    posM(1, door)
).
/* Move from room 4 to 2 if box 1 was placed and the rest not */
next_pos(
    posM(4, door),
    boxes(
        posM(4, middle),
        posM(2, window),
        posM(3, window),
        posM(4, window)
    ),
    posM(2, door)
).
/* Move from room 4 to 3 if boxes 1 & 2 were placed and the rest not */
next_pos(
    posM(4, door),
    boxes(
        posM(4, middle),
        posM(4, middle),
        posM(3, window),
        posM(4, window)
    ),
    posM(3, door)
).
/* Move from room 2 to 4 is monkey starts here */
next_pos(
    posM(2, door),
    boxes(
        posM(1, window),
        posM(2, window),
        posM(3, window),
        posM(4, window)
    ),
    posM(4, door)
).
/* Move from room 3 to 4 is monkey starts here */
next_pos(
    posM(3, door),
    boxes(
        posM(1, window),
        posM(2, window),
        posM(3, window),
        posM(4, window)
    ),
    posM(4, door)
).

/* Next box pushing position generator */
next_push(posM(Room, door), posM(Room, middle)).
next_push(posM(Room, window), posM(Room, door)).
next_push(posM(Room, window), posM(Room, middle)).
next_push(posM(1, door), posM(4, door)).
next_push(posM(2, door), posM(4, door)).
next_push(posM(3, door), posM(4, door)).
