local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
  local xPlayer = ESX.GetPlayerFromId(source) 
end)

RegisterServerEvent('aRent:payDamage')
AddEventHandler('aRent:payDamage', function()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
     xPlayer.removeMoney(500)
end)

RegisterServerEvent("rent:checkMoney")
AddEventHandler("rent:checkMoney", function(cijena)
    local imal = false
    local igrac = ESX.GetPlayerFromId(source)

    if igrac.getMoney() >= tonumber(cijena) then 
        TriggerClientEvent("aRent:haveMoney", source, true)
        igrac.removeMoney(tonumber(cijena))
    else
        TriggerClientEvent("aRent:haveMoney", source, false)
    end

end)