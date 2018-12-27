numPoints=[10^3,10^4,10^5,10^6,10^7];
time=zeros(1,numel(numPoints));
for index =1:numel(numPoints)
    tic;                                        %start timer
    distance(numPoints(index));                     %run calculation
    time(index)=toc;
end

plot(time,numPoints,'-o');                              %plot on scatter plot (plot() just gave straight line)
xlabel('time (s)');                             %add x and y lables
ylabel('Number of points');

function c=distance(points)
    a=rand(points,2);                           %use random numbers
    b=rand(points,2); 
    for pair=1:points%convert this one to parfor
        sum=(a(pair,1)-b(pair,1))^2+(a(pair,2)-b(pair,2))^2;
    end
    c=sqrt(sum);
end


%{
elem=[10^1,10^2,10^3,10^4,10^5,10^6,10^7,10^8];  %different vector lengths
time=zeros(1,numel(elem));                       %array initialized with 0s with same length as the lengths
for index=1:numel(elem)                          %go through each length
    tic;                                        %start timer
    c=distance(elem(index));                     %run calculation
    time(index)=toc;                            %stop and record time
end
plot(time,elem,'-o');                              %plot on scatter plot (plot() just gave straight line)
xlabel('time (s)');                             %add x and y lables
ylabel('elements');

function c=distance(length)                     %function to be called, requires array length
    a=rand(length,2);                           %use random numbers
    b=rand(length,2);                           %for both arrays
    sum=0;                                      
    for num=1:length                            %loop through the arrays
        sum=sum +(a(num)-b(num))^2;             %calculate interior sum
    end
    c=sqrt(sum);                                %sqrt for actual distance
end

%}

