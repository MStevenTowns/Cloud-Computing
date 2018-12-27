function prob = runBirthday(numtrials, groupsize)
% RUNBIRTHDAY Runs a Monte Carlo simulation using the Birthday Paradox code
%    PROB = RUNBIRTHDAY(NUMTRIALS, GROUPSIZE) Calls the birthday code
%    NUMTRIALS times to see if any birthdays match in a group of size
%    GROUPSIZE.  The return value is the probability that a match will be
%    found.
%
%    Example:
%    p = runBirthday(1e5, 60)

% Preallocate some memory for the matches
matches = false(1, numtrials);

for trial = 1:numtrials
    % Run a simulation for a group
    matches(trial) = birthday(groupsize);
end

% Probability is the sum of matches divided by number of trials
prob = sum(matches)/numtrials;
