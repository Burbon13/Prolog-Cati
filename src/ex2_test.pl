/* ============== Tests ex2 ============== */
/* To run the tests copy all of the code below this line and run it. */
/* If the result is True, yay, all tests passed. */

/* state */
state([[1,3,6,9,10,2,13,15,14,7,0,5,8,4,11,12], 11]),
state([[1,3,6,0,10,2,13,15,14,7,9,5,8,4,11,12], 4]),
state([[1,3,6,9,10,2,13,15,14,7,12,5,8,4,11,0], 16]),
state([[0,3,6,9,10,2,13,15,14,7,1,5,8,4,11,12], 1]),
not(state([[1,3,6,9,10,2,13,15,14,7,0,5,8,4,11,12], 10])),
not(state([[1,3,6,9,10,2,13,15,14,7,0,5,8,4,11,12,13], 11])),
not(state([[1,3,6,9,10,2,13,15,14,7,0,5,8,4,12], 11])),
not(state([[1,3,6,9,10,2,13,15,14,7,0,5,8,4,11,11], 11])),

/* list_contains */
not(list_contains([1,2,3,4],0)),
list_contains([1,2,3,4],1),
list_contains([1,2,3,4],4),
not(list_contains([1,2,3,4],44)),

/* empty_cell_correct_position */
empty_cell_correct_position([1, 3, 6, 9, 10, 2, 13, 15, 14, 7, 0, 5, 8, 4, 11, 12], 11),
not(empty_cell_correct_position([1, 3, 6, 9, 10, 2, 13, 15, 14, 7, 0, 5, 8, 4, 11, 12], 12)),
not(empty_cell_correct_position([1, 3, 6, 9, 10, 2, 13, 15, 14, 7, 0, 5, 8, 4, 11, 12], 10)),
empty_cell_correct_position([0,2,3],1),
empty_cell_correct_position([1,0,3],2),
empty_cell_correct_position([1,2,0],3),
not(empty_cell_correct_position([1,0,3],-2)),
not(empty_cell_correct_position([1,0,3],20)),
not(empty_cell_correct_position([1,1,3],2)),

/* valid_value */
valid_value(0),
valid_value(6),
not(valid_value(-4)),
valid_value(15),
not(valid_value(20)),
not(valid_value(16)),

/* list_contains_right_values */
list_contains_right_values([1, 3, 6, 9, 10, 2, 13, 15, 14, 7, 0, 5, 8, 4, 11, 12]),
list_contains_right_values([11, 10, 3, 5, 9, 2, 12, 1, 14, 13, 4, 8, 6, 7, 0, 15]),
list_contains_right_values([9, 0, 14, 3, 6, 15, 12, 5, 7, 1, 11, 8, 10, 13, 4, 2]),
list_contains_right_values([3, 1, 11, 15, 13, 9, 12, 4, 6, 8, 7, 5, 2, 14, 0, 10]),
list_contains_right_values([5, 10, 8, 12, 13, 9, 0, 15, 11, 2, 7, 4, 6, 1, 14, 3]),
list_contains_right_values([2, 14, 3, 7, 12, 10, 6, 15, 13, 9, 1, 4, 8, 0, 11, 5]),
list_contains_right_values([10, 13, 11, 0, 15, 1, 4, 6, 12, 14, 5, 9, 3, 7, 8, 2]),
not(list_contains_right_values([1, 3, 6, 9, 10, 22, 13, 15, 14, 7, 0, 5, 8, 4, 11, 12])),
not(list_contains_right_values([11, 10, 3, 5, 8, 2, 12, 1, 14, 13, 4, 8, 6, 7, 0, 15])),
not(list_contains_right_values([9, 0, 14, 3, 6, 15, 12, 5, 7, 1, 11, 8, 10, 13, 4, 20])),
not(list_contains_right_values([3, 1, 11, 15, 13, 9, 12, 4, 6, 8, 7, 5, 2, 14, 0, 0])),
not(list_contains_right_values([5, 10, 8, 12, 13, 9, 0, 15, 11, 2, 7, 4, 6, 1, 14, 3, 16])),
not(list_contains_right_values([7, 12, 10, 6, 15, 13, 9, 1, 4, 8, 0, 11, 5])),
not(list_contains_right_values([10, 13, 11, 15, 1, 4, 6, 12, 14, 5, 9, 3, 7, 8, 2])).
