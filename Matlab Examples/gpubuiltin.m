n = 1e7;
r = rand(n,1,'double');
tic; rf = fft(r); toc;
tic; g = gpuArray(r);
gf = fft(g); 
gg = gather(gf); toc;