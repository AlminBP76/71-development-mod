-- NotW4018 <3

ESX = nil
AdminPlayers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('tag', function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if AdminPlayers[source] == nil then
        if Config.TagByPermission then
            AdminPlayers[source] = {source = source, permission = xPlayer.getPermissions()}
        else
            AdminPlayers[source] = {source = source, group = xPlayer.getGroup()}
        end

        TriggerClientEvent('okokNotify:Alert', xPlayer.source, "71 Development", "Ukljucili ste TAG!", 10000, 'info')
    else
        AdminPlayers[source] = nil
        TriggerClientEvent('okokNotify:Alert', xPlayer.source, "71 Development", "Iskljucili ste TAG!", 10000, 'info')
    end
    TriggerClientEvent('notw_tagaj:setaj_admine',-1,AdminPlayers)
end)

ESX.RegisterServerCallback('notw_tagaj:getajigrace',function(source,cb)
    cb(AdminPlayers)
end)

AddEventHandler('esx:playerDropped', function(source)
    if AdminPlayers[source] ~= nil then
        AdminPlayers[source] = nil
    end
    TriggerClientEvent('notw_tagaj:setaj_admine',-1,AdminPlayers)
end)

