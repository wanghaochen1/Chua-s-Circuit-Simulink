% This progarme genertes Multiple attracters in Chua's circuit
% using triangular wave
% Author: 王昊宸
% 这个代码没有使用传统的电路建模方式，而是直接基于微分方程进行优化
clc, clear
tspan = [0 25];
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
    N = 0;
    M = 0;
    alpha = 4.2;
    beta = 6.7;
    gamma = 4.0;
    epson = 28.0;
    dydt = zeros(3, 1);
    X = y(1);
    Y = y(2);
    Z = y(3);
    dydt(1) = beta * Y - X - alpha * f(X, N, M);
    dydt(2) = beta * X - gamma * Z;
    dydt(3) = epson * Y - Z;
end

function sum = f(x, N, M)
    sum = x - h0(x);

    for n = 1:N
        sum = sum - h_plus(x - 2 * n);
    end

    for m = 1:M
        sum = sum - h_minus(x + 2 * m);
    end

end

function y = h0(x)
    persistent ylast;
    %初始化
    if isempty(ylast)
        ylast = 0;
    end

    %滞回比较
    if x <- 1 && ylast >= 1
        ylast = -1;
        y = -1;
    elseif x > 1 && ylast <= -1
        ylast = 1;
        y = 1;
    else
        y = ylast;
    end

end

function y = h_minus(x)
    persistent ylast;
    %初始化
    if isempty(ylast)
        ylast = 0;
    end

    %滞回比较
    if x <- 1 && ylast == 0
        ylast = -2;
        y = -2;
    elseif x > 1 && ylast == -2
        ylast = 0;
        y = 0;
    else
        y = ylast;
    end

end

function y = h_plus(x)
    persistent ylast;
    %初始化
    if isempty(ylast)
        ylast = 0;
    end

    %滞回比较
    if x <- 1 && ylast == 2
        ylast = 0;
        y = 0;
    elseif x > 1 && ylast == 0
        ylast = 2;
        y = 2;
    else
        y = ylast;
    end

end
