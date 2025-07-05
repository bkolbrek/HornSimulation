ka = logspace(-1,2,500);
Z = circularPistonIB(ka);

figure(1);
loglog(ka, real(Z), ka, imag(Z));