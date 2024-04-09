% This progarme genertes Multiple attracters in Chua's circuit
% using triangular wave
% Author: 王昊宸
% 这个代码没有使用传统的电路建模方式，而是直接基于微分方程进行优化
clc, clear
tspan = [0 360];
filename = 'result/Multiple_attractor.gif';
%%
y0 = [0.5; 0.5; 0.5]; % initial conditions
[t, y] = ode45(@myODE, tspan, y0);
plot3(y(:, 1), y(:, 2), y(:, 3));
grid on
% for j = 1:10:length(t)
%     % Draw plot for y upto current timepoint
%     plot3(y(1:j, 1), y(1:j, 2), y(1:j, 3));
%     view(mod(j / 10, 360), 5);
%     grid on
%     drawnow
%     % Capture the plot as an image
%     frame = getframe(gcf);
%     im = frame2im(frame);
%     [imind, cm] = rgb2ind(im, 256);
%     % Change view angle
%     % Write to the GIF File
%     if j == 1
%         imwrite(imind, cm, filename, 'gif', 'Loopcount', inf);
%     else
%         imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append');
%     end
% 
% end
%%
function dydt = myODE(t, y)
    N = 5;
    alpha = 4.2;
    beta = 6.7;
    gamma = 4.0;
    epson = 11.6;
    dydt = zeros(3, 1);
    X = y(1);
    Y = y(2);
    Z = y(3);
    dydt(1) = beta * Y - X - alpha * f(X, N);
    dydt(2) = beta * X - gamma * Z;
    dydt(3) = epson * Y - Z;
end

function sum = f(x, N)
    sum = x;

    for n = 1:2 * N - 1
        sum = sum + (-1) ^ (n) * (abs(x + (2 * n - 1)) - abs(x - (2 * n - 1)));
    end

end
