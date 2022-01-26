RegisterServerEvent("postar:nemaauta")
AddEventHandler("postar:nemaauta", function()
    local src = source
    ESX.GetPlayerFromId(src).removeMoney(500)
end)

ESX.RegisterServerCallback("poslovipostar:zavrsiposo", function(source)
    local src = source
    local _source = source

    ESX.GetPlayerFromId(src).addMoney(250)
    TriggerClientEvent('esx:showNotification', source, 'Dobili ste 250 dolara od postara')
end)