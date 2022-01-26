
konfig = {}
cfg = {
	deformationMultiplier = 1.0,				-- How much should the vehicle visually deform from a collision. Range 0.0 to 10.0 Where 0.0 is no deformation and 10.0 is 10x deformation. -1 = Don't touch. Visual damage does not sync well to other players.
	deformationExponent = 1.0,					-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	collisionDamageExponent = 0.8,				-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	damageFactorEngine = 1.7,					-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
	damageFactorBody = 4.8,						-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
	damageFactorPetrolTank = 6.8,				-- Sane values are 1 to 200. Higher values means more damage to vehicle. A good starting point is 64
	engineDamageExponent = 0.6,					-- How much should the handling file engine damage setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	weaponsDamageMultiplier = 0.15,				-- How much damage should the vehicle get from weapons fire. Range 0.0 to 10.0, where 0.0 is no damage and 10.0 is 10x damage. -1 = don't touch
	degradingHealthSpeedFactor = 1.5,			-- Speed of slowly degrading health, but not failure. Value of 10 means that it will take about 0.25 second per health point, so degradation from 800 to 305 will take about 2 minutes of clean driving. Higher values means faster degradation
	cascadingFailureSpeedFactor = 2.5,			-- Sane values are 1 to 100. When vehicle health drops below a certain point, cascading failure sets in, and the health drops rapidly until the vehicle dies. Higher values means faster failure. A good starting point is 8
	degradingFailureThreshold = 250.0,			-- Below this value, slow health degradation will set in
	cascadingFailureThreshold = 200.0,			-- Below this value, health cascading failure will set in
	engineSafeGuard = 120.0,					-- Final failure value. Set it too high, and the vehicle won't smoke when disabled. Set too low, and the car will catch fire from a single bullet to the engine. At health 100 a typical car can take 3-4 bullets to the engine before catching fire.
	torqueMultiplierEnabled = true,				-- Decrease engine torque as engine gets more and more damaged
	limpMode = false,							-- If true, the engine never fails completely, so you will always be able to get to a mechanic unless you flip your vehicle and preventVehicleFlip is set to true
	limpModeMultiplier = 0.20,					-- The torque multiplier to use when vehicle is limping. Sane values are 0.05 to 0.25
	preventVehicleFlip = true,					-- If true, you can't turn over an upside down vehicle
	sundayDriver = false,						-- If true, the accelerator response is scaled to enable easy slow driving. Will not prevent full throttle. Does not work with binary accelerators like a keyboard. Set to false to disable. The included stop-without-reversing and brake-light-hold feature does also work for keyboards.
	sundayDriverAcceleratorCurve = 7.5,			-- The response curve to apply to the accelerator. Range 0.0 to 10.0. Higher values enables easier slow driving, meaning more pressure on the throttle is required to accelerate forward. Does nothing for keyboard drivers
	sundayDriverBrakeCurve = 5.0,				-- The response curve to apply to the Brake. Range 0.0 to 10.0. Higher values enables easier braking, meaning more pressure on the throttle is required to brake hard. Does nothing for keyboard drivers
	displayBlips = false,						-- Show blips for mechanics locations
	compatibilityMode = true,					-- prevents other scripts from modifying the fuel tank health to avoid random engine failure with BVA 2.01 (Downside is it disabled explosion prevention)
	randomTireBurstInterval = 0,				-- Number of minutes (statistically, not precisely) to drive above 22 mph before you get a tire puncture. 0=feature is disabled
	chargeForRepairs = false,					-- if true fixing vehicle cost money
	price = 100.0,								-- you may edit this to your liking. if "chargeForRepairs = false" ignore this one
	DamageMultiplier = 5.0,
	StallChance = 80,
	StallDamageRequired = 25,
	StallMinWaitTime = 1000,
	StallMaxWaitTime = 5000,

	classDamageMultiplier = {
	[0] = 	1.0,		--	0: Compacts
			1.0,		--	1: Sedans
			1.0,		--	2: SUVs
			1.0,		--	3: Coupes
			1.0,		--	4: Muscle
			1.0,		--	5: Sports Classics
			1.0,		--	6: Sports
			1.2,		--	7: Super
			1.6,		--	8: Motorcycles
			0.7,		--	9: Off-road
			0.2,		--	10: Industrial
			1.0,		--	11: Utility
			1.0,		--	12: Vans
			1.0,		--	13: Cycles
			1.2,		--	14: Boats
			0.7,		--	15: Helicopters
			0.7,		--	16: Planes
			0.8,		--	17: Service
			0.5,		--	18: Emergency
			0.6,		--	19: Military
			1.0,		--	20: Commercial
			1.0			--	21: Trains
	}
}

konfig.Lokacija = vector3(234.7181, 222.0505, 110.2828)

konfig.RataKredita = 5000