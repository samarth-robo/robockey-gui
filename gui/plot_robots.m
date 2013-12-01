clear
close all
clc

% dimensions
xmax = 230;
ymax = 120;

teams = [1, 2];

delete(instrfind);

try
    ls /dev/ttyS101
catch
    !sudo ln -s /dev/ttyACM0 /dev/ttyS101
end

if(~exist('s', 'var'))
    s = serial('/dev/ttyS101');
end

try
    fopen(s);
catch
    fclose(s);
    clear s;
    disp('Error opening port');
    return;
end

try
    fwrite(s, 's', 'char');
catch
    fclose(s);
    disp('Error initializing communication with M2');
    return;
end

load addresses
try
    for i = 1 : numel(teams)
        for j = 1 : 3
            fwrite(s, addresses(i, j), 'char');
            pause(0.1);
        end
    end
catch
    fclose(s);
    disp('Error communicating hex addresses of teams to M2');
    return;
end

for i = 1 : 200
    pos = zeros(6, 2);

    % flush input buffer
    if(s.BytesAvailable > 0)
        fread(s, s.BytesAvailable);
    end

    try
        for robot_idx = 1 : 6
            fwrite(s, robot_idx, 'char');
            pos(robot_idx, :) = fread(s, 2, 'uchar');
        end
    catch
        fclose(s);
        disp('Error getting robot positions from M2');
        return;
    end

    if(~exist('h1', 'var'))
        figure;
        axis([-20 250 -20 140]);
        hold on;
        % axis off;
        line([0; xmax; xmax; 0; 0], [0; 0; ymax; ymax; 0], 'LineStyle', '-.', 'LineWidth', 3,...
            'Color', 'k');
        line([xmax/2; xmax/2], [0; ymax], 'LineStyle', '-', 'LineWidth', 2, 'Color', 'b');
        h1 = scatter(pos(1:3, 1), pos(1:3, 2), 'r');
        h2 = scatter(pos(4:6, 1), pos(4:6, 2), 'g');
    else
        set(h1, 'XData', pos(1:3, 1), 'YData', pos(1:3, 2));
        set(h2, 'XData', pos(4:6, 1), 'YData', pos(4:6, 2));
    end
    
    pause(0.05);
end


fclose(s);