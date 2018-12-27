numPoints=[10^3,10^4,10^5,10^6,10^7];
time=zeros(1,numel(numPoints));
for index =1:numel(numPoints)
    tic;                                        %start timer
    distance(numPoints(index));                     %run calculation
    time(index)=toc;
end

plot(time,numPoints,'-o');                              
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

