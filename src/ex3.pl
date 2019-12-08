/* Call with:
canget(state(posM(3, middle), onfloor, boxes(
    posM(1, window),
    posM(2, window),
    posM(3, window),
    posM(4, window)
), hasnot), R)
*/

/* canget(S) True if S is a state from which the monkey can get the banana */
canget(state(_, _, _, has),[]):-!.
canget(State1, [Move | Res]):-
    move(State1, Move, State2),
    print(Move),
    canget(State2, Res),
    !.


/* The goal of the game: a situation in which the monkey has the banana.
 * Structure: state(horizontal pos, vertical pos, box position, has/has not
 * banana) */
state(_, _, _, has).


/* ===================== MOVES ======================== */
/* move(Initial state, Type of move, After move state) */

/* === Grasp banana === */
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
).

/* === Climb box === */
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
).

/* === Push box === */
/* Box nr. 1 */
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
/* Box nr. 2 */
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

/* Box nr. 3 */
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

/* Box nr. 4 */
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

/* Next walking position generator */
next_pos(posM(Room, middle), _, posM(Room, door)).
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
/*next_pos(posM(Room, door), posM(Room, middle)).*/
next_pos(posM(Room, window), _, posM(Room, door)).
/*next_pos(posM(Room, window), posM(Room, middle)).*/
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
/* nex_pos(posM(1, door), posM(4, door)). */
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

/* Next pushing position generator */
next_push(posM(Room, middle), posM(Room, door)).
next_push(posM(Room, middle), posM(Room, window)).
next_push(posM(Room, door), posM(Room, window)).
next_push(posM(Room, door), posM(Room, middle)).
next_push(posM(Room, window), posM(Room, door)).
next_push(posM(Room, window), posM(Room, middle)).
next_push(posM(4, door), posM(1, door)).
next_push(posM(4, door), posM(2, door)).
next_push(posM(4, door), posM(3, door)).
next_push(posM(1, door), posM(4, door)).
next_push(posM(2, door), posM(4, door)).
next_push(posM(3, door), posM(4, door)).
