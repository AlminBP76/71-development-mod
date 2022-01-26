ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local chicken = vehicleBaseRepairCost

RegisterServerEvent('np-bennys:attemptPurchase')
AddEventHandler('np-bennys:attemptPurchase', function(type, upgradeLevel)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if type == "repair" then
        if xPlayer.getMoney() >= chicken then
            xPlayer.removeMoney(chicken)
            TriggerClientEvent('np-bennys:purchaseSuccessful', source)
            TriggerClientEvent("banking:removeCash", source, chicken)
        else
            TriggerClientEvent('np-bennys:purchaseFailed', source)
        end
    elseif type == "performance" then
        if xPlayer.getMoney() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('np-bennys:purchaseSuccessful', source)
            xPlayer.removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel])
            TriggerClientEvent("banking:removeCash", source, vehicleCustomisationPrices[type].prices[upgradeLevel])
        else
            TriggerClientEvent('np-bennys:purchaseFailed', source)
        end
    else
        if xPlayer.getMoney() >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('np-bennys:purchaseSuccessful', source)
            xPlayer.removeMoney(vehicleCustomisationPrices[type].price)
            TriggerClientEvent("banking:removeCash", source, vehicleCustomisationPrices[type].price)
        else
            TriggerClientEvent('np-bennys:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('np-bennys:updateRepairCost')
AddEventHandler('np-bennys:updateRepairCost', function(cost)
    chicken = cost
end)

RegisterServerEvent('updateVehicle')
AddEventHandler('updateVehicle', function(myCar)
    MySQL.Async.execute('UPDATE `owned_vehicles` SET `vehicle` = @vehicle WHERE `plate` = @plate',
	{
		['@plate']   = myCar.plate,
		['@vehicle'] = json.encode(myCar)
	})
end)