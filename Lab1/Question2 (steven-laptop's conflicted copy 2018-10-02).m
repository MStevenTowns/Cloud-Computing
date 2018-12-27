delete(gcp()); %making sure i start by deleting the old pool
maxWorkers=10;

%shamlessly coppied from the internet
myCluster = parcluster('local');
myCluster.NumWorkers = maxWorkers;     % 'Modified' property now TRUE
saveProfile(myCluster);             % 'local' profile now updated,
                                    % 'Modified' property now FALSE

numPoints=[10^1,10^2,10^3,10^4,10^5,10^6,10^7];                                 
time=zeros(maxWorkers,numel(numPoints)); 

for workers=1:maxWorkers
    delete(gcp);
    parpool(workers);
    parfor index =1:numel(numPoints)
        tic;                                        %start timer
        distance(numPoints(index));                     %run calculation
        time(workers,index)=toc;
    end
end

plot(time(1,:),numPoints,'-o','DisplayName','1 worker'); hold on;
plot(time(2,:),numPoints,'-o','DisplayName','2 workers');
plot(time(3,:),numPoints,'-o','DisplayName','3 workers');
plot(time(4,:),numPoints,'-o','DisplayName','4 workers');
plot(time(5,:),numPoints,'-o','DisplayName','5 workers');
plot(time(6,:),numPoints,'-o','DisplayName','6 workers');
plot(time(7,:),numPoints,'-o','DisplayName','7 workers');
plot(time(8,:),numPoints,'-o','DisplayName','8 workers');
plot(time(9,:),numPoints,'-o','DisplayName','9 workers'); 
plot(time(10,:),numPoints,'-o','DisplayName','10 workers'); hold off;
xlabel('time (s)');                             %add x and y lables
ylabel('Number of points');

function distance(points)
    a=rand(points,2);                           %use random numbers
    b=rand(points,2);
    c=zeros(points,1);
    for pair=1:points
        c(pair)=sqrt((a(pair,1)-b(pair,1))^2+(a(pair,2)-b(pair,2))^2);
    end
end

