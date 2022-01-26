Config = {}

-- NotW4018 <3

-- STA TI NE TREBA OD GRUPA PROMENI
Config.SeeOwnLabel = true
Config.SeeDistance = 100
Config.TextSize = 0.8
Config.ZOffset = 1.2
Config.NearCheckWait = 500
Config.TagByPermission = false --Using xPlayer.getPermissions() which is deprecated method for old ESX
Config.GroupLabels = {
    helper = "~p~[ probni admin ]\n~w~ ",
    mod = "~m~[ moderator ]\n~w~ ",
	owner = "~r~[ vlasnik ]\n~w~ ",
    admin = "~g~[ admin ]\n~w~ ",
    headadmin = "~y~[ head admin ]\n~w~ ",
	developer = "~o~[ skripter ]\n~w~ ",
    superadmin = "~b~[ super admin ]\n~w~ ",
}

Config.PermissionLabels = {
    [1] = "PROBNI ADMIN",
    [2] = "~g~MODERATOR",
    [3] = "~b~ADMIN",
    [4] = "~r~SUPER ADMIN",
    [5] = "~r~SUPER ADMIN",
}
