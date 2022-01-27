ESX.RegisterServerCallback("aCore:pokupiRank", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

ESX.RegisterServerCallback('liberty:getajigrace', function(source, cb)
    local xPlayers = ESX.GetPlayers()
    local igraci  = {}

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        table.insert(igraci, {
            source      = xPlayer.source,
            identifier  = xPlayer.getIdentifier(),
      name        = GetPlayerName(xPlayers[i]),
            job         = xPlayer.getJob(),
      group       = xPlayer.getGroup(),
      posao       = xPlayer.job.label,
      cin          = xPlayer.job.grade_label,
      placa        = xPlayer.job.grade_salary,
        })
    end
    cb(igraci)
end)
   