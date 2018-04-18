classdef WaterRowerS4
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        USB
        UI
        
    end
    
    methods
        function obj = WaterRowerS4(ComPort,app)
            %WATERROWERS4 Construct an instance of WaterRowerS4
            %   Detailed explanation goes here
            obj.UI = app;
            obj.USB = serial(ComPort,'BytesAvailableFcn',{@readdata,obj});
            obj.USB.Terminator = 'CR/LF';
           % obj.USB.BytesAvailableFcn = @obj.readdata,app;
            obj.USB.BytesAvailableFcnMode = 'terminator';
            obj.USB.Tag = 'WaterRower';
        end
        function readdata(rower,event,obj)
            out = fscanf(obj.USB, '%s');
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
                    switch out(4:6)
                        case hex2dec('057')
                            disp = '057'
                        case hex2dec('065')
                        case hex2dec('060')
                        otherwise
                    end
                    app.UI.Label_2.Text = hex2dec(out(7:end));
                otherwise
                    disp = out

            end
        end
        function result = connect(obj)
            %CONNECT Summary of this method goes here
            %   Detailed explanation goes here
            try
                fopen(obj.USB);
                fprintf(obj.USB,'USB');
                result = 1;
            catch err
                result = 0;
                msgbox(err.message)
            end
            
        end
        function result = request(obj,reg,numregs)
            switch numregss
                case 1
                    prefix = 'IRS';
                case 2
                    prefix = 'IRD';
                case 3
                    prefix = 'IRT';
            end
            result=fprintf(obj.USB,strcat(prefix,reg));
        end
        function result = shutdown(obj)
            fclose(obj.USB);
            result =1;
        end
    end
end

