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

local plyInVeh = false
local enableController = true               -- Enable controller inputs
local seatbeltInput = 305                    -- Toggle seatbelt on/off with K or DPAD down (controller)
local seatbeltDisableExit = true            -- Disable vehicle exit when seatbelt is enabled
local seatbeltEjectSpeed = 45.0             -- Speed threshold to eject player (MPH)
local seatbeltEjectAccel = 100.0            -- Acceleration threshold to eject player (G's)
local currSpeed = 0.0
local cruiseSpeed = 999.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
local seatbeltIsOn = false

CreateThread(function()
    while true do
        Wait(1400)	
        local ply = PlayerPedId()
        if IsPedInAnyVehicle(ply, false) then
            if not plyInVeh then
                plyInVeh = true
            end
        else
            if plyInVeh then
                plyInVeh = false
                seatbeltIsOn = false
                SendNUIMessage({action = 'vehicleReset'})
            end
        end
	end
end)


CreateThread(function()
	while true do
		Wait(105)
        local ply = PlayerPedId()
        if IsPedInAnyVehicle(ply, false) then
            local vehicle = GetVehiclePedIsIn(ply, false)
            if vehicle ~= 0 then
                local vehicleHealth = GetVehicleEngineHealth(vehicle)
                local vehicleFuel = GetVehicleFuelLevel(vehicle)
                local vehicleSpeed = math.ceil(GetEntitySpeed(vehicle) * 3.605936)
                local vehicleMaxSpeed = math.ceil(GetVehicleModelEstimatedMaxSpeed(GetEntityModel(vehicle)) * 3.605936) or 200
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
				

                local vehicleGear = GetVehicleCurrentGear(vehicle)
                if (vehicleSpeed == 0 and vehicleGear == 0) or (vehicleSpeed == 0 and vehicleGear == 1) then
                    vehicleGear = 'N'
                elseif vehicleSpeed > 0 and vehicleGear == 0 then
                    vehicleGear = 'R'
                end
            
                local vehicleVal,vehicleLights,vehicleHighlights  = GetVehicleLightsState(vehicle)
                local vehicleLight
                if vehicleLights == 1 and vehicleHighlights == 0 then
                    vehicleLight = 'normal'
                elseif (vehicleLights == 1 and vehicleHighlights == 1) or (vehicleLights == 0 and vehicleHighlights == 1) then
                    vehicleLight = 'high'
                else
                    vehicleLight = 'off'
                end
                if GetPedInVehicleSeat(vehicle,-1) == ply then 
                    local player = PlayerId()
                    DisablePlayerFiring(player, true) 
                end
                SendNUIMessage({action = 'vehicle', health = vehicleHealth, gear = vehicleGear, fuel = vehicleFuel, lights = vehicleLight, speed = vehicleSpeed, max = vehicleMaxSpeed })
            end
        end
    end
end)

CreateThread(function()
    while true do
		Wait(5)
		local ply = PlayerPedId()
		if IsPedInAnyVehicle(ply, false) then
			local plyCoords = GetEntityCoords(ply)	
            local vehicle = GetVehiclePedIsIn(ply, false)     
            local vehicleClass = GetVehicleClass(vehicle)
            if GetIsVehicleEngineRunning(vehicle) and vehicleClass ~= 13 then
                local prevSpeed = currSpeed
                currSpeed = GetEntitySpeed(vehicle)
                SetPedConfigFlag(ply, 32, true)
                if IsControlJustReleased(0, seatbeltInput) and (enableController or GetLastInputMethod(0)) and vehicleClass ~= 8 then                    
                    if seatbeltIsOn then
                        --print('vezan si')
                        TriggerEvent("bfunkcije:notif", "POJAS", "Odvezali ste se", 5, false)
                        --TriggerEvent("pNotify:SendNotification", {text = 'Odvezali ste se!', type = "success", queue = "success", timeout = 1500, layout = "center"})
                        SetTimeout(0, function()
                            SendNUIMessage({action = "belt", status = false})
                            SeatBelt = false
                            TriggerEvent("cancelando", false)
                        end)
                    elseif not seatbeltIsOn then
                        --print('nisi vezan')
                        TriggerEvent("bfunkcije:notif", "POJAS", "Vezali ste se", 5, true)
                        --TriggerEvent("pNotify:SendNotification", {text = 'Vezali ste se!', type = "success", queue = "success", timeout = 1500, layout = "center"})
                        SetTimeout(0, function()
                            SendNUIMessage({action = "belt", status = true})
                            SeatBelt = true
                            TriggerEvent("cancelando", false)
                        end)
                    end
                    seatbeltIsOn = not seatbeltIsOn
                end
                if not seatbeltIsOn then
                    local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                    local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
                    if (vehIsMovingFwd and (prevSpeed > (seatbeltEjectSpeed/2.237)) and (vehAcc > (seatbeltEjectAccel*9.81))) then
                        SetEntityCoords(ply, plyCoords.x, plyCoords.y, plyCoords.z - 0.47, true, true, true)
                        SetEntityVelocity(ply, prevVelocity.x, prevVelocity.y, prevVelocity.z)
                        Wait(1)
                        SetPedToRagdoll(ply, 1000, 1000, 0, 0, 0, 0)
                    else
                        prevVelocity = GetEntityVelocity(vehicle)
                    end
                elseif seatbeltDisableExit then
                    DisableControlAction(0, 75)
                end
            end
		end
    end
end)