%%  File     	: proj2.pl
%%  Student ID  : 893717
%%  Author   	: Akshat Gupta
%%  Purpose  	: Prolog project 2.

:- ensure_loaded(library(clpfd)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%								Introduction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% The following project required to create a program to solve a number puzzle 
%% the number puzzle can be described as a grid of squares, each to be filled 
%% with a single digit 1-9 satisfying the following constraints as provided in
%% the project specification:
%%   -Each row & each column have no repeated values.
%%   -all squares on the diagonal line form the upper left to lower right 
%%    contain the same values
%%   -The heading of each row and column hold either the sum or the product of 
%%    all the digits in that row or column
%%
%% An Example puzzle              The Puzzle solved
%%
%%     14 | 10 | 35                  | 14 |10 | 35
%% 14 |   |    |                  14 | 7  | 2 | 1
%% 15 |   |    |                  15 | 3  | 7 | 5
%% 28 |   |    |                  28 | 4  | 1 | 7
%%
%% The row and column headings are given and do not have any constraints.
%%
%% The program is supposed to solve 2x2,3x3,4x4 puzzles.
%%
%% The approach followed here was to create entry points for the three puzzles
%% Then for every puzzle all the constraints described above are verified.
%% If any of the condition fails to match further checking will be seized.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

puzzle_solution([[_,C1,C2], [R1,R11,R12], [R2,R21,R22]]) :-
	R11 = R22,  %% checking the diagonal values
	validate_element([R1,R11,R12]),
	validate_element([R2,R21,R22]),
	validate_element([C1,R11,R21]),
	validate_element([C2,R12,R22]).

puzzle_solution([[_,C1,C2,C3], [R1,R11,R12,R13], 
	[R2,R21,R22,R23], [R3,R31,R32,R33]]) :-
	R11 = R22, R22 = R33,  %% checking the diagonal values
	validate_element([R1,R11,R12,R13]),
	validate_element([R2,R21,R22,R23]),
	validate_element([R3,R31,R32,R33]),
	validate_element([C1,R11,R21,R31]),
	validate_element([C2,R12,R22,R32]),
	validate_element([C3,R13,R23,R33]).

puzzle_solution([[_,C1,C2,C3,C4], [R1,R11,R12,R13,R14], [R2,R21,R22,R23,R24],
 [R3,R31,R32,R33,R34], [R4,R41,R42,R43,R44]]) :-
	R11 = R22, R22 = R33, R33 = R44,  %% checking the diagonal values
	validate_element([R1,R11,R12,R13,R14]),
	validate_element([R2,R21,R22,R23,R24]),
	validate_element([R3,R31,R32,R33,R34]),
	validate_element([R4,R41,R42,R43,R44]),
	validate_element([C1,R11,R21,R31,R41]),
	validate_element([C2,R12,R22,R32,R42]),
	validate_element([C3,R13,R23,R33,R43]),
	validate_element([C4,R14,R24,R34,R44]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% The validate_element/1 function will validate every element based on the 
%% constraints described above. It will test if the element lies in the range, 
%% it will also check if the element does not repeat within the same row or
%% column. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validate_element([Head|Tail]) :-
	validate_range(Tail),
	all_distinct(Tail),
	check_sumproduct(Head, Tail).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% The check_sumproduct/2 function will check if the sum or product of the row
%% and the column matches the header. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

check_sumproduct(Head, Tail) :-
	(validate_sum(Tail, Head); validate_product(Tail, Head)).

validate_sum([],0).
validate_sum([Head|Tail],Sum) :-
    validate_sum(Tail,RemainingElem),
    Sum is Head+RemainingElem.

validate_product([],1).
validate_product([Head|Tail],Product) :-
    validate_product(Tail,RemainingElem),
    Product is Head*RemainingElem.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% The validate_range/1 function will ensure that all the elements are in the 
%% range (1,9).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validate_range([]).
validate_range([Head|Tail]) :-
	member(Head,[1,2,3,4,5,6,7,8,9]),
	validate_range(Tail).

%%%%%%%%%%%%%%%%%%%%%%%%%% End of File %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%