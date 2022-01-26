Config = {}
--------------------------------
-- [Date Format]

Config.DateFormat = '%H:%M' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- [Staff Groups]

Config.StaffGroups = {
	'superadmin',
	'admin',
	'mod'
}

--------------------------------
-- [Clear Player Chat]

Config.AllowPlayersToClearTheirChat = true

Config.ClearChatCommand = 'clear'

--------------------------------
-- [Staff]

Config.EnableStaffCommand = true

Config.StaffCommand = 'staff'

Config.AllowStaffsToClearEveryonesChat = true

Config.ClearEveryonesChatCommand = 'clearall'

-- [Staff Only Chat]

Config.EnableStaffOnlyCommand = true

Config.StaffOnlyCommand = 'staffo'

--------------------------------
-- [Advertisements]

Config.EnableAdvertisementCommand = true

Config.AdvertisementCommand = 'ad'

Config.AdvertisementPrice = 1000

Config.AdvertisementCooldown = 5 -- in minutes

--------------------------------
-- [Twitch]

Config.EnableTwitchCommand = true

Config.TwitchCommand = 'twitch'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.TwitchList = {
	'steam:110000118a12j8a' -- Example, change this
}

--------------------------------
-- [Youtube]

Config.EnableYoutubeCommand = true

Config.YoutubeCommand = 'youtube'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.YoutubeList = {
	'steam:110000118a12j8a' -- Example, change this
}

--------------------------------
-- [Twitter]

Config.EnableTwitterCommand = true

Config.TwitterCommand = 'twitter'

--------------------------------
-- [Police]

Config.EnablePoliceCommand = true

Config.PoliceCommand = 'police'

Config.PoliceJobName = 'police'

--------------------------------
-- [Ambulance]

Config.EnableAmbulanceCommand = true

Config.AmbulanceCommand = 'ambulance'

Config.AmbulanceJobName = 'ambulance'

--------------------------------
-- [OOC]

Config.EnableOOCCommand = true

Config.OOCCommand = 'ooc'

Config.OOCDistance = 20.0

--------------------------------