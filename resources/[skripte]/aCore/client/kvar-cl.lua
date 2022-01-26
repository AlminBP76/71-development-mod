local pedInSameVehicleLast=false
local vehicle
local lastVehicle
local vehicleClass
local fCollisionDamageMult = 0.0
local fDeformationDamageMult = 0.0
local fEngineDamageMult = 0.0
local fBrakeForce = 1.0
local isBrakingForward = false
local isBrakingReverse = false
local healthEngineLast = 1000.0
local healthEngineCurrent = 1000.0
local healthEngineNew = 1000.0
local healthEngineDelta = 0.0
local healthEngineDeltaScaled = 0.0
local healthBodyLast = 1000.0
local healthBodyCurrent = 1000.0
local healthBodyNew = 1000.0
local healthBodyDelta = 0.0
local healthBodyDeltaScaled = 0.0
local healthPetrolTankLast = 1000.0
local healthPetrolTankCurrent = 1000.0
local healthPetrolTankNew = 1000.0
local healthPetrolTankDelta = 0.0
local healthPetrolTankDeltaScaled = 0.0
local tireBurstLuckyNumber
local repairCost = 0
local Wait = Wait
local stalled = false
local oldBodyDamage = 0

math.randomseed(GetGameTimer());

local tireBurstMaxNumber = cfg.randomTireBurstInterval * 1200; 												-- the tire burst lottery runs roughly 1200 times per minute
if cfg.randomTireBurstInterval ~= 0 then tireBurstLuckyNumber = math.random(tireBurstMaxNumber) end			-- If we hit this number again randomly, a tire will burst.

local function isPedDrivingAVehicle()
	local ped = PlayerPedId()
	vehicle = GetVehiclePedIsIn(ped, false)
	if IsPedInAnyVehicle(ped, false) then
		if GetPedInVehicleSeat(vehicle, -1) == ped then
			local class = GetVehicleClass(vehicle)
			if class ~= 15 and class ~= 16 and class ~=21 and class ~=13 then
				return true
			end
		end
	end
	return false
end

local function fscale(inputValue, originalMin, originalMax, newBegin, newEnd, curve)
	local OriginalRange = 0.0
	local NewRange = 0.0
	local zeroRefCurVal = 0.0
	local normalizedCurVal = 0.0
	local rangedValue = 0.0
	local invFlag = 0

	if (curve > 10.0) then curve = 10.0 end
	if (curve < -10.0) then curve = -10.0 end

	curve = (curve * -.1)
	curve = 10.0 ^ curve

	if (inputValue < originalMin) then
	  inputValue = originalMin
	end
	if inputValue > originalMax then
	  inputValue = originalMax
	end

	OriginalRange = originalMax - originalMin

	if (newEnd > newBegin) then
		NewRange = newEnd - newBegin
	else
	  NewRange = newBegin - newEnd
	  invFlag = 1
	end

	zeroRefCurVal = inputValue - originalMin
	normalizedCurVal  =  zeroRefCurVal / OriginalRange

	if (originalMin > originalMax ) then
	  return 0
	end

	if (invFlag == 0) then
		rangedValue =  ((normalizedCurVal ^ curve) * NewRange) + newBegin
	else
		rangedValue =  newBegin - ((normalizedCurVal ^ curve) * NewRange)
	end

	return rangedValue
end

