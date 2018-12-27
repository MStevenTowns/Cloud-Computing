function U = parheateqn(k, n, Ts, L, c)
ms = L / n; 
if (Ts>(ms^2/2/c)), error('Selected time step is too large.'); end
Uinit = initialTempDistrib(n);
parts = codistributor1d.defaultPartition(n+2);
numLocalCols = parts(labindex);
leftColInd = sum(parts(1:labindex - 1)) + 1;
rightColInd = leftColInd + numLocalCols - 1;
U = Uinit(:, leftColInd:rightColInd);
if (labindex > 1),       U = [zeros(n+2, 1) U]; end
if (labindex < numlabs), U = [U zeros(n+2, 1)]; end
if (labindex == 1) || (labindex == numlabs)
    numLocalCols = numLocalCols - 1;
end
rightNeighbor = mod(labindex, numlabs) + 1;
leftNeighbor  = mod(labindex - 2, numlabs) + 1;
north    = 1:n;
south    = 3:n + 2;
currRow  = 2:n + 1;
currCol  = 2:numLocalCols + 1;
east     = 3:numLocalCols + 2;
west     = 1:numLocalCols;
for iter = 1:k
    rightBoundary = labSendReceive(leftNeighbor,rightNeighbor,U(:,2));
    leftBoundary = labSendReceive(rightNeighbor,leftNeighbor,U(:,end-1));
    if (labindex > 1),       U(:, 1) = leftBoundary;    end
    if (labindex < numlabs), U(:, end) = rightBoundary; end
    U(currRow,currCol) = U(currRow,currCol)+c*Ts/(ms^2)*(U(north,currCol) ...
        +U(south,currCol)-4*U(currRow,currCol)+U(currRow,east)+U(currRow,west));
end
U = U(2:end-1, 2:end-1);  

function U = initialTempDistrib(n)
U = 23*ones(n + 2);
U(1, :) = (1:(n + 2))*700/(n + 2);
U(end, :) = ((1:(n + 2)) + (n + 2))*700/2/(n + 2);
U(:, 1) = (1:(n + 2))*700/(n + 2);
U(:, end) = ((1:(n + 2)) + (n + 2))*700/2/(n + 2);