ESX.Trace = function(msg)
	if Config.EnableDebug then
		print(('[^2TRACE^7] %s^7'):format(msg))
	end
end

ESX.SetTimeout = function(msec, cb)
	local id = Core.TimeoutCount + 1

	SetTimeout(msec, function()
		if Core.CancelledTimeouts[id] then
			Core.CancelledTimeouts[id] = nil
		else
			cb()
		end
	end)

	Core.TimeoutCount = id

	return id
end

ESX.RegisterCommand = function(name, group, cb, allowConsole, suggestion)
	if type(name) == 'table' then
		for i=1, #name do
			ESX.RegisterCommand(name[i], group, cb, allowConsole, suggestion)
		end
		return
	end

	if Core.RegisteredCommands[name] then
		if Core.RegisteredCommands[name].suggestion then
			TriggerClientEvent('chat:removeSuggestion', -1, ('/%s'):format(name))
		end
	end

	if suggestion then
		if not suggestion.help then suggestion.help = '' end
		TriggerClientEvent('chat:addSuggestion', -1, ('/%s'):format(name), suggestion.help, suggestion.arguments)
	end

	Core.RegisteredCommands[name] = {name = name, group = group, cb = cb, allowConsole = allowConsole, suggestion = suggestion}

	RegisterCommand(name, function(playerId, args, rawCommand)
		local command = Core.RegisteredCommands[name]

		if not command.allowConsole and playerId == 0 then
			print(('[^3WARNING^7] ^5%s'):format(_U('commanderror_console')))
		else
			if playerId == 0 or IsPlayerAceAllowed(playerId, ('command.%s'):format(name)) then
				local xPlayer, error = ESX.GetPlayerFromId(playerId), nil

				if command.suggestion?.arguments then
					if command.suggestion.validate then
						if #args ~= #command.suggestion.arguments then
							error = _U('commanderror_argumentmismatch', #args, #command.suggestion.arguments)
						end
					end
					local newArgs = {}

					for k,v in ipairs(command.suggestion.arguments) do
						if v.type then
							if v.type == 'number' then
								local newArg = tonumber(args[k])

								if newArg then
									newArgs[v.name] = newArg
								else
									error = _U('commanderror_argumentmismatch_number', k)
								end
							elseif v.type == 'player' or v.type == 'playerId' then
								local targetPlayer = tonumber(args[k])

								if args[k] == 'me' then targetPlayer = playerId end

								if targetPlayer then
									local xTargetPlayer = ESX.GetPlayerFromId(targetPlayer)

									if xTargetPlayer then
										if v.type == 'player' then
											newArgs[v.name] = xTargetPlayer
										else
											newArgs[v.name] = targetPlayer
										end
									else
										error = _U('commanderror_invalidplayerid')
									end
								else
									error = _U('commanderror_argumentmismatch_number', k)
								end
							elseif v.type == 'string' then
								newArgs[v.name] = args[k]
							elseif v.type == 'weapon' then
								if ESX.GetWeapon(args[k]) then
									newArgs[v.name] = string.upper(args[k])
								else
									error = _U('commanderror_invalidweapon')
								end
							elseif v.type == 'any' then
								newArgs[v.name] = args[k]
							end
						end

						if error then break end
					end

					args = newArgs
				end

				if error then
					if playerId == 0 then
						print(('[^3WARNING^7] %s^7'):format(error))
					else
						xPlayer.triggerEvent('chat:addMessage', {args = {'^1SYSTEM', error}})
					end
				else
					cb(xPlayer or false, args, function(msg)
						if playerId == 0 then
							print(('[^3WARNING^7] %s^7'):format(msg))
						else
							xPlayer.triggerEvent('chat:addMessage', {args = {'^1SYSTEM', msg}})
						end
					end)
				end
			end
		end
	end, true)

	if type(group) == 'table' then
		for k,v in ipairs(group) do
			ExecuteCommand(('add_ace group.%s command.%s allow'):format(v, name))
		end
	else
		ExecuteCommand(('add_ace group.%s command.%s allow'):format(group, name))
	end
end

ESX.ClearTimeout = function(id)
	Core.CancelledTimeouts[id] = true
end

ESX.RegisterServerCallback = function(name, cb)
	Core.ServerCallbacks[name] = cb
end

Core.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if Core.ServerCallbacks[name] then
		Core.ServerCallbacks[name](source, cb, ...)
	else
		print(('[^3WARNING^7] Server callback ^5"%s"^0 does not exist. Please Check The Server File for Errors!'):format(name))
	end
end

Core.SavePlayer = function(xPlayer, cb)
	MySQL.prepare("UPDATE `users` SET `accounts` = ?, `job` = ?, `job_grade` = ?, `group` = ?, `position` = ?, `inventory` = ? WHERE `identifier` = ?", {{
		json.encode(xPlayer.getAccounts(true)),
		xPlayer.job.name,
		xPlayer.job.grade,
		xPlayer.group,
		json.encode(xPlayer.getCoords()),
		json.encode(xPlayer.getInventory(true)),
		xPlayer.identifier
	}}, function(affectedRows)
		if affectedRows == 1 then
			print(('[^2INFO^7] Saved player ^5"%s^7"'):format(xPlayer.name))
		end
		if cb then cb() end
	end)
end

Core.SavePlayers = function(cb)
	local xPlayers = ESX.GetExtendedPlayers()
	local count = #xPlayers
	if count > 0 then
		local parameters = {}
		local time = os.nanotime()
		for i=1, count do
			local xPlayer = xPlayers[i]
			parameters[#parameters+1] = {
				json.encode(xPlayer.getAccounts(true)),
				xPlayer.job.name,
				xPlayer.job.grade,
				xPlayer.group,
				json.encode(xPlayer.getCoords()),
				json.encode(xPlayer.getInventory(true)),
				xPlayer.identifier
			}
		end
		MySQL.prepare("UPDATE `users` SET `accounts` = ?, `job` = ?, `job_grade` = ?, `group` = ?, `position` = ?, `inventory` = ? WHERE `identifier` = ?", parameters,
		function(results)
			if results then
				if type(cb) == 'function' then cb() else print(('[^2INFO^7] Saved %s %s over %s ms'):format(count, count > 1 and 'players' or 'player', (os.nanotime() - time) / 1000000)) end
			end
		end)
	end
end
SetInterval(Core.SavePlayers, 600000)

ESX.GetPlayers = function()
	local sources = {}
	for k in pairs(ESX.Players) do
		sources[#sources+1] = k
	end
	return sources
end

ESX.GetExtendedPlayers = function(key, val)
	local xPlayers = {}
	for _, v in pairs(ESX.Players) do
		if key then
			if (key == 'job' and v.job.name == val) or v[key] == val or v.variables[key] == val then
				xPlayers[#xPlayers+1] = v
			end
		else
			xPlayers[#xPlayers+1] = v
		end
	end
	return xPlayers
end

ESX.GetPlayerFromId = function(source)
	return ESX.Players[tonumber(source)]
end

ESX.GetPlayerFromIdentifier = function(identifier)
	for _,v in pairs(ESX.Players) do
		if v.identifier == identifier then
			return v
		end
	end
end

ESX.GetIdentifier = function(playerId)
	local identifier = Config.Identifier..':'
	for _, v in pairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, identifier) then
			identifier = string.gsub(v, identifier, '')
			return identifier
		end
	end
end

ESX.RegisterUsableItem = function(item, cb)
	Core.UsableItemsCallbacks[item] = cb
end

ESX.UseItem = function(source, item, data)
	Core.UsableItemsCallbacks[item](source, item, data)
end

ESX.GetItemLabel = function(item)
	item = exports.ox_inventory:Items(item)
	if item then
		return item.label
	end
end

ESX.GetJobs = function()
	return ESX.Jobs
end

ESX.GetUsableItems = function()
	local Usables = {}
	for k in pairs(Core.UsableItemsCallbacks) do
		Usables[k] = true
	end
	return Usables
end

ESX.DoesJobExist = function(job, grade)
	if job and grade and ESX.Jobs[job] and ESX.Jobs[job].grades[tostring(grade)] then
		return true
	end
	return false
end

Core.IsPlayerAdmin = function(playerId)
	if (IsPlayerAceAllowed(playerId, 'command') or GetConvar('sv_lan', '') == 'true') and true or false then
		return true
	end

	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer then
		if xPlayer.group == 'admin' or xPlayer.group == 'superadmin' then
			return true
		end
	end

	return false
end