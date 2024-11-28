%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here:
%%%%%%%%%%%%%%%%%%%%%%
initial_state(X) :- 
  X = state(Pos,noKey, noColor, noColor),
  initial(Pos).
take_action(state(A,Key, KeyColor1, KeyColor2), move(A,B), state(B,Key, KeyColor1, KeyColor2)) :-
  door(A,B).
take_action(state(A,Key, KeyColor1, KeyColor2), move(A,B), state(B,Key, KeyColor1, KeyColor2)) :-
  door(B,A).
% scenario1 blue
take_action(state(A,noKey, KeyColor1, noColor), move(A,B), state(B,hasKey, KeyColor1, blue)) :-
  door(A,B), key(B, blue).
take_action(state(A,noKey, KeyColor1, noColor), move(A,B), state(B,hasKey, KeyColor1, blue)) :-
  door(B,A), key(B, blue).
take_action(state(A,hasKey, KeyColor1, noColor), move(A,B), state(B,hasKey, KeyColor1, blue)) :-
  door(A,B), key(B, blue).
take_action(state(A,hasKey, KeyColor1, noColor), move(A,B), state(B,hasKey, KeyColor1, blue)) :-
  door(B,A), key(B, blue).
take_action(state(A,hasKey, KeyColor1, blue), move(A,B), state(B,hasKey, KeyColor1, blue)) :-
  locked_door(A,B, blue).
take_action(X, move(A,B), state(B,hasKey, KeyColor1, blue)) :-
  X = state(A,hasKey, KeyColor1, blue),
  locked_door(B,A, blue).
% scenario1: red  
take_action(state(A,noKey, noColor, KeyColor2), move(A,B), state(B,hasKey, red, KeyColor2)) :-
  door(A,B), key(B, red).
take_action(state(A,noKey, noColor, KeyColor2), move(A,B), state(B,hasKey, red, KeyColor2)) :-
  door(B,A), key(B, red).
take_action(state(A,hasKey, noColor, KeyColor2), move(A,B), state(B,hasKey, red, KeyColor2)) :-
  door(A,B), key(B, red).
take_action(state(A,hasKey, noColor, KeyColor2), move(A,B), state(B,hasKey, red, KeyColor2)) :-
  door(B,A), key(B, red).
take_action(state(A,hasKey, red, KeyColor2), move(A,B), state(B,hasKey, red, KeyColor2)) :-
  locked_door(A,B, red).
take_action(X, move(A,B), state(B,hasKey, red, KeyColor2)) :-
  X = state(A,hasKey, red, KeyColor2),
  locked_door(B,A, red).
% scenario2
take_action(state(A,noKey, noColor, KeyColor2), move(A,B), state(B,hasKey, black, KeyColor2)) :-
  door(A,B), key(B, black).
take_action(state(A,noKey, noColor, KeyColor2), move(A,B), state(B,hasKey, black, KeyColor2)) :-
  door(B,A), key(B, black).
take_action(state(A,hasKey, noColor, KeyColor2), move(A,B), state(B,hasKey, black, KeyColor2)) :-
  door(A,B), key(B, black).
take_action(state(A,hasKey, noColor, KeyColor2), move(A,B), state(B,hasKey, black, KeyColor2)) :-
  door(B,A), key(B, black).
take_action(state(A,hasKey, black, KeyColor2), move(A,B), state(B,hasKey, black, KeyColor2)) :-
  locked_door(A,B, black).
take_action(X, move(A,B), state(B,hasKey, black, KeyColor2)) :-
  X = state(A,hasKey, black, KeyColor2),
  locked_door(B,A, black).
final_state(state(Pos, _, _, _)) :- treasure(Pos).
take_steps(S0, [Action], S1) :- take_action(S0, Action, S1).
take_steps(S0, [Action | Rest], S1) :- 
  take_action(S0, Action, SNew),
  take_steps(SNew, Rest, S1).
search(Actions) :-
  initial_state(S0),
  length(Actions, _),
  take_steps(S0, Actions, SFinal),
  final_state(SFinal), !.