if cfg.torqueMultiplierEnabled or cfg.preventVehicleFlip or cfg.limpMode then
	CreateThread(function()
		while true do
			Wait(7)
			if cfg.torqueMultiplierEnabled or cfg.sundayDriver or cfg.limpMode then
				if pedInSameVehicleLast then
					local factor = 1.0
					if cfg.torqueMultiplierEnabled and healthEngineNew < 900 then
						factor = (healthEngineNew+200.0) / 1100
					end
					if cfg.sundayDriver and GetVehicleClass(vehicle) ~= 14 then -- Not for boats
						local accelerator = GetControlValue(2,71)
						local brake = GetControlValue(2,72)
						local speed = GetEntitySpeedVector(vehicle, true)['y']
						local brk = fBrakeForce
						if speed >= 1.0 then
							if accelerator > 127 then
								local acc = fscale(accelerator, 127.0, 254.0, 0.1, 1.0, 10.0-(cfg.sundayDriverAcceleratorCurve*2.0))
								factor = factor * acc
							end
							if brake > 127 then
								isBrakingForward = true
								brk = fscale(brake, 127.0, 254.0, 0.01, fBrakeForce, 10.0-(cfg.sundayDriverBrakeCurve*2.0))
							end
						elseif speed <= -1.0 then
							if brake > 127 then
								local rev = fscale(brake, 127.0, 254.0, 0.1, 1.0, 10.0-(cfg.sundayDriverAcceleratorCurve*2.0))
								factor = factor * rev
							end
							if accelerator > 127 then
								isBrakingReverse = true
								brk = fscale(accelerator, 127.0, 254.0, 0.01, fBrakeForce, 10.0-(cfg.sundayDriverBrakeCurve*2.0))
							end
						else
							local entitySpeed = GetEntitySpeed(vehicle)
							if entitySpeed < 1 then
								if isBrakingForward == true then
									DisableControlAction(2,72,true) -- Disable Brake until user lets go of brake
									SetVehicleForwardSpeed(vehicle,speed*0.98)
									SetVehicleBrakeLights(vehicle,true)
								end
								if isBrakingReverse == true then
									DisableControlAction(2,71,true) -- Disable reverse Brake until user lets go of reverse brake (Accelerator)
									SetVehicleForwardSpeed(vehicle,speed*0.98)
									SetVehicleBrakeLights(vehicle,true)
								end
								if isBrakingForward == true and GetDisabledControlNormal(2,72) == 0 then
									isBrakingForward=false
								end
								if isBrakingReverse == true and GetDisabledControlNormal(2,71) == 0 then
									isBrakingReverse=false
								end
							end
						end
						if brk > fBrakeForce - 0.02 then brk = fBrakeForce end -- Make sure we can brake max.
						SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce', brk)  -- Set new Brake Force multiplier
					end
					if cfg.limpMode == true and healthEngineNew < cfg.engineSafeGuard + 5 then
						factor = cfg.limpModeMultiplier
					end
					SetVehicleEngineTorqueMultiplier(vehicle, factor)
				end
			end
			if cfg.preventVehicleFlip then
				local roll = GetEntityRoll(vehicle)
				if (roll > 70.0 or roll < -70.0) and GetEntitySpeed(vehicle) < 5 and not IsThisModelABike(vehicle) and not IsThisModelABoat(vehicle) and not IsThisModelAPlane(vehicle) then
					DisableControlAction(0,59,true) -- Disable left/right
					DisableControlAction(0,60,true) -- Disable up/down
				end
			end
		end
	end)
end

