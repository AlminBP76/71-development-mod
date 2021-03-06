Config                            = {}

Config.DrawDistance               = 15.0 -- How close do you need to be in order for the markers to be drawn (in GTA units).

Config.Marker                     = {type = 21, x = 1.0, y = 1.0, z = 0.3, r = 102, g = 0, b = 102, a = 100, rotate = true}

Config.ReviveReward               = 700  -- Revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- Enable anti-combat logging? (Removes Items when a player logs back after intentionally logging out while dead.)
Config.LoadIpl                    = false -- Disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

Config.EarlyRespawnTimer          = 60000 * 1  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 10 -- time til the player bleeds out

Config.EnablePlayerManagement     = true -- Enable society managing (If you are using esx_society).

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 100

Config.WebHuk = ""

Config.RespawnPoint = {coords = vector3(341.0, -1397.3, 32.5), heading = 48.5}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(292.3558, -586.935, 43.192),
			sprite = 61,
			scale  = 1.0,
			color  = 2
		},

		AmbulanceActions = {
			vector3(298.5574, -598.491, 43.283)
		},

		Pharmacies = {
			vector3(310.1578, -568.406, 43.284)
		},

		Vehicles = {
			{
				Spawner = vector3(299.1848, -576.540, 43.259),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(291.7774, -587.624, 43.187), heading = 54.57, radius = 4.0},
					{coords = vector3(291.7774, -587.624, 43.187), heading = 54.57, radius = 4.0},
					{coords = vector3(291.7774, -587.624, 43.187), heading = 54.57, radius = 6.0}
				}
			}
		},

		Helikopteri = {
			{
			    Spawner = vector3(307.56,-1457.56,46.51),
			    SpawnPoints = {
                    { coords = vector3(351.78,-587.96,74.17), heading = 35.5, radius = 1.5 },
                    { coords = vector3(351.78,-587.96,74.17), heading = 35.5, radius = 1.5 }
			    }
			}
		},

		ParkirajAuto = {
			vector3(295.7588, -604.997, 43.316),
		},
		
		ParkirajHeli = {
			vector3(299.32,-1453.68,46.0), 
		},

		FastTravels = {
			{
				From = vector3(294.7, -1448.1, 29.0),
				To = {coords = vector3(272.8, -1358.8, 23.5), heading = 0.0},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(275.3, -1361, 23.5),
				To = {coords = vector3(295.8, -1446.5, 28.9), heading = 0.0},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(234.5, -1373.7, 20.9),
				To = {coords = vector3(320.9, -1478.6, 28.8), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(317.9, -1476.1, 28.9),
				To = {coords = vector3(238.6, -1368.4, 23.5), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(308.85,-1434.76,30.0),
				To = {coords = vector3(335.44,-1434.37,46.51), heading = 140.77},
				Marker = {type = 34, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true}
			},

			{
				From = vector3(335.44,-1432.37,45.51),
				To = {coords = vector3(311.61,-1437.43,30.0), heading = 146.99},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			
		},

		FastTravelsPrompt = {
			{
				From = vector3(237.4, -1373.8, 26.0),
				To = {coords = vector3(251.9, -1363.3, 38.5), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(256.5, -1357.7, 36.0),
				To = {coords = vector3(235.4, -1372.8, 26.3), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = _U('fast_travel')
			}
		}

	}
}

Config.AuthorizedVehicles = {
	car = {
		ambulance = {
			{model = 'ambulance', price = 500}
		},

		doctor = {
			{model = 'ambulance', price = 400}
		},

		chief_doctor = {
			{model = 'ambulance', price = 300}
		},

		boss = {
			{model = 'ambulance', price = 200}
		}
	},

	helicopter = {
		ambulance = {},

		doctor = {
			{model = 'buzzard2', price = 150}
		},

		chief_doctor = {
			{model = 'buzzard2', price = 150},
			{model = 'seasparrow', price = 300}
		},

		boss = {
			{model = 'buzzard2', price = 100},
			{model = 'seasparrow', price = 200}
		}
	}
}
