/* canget(S) True if S is a state from which the monkey can get the banana */
canget(state(_, _, _, has)):-!.
canget(State1):-
    move(State1, _, State2),
    canget(State2),
    !.


/* The goal of the game: a situation in which the monkey has the banana.
 * Structure: state(horizontal pos, vertical pos, box position, has/has not
 * banana) */
state(_, _, _, has).


/* move(Initial state, Type of move, After move state) */

/* Grasp banana */
move(state(middle, onbox, middle, hasnot),
     grasp,
     state(middle, onbox, middle, has)):-!.
/* Climb box */
move(state(MonkeyPos, onfloor, MonkeyPos, H),
    climb,
    state(MonkeyPos, onbox, MonkeyPos, H)).
/* Push box */
move(state(MonkeyPos1, onfloor, MonkeyPos1, H),
    push(MonkeyPos1, MonkeyPos2),
    state(MonkeyPos2, onfloor, MonkeyPos2, H)).
/* Monkey walk */
move(state(MonkeyPos1, onfloor, BoxPos, H),
     walk(MonkeyPos1, MonkeyPos2),
     state(MonkeyPos2, onfloor, BoxPos, H)).
