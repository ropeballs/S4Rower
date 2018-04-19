function pollSignals(~,~,app)
    app.rower.request(app.messages{app.nextmessage},2);
    app.nextmessage = app.nextmessage +1;
    if app.nextmessage > length(app.messages)
        app.nextmessage =1;
    end
end