--------------------------------------------------------------------
-------------------------Converted by ex#1515-----------------------
--------------------------------------------------------------------

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('71Salon:requestInfo')
AddEventHandler('71Salon:requestInfo', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local rows    

    TriggerClientEvent('71Salon:receiveInfo', src, xPlayer.getMoney())
    TriggerClientEvent("71Salon:notify", src, 'error', 'Koristi A i D da rotiras vozilo')
end)

ESX.RegisterServerCallback('71Salon:isPlateTaken', function (source, cb, plate)
	MySQL.query('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)




-- Double checking on the money, if you do not have it in the inventory, look at the bank -- CREDIT (Sr.Zek)
RegisterServerEvent('71Salon:CheckMoneyForVeh')
AddEventHandler('71Salon:CheckMoneyForVeh', function(veh, price, name, vehicleProps)
	local _source = source
	local src = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= tonumber(price) then
		xPlayer.removeMoney(tonumber(price))
		if Config.SpawnVehicle then
			stateVehicle = 0
		else
			stateVehicle = 1
		end

		MySQL.query('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
		{
			['@owner']   = xPlayer.identifier,
			['@plate']   = vehicleProps.plate,
			['@vehicle'] = json.encode(vehicleProps)
		}, function (rowsChanged)
			
			TriggerClientEvent("71Salon:successfulbuy", _source, name, vehicleProps.plate, price)
			TriggerClientEvent('71Salon:receiveInfo', _source, xPlayer.getMoney())   
			TriggerClientEvent('71Salon:spawnVehicle', _source, veh, vehicleProps.plate)
		end)
	elseif xPlayer.getAccount('bank').money >= tonumber(price) then
		xPlayer.removeAccountMoney('bank',tonumber(price))
		if Config.SpawnVehicle then
			stateVehicle = 0
		else
			stateVehicle = 1
		end

		MySQL.query('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
		{
			['@owner']   = xPlayer.identifier,
			['@plate']   = vehicleProps.plate,
			['@vehicle'] = json.encode(vehicleProps)
		}, function (rowsChanged)
			
			TriggerClientEvent("71Salon:successfulbuy", _source, name, vehicleProps.plate, price)
			TriggerClientEvent('71Salon:receiveInfo', _source, xPlayer.getMoney())   
			TriggerClientEvent('71Salon:spawnVehicle', _source, veh, vehicleProps.plate)
		end)
	else
		TriggerClientEvent('esx:showNotification', source, 'Nemas dovoljno novca')

	end
end)