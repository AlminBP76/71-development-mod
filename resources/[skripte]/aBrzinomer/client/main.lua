local ESX	 = nil

-- ESX
CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	SendNUIMessage({ action = 'toggleUi', value = true })
end)

local status = false
local showMovie = false
local map = false
CreateThread(function()
	while true do
	Wait(250)
		local ped = GetPlayerPed(-1)		
		SendNUIMessage({
            action = 'player',
            health = (GetEntityHealth(ped)-100),
						armor = GetPedArmour(ped),
						movie = showMovie
				})
			if IsPedInAnyVehicle(ped, false) then 
					map = true 
			else 
					map = true    ---- true if you want have map outside
			end
		end
end)

RegisterCommand("movie",function(source,args)
	showMovie = not showMovie
end)

 CreateThread(function()
	 while true do
		 Wait(250)
		 SendNUIMessage({action = 'pause', status = status})
    end
end)