-- Made by Tomić#9076
Config = {}
--[[        ------------------------------         --]]
Config.CoinNagrada = 100000 -- An amount that player gets after executing "hcnagrada". (Player needs 100 tCoins to execute the command.)
--[[        ------------------------------         --]]
Config.ProvjeriStanjeKomanda = "tcstanje" -- A command to see your current balance.
Config.NagradaKomanda = "tcnagrada" -- A command to redeem the reward after claiming 100 or more tCoins.
--[[        ------------------------------         --]]
--[[ YOU CAN CHANGE LOCATION NAMES AND COORDINATES IN 'sv_strana.lua' --]]
--[[ IMENA LOKACIJA I KORDINATE MOZETE VIDJETI U 'sv_strana.lua' --]]
--[[        ------------------------------         --]]
Config.PrefixPoruke = "[INFO]"
Config.PrefixColor = {51, 102, 153}
--[[        ----------R----G----B---------         --]]
Config.First3DMessage = "Pronasli ste ~b~tCoin~w~!"
Config.Second3DMessage = "Pritisnite [~b~E~w~] da ga ~b~pokupite~w~."
--[[ i honestly do not have time to deal with these messages, and putting them in the config is just time-consuming,
    so if you want to translate them, just go in the client and server files and change them manually, it's a 10 minute job... --]]
--[[        ------------------------------         --]]
Config.Vrijeme = 30 -- tCoin spawns every __? Default: 30minutes (15-60min recommended)
