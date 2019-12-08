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
            posB(4, middle, 1),
            posB(4, middle, 2),
            posB(4, middle, 3),
            posB(4, middle, 4)
        ),
        hasnot
        ),
    grasp,
    state(
        posM(4, middle),
        onbox,
        boxes(
            posB(4, middle, 1),
            posB(4, middle, 2),
            posB(4, middle, 3),
            posB(4, middle, 4)
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
            posB(4, middle, 1),
            posB(4, middle, 2),
            posB(4, middle, 3),
            posB(4, middle, 4)
        ),
        hasnot
        ),
    grasp,
    state(
        posM(4, middle),
        onbox,
        boxes(
            posB(4, middle, 1),
            posB(4, middle, 2),
            posB(4, middle, 3),
            posB(4, middle, 4)
        ),
        hasnot
    )
).
/* === Monkey walk === */
move(
    state(MonkeyPos1, onfloor, BoxPos, hasnot),
    walk(MonkeyPos1, MonkeyPos2),
    state(MonkeyPos2, onfloor, BoxPos, hasnot)
):-
    walker(MonkeyPos1, MonkeyPos2).

/* Next walking position generator */
walker(posM(Room, middle), posM(Room, door)).
walker(posM(Room, middle), posM(Room, window)).
walker(posM(Room, door), posM(Room, window)).
walker(posM(Room, door), posM(Room, middle)).
walker(posM(Room, window), posM(Room, door)).
walker(posM(Room, window), posM(Room, middle)).
walker(posM(4, door), posM(1, door)).
walker(posM(4, door), posM(2, door)).
walker(posM(4, door), posM(3, door)).
walker(posM(1, door), posM(4, door)).
walker(posM(2, door), posM(4, door)).
walker(posM(3, door), posM(4, door)).
