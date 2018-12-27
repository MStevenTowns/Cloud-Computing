function match = birthday(groupSize)
% BIRTHDAY Simulates a single trial of the Birthday Paradox
%    MATCH = BIRTHDAY(GROUPSIZE) creates a randomly selected birthday for
%    every member of a group of size GROUPSIZE and tests whether any of 
%    the selected birthdays match.  MATCH is 1 if two or more members of 
%    the group share the same birthday and 0 otherwise.
%
%    Example:
%    match = birthday(30)
%

% Create a list with a random birthday for each member in the group
bdays = randi(365, groupSize, 1);

% Sort the birthdays
bdays = sort(bdays);

% Check if someone else in the group shares the same birthday
match =  any(diff(bdays) == 0);
