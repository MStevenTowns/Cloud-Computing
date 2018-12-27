n = 1e7;
r1 = rand(n,1,'double');
r2 = rand(n,1,'double');
tic; s = (r1+r2); toc;
% 1. Create CUDAKernel object.
k = parallel.gpu.CUDAKernel('gpufcn.ptx',...
    'gpufcn.cu','add2');
% 2. Set object properties.
k.ThreadBlockSize = 128;
% 3. Call feval with defined inputs.
tic; 
x1 = gpuArray(r1);
x2 = gpuArray(r2);
y = feval(k,x1,x2); 
yg = gather(y);
toc;
isequal(s,yg)