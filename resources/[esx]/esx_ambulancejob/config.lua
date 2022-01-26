Config                            = {}

Config.DrawDistance               = 20.0

Config.MarkerAuto                 = { x = 3.0, y = 3.0, z = 3.0 }

Config.Marker                     = { type = 22, x = 1.5, y = 1.5, z = 0.5, r = 0, g = 255, b = 0, a = 100, rotate = false }

Config.ReviveReward               = 200  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale = 'en'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 5 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 15 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 500

Config.RespawnPoint = { coords = vector3(355.69, -596.26, 28.28), heading = 249.56 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(310.11, -591.44, 43.29),
			sprite = 61,
			scale  = 0.9,
			color  = 2
		},

		AmbulanceActions = {
			vector3(305.01,-600.4,43.28)
		},

		Pharmacies = {
			vector3(311.37, -597.04, 43.28)
		},

		ParkirajAuto = {
			-- Bolnica
			vector3(285.81,-613.48,43.35),
		},

		-- Vehicles = {
		-- 	{
		-- 		Spawner = vector3(340.31, -562.31, 28.15),
		-- 		InsideShop = vector3(323.86, -549.07, 27.84),
		-- 		Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 0, g = 255, b = 0, a = 100, rotate = true },
		-- 		SpawnPoints = {
		-- 			{ coords = vector3(323.86, -549.07, 27.84), heading = 262.99, radius = 4.0 },
		-- 			{ coords = vector3(323.73, -543.03, 27.84), heading = 262.99, radius = 4.0 },
		-- 			{ coords = vector3(323.74, -554.35, 27.84), heading = 254.60, radius = 6.0 }
		-- 		}
		-- 	}
		-- },

		-- Helicopters = {
		-- 	{
		-- 		Spawner = vector3(348.53, -593.13, 73.67),
		-- 		InsideShop = vector3(351.60, -588.02, 73.27),
		-- 		Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 0, g = 255, b = 0, a = 100, rotate = true },
		-- 		SpawnPoints = {
		-- 			{ coords = vector3(351.60, -588.02, 73.27), heading = 241.68, radius = 10.0 },
		-- 			{ coords = vector3(349.33, -594.35, 73.27), heading = 142.7, radius = 10.0 }
		-- 		}
		-- 	}
		-- },

		-- FastTravels = {
		-- 	{
		-- 		From = vector3(330.44, -601.14, 42.38),
		-- 		To = { coords = vector3(341.13, -584.47, 73.27), heading = 250.85 },
		-- 		Marker = { type = 27, x = 2.0, y = 2.0, z = 0.5, r = 0, g = 255, b = 0, a = 100, rotate = false }
		-- 	},

		-- 	{
		-- 		From = vector3(338.60, -583.77, 73.27),
		-- 		To = { coords = vector3(332.23, -595.62, 42.38), heading = 73.06 },
		-- 		Marker = { type = 27, x = 2.0, y = 2.0, z = 0.5, r = 0, g = 255, b = 0, a = 100, rotate = false }
		-- 	},

		-- 	{
		-- 		From = vector3(294.7, -1448.1, 29.0),
		-- 		To = { coords = vector3(272.8, -1358.8, 23.5), heading = 0.0 },
		-- 		Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
		-- 	},

		-- 	{
		-- 		From = vector3(275.3, -1361, 23.5),
		-- 		To = { coords = vector3(295.8, -1446.5, 28.9), heading = 0.0 },
		-- 		Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
		-- 	},

		-- 	{
		-- 		From = vector3(247.3, -1371.5, 23.5),
		-- 		To = { coords = vector3(333.1, -1434.9, 45.5), heading = 138.6 },
		-- 		Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
		-- 	},

		-- 	{
		-- 		From = vector3(335.5, -1432.0, 45.50),
		-- 		To = { coords = vector3(249.1, -1369.6, 23.5), heading = 0.0 },
		-- 		Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
		-- 	},

		-- 	{
		-- 		From = vector3(234.5, -1373.7, 20.9),
		-- 		To = { coords = vector3(320.9, -1478.6, 28.8), heading = 0.0 },
		-- 		Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
		-- 	},

		-- 	{
		-- 		From = vector3(317.9, -1476.1, 28.9),
		-- 		To = { coords = vector3(238.6, -1368.4, 23.5), heading = 0.0 },
		-- 		Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
		-- 	}
		-- },

		-- FastTravelsPrompt = {
		-- 	{
		-- 		From = vector3(237.4, -1373.8, 26.0),
		-- 		To = { coords = vector3(251.9, -1363.3, 38.5), heading = 0.0 },
		-- 		Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
		-- 		Prompt = _U('fast_travel')
		-- 	},

		-- 	{
		-- 		From = vector3(256.5, -1357.7, 36.0),
		-- 		To = { coords = vector3(235.4, -1372.8, 26.3), heading = 0.0 },
		-- 		Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
		-- 		Prompt = _U('fast_travel')
		-- 	}
		-- }

	}
}

-- Config.AuthorizedVehicles = {

-- 	ambulance = {
-- 		{ model = 'ambulanceems', label = 'Ambulance', price = 1}
-- 	},

-- 	doctor = {
-- 		{ model = 'ambulanceems', label = 'Ambulance', price = 1},
-- 		{ model = 'dodgeems', label = 'Paramedic Dodge Charger', price = 1}
-- 	},

-- 	chief_doctor = {
-- 		{ model = 'ambulanceems', label = 'Ambulance', price = 1},
-- 		{ model = 'dodgeems', label = 'Paramedic Dodge Charger', price = 1}
-- 	},

-- 	boss = {
-- 		{ model = 'ambulanceems', label = 'Ambulance', price = 1},
-- 		{ model = 'dodgeems', label = 'Paramedic Dodge Charger', price = 1}
-- 	}

-- }

-- Config.AuthorizedHelicopters = {

-- 	ambulance = {},

-- 	doctor = {},

-- 	chief_doctor = {
-- 		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 1 }
-- 	},

-- 	boss = {
-- 		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 1 },
-- 		{ model = 'seasparrow', label = 'Sea Sparrow', price = 1 }
-- 	}

-- }
