
RegisterServerEvent("esx_uber:pay")
AddEventHandler("esx_uber:pay",function(a)
    local b=source;
    local c=ESX.GetPlayerFromId(b)
    c.addMoney(tonumber(a))
end)


RegisterServerEvent("uber:esyaSil")
AddEventHandler("uber:esyaSil",function(a)
    local b=source;
    local c=ESX.GetPlayerFromId(b)
    c.removeInventoryItem(a,1)
end)