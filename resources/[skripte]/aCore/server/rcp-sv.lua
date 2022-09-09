GlobalState["BrojIgraca"] = 0

CreateThread(function()
    while true do
        local igraci = GetPlayers()
        GlobalState["BrojIgraca"] = #igraci
        Wait(5000)
    end
end) 