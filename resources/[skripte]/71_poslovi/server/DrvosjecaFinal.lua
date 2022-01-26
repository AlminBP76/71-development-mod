ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bPoslovi:DrvosjecaZavrsioSjecenje')
AddEventHandler('bPoslovi:DrvosjecaZavrsioSjecenje', function()
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	local itemQuantity = xPlayer.getInventoryItem('drvo').count

		random = math.random(3,4)
		tempbroj = random
		xPlayer.addInventoryItem('drvo', random)
        TriggerClientEvent('esx:showNotification', source, 'Dobili ste ' .. tempbroj .. ' drveta')
end)

RegisterServerEvent("bPoslovi:prodajProdukata")
AddEventHandler("bPoslovi:prodajProdukata", function(amountToSell, totalSellPrice, itemName)
    local _source = source
    local _item = itemName
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        print("broke it")
        return
    else
        itemLabel = string.lower(xPlayer.getInventoryItem(_item).label)
        stvar = xPlayer.getInventoryItem(_item).count
        if stvar >= amountToSell then
            xPlayer.addMoney(totalSellPrice)
            xPlayer.removeInventoryItem(_item, amountToSell)
            TriggerClientEvent('esx:showNotification', source, 'Prodao si ' ..amountToSell.. ' ' ..itemLabel.. ' za $' ..totalSellPrice..'')
        else
            TriggerClientEvent('esx:showNotification', source, 'Nemas potrebne iteme')
        end
    end
end)