/* Initial state: state(posM(nr, pos), onfloor, boxes(-1,-1,-1,-1), hasnot) */

/* canget(S) True if S is a state from which the monkey can get the banana */
canget(state(_, _, _, has),[]):-!.
canget(State1, [Move | Res]):-
    move(State1, Move, State2),
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
            -1,
            -1,
            -1
        ),
        hasnot
    ),
    pushBox(1, MonkeyPos1, MonkeyPos2),
    state(
        MonkeyPos2,
        onfloor,
        boxes(
            MonkeyPos2,
            -1,
            -1,
            -1
        ),
        hasnot
    )
):-
    nex_pos(MonkeyPos1, MonkeyPos2).
/* Box nr. 2 */
move(
    state(
        MonkeyPos1,
        onfloor,
        boxes(
            posM(4, middle),
            MonkeyPos1,
            -1,
            -1
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
            -1,
            -1
        ),
        hasnot
    )
):-
    nex_pos(MonkeyPos1, MonkeyPos2).

/* Box nr. 3 */
move(
    state(
        MonkeyPos1,
        onfloor,
        boxes(
            posM(4, middle),
            posM(4, middle),
            MonkeyPos1,
            -1
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
            -1
        ),
        hasnot
    )
):-
    nex_pos(MonkeyPos1, MonkeyPos2).

/* Box nr. 4 */
move(
    state(
        MonkeyPos1,
        onfloor,
        boxes(
            posM(4, middle),
            posM(4, middle),
            posM(4, middle),
            MonkeyPos1,
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
            MonkeyPos2,
        ),
        hasnot
    )
):-
    nex_pos(MonkeyPos1, MonkeyPos2).

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
    nex_pos(MonkeyPos1, MonkeyPos2).

/* Next walking position generator */
nex_pos(posM(Room, middle), posM(Room, door)).
nex_pos(posM(Room, middle), posM(Room, window)).
nex_pos(posM(Room, door), posM(Room, window)).
nex_pos(posM(Room, door), posM(Room, middle)).
nex_pos(posM(Room, window), posM(Room, door)).
nex_pos(posM(Room, window), posM(Room, middle)).
nex_pos(posM(4, door), posM(1, door)).
nex_pos(posM(4, door), posM(2, door)).
nex_pos(posM(4, door), posM(3, door)).
nex_pos(posM(1, door), posM(4, door)).
nex_pos(posM(2, door), posM(4, door)).
nex_pos(posM(3, door), posM(4, door)).
