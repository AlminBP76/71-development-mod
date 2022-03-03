local vehiclemeters = -1
local previousvehiclepos = nil
local CheckDone = false
DrivingDistance = {}

Citizen.CreateThread(function()
    Wait(500)
    while true do
        local ped = PlayerPedId()
        local invehicle = IsPedInAnyVehicle(ped, true)
        if invehicle then
            local veh = GetVehiclePedIsIn(ped)
            local seat = GetPedInVehicleSeat(veh, -1)
            local pos = GetEntityCoords(ped)
            local vehclass = GetVehicleClass(GetVehiclePedIsIn(ped))
            local plate = GetVehicleNumberPlateText(veh)

            if plate ~= nil then
                if seat == ped then
                    if not CheckDone then
                        if vehiclemeters == -1 then
                            CheckDone = true
                           -- Core.Functions.TriggerCallback('vehicletuning:server:IsVehicleOwned', function(IsOwned)
                                if false then
                                    if DrivingDistance[plate] ~= nil then
                                        vehiclemeters = DrivingDistance[plate]
                                    else
                                        DrivingDistance[plate] = 0
                                        vehiclemeters = DrivingDistance[plate]
                                    end
                                else
                                    if DrivingDistance[plate] ~= nil then
                                        vehiclemeters = DrivingDistance[plate]
                                    else
                                        DrivingDistance[plate] = math.random(111111, 999999)
                                        vehiclemeters = DrivingDistance[plate]
                                    end
                                end
                           --[[ end , plate)]]
                        end
                    end
                else
                    if vehiclemeters == -1 then
                        if DrivingDistance[plate] ~= nil then
                            vehiclemeters = DrivingDistance[plate]
                        end
                    end
                end

                if vehiclemeters ~= -1 then
                    if seat == ped then
                        if previousvehiclepos ~= nil then
                            local Distance = GetDistanceBetweenCoords(pos, previousvehiclepos, true)

                            vehiclemeters = vehiclemeters + ((Distance / 100) * 325)
                            DrivingDistance[plate] = vehiclemeters
                           
                            local amount = round(DrivingDistance[plate] / 2500, -2)
                            TriggerEvent('hud:client:UpdateDrivingMeters', true, amount)
                        end
                    else
                        if invehicle then
                            if DrivingDistance[plate] ~= nil then
                                local amount = round(DrivingDistance[plate] / 2500, -2)
                                TriggerEvent('hud:client:UpdateDrivingMeters', true, amount)
                            end
                        else
                            if vehiclemeters ~= -1 then
                                vehiclemeters = -1
                            end
                            if CheckDone then
                                CheckDone = false
                            end
                        end
                    end
                end

                previousvehiclepos = pos
            end
        else
            if vehiclemeters ~= -1 then
                vehiclemeters = -1
            end
            if CheckDone then
                CheckDone = false
            end
            if previousvehiclepos ~= nil then
                previousvehiclepos = nil
            end
        end

        if invehicle then
            Citizen.Wait(2000)
        else
            Citizen.Wait(500)
        end
    end
end)


Citizen.CreateThread(function()
    while true do               
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
        local seat = GetPedInVehicleSeat(veh, -1)
        local plate = GetVehicleNumberPlateText(veh)
        if seat then
            if DrivingDistance[plate] ~= nil then
                local amount = round(DrivingDistance[plate] / 2500, -2)
                TriggerEvent('hud:client:UpdateDrivingMeters', true, amount)
            --  TriggerServerEvent('vehicletuning:server:UpdateDrivingDistance', DrivingDistance[plate], plate)
            end
        end        
        Wait(30000)
    end
end)


RegisterNetEvent('hud:client:UpdateDrivingMeters')
AddEventHandler('hud:client:UpdateDrivingMeters', function(toggle, amount)
	displayKMH = amount
end)

RegisterNetEvent("seatbelt:client:ToggleSeatbelt")
AddEventHandler("seatbelt:client:ToggleSeatbelt", function(toggle)
    if toggle == nil then
        seatbeltOn = not seatbeltOn
    else
        seatbeltOn = toggle    
    end
end)


RegisterNetEvent('sendNosVehicle')
AddEventHandler('sendNosVehicle', function(result)
	nitro = result
end)


function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces>0 then
      local mult = 10^numDecimalPlaces
      return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end

function GetDamageMultiplier(meters)
    local check = round(meters / 1000, -2)
    local retval = nil
    for k, v in pairs(Config.MinimalMetersForDamage) do
        if check >= v.min and check <= v.max then
            retval = k
            break
        elseif check >= Config.MinimalMetersForDamage[#Config.MinimalMetersForDamage].min then
            retval = #Config.MinimalMetersForDamage
            break
        end
    end
    return retval
end