
local shouldSendNUIUpdate = false
local isHudHidden = false

seatbeltOn = false
local lastCarLS_r, lastCarLS_o, lastCarLS_h
local lastCarFuelAmount, lastCarHandbreak, lastCarBrakePressure
local lastCarIL, lastCarRPM, lastCarSpeed, lastCarGear

displayKMH = 0
local nitro = 0

seat_belt = false

local function DisableVehicleExit()
	while seat_belt do
		Wait(0)
		DisableControlAction(0, 75, true)
	end
end

RegisterCommand('+pojas', function()
	local PlayerPed = PlayerPedId()
	local PlayerVehicle = GetVehiclePedIsUsing(PlayerPed)
	local VehicleClass = GetVehicleClass(PlayerVehicle)

	if IsPedInAnyVehicle(PlayerPed, false) and VehicleClass ~= 8 and VehicleClass ~= 13 and VehicleClass ~= 14 then
		seat_belt = not seat_belt

		if seat_belt then
			ESX.ShowNotification("Zavezao si pojas!")
			TriggerServerEvent('InteractSound_SV:PlayOnSource', 'carbuckle', 0.25)
		else
			ESX.ShowNotification("Odvezao si pojas!")
			TriggerServerEvent('InteractSound_SV:PlayOnSource', 'carunbuckle', 0.25)
		end

		SetPedConfigFlag(PlayerPed, 32, not seat_belt)
		TriggerEvent('seatbelt:client:ToggleSeatbelt', seat_belt)
		DisableVehicleExit()
	end
end, false)

RegisterNetEvent("hudevents:leftVehicle")
AddEventHandler('hudevents:leftVehicle', function()
	isInVehicle = false

	if not isHudHidden then
		isHudHidden = true

		SendNUIMessage({
			HideHud = isHudHidden
		})
	end
end)

RegisterNetEvent("hudevents:enteredVehicle")
AddEventHandler('hudevents:enteredVehicle', function(currentVehicle, currentSeat, vehicle_name, net_id)

	isInVehicle = true
	SetPedConfigFlag(PlayerPedId(), 32, true)
	seat_belt = false

	if isHudHidden then
		isHudHidden = false
		SendNUIMessage({
			HideHud = isHudHidden
		})
	end

	while isInVehicle do
		Wait(50)	

		local PlayerPed = PlayerPedId()
		
		if not isHudHidden then
			if IsVehicleEngineOn(currentVehicle) then
				local carRPM = GetVehicleCurrentRpm(currentVehicle)			
				
				local multiplierUnit = 2.8

				if Config.Unit == "KMH" then
					multiplierUnit = 3.6
				end

				local carSpeed = math.floor(GetEntitySpeed(currentVehicle) * multiplierUnit)
				local carGear = GetVehicleCurrentGear(currentVehicle)
				local carHandbrake = GetVehicleHandbrake(currentVehicle)
				local carBrakePressure = GetVehicleWheelBrakePressure(currentVehicle, 0)
				local fuelamount = GetVehicleFuelLevel(currentVehicle) or 0

				shouldSendNUIUpdate = false

				if lastCarRPM ~= carRPM then lastCarRPM = carRPM shouldSendNUIUpdate = true end
				if lastCarSpeed ~= carSpeed then lastCarSpeed = carSpeed shouldSendNUIUpdate = true end
				if lastCarGear ~= carGear then lastCarGear = carGear shouldSendNUIUpdate = true end
				if lastCarHandbreak ~= carHandbrake then lastCarHandbreak = carHandbrake shouldSendNUIUpdate = true end
				if lastCarBrakePressure ~= carBrakePressure then lastCarBrakePressure = carBrakePressure shouldSendNUIUpdate = true end

				if lastCarFuelAmount ~= fuelamount then lastCarFuelAmount = fuelamount shouldSendNUIUpdate = true end

				if shouldSendNUIUpdate then
					SendNUIMessage({
						ShowHud = true,
						CurrentCarRPM = carRPM * 10,
						CurrentUnitDistance = Config.Unit,
						CurrentCarGear = carGear,
						CurrentCarSpeed = carSpeed,
						CurrentCarHandbrake = carHandbrake,
						CurrentCarFuelAmount = math.ceil(fuelamount),
						CurrentDisplayKMH = displayKMH,
						CurrentCarBrake = carBrakePressure,
						CurrentNitro = nitro,						
						seatbelt = seatbeltOn
					})		
				end
			end
		end
	end
end)


CreateThread(function()	
	SetFlyThroughWindscreenParams(20.0, 0.0, 0.0, 15.0)

	while true do
		Wait(500)

		if not isHudHidden then
			if not Config.ShowStreetName then
				HideHudComponentThisFrame(9)
				HideHudComponentThisFrame(7)
			end

			if not Config.ShowClassVehicleName then
				HideHudComponentThisFrame(6)
				HideHudComponentThisFrame(8)
			end
			Wait(1)
		end
				
	end
end)


local function GetPedVehicleSeat(entity)
    local Vehicle = GetVehiclePedIsIn(entity, false)

	for i= -2, GetVehicleMaxNumberOfPassengers(Vehicle) do
        if GetPedInVehicleSeat(Vehicle, i) == entity then
			return i
		end
    end

	return -2
end

AddEventHandler('onResourceStart', function()
	local PlayerPed = PlayerPedId()

	if IsPedInAnyVehicle(PlayerPed, false) then
		local currentVehicle = GetVehiclePedIsUsing(PlayerPed)
		local currentSeat = GetPedVehicleSeat(PlayerPed)
		local netID = VehToNet(currentVehicle)

		TriggerEvent('hudevents:enteredVehicle', currentVehicle, currentSeat, GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle)), netID)

		cruiser = true
		ExecuteCommand('cruiser')
	end
end)