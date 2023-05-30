function m0 = mymag0(mx, my, mz)

m0 = zeros(3, 1);
m0(1) = 0;
m0(2) = sqrt(mx^2 + my^2);
m0(3) = mz;

end
