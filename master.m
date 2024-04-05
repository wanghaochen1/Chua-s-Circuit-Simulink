clc,clear

tspan = [0 5000];
y0 = [1; 1; 0]; % initial conditions
[t, y] = ode45(@myODE, tspan, y0);
figure
plot(y)
figure
plot3(y(:,1),y(:,2),y(:,3));

function dydt = myODE(t, y)

G = 0.7;
C1 = 1/10;
C2 = 1/10;
L=1/7;
R=0;

v1 = y(1);
v2 = y(2);
i3 = y(3);
dydt = zeros(3,1);
dydt(1) = 1/C1 * (G*(v2 - v1)-f(v1));
dydt(2) = 1/C2 * (G*(v1 - v2) + i3);
dydt(3) = -1/L *(v2+R*i3);
end

function y = f(v1)
K=0.1;
Gb=0.01;
E = 0.5;
y=Gb*v1 + 0.5*(K)*(abs(v1+E)-abs(v1-E));
end