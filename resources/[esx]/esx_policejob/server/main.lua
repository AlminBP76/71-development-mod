if Config.EnableESXService then
	if Config.MaxInService ~= -1 then
		TriggerEvent('esx_service:activateService', 'police', Config.MaxInService)
	end
end

TriggerEvent('esx_phone:registerNumber', 'police', _U('alert_police'), true, true)
TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:handcuff', target)
	else
		print(('esx_policejob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:drag', target, source)
	else
		print(('esx_policejob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:putInVehicle', target)
	else
		print(('esx_policejob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:OutVehicle', target)
	else
		print(('esx_policejob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

ESX.RegisterServerCallback('esx_policejob:getOtherPlayerData', function(source, cb, target, notify)
	local xPlayer = ESX.GetPlayerFromId(target)

	if notify then
		xPlayer.showNotification(_U('being_searched'))
	end

	if xPlayer then
		local data = {
			name = xPlayer.getName(),
			job = xPlayer.job.label,
			grade = xPlayer.job.grade_label
		}

		if Config.EnableESXIdentity then
			data.dob = xPlayer.get('dateofbirth')
			data.height = xPlayer.get('height')

			if xPlayer.get('sex') == 'm' then data.sex = 'male' else data.sex = 'female' end
		end

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status then
				data.drunk = ESX.Math.Round(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end
	end
end)

ESX.RegisterServerCallback('esx_policejob:getFineList', function(source, cb, category)
	MySQL.query('SELECT * FROM fine_types WHERE category = ?', {category},
	function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleInfos', function(source, cb, plate)
	local retrivedInfo = {
		plate = plate
	}
	if Config.EnableESXIdentity then
		MySQL.single('SELECT users.firstname, users.lastname FROM owned_vehicles JOIN users ON owned_vehicles.owner = users.identifier WHERE plate = ?', {plate},
		function(result)
			if result then
				retrivedInfo.owner = ('%s %s'):format(result.firstname, result.lastname)
			end
			cb(retrivedInfo)
		end)
	else
		MySQL.scalar('SELECT owner FROM owned_vehicles WHERE plate = ?', {plate},
		function(owner)
			if owner then
				local xPlayer = ESX.GetPlayerFromIdentifier(owner)
				if xPlayer then
					retrivedInfo.owner = xPlayer.getName()
				end
			end
			cb(retrivedInfo)
		end)
	end
end)

ESX.RegisterServerCallback('esx_policejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_policejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)

			MySQL.insert('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (?, ?, ?, ?, ?, ?)', { xPlayer.identifier, json.encode(vehicleProps), vehicleProps.plate, type, xPlayer.job.name, true},
			function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_policejob:storeNearbyVehicle', function(source, cb, plates)
	local xPlayer = ESX.GetPlayerFromId(source)

	local plate = MySQL.single.await('SELECT plate FROM owned_vehicles WHERE owner = ? AND plate IN (?) AND job = ?', {xPlayer.identifier, plates, xPlayer.job.name})

	if plate then
		MySQL.update('UPDATE owned_vehicles SET `stored` = true WHERE owner = ? AND plate = ? AND job = ?', {xPlayer.identifier, plate, xPlayer.job.name},
		function(rowsChanged)
			if rowsChanged == 0 then
				cb(false)
			else
				cb(plate)
			end
		end)
	else
		cb(false)
	end
end)

function getPriceFromHash(vehicleHash, jobGrade, type)
	local vehicles = Config.AuthorizedVehicles[type][jobGrade]

	for i = 1, #vehicles do
		local vehicle = vehicles[i]
		if GetHashKey(vehicles.model) == vehicleHash then
			return vehicle.price
		end
	end

	return 0
end

AddEventHandler('playerDropped', function()
	local playerId = source
	if playerId then
		local xPlayer = ESX.GetPlayerFromId(playerId)
		if xPlayer and xPlayer.job.name == 'police' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_policejob:updateBlip', -1)
		end
	end
end)

RegisterNetEvent('esx_policejob:spawned')
AddEventHandler('esx_policejob:spawned', function()
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer and xPlayer.job.name == 'police' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

RegisterNetEvent('esx_policejob:forceBlip')
AddEventHandler('esx_policejob:forceBlip', function()
	for _, xPlayer in pairs(ESX.GetExtendedPlayers('job', 'police')) do
		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		for _, xPlayer in pairs(ESX.GetExtendedPlayers('job', 'police')) do
			TriggerClientEvent('esx_policejob:updateBlip', xPlayer.source)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)