CreateThread(function()
	while true do
		Wait(50)
		local stalled = false
		local ped = PlayerPedId()
		if isPedDrivingAVehicle() then
			vehicle = GetVehiclePedIsIn(ped, false)
			vehicleClass = GetVehicleClass(vehicle)
			healthEngineCurrent = GetVehicleEngineHealth(vehicle)
			if healthEngineCurrent >= 1000 then
				SetVehicleEngineHealth(vehicle, 1000.00)
				healthEngineLast = 1000.0
			end

			healthEngineNew = healthEngineCurrent
			healthEngineDelta = healthEngineLast - healthEngineCurrent
			healthEngineDeltaScaled = healthEngineDelta * cfg.damageFactorEngine * cfg.classDamageMultiplier[vehicleClass]

			healthBodyCurrent = GetVehicleBodyHealth(vehicle)
			if healthBodyCurrent > 1000 then
				SetVehicleBodyHealth(vehicle, 1000.00)
				healthBodyLast = 1000.0 
			end
			healthBodyNew = healthBodyCurrent
			healthBodyDelta = healthBodyLast - healthBodyCurrent
			healthBodyDeltaScaled = healthBodyDelta * cfg.damageFactorBody * cfg.classDamageMultiplier[vehicleClass]

			healthPetrolTankCurrent = GetVehiclePetrolTankHealth(vehicle)
			if cfg.compatibilityMode and healthPetrolTankCurrent < 1 then
				--	SetVehiclePetrolTankHealth(vehicle, healthPetrolTankLast)
				--	healthPetrolTankCurrent = healthPetrolTankLast
				healthPetrolTankLast = healthPetrolTankCurrent
			end
			if healthPetrolTankCurrent >= 1000 then
				healthPetrolTankLast = 1000.0 
			end
			healthPetrolTankNew = healthPetrolTankCurrent
			healthPetrolTankDelta = healthPetrolTankLast-healthPetrolTankCurrent
			healthPetrolTankDeltaScaled = healthPetrolTankDelta * cfg.damageFactorPetrolTank * cfg.classDamageMultiplier[vehicleClass]

			if healthEngineCurrent > cfg.engineSafeGuard+1 then
				SetVehicleUndriveable(vehicle,false)
				stalled = false
			end
			if healthEngineCurrent <= cfg.engineSafeGuard+1 and cfg.limpMode == false then
				SetVehicleUndriveable(vehicle,true)
				stalled = true
			end
			if vehicle ~= lastVehicle then
				pedInSameVehicleLast = false
			end

			if pedInSameVehicleLast == true then
				if healthEngineCurrent ~= 1000.0 or healthBodyCurrent ~= 1000.0 or healthPetrolTankCurrent ~= 1000.0 then
					local healthEngineCombinedDelta = math.max(healthEngineDeltaScaled, healthBodyDeltaScaled, healthPetrolTankDeltaScaled)
					if healthEngineCombinedDelta > (healthEngineCurrent - cfg.engineSafeGuard) then	healthEngineCombinedDelta = healthEngineCombinedDelta * 0.7	end
					if healthEngineCombinedDelta > healthEngineCurrent then	healthEngineCombinedDelta = healthEngineCurrent - (cfg.cascadingFailureThreshold / 5)	end	healthEngineNew = healthEngineLast - healthEngineCombinedDelta
					if healthEngineNew > (cfg.cascadingFailureThreshold + 5) and healthEngineNew < cfg.degradingFailureThreshold then	healthEngineNew = healthEngineNew-(0.038 * cfg.degradingHealthSpeedFactor)	end
					if healthEngineNew < cfg.cascadingFailureThreshold then	healthEngineNew = healthEngineNew-(0.1 * cfg.cascadingFailureSpeedFactor)	end
					if healthEngineNew < cfg.engineSafeGuard then	healthEngineNew = cfg.engineSafeGuard	end
					if cfg.compatibilityMode == false and healthPetrolTankCurrent < 750 then	healthPetrolTankNew = 750.0	end
					if healthBodyNew < 0  then	healthBodyNew = 0.0	end
				end
			else
				fDeformationDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult')
				fBrakeForce = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce')
				local newFDeformationDamageMult = fDeformationDamageMult ^ cfg.deformationExponent	-- Pull the handling file value closer to 1
				if cfg.deformationMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult', newFDeformationDamageMult * cfg.deformationMultiplier) end  -- Multiply by our factor
				if cfg.weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fWeaponDamageMult', cfg.weaponsDamageMultiplier/cfg.damageFactorBody) end -- Set weaponsDamageMultiplier and compensate for damageFactorBody

				fCollisionDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fCollisionDamageMult')

				local newFCollisionDamageMultiplier = fCollisionDamageMult ^ cfg.collisionDamageExponent	-- Pull the handling file value closer to 1
				SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fCollisionDamageMult', newFCollisionDamageMultiplier)

				fEngineDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fEngineDamageMult')
				local newFEngineDamageMult = fEngineDamageMult ^ cfg.engineDamageExponent	-- Pull the handling file value closer to 1
				SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fEngineDamageMult', newFEngineDamageMult)

				if healthBodyCurrent < cfg.cascadingFailureThreshold then
					healthBodyNew = cfg.cascadingFailureThreshold
				end
				pedInSameVehicleLast = true
			end
			-- set the actual new values
			if healthEngineNew ~= healthEngineCurrent then
				SetVehicleEngineHealth(vehicle, healthEngineNew)
			end
			if healthBodyNew ~= healthBodyCurrent then SetVehicleBodyHealth(vehicle, healthBodyNew) end
			if healthPetrolTankNew ~= healthPetrolTankCurrent then SetVehiclePetrolTankHealth(vehicle, healthPetrolTankNew) end
			healthEngineLast = healthEngineNew
			healthBodyLast = healthBodyNew
			healthPetrolTankLast = healthPetrolTankNew
			lastVehicle=vehicle
			if cfg.randomTireBurstInterval ~= 0 and GetEntitySpeed(vehicle) > 10 then tireBurstLottery() end
		else
			if pedInSameVehicleLast == true then
				-- We just got out of the vehicle
				lastVehicle = GetVehiclePedIsIn(ped, true)				
				if cfg.deformationMultiplier ~= -1 then SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fDeformationDamageMult', fDeformationDamageMult) end -- Restore deformation multiplier
					SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fBrakeForce', fBrakeForce)  -- Restore Brake Force multiplier
				if cfg.weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fWeaponDamageMult', cfg.weaponsDamageMultiplier) end	-- Since we are out of the vehicle, we should no longer compensate for bodyDamageFactor
					SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fCollisionDamageMult', fCollisionDamageMult) -- Restore the original CollisionDamageMultiplier
					SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fEngineDamageMult', fEngineDamageMult) -- Restore the original EngineDamageMultiplier
			end
			pedInSameVehicleLast = false
		end
	end
end)

