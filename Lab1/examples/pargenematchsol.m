function results = pargenematchsol()

% Define sequence to find and number or tasks to create
searchSeq = repmat('gattaca', 1, 5);
numTasks = 4;
numBases = 7048095;

% Create the job
cluster = parcluster('local');
job = createJob(cluster);


% Split up the sequence of bases for multiple tasks
[startValues, endValues] = splitDataset(numBases, numTasks);


% Add border handling
offsetLeft = floor(length(searchSeq)/2);
if mod(length(searchSeq),2) == 0
    offsetRight = offsetLeft - 1;
else
    offsetRight = offsetLeft;
end
    
startValues(2:end) = startValues(2:end) - offsetLeft;
endValues(1:end-1) = endValues(1:end-1) + offsetRight;

% Create the tasks
for tasknum = 1:numTasks
    createTask(job, @genematch, 2, {searchSeq, 'gene.txt', startValues(tasknum), endValues(tasknum)});
end


% Submit and Wait for Results
submit(job);
wait(job, 'finished');


% Report the resultsspl
results = fetchOutputs(job);

% Return absolute position
results = cell2mat(results);
[~,idx] = max(results(:,1));
bpm = results(idx,1);
msi = results(idx,2)+startValues(idx)-1;



function [startValues, endValues] = splitDataset(numTotalElements, numTasks)

% Divide up the total elements among the tasks
numPerTask = repmat(floor(numTotalElements/numTasks), 1, numTasks);
leftover = rem(numTotalElements, numTasks);
numPerTask(1:leftover) = numPerTask(1:leftover) + 1;

% Determine the start end end values for the vector
endValues = cumsum(numPerTask);
startValues = [1 endValues(1:end-1) + 1];
