ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('trp_meth:start')
AddEventHandler('trp_meth:start', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.getInventoryItem('acetone').count >= 5 and xPlayer.getInventoryItem('lithium').count >= 2 and xPlayer.getInventoryItem('methlab').count >= 1 then
		if xPlayer.getInventoryItem('meth').count >= 100 then
				TriggerClientEvent('trp_meth:notify', _source, "Ne mozes drzati vise Meta")
		else
			TriggerClientEvent('trp_meth:startprod', _source)
			xPlayer.removeInventoryItem('acetone', 5)
			xPlayer.removeInventoryItem('lithium', 2)
		end

		
		
	else
		TriggerClientEvent('trp_meth:notify', _source, "Nema dovoljno zaliha za pocetak proizvodnje Met")

	end
	
end)
RegisterServerEvent('trp_meth:stopf')
AddEventHandler('trp_meth:stopf', function(id)
local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(_source)
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('trp_meth:stopfreeze', xPlayers[i], id)
	end
	
end)
RegisterServerEvent('trp_meth:make')
AddEventHandler('trp_meth:make', function(posx,posy,posz)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.getInventoryItem('methlab').count >= 1 then
	
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			TriggerClientEvent('trp_meth:smoke',xPlayers[i],posx,posy,posz, 'a') 
		end
		
	else
		TriggerClientEvent('trp_meth:stop', _source)
	end
	
end)
RegisterServerEvent('trp_meth:finish')
AddEventHandler('trp_meth:finish', function(qualtiy)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	print(qualtiy)
	local rnd = math.random(-5, 5)
--	TriggerEvent('KLevels:addXP', _source, 20)
	xPlayer.addInventoryItem('meth', math.floor(qualtiy*1.4) + rnd)
	
end)

RegisterServerEvent('trp_meth:blow')
AddEventHandler('trp_meth:blow', function(posx, posy, posz)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(_source)
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('trp_meth:blowup', xPlayers[i],posx, posy, posz)
	end
	xPlayer.removeInventoryItem('methlab', 1)
end)