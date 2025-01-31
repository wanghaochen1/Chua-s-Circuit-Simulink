% Author: 王昊宸
clc, clear
legendInfo = {}; % Initialize cell array to hold legend info
frames = [];
colors = ['r', 'g', 'b', 'c', 'm', 'y', 'k'];
color_idx = 1;
%%
tspan = [0 250];
idx = 1; % Initialize index for legendInfo
MOVIE = 1; % Generate movie if MOVIE = 1
filename = 'result/Chua_Differnt_start.gif';
az = 10; % Initialize azimuth
el = 10; % Initialize elevation
%%
figure
grid on
hold on

for a = 1:0.1:1.1

    for b = 0.5:0.1:0.6

        for c = 0.2:0.1:0.3
            y0 = [a; b; c];
            [t, y] = ode45(@myODE, tspan, y0);
            plot3(y(:, 1), y(:, 2), y(:, 3));
            plot3(a, b, c, [colors(color_idx) '.'], "MarkerSize", 20);
            legendInfo{idx} = ['Initial conditions: ', num2str(a), ', ', num2str(b), ', ', num2str(c)];
            idx = idx + 1;
            legendInfo{idx} = ['Start point', num2str(a), ', ', num2str(b), ', ', num2str(c)];
            idx = idx + 1;
            view(az, el) % Change view
            hold on
            color_idx = color_idx + 1; % 更新颜色索引

            if color_idx > length(colors) % 如果颜色索引超过颜色数组的长度，就重置为1
                color_idx = 1;
            end

            if MOVIE
                frame = getframe; % Capture the plot as a frame
                frames = [frames frame];
                drawnow
                im = frame2im(frame);
                [imind, cm] = rgb2ind(im, 256);

                if a == 1 && b == 0.5 && c == 0.2
                    imwrite(imind, cm, filename, 'gif', 'Loopcount', inf); % Write to the GIF file
                else
                    imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append'); % Append to the GIF file
                end

            else
                hold on
            end

            % az = az + 1; % Increment azimuth
            % el = el + 1; % Increment elevation
        end

    end

end

legend(legendInfo)

if MOVIE
    movie(frames)
end

%% Chua's Parameters
function dydt = myODE(t, y)

    G = 0.7;
    C1 = 1/9;
    C2 = 1;
    L = 1/7;
    R = 0.005;

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
