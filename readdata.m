function  readdata(rower,~,app)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
out = fscanf(rower, '%s');
switch out(1)
    case 'S'
        switch out(2)
            case 'S'
                try        
                    app.UI.SetStrokesPerMin(60/toc);
%                     app.UI.StrokesMinuteGauge.Value = 60/toc;
%                     app.UI.StrokesMinuteGauge.Text = 60/toc;
                catch
                end
                tic
%                app.stroke = 'Start';
            case 'E'
%                app.stroke = 'END';
            otherwise
        end
    case 'P'
        if out(2) == 'I'
            disp = 'PING';
         %   app.started = 0;
        else
%            app.pulseCount = str2double(out(2:3));
        end
    case '_'
         disp = 'HW';
    case 'I'
        %'055' is distance going up
        
        message = out(4:6);
        value = hex2dec(out(7:end));
%         app.UI.message = out(4:6);
        switch message
            case '1E1'
                mintues = str2double(dec2hex(bitshift(value,-8)));
                seconds = str2double(dec2hex(bitand(value,255)));
                time = duration(0,mintues,seconds);
                app.UI.Label.Text = string(time);
                app.UI.logtime(app.UI.indx) = time;
%                 app.UI.Label.Text = dec2hex(bitshift(value,-8));
%                 app.UI.Label_5.Text = dec2hex(bitand(value,255));

            case '055'
                roweddistance = value;
                app.UI.setDistance(num2str(value));
                app.UI.logdistance(app.UI.indx) = roweddistance;
                plot(app.UI.UIAxes,app.UI.logtime(1:app.UI.indx),app.UI.logdistance(1:app.UI.indx))
            case '148'
                app.UI.SetMeterPerMin(value/10);
        end
            app.UI.nextmessage = app.UI.nextmessage +1;
            if app.UI.nextmessage > length(app.UI.messages)
                app.UI.indx = app.UI.indx+1;
                app.UI.nextmessage =1;
            end            
    otherwise
        disp = out
       
end
end

