delete(gcp()); %making sure i start by deleting the old pool
maxWorkers=4;

myCluster = parcluster('local');
myCluster.NumWorkers = maxWorkers;     % 'Modified' property now TRUE
saveProfile(myCluster);             % 'local' profile now updated,
                                    % 'Modified' property now FALSE

numPoints=[10^1,10^2,10^3,10^4,10^5,10^6,10^7];                                 
time=zeros(numel(numPoints));

for index =1:numel(numPoints)
    tic;                                        %start timer
    distance(numPoints(index));                     %run calculation
    time(index)=toc;
end

function distance(points)
    a=rand(points,2);                           %use random numbers
    b=rand(points,2); 
    c=zeros(points,1);
    sum=0;
    
    switch labindex
        case 1
            for pair =1:points
                dif=a(pair)-b(pair);
                labSend(dif,2);
            end
        case 2
            sqr=labRecieve(1)^2;
            labSend(sqr,3);
        case 3
            sum=sum+labRecieve(2);
            labSend(sum,4);
        case 4
            root=sqrt(labRecieve(3));
            labSend(root,1);
    end
end