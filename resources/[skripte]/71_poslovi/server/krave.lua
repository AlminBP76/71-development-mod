RegisterServerEvent("bPoslovi:kraveGotovoCiscenje")
AddEventHandler("bPoslovi:kraveGotovoCiscenje", function()
    local src = source
    local _source = source
    ESX.GetPlayerFromId(src).addMoney(250)
    TriggerClientEvent('esx:showNotification', source, 'Dobili ste 250 dolara od ciscenja govana')
end)


RegisterServerEvent("bPoslovi:mlijekoprerada")
AddEventHandler("bPoslovi:mlijekoprerada", function()
    local src = source
    local _source = source
    ESX.GetPlayerFromId(src).addMoney(350)
    TriggerClientEvent('esx:showNotification', source, 'Dobili ste 350 dolara od muzenja krava')
end)