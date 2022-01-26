AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	TriggerEvent('esx_status:set', 'stress', 0)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

OnPlayerData = function(key, val)
	if key == 'dead' and val == true then
		TriggerEvent('esx_basicneeds:resetStatus')
	end
end

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return Config.Visible
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return Config.Visible
	end, function(status)
		status.remove(75)
	end)

	TriggerEvent('esx_status:registerStatus', 'stress', 0, '#d14848', function(status)
		return Config.Visible
	end, function(status)
		status.remove(5)
	end)

end)

local stress = 0
local stressWait = 0
local aiming = 0
local melee = 0
local still = 0
local stealth = 0
local chute = 0

AddEventHandler('esx_status:onTick', function(data)
	local prevHealth = GetEntityHealth(ESX.PlayerData.ped)
	local health	 = prevHealth
	
	for k, v in pairs(data) do
		if v.name == 'hunger' and v.percent == 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		elseif v.name == 'thirst' and v.percent == 0 then
			if prevHealth <= 150 then
				health = health - 5
			else
				health = health - 1
			end
		elseif v.name == 'stress' then

			if stressWait > 0 then stressWait = stressWait - 1
			elseif v.percent >= 80 then
				stressWait = 3
				ShakeGameplayCam('VIBRATE_SHAKE', 0.50)
			elseif v.percent >= 65 then
				stressWait = 4
				ShakeGameplayCam('VIBRATE_SHAKE', 0.30)
			elseif v.percent >= 50 then
				stressWait = 5
				ShakeGameplayCam('VIBRATE_SHAKE', 0.12)
			elseif v.percent >= 35 then
				stressWait = 6
				ShakeGameplayCam('VIBRATE_SHAKE', 0.07)
			end

			if stress < 1000000 then

				if aiming < 1 and IsPlayerFreeAiming(ESX.PlayerData.ped) then
					stress = stress + 10000
					aiming = 5
				else aiming = aiming - 1 end

				if melee < 1 and IsPedInMeleeCombat(ESX.PlayerData.ped) then
					stress = stress + 5000
					melee = 5
				else melee = melee - 1 end

				if stealth < 1 and GetPedStealthMovement(ESX.PlayerData.ped) then
					stress = stress + 10000
					stealth = 8
				else stealth = stealth - 1 end

				if chute < 1 then
					if IsPedFalling(ESX.PlayerData.ped) then
						local state = GetPedParachuteState(ESX.PlayerData.ped)
						if state == 2 then
							stress = stress - 2000
						else
							local velocity = GetEntityVelocity(ESX.PlayerData.ped)
							if state == -1 then
								stress = stress + 10000*#velocity
							elseif state == 0 then
								stress = stress - 10*#velocity
							elseif state == 3 then
								stress = stress - 10000*#velocity
							end
						end
					else chute = 5 end
				else chute = chute - 1 end

			end

			if stress < 5000 and still < 1 and IsPedStill(ESX.PlayerData.ped) then
				stress = stress - 1000
				still = 5
			else still = still - 1 end

			if stress ~= 0 and v.val >= 0 then
				if stress > 0 then TriggerEvent('esx_status:add', 'stress', stress) else TriggerEvent('esx_status:remove', 'stress', -stress) end
			end
			stress = 0
		end
	end
	
	if health ~= prevHealth then SetEntityHealth(ESX.PlayerData.ped, health) end
end)