CreateThread(function()
    while true do
        Wait(50)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        if isPedDrivingAVehicle() and DoesEntityExist(vehicle) then 
            local currentDamage = GetVehicleBodyHealth(vehicle) 
            if currentDamage ~= oldBodyDamage then
				local speed = GetEntitySpeed(vehicle) * 2.236963
                if not stalled and (currentDamage < oldBodyDamage) and ((oldBodyDamage - currentDamage) >= cfg.StallDamageRequired) then 
                    if(math.random(1,100) < cfg.StallChance) then 
                        stalled = true
						SetVehicleEngineOn(vehicle,false,true,true)
						ApplyDamageToPed(ped,math.random(1,50),false)
						Wait(50)
                    end 
                end 
                oldBodyDamage = currentDamage
            end 
        else 
            oldBodyDamage = 0
        end 

        if stalled and isPedDrivingAVehicle() then
			Wait(5)
            -- what happens when we're stalled?
			SetVehicleEngineOn(vehicle,false,false,true)
			SetVehicleUndriveable(vehicle, true)
			SetVehicleAudioBodyDamageFactor(vehicle, 0.5)
            TriggerEvent("bfunkcije:notif", "INFO", "Vase vozilo je u kurcu", 5, false)
            local unstall = exports["skillbar"]:taskBar(1500,math.random(2,5))
            if unstall ~= 100 or not isPedDrivingAVehicle() then
				stalled = true
                Wait(math.random(1000,5000))
				SetVehicleEngineOn(vehicle,false,true,false)
			end 
			stalled = false
			if GetPedInVehicleSeat(vehicle, -1) == ped then
				SetVehicleUndriveable(vehicle, false)
				SetVehicleEngineOn(vehicle,true,true,true)
				TriggerEvent("bfunkcije:notif", "INFO", "Uspio si upaliti vozilo", 5, true)
			end
        end 
    end 
end)
