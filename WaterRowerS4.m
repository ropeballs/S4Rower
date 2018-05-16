classdef WaterRowerS4
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        USB
        UI
        started = 0;
        
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
        function result = reset(obj)
            fprintf(obj.USB,'RESET');
            result = 1;
        end
        function result = request(obj,reg,numregs)
            switch numregs
                case 1
                    prefix = 'IRS';
                case 2
                    prefix = 'IRD';
                case 3
                    prefix = 'IRT';
            end
            fprintf(obj.USB,strcat(prefix,reg));
            result = 1;
        end
        function result = shutdown(obj)
            fclose(obj.USB);
            result =1;
        end
    end
end

