clc, clear
legendInfo = {}; % Initialize cell array to hold legend info
frames = [];
filename = 'result/Double_attractor.gif';
%%
tspan = [0 250];

%%
y0 = [1; 0.5; 0]; % initial conditions
[t, y] = ode45(@myODE, tspan, y0);
%%
for j = 1:10:length(t)
    % Draw plot for y upto current timepoint
    plot3(y(1:j, 1), y(1:j, 2), y(1:j, 3));
    view(mod(j / 10, 360), 5);
    grid on
    drawnow
    % Capture the plot as an image
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);
    % Change view angle
    % Write to the GIF File
    if j == 1
        imwrite(imind, cm, filename, 'gif', 'Loopcount', inf);
    else
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append');
    end

end

%% Chua's Parameters
function dydt = myODE(t, y)

    G = 0.7;
    C1 = 1/9;
    C2 = 1;
    L = 1/7;
    R = 0.001;

    v1 = y(1);
    v2 = y(2);
    i3 = y(3);
    dydt = zeros(3, 1);
    dydt(1) = 1 / C1 * (G * (v2 - v1) - f(v1));
    dydt(2) = 1 / C2 * (G * (v1 - v2) + i3);
    dydt(3) = -1 / L * (v2 + R * i3);
end

function y = f(v1)
    Ga = -0.8;
    Gb = -0.5;
    E = 1;
    y = Gb * v1 + 0.5 * (Ga - Gb) * (abs(v1 + E) - abs(v1 - E));
end
