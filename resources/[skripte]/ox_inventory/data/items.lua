return {
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		limit = 3,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			test = 'what an amazingly delicious burger, amirite?'
		}
	},

	['bandage'] = {
		label = 'Zavoj',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['medikit'] = {
		label = 'Prva Pomoc',
		weight = 130,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Prljav Novac',
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'Pojeo si burger'
		},
	},

	['identification'] = {
		label = 'Licna Karta',
		weight = 0,
		stack = false,
		close = true,
		client = {
			consume = 0,
			event = "qidentification:identification",
		}
	},

	['drivers_license'] = {
		label = 'Vozacka Dozvola',
		weight = 0,
		stack = false,
		close = true,
		client = {
			consume = 0,
			event = "qidentification:drivers_license",
		}
	},

	['firearms_license'] = {
		label = 'Oruzana Licenca',
		weight = 0,
		stack = false,
		close = true,
		client = {
			consume = 0,
			event = "qidentification:firearms_license",
		}
	},

	['cola'] = {
		label = 'eCola',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Popio si kolu'
		}
	},

	['parachute'] = {
		label = 'Padobran',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Smece',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['contract'] = {
		label = 'Ugovor',
		weight = 1,
		stack = false,
		close = true,
		consume = 0
	},

	['drvo'] = {
		label = 'Drvo',
		weight = 1,
		stack = false,
		close = true,
		consume = 0
	},

	['jabuka'] = {
		label = 'Jabuka',
		weight = 1,
		stack = false,
		close = true,
		consume = 0
	},

	['tkanina'] = {
		label = 'Tkanina',
		weight = 1,
		stack = false,
		close = true,
		consume = 0
	},

	['acetone'] = {
		label = 'Aceton',
		weight = 2,
		stack = false,
		close = true,
		consume = 0
	},

	['methlab'] = {
		label = 'Prijenosni Metlab',
		weight = 7,
		stack = false,
		close = true,
		consume = 0
	},

	['meth'] = {
		label = 'meth',
		weight = 1,
		stack = false,
		close = true,
		consume = 0
	},

	['lithium'] = {
		label = 'Lithijske Baterije',
		weight = 1,
		stack = false,
		close = true,
		consume = 0
	},

	['identification'] = {
		label = 'Identifikacija',
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
		consume = 0,
		client = {
			anim = { dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', clip = 'machinic_loop_mechandplayer' },
			disable = { move = true, car = true, combat = true },
			usetime = 5000,
			cancel = true
		}
	},

	['blue_phone'] = {
		label = 'Mobitel',
		weight = 190,
		stack = false,
		consume = 0,
	},

	['money'] = {
		label = 'Novac',
	},

	['mustard'] = {
		label = 'Senf',
		weight = 500,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'Popio si... senf'
		}
	},

	['water'] = {
		label = 'Voda',
		weight = 500,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'Popio si osvjezavajucu vodu'
		}
	},
}