CreateThread(function()
	while not Config.Multichar do
		Wait(0)
		if NetworkIsPlayerActive(PlayerId()) then
			exports.spawnmanager:setAutoSpawn(false)
			DoScreenFadeOut(0)
			TriggerServerEvent('esx:onPlayerJoined')
			break
		end
	end
end)

local PlayerKilledByPlayer = function(killerServerId, killerClientId, deathCause, victimCoords)
	local killerCoords = GetEntityCoords(GetPlayerPed(killerClientId))
	local distance = #(victimCoords - killerCoords)

	local data = {
		victimCoords = {x = ESX.Math.Round(victimCoords.x, 1), y = ESX.Math.Round(victimCoords.y, 1), z = ESX.Math.Round(victimCoords.z, 1)},
		killerCoords = {x = ESX.Math.Round(killerCoords.x, 1), y = ESX.Math.Round(killerCoords.y, 1), z = ESX.Math.Round(killerCoords.z, 1)},

		killedByPlayer = true,
		deathCause = deathCause,
		distance = ESX.Math.Round(distance, 1),

		killerServerId = killerServerId,
		killerClientId = killerClientId
	}

	TriggerEvent('esx:onPlayerDeath', data)
	TriggerServerEvent('esx:onPlayerDeath', data)
end

local PlayerKilled = function(deathCause, victimCoords)
	local data = {
		victimCoords = {x = ESX.Math.Round(victimCoords.x, 1), y = ESX.Math.Round(victimCoords.y, 1), z = ESX.Math.Round(victimCoords.z, 1)},

		killedByPlayer = false,
		deathCause = deathCause
	}
	TriggerEvent('esx:onPlayerDeath', data)
	TriggerServerEvent('esx:onPlayerDeath', data)
end

RegisterNetEvent('esx:playerLoaded', function(xPlayer, isNew, skin)
	ESX.PlayerLoaded = true
	ESX.PlayerData = xPlayer

	FreezeEntityPosition(PlayerPedId(), true)

	if Config.Multichar then
		Wait(3000)
	else
		exports.spawnmanager:spawnPlayer({
			x = ESX.PlayerData.coords.x,
			y = ESX.PlayerData.coords.y,
			z = ESX.PlayerData.coords.z + 0.25,
			heading = ESX.PlayerData.coords.heading,
			model = `mp_m_freemode_01`,
			skipFade = false
		}, function()
			TriggerServerEvent('esx:onPlayerSpawn')
			TriggerEvent('esx:onPlayerSpawn')
			TriggerEvent('playerSpawned') -- compatibility with old scripts
			if isNew then
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadDefaultModel', true)
				else
					TriggerEvent('skinchanger:loadDefaultModel', false)
				end
			elseif skin then TriggerEvent('skinchanger:loadSkin', skin) end
			TriggerEvent('esx:loadingScreenOff')
			ShutdownLoadingScreen()
			ShutdownLoadingScreenNui()
			FreezeEntityPosition(ESX.PlayerData.ped, false)
		end)
	end

	while ESX.PlayerData.ped == nil do Wait(20) end
	-- enable PVP
	if Config.EnablePVP then
		SetCanAttackFriendly(ESX.PlayerData.ped, true, false)
		NetworkSetFriendlyFireOption(true)
	end

	if Config.EnableHud then
		for k,v in ipairs(ESX.PlayerData.accounts) do
			local accountTpl = '<div><img src="img/accounts/' .. v.name .. '.png"/>&nbsp;{{money}}</div>'
			ESX.UI.HUD.RegisterElement('account_' .. v.name, k, 0, accountTpl, {money = ESX.Math.GroupDigits(v.money)})
		end

		local jobTpl = '<div>{{job_label}}{{grade_label}}</div>'

		local gradeLabel = ESX.PlayerData.job.grade_label ~= ESX.PlayerData.job.label and ESX.PlayerData.job.grade_label or ''
		if gradeLabel ~= '' then gradeLabel = ' - '..gradeLabel end

		ESX.UI.HUD.RegisterElement('job', #ESX.PlayerData.accounts, 0, jobTpl, {
			job_label = ESX.PlayerData.job.label,
			grade_label = gradeLabel
		})
	end

	local isDead = false
	local previousCoords = vector3(ESX.PlayerData.coords.x, ESX.PlayerData.coords.y, ESX.PlayerData.coords.z)
	SetInterval(function()
		local playerPed = PlayerPedId()
		if ESX.PlayerData.ped ~= playerPed then ESX.SetPlayerData('ped', playerPed) end
		local playerCoords = GetEntityCoords(playerPed)

		if not isDead and IsPedFatallyInjured(playerPed) then
			isDead = true

			local killerEntity, deathCause = GetPedSourceOfDeath(playerPed), GetPedCauseOfDeath(playerPed)
			local killerClientId = NetworkGetPlayerIndexFromPed(killerEntity)

			if killerEntity ~= playerPed and killerClientId and NetworkIsPlayerActive(killerClientId) then
				PlayerKilledByPlayer(GetPlayerServerId(killerClientId), killerClientId, deathCause, playerCoords)
			else
				PlayerKilled(deathCause, playerCoords)
			end

		elseif isDead and not IsPedFatallyInjured(playerPed) then
			isDead = false
		end

		if #(playerCoords - previousCoords) > 3 then
			previousCoords = playerCoords
			TriggerServerEvent('esx:updateCoords', {
				x = ESX.Math.Round(playerCoords.x, 1),
				y = ESX.Math.Round(playerCoords.y, 1),
				z = ESX.Math.Round(playerCoords.z, 1),
				heading = ESX.Math.Round(GetEntityHeading(playerPed), 1)
			})
		end

	end, 500)
end)

RegisterNetEvent('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	if Config.EnableHud then ESX.UI.HUD.Reset() end
end)

AddEventHandler('esx:onPlayerSpawn', function()
	ESX.SetPlayerData('ped', PlayerPedId())
	ESX.SetPlayerData('dead', false)
end)

AddEventHandler('esx:onPlayerDeath', function()
	ESX.SetPlayerData('ped', PlayerPedId())
	ESX.SetPlayerData('dead', true)
end)

RegisterNetEvent('esx:setAccountMoney', function(account)
	for k,v in ipairs(ESX.PlayerData.accounts) do
		if v.name == account.name then
			ESX.PlayerData.accounts[k] = account
			break
		end
	end
	ESX.SetPlayerData('accounts', ESX.PlayerData.accounts)

	if Config.EnableHud then
		ESX.UI.HUD.UpdateElement('account_' .. account.name, {
			money = ESX.Math.GroupDigits(account.money)
		})
	end
end)

RegisterNetEvent('esx:teleport', function(coords)
	ESX.Game.Teleport(ESX.PlayerData.ped, coords)
end)

RegisterNetEvent('esx:setJob', function(Job)
	if Config.EnableHud then
		local gradeLabel = Job.grade_label ~= Job.label and Job.grade_label or ''
		if gradeLabel ~= '' then gradeLabel = ' - '..gradeLabel end
		ESX.UI.HUD.UpdateElement('job', {
			job_label = Job.label,
			grade_label = gradeLabel
		})
	end
	ESX.SetPlayerData('job', Job)
end)

RegisterNetEvent('esx:registerSuggestions', function(registeredCommands)
	for name,command in pairs(registeredCommands) do
		if command.suggestion then
			TriggerEvent('chat:addSuggestion', ('/%s'):format(name), command.suggestion.help, command.suggestion.arguments)
		end
	end
end)

RegisterNetEvent('esx:tpm', function()
	ESX.TriggerServerCallback('esx:admincommand', function(result)
		if result then
			local WaypointHandle = GetFirstBlipInfoId(8)
			if DoesBlipExist(WaypointHandle) then
				local playerPed = ESX.PlayerData.ped
				local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
				for height = 1, 1000 do
					SetPedCoordsKeepVehicle(playerPed, waypointCoords.x, waypointCoords.y, height + 0.0)
					local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, height + 0.0)
					if foundGround then
						SetPedCoordsKeepVehicle(playerPed, waypointCoords.x, waypointCoords.y, height + 0.0)
						break
					end

					Wait(5)
				end
				TriggerEvent('chat:addMessage', 'Uspjesno teleportovano')
			else
				TriggerEvent('chat:addMessage', 'Nema postavljenog waypointa')
			end
		end
	end)
end)

local noclip
RegisterNetEvent('esx:noclip', function()
	ESX.TriggerServerCallback('esx:admincommand', function(result)
		if result then
			if not noclip then
				local playerPed = ESX.PlayerData.ped
				SetEntityInvincible(playerPed, true)
				SetPedAoBlobRendering(playerPed, false)
				SetEntityAlpha(playerPed, 0)
				local position = GetEntityCoords(playerPed)

				noclip = SetInterval(function()
					playerPed = ESX.PlayerData.ped
					local heading = GetFinalRenderedCamRot(2)?.z or 0.0
					SetEntityHeading(playerPed, heading)

					if (IsControlPressed(1, 8)) then position = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, -1.0, 0.0) end
					if (IsControlPressed(1, 32)) then position = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 1.0, 0.0) end
					if (IsControlPressed(1, 27)) then position = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.0, 1.0) end
					if (IsControlPressed(1, 173)) then position = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.0, -1.0) end

					SetEntityCoordsNoOffset(playerPed, position.x, position.y, position.z, 0, 0, 0)
				end, 0)
			else
				ClearInterval(noclip)
				local playerPed = ESX.PlayerData.ped
				SetEntityInvincible(playerPed, false)
				SetPedAoBlobRendering(playerPed, true)
				ResetEntityAlpha(playerPed)
				noclip = false
			end

			TriggerEvent('chat:addMessage', ('Noclip has been %s'):format(noclip and 'enabled' or 'disabled'))
		end
	end)
end)

-- Pause menu disables HUD display
if Config.EnableHud then
	local isPaused = false
	SetInterval(function()
		local paused = IsPauseMenuActive()
		if paused and not isPaused then
			isPaused = true
			ESX.UI.HUD.SetDisplay(0.0)
		elseif not paused and isPaused then
			isPaused = false
			ESX.UI.HUD.SetDisplay(1.0)
		end
	end, 300)

	AddEventHandler('esx:loadingScreenOff', function()
		ESX.UI.HUD.SetDisplay(1.0)
	end)
end

-- disable wanted level
if not Config.EnableWantedLevel then
	ClearPlayerWantedLevel(PlayerId())
	SetMaxWantedLevel(0)
end
