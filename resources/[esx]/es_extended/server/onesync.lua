ESX.OneSync = {}

---@param source vector|number either coordinates to originate from, or a player id
---@param closest boolean
---@param distance number
---@param ignore boolean 
---@return table
function ESX.OneSync.Players(source, closest, distance, ignore)
	local result = {}
	local count = 0
	if not distance then distance = 100 end
	if type(source) == 'number' then
		source = GetEntityCoords(GetPlayerPed(source))
	end

	for _, xPlayer in pairs(ESX.Players) do
		if not ignore or not ignore[xPlayer.source] then
			local entity = GetPlayerPed(xPlayer.source)
			local coords = GetEntityCoords(entity)

			if not closest then
				local dist = #(source - coords)
				if dist <= distance then
					count += 1
					result[count] = {id = xPlayer.source, ped = entity, coords = coords, dist = dist}
				end
			else
				local dist = #(source - coords)
				if dist <= (result.dist or distance) then
					result = {id = xPlayer.source, ped = entity, coords = coords, dist = dist}
				end
			end
		end
	end

	return result
end

---@param source vector|number entitycoords or entityid
---@param maxDistance number
---@param ignore table
ESX.OneSync.GetPlayersInArea = function(source, maxDistance, ignore)
	return ESX.OneSync.Players(source, false, maxDistance, ignore)
end

---@param source vector|number entitycoords or entityid
---@param maxDistance number
---@param ignore table
ESX.OneSync.GetClosestPlayer = function(source, maxDistance, ignore)
	return ESX.OneSync.Players(source, true, maxDistance, ignore)
end

ESX.OneSync.SpawnVehicle = function(model, coords, heading, cb)
	if type(model) == 'string' then model = GetHashKey(model) end
	CreateThread(function()
		local entity = Citizen.InvokeNative(`CREATE_AUTOMOBILE`, model, coords.x, coords.y, coords.z, heading)
		while not DoesEntityExist(entity) do Wait(50) end
		cb(entity)
	end)
end

ESX.OneSync.SpawnObject = function(model, coords, heading, cb)
	if type(model) == 'string' then model = GetHashKey(model) end
	CreateThread(function()
		CreateObject(model, coords, heading, true, true)
		while not DoesEntityExist(entity) do Wait(50) end
		cb(entity)
	end)
end

ESX.OneSync.SpawnPed = function(model, coords, heading, cb)
	if type(model) == 'string' then model = GetHashKey(model) end
	CreateThread(function()
		local entity = CreatePed(0, model, coords.x, coords.y, coords.z, heading, true, true)
		while not DoesEntityExist(entity) do Wait(50) end
		cb(entity)
	end)
end

ESX.OneSync.SpawnPedInVehicle = function(model, vehicle, seat, cb)
	if type(model) == 'string' then model = GetHashKey(model) end
	CreateThread(function()
		local entity = CreatePedInsideVehicle(vehicle, 1, model, seat, true, true)
		while not DoesEntityExist(entity) do Wait(50) end
		cb(entity)
	end)
end

ESX.OneSync.GetNearbyEntities = function(entities, coords, modelFilter, maxDistance, isPed)
	local nearbyEntities = {}
	coords = type(coords) == 'number' and GetEntityCoords(GetPlayerPed(coords)) or vector3(coords.x, coords.y, coords.z)
	for _, entity in pairs(entities) do
		if not isPed or (isPed and not IsPedAPlayer(entity)) then
			if not modelFilter or modelFilter[GetEntityModel(entity)] then
				local entityCoords = GetEntityCoords(entity)
				if not maxDistance or #(coords - entityCoords) <= maxDistance then
					nearbyEntities[#nearbyEntities+1] = {entity=entity, coords=entityCoords}
				end
			end
		end
	end

	return nearbyEntities
end

ESX.OneSync.GetClosestEntity = function(entities, coords, modelFilter, isPed)
	local distance, closestEntity, closestCoords = maxDistance or 100, nil, nil
	coords = type(coords) == 'number' and GetEntityCoords(GetPlayerPed(coords)) or vector3(coords.x, coords.y, coords.z)

	for _, entity in pairs(entities) do
		if not isPed or (isPed and not IsPedAPlayer(entity)) then
			if not modelFilter or modelFilter[GetEntityModel(entity)] then
				local entityCoords = GetEntityCoords(entity)
				local dist = #(coords - entityCoords)
				if dist < distance then
					closestEntity, distance, closestCoords = entity, dist, entityCoords
				end
			end
		end
	end
	return closestEntity, distance, closestCoords
end

ESX.OneSync.GetPedsInArea = function(coords, maxDistance, modelFilter)
	return ESX.OneSync.GetNearbyEntities(GetAllPeds(), coords, modelFilter, maxDistance, true)
end

ESX.OneSync.GetObjectsInArea = function(coords, maxDistance, modelFilter)
	return ESX.OneSync.GetNearbyEntities(GetAllObjects(), coords, modelFilter, maxDistance)
end

ESX.OneSync.GetVehiclesInArea = function(coords, maxDistance, modelFilter)
	return ESX.OneSync.GetNearbyEntities(GetAllVehicles(), coords, modelFilter, maxDistance)
end

ESX.OneSync.GetClosestPed = function(coords, modelFilter)
	return ESX.OneSync.GetClosestEntity(GetAllPeds(), coords, modelFilter, true)
end

ESX.OneSync.GetClosestObject = function(coords, modelFilter)
	return ESX.OneSync.GetClosestEntity(GetAllObjects(), coords, modelFilter)
end

ESX.OneSync.GetClosestVehicle = function(coords, modelFilter)
	return ESX.OneSync.GetClosestEntity(GetAllVehicles(), coords, modelFilter)
end
