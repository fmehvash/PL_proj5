:- consult(parse).

test_parse1 :- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2']).

test_parse2 :- \+ parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2', ',']).

test_parse3 :- \+ parse(['3', '2', ',', ';', '0']).