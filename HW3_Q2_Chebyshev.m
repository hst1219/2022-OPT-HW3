close all;
clear all;

a1 = [ 2;  1];
a2 = [ 2; -1];
a3 = [-1;  2];
a4 = [-1; -2];
b = [2 0 6 2];

% Create and solve the model (r, x_c)
cvx_begin

variable r
variable x_c(2,1)

maximize(r)

subject to

a1'*x_c+r*norm(a1)<=b(1)
a2'*x_c+r*norm(a2)<=b(2)
a3'*x_c+r*norm(a3)<=b(3)
a4'*x_c+r*norm(a4)<=b(4)




cvx_end
% Generate the figure
x = linspace(-6,6);
theta = 0:pi/100:2*pi;
plot( x, -x*a1(1)./a1(2) + b(1)./a1(2),'b-');
hold on
plot( x, -x*a2(1)./a2(2) + b(2)./a2(2),'g-');
plot( x, -x*a3(1)./a3(2) + b(3)./a3(2),'r-');
plot( x, -x*a4(1)./a4(2) + b(4)./a4(2),'m-');
plot( x_c(1) + r*cos(theta), x_c(2) + r*sin(theta), 'k');
plot(x_c(1),x_c(2),'k+')
xlabel('x_1')
ylabel('x_2')
legend('2x_1 + x_2 <= 2','2x_1 - x_2 <= 0','x_1 - 2x_2 >= -6','x_2 + 2x_2 >= -2')
% title('Largest Euclidean ball lying in a 2D polyhedron');
axis([-3 3 -2 4])
axis equal
grid on


x_c = x_c'  % center