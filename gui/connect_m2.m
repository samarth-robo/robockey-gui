function [s, h1, h2] = connect_m2(s, teams)

% dimensions
xmax = 230;
ymax = 120;

acm_port = ls('/dev/ttyACM*');
serial_port = ['/dev/ttyS10', acm_port(end-1)];

try
    ls(serial_port);
catch
    cmd = ['sudo ln -s ', acm_port(1:end-1), ' ', serial_port];
    system(cmd);
end

if(isempty(s))
    s = serial(serial_port, 'Timeout', 0.5);
end

try
    disp('Opening port...');
    fopen(s);
    disp('Done!');
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

% load addresses
addresses = [4*teams(1):4*teams(1)+3; 4*teams(2):4*teams(2)+3];
try
    for i = 1 : size(addresses, 1)
        for j = 1 : size(addresses, 2)
%             fwrite(s, addresses(teams(i), j), 'char');
            fwrite(s, addresses(i, j), 'char');
            pause(0.1);
        end
    end
catch
    fclose(s);
    disp('Error communicating hex addresses of teams to M2');
    return;
end

axis([-20, xmax+20, -20, ymax+20]);
hold on;
% axis off;
line([0; xmax; xmax; 0; 0], [0; 0; ymax; ymax; 0], 'LineStyle', '-.', 'LineWidth', 3,...
    'Color', 'k');
line([xmax/2; xmax/2], [0; ymax], 'LineStyle', '-', 'LineWidth', 2, 'Color', 'b');
h1 = scatter([10, 10, 10], linspace(10, ymax-10, 3), 'r');
h2 = scatter((xmax-10)*[1, 1, 1], linspace(10, ymax-10, 3), 'g');