cluster = parcluster('local');
job = createCommunicatingJob(cluster, 'Type', 'SPMD');
createTask(job, @parheateqn, 1, {1e3, 500, 0.08, 3, 1.13e-4});
set(job, 'NumWorkersRange', [3 3]);
submit(job);
wait(job, 'finished');
results = fetchOutputs(job);
U = cell2mat(results');
imagesc(U)
delete(job);
clear job;