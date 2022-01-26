ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bPoslovi_jabuke:done')
AddEventHandler('bPoslovi_jabuke:done', function()
	local _source = source
	local igrac  = ESX.GetPlayerFromId(source)
	local kolicina = igrac.getInventoryItem('jabuka').count

		random = math.random(3,4)
		tempbroj = random
		if kolicina < 300 then
		igrac.addInventoryItem('jabuka', random)
		TriggerClientEvent('esx:showNotification', source, 'Dobili ste ' .. tempbroj .. ' jabuka!')
     else
		TriggerClientEvent('esx:showNotification', source, 'Nemate dovoljno mjesta u inventaru')
	 end
end)

ESX.RegisterServerCallback('bPoslovi_jabuka:MozelNosit', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)
