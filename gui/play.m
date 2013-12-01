function [] = play(s, h1, h2)

fwrite(s, 'p', 'char');
pause(0.5);

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
%         fclose(s);
        disp('Error getting robot positions from M2');
        return;
    end
    
    set(h1, 'XData', pos(1:3, 1), 'YData', pos(1:3, 2));
    set(h2, 'XData', pos(4:6, 1), 'YData', pos(4:6, 2));
    
    pause(0.05);
end