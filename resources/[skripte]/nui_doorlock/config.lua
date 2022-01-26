Config = {}
Config.DoorList = {}
Config.ShowUnlockedText = false
Config.CheckVersion = true

-- Allow players with access to /newdoor to open any door
Config.AdminAccess = false


-- Policija garazna
table.insert(Config.DoorList, {
	audioRemote = false,
	lockpick = false,
	objHeading = 0.0,
	slides = true,
	fixText = false,
	maxDistance = 6.0,
	authorizedJobs = { ['police']=0 },
	objHash = 1356380196,
	garage = true,
	locked = true,
	objCoords = vector3(452.3017, -1001.13, 26.64809),			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})

-- Policija garazna 2
table.insert(Config.DoorList, {
	audioRemote = false,
	lockpick = false,
	objHeading = 0.0,
	slides = true,
	fixText = false,
	maxDistance = 6.0,
	authorizedJobs = { ['police']=0 },
	objHash = 1356380196,
	garage = true,
	locked = true,
	objCoords = vector3(447.4821, -1001.13, 26.64809),			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})

-- Policija garaza ulazna
table.insert(Config.DoorList, {
	audioRemote = false,
	lockpick = false,
	objHeading = 89.999977111816,
	slides = false,
	fixText = false,
	maxDistance = 2.0,
	authorizedJobs = { ['police']=0 },
	objHash = 165994623,
	garage = false,
	locked = true,
	objCoords = vector3(464.8759, -989.3229, 25.86022),			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})

-- Policija garaza 3
table.insert(Config.DoorList, {
	audioRemote = false,
	lockpick = false,
	objHeading = 0.0,
	slides = true,
	fixText = false,
	maxDistance = 6.0,
	authorizedJobs = { ['police']=0 },
	objHash = 1356380196,
	garage = true,
	locked = true,
	objCoords = vector3(436.2234, -1001.252, 26.64215),			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})

-- Policija garaza 4
table.insert(Config.DoorList, {
	audioRemote = false,
	lockpick = false,
	objHeading = 0.0,
	slides = true,
	fixText = false,
	maxDistance = 6.0,
	authorizedJobs = { ['police']=0 },
	objHash = 1356380196,
	garage = true,
	locked = true,
	objCoords = vector3(431.4082, -1001.252, 26.64181),			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})

-- Policija Glavni Ulaz
table.insert(Config.DoorList, {
	slides = false,
	maxDistance = 2.5,
	doors = {
		{objHash = 1388858739, objHeading = 270.00003051758, objCoords = vector3(434.712, -983.0622, 30.80078)},
		{objHash = -165604314, objHeading = 269.99996948242, objCoords = vector3(434.7102, -980.8273, 30.80078)}
 },
	lockpick = false,
	audioRemote = false,
	locked = true,
	authorizedJobs = { ['police']=0 },			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})

-- Policija Sporedni Ulaz
table.insert(Config.DoorList, {
	slides = false,
	maxDistance = 2.5,
	doors = {
		{objHash = -165604314, objHeading = 179.99998474121, objCoords = vector3(441.2427, -998.6813, 30.79962)},
		{objHash = 1388858739, objHeading = 179.99998474121, objCoords = vector3(439.0086, -998.6813, 30.79962)}
 },
	lockpick = false,
	audioRemote = false,
	locked = true,
	authorizedJobs = { ['police']=0 },			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})

-- Policija Sporedni Ulaz2
table.insert(Config.DoorList, {
	slides = false,
	maxDistance = 2.5,
	doors = {
		{objHash = 1388858739, objHeading = 180.00001525879, objCoords = vector3(441.5994, -998.6813, 30.79962)},
		{objHash = -165604314, objHeading = 179.99998474121, objCoords = vector3(443.8397, -998.6813, 30.79962)}
 },
	lockpick = false,
	audioRemote = false,
	locked = true,
	authorizedJobs = { ['police']=0 },			
		-- oldMethod = true,
		-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
		-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
		-- autoLock = 1000
})