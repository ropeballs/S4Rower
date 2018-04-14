function  readdata(rower,event,app)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
out = fscanf(rower, '%s');
switch out(1)
    case 'S'
        switch out(2)
            case 'S'
                app.stroke = 'Start';
            case 'E'
                app.stroke = 'END';
            otherwise
        end
    case 'P'
        if out(2) == 'I'
            disp = 'PING'
        else
            app.pulseCount = str2double(out(2:3));
        end
    case '_'
         disp = 'HW'
    case 'I'
        app.UI.message = out(4:6)
        app.value = hex2dec(out(7:end))
    otherwise
        disp = out
       
end
end

