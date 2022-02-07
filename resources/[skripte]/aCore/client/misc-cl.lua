local cucnuo = false

RegisterKeyMapping('cucni', 'cucni', 'keyboard', 'LCONTROL')

RegisterCommand('cucni', function()
    DisableControlAction(0, 36, true)

    local ped = PlayerPedId()

    RequestAnimSet( "move_ped_crouched" )

    if ( cucnuo == true ) then 
        ResetPedMovementClipset( ped, 0 )
        cucnuo = false 
    elseif ( cucnuo == false ) then
        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
        cucnuo = true 
    end 
end)
---CUCANJE----



local mp_pointing = false
local keyPressed = false

local function startPointing()
	local ped =  PlayerPedId()
	RequestAnimDict("anim@mp_point")
	while not HasAnimDictLoaded("anim@mp_point") do
		Wait(0)
	end
	SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
	SetPedConfigFlag(ped, 36, 1)
	Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
	RemoveAnimDict("anim@mp_point")
	mp_pointing = true
end

local function stopPointing()
	local ped = PlayerPedId()
	Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
	if not IsPedInjured(ped) then
		ClearPedSecondaryTask(ped)
	end
	if not IsPedInAnyVehicle(ped, 1) then
		SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
	end
	SetPedConfigFlag(ped, 36, 0)
	ClearPedSecondaryTask(PlayerPedId())
	mp_pointing = false
end

RegisterKeyMapping('pokazujprstom', 'Pokazivanje prstom', 'keyboard', 'b')
RegisterCommand("pokazujprstom", function()

	if IsPedInAnyVehicle(PlayerPedId(), false) or LocalPlayer.state.BlokirajSve or LocalPlayer.state.AnimAllowed == false then
		return
	end

	if mp_pointing then
		stopPointing()
	else
		startPointing()

		Citizen.CreateThread(function()
			while mp_pointing do
				Wait(20)
				local ped = PlayerPedId()

				if IsTaskMoveNetworkActive(ped) and not mp_pointing then
					stopPointing()
				end
				if IsTaskMoveNetworkActive(ped) then
					if not IsPedOnFoot(ped) then
						stopPointing()
					else
						local camPitch = GetGameplayCamRelativePitch()
						if camPitch < -70.0 then
							camPitch = -70.0
						elseif camPitch > 42.0 then
							camPitch = 42.0
						end
						camPitch = (camPitch + 70.0) / 112.0

						local camHeading = GetGameplayCamRelativeHeading()
						local cosCamHeading = Cos(camHeading)
						local sinCamHeading = Sin(camHeading)
						if camHeading < -180.0 then
							camHeading = -180.0
						elseif camHeading > 180.0 then
							camHeading = 180.0
						end
						camHeading = (camHeading + 180.0) / 360.0

						local blocked = 0
						local nn = 0

						local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
						local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
						nn,blocked,coords,coords = GetRaycastResult(ray)

						SetTaskMoveNetworkSignalFloat( ped, "Pitch", camPitch)
						SetTaskMoveNetworkSignalFloat( ped, "Heading", camHeading * -1.0 + 1.0)
						SetTaskMoveNetworkSignalBool( ped, "isBlocked", blocked)
						SetTaskMoveNetworkSignalBool( ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

					end
				end
			end
		end)

	end
end)

---POKAZIVANJE PRSTOM---------------
