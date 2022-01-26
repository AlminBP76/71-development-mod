-- Made by Tomić#9076
Config = {}
-- Jezik/The language you want the script to be in..
Config.Locale = 'hr' -- Currently English (en) and Croatian (hr) only.
--[[        ------------------------------         --]]
--[[
  _______ ______ _____  _____ _______ ____  _____  _____     _ ______ 
 |__   __|  ____|  __ \|_   _|__   __/ __ \|  __ \|_   _|   | |  ____|
    | |  | |__  | |__) | | |    | | | |  | | |__) | | |     | | |__   
    | |  |  __| |  _  /  | |    | | | |  | |  _  /  | | _   | |  __|  
    | |  | |____| | \ \ _| |_   | | | |__| | | \ \ _| || |__| | |____ 
    |_|  |______|_|  \_\_____|  |_|  \____/|_|  \_\_____\____/|______|
                                                                                                                                                                    --]]
--[[        ------------------------------         --]]
-- Nakon koliko vremena se može opet zauzimati ista teritorija? (minute)
-- After how many minutes can you again start the territory capture?
Config.Cooldown = 60
--[[        ------------------------------         --]]
-- Da se cooldown odmah pojavi, u momentu kada započnete zauzimanje, a ne kada tek zauzmete teritoriju..?
-- True = Cooldown appears on attempt. False = Cooldown appears only after a successful capture.
Config.InstantCooldown = true
--[[        ------------------------------         --]]
-- U milisekundama, koliko vremena treba da bi se zauzeo 1%? (6sec = 1% | 6sec * 100% = 600sec | 600sec % 60sec = 10min)
-- In miliseconds, how much time does one percent need to be fulfilled or taken? (6000ms for one percent, 100% is going to be completed in 10 minutes!)
Config.Zauzimanje = 6000
--[[        ------------------------------         --]]
-- Nakon koje daljine se prekida zauzimanje? (Ako se napusti radius teritorije, zauzimanje se prekida.)
-- After what distance from the marker does the taking cancel?
Config.RadiusPrekidanja = 50
--[[        ------------------------------         --]]
-- Komanda za provjeru posjedovanja teritorija.
-- A command to check current territory owners.
Config.Komanda = "teritorije"
--[[        ------------------------------         --]]
Config.TipMarkera = 2 -- Sprite markera / Marker Sprite
--[[        ------------------------------         --]]
-- Ovdje dodajete poslove koji mogu zauzimati teritorije, ostali poslovi nece moći...
-- Down below, you can put the list of jobs that are allowed to capture the territories.
Config.Organizacije = {
    gsf = {},
    ballas = {},
    vagos = {},
}
--[[        ------------------------------         --]]
-- TeritorijaIme će pisati na /teritorije kada komanda bude pokrenuta.
-- TeritorijaIme stands for the actual name of the territory. (This name will be displayed on /territories when executed)
-- TeritorijaKordinate stands for the coords of the marker, the circular blip and some other stuff.
Config.TeritorijaIme1 = "Ter1"
Config.TeritorijaKordinate1 = vector3(1904.4, 301.02, 165.53) -- Marker i Okrugli Blip
--[[        ------------------------------         --]]
Config.TeritorijaIme2 = "Ter2"
Config.TeritorijaKordinate2 = vector3(-105.17, -432.35, 36.1) -- Marker i Okrugli Blip
--[[        ------------------------------         --]]
Config.TeritorijaIme3 = "Ter3"
Config.TeritorijaKordinate3 = vector3(-1833.99, -1221.03, 13.02) -- Marker i Okrugli Blip
--[[        ------------------------------         --]]
Config.TeritorijaIme4 = "Ter4"
Config.TeritorijaKordinate4 = vector3(389.91, -1523.68, 29.28) -- Marker i Okrugli Blip
--[[        ------------------------------         --]]
Config.TeritorijaIme5 = "Ter5"
Config.TeritorijaKordinate5 = vector3(1011.28, -2867.08, 39.16) -- Marker i Okrugli Blip
--[[        ------------------------------         --]]
Config.TeritorijaIme6 = "Ter6"
Config.TeritorijaKordinate6 = vector3(-427.37, 1116.28, 326.78) -- Marker i Okrugli Blip
--[[        ------------------------------         --]]
Config.TeritorijaIme7 = "Ter7"
Config.TeritorijaKordinate7 = vector3(-857.68, -1771.42, 23.8) -- Marker i Okrugli Blip
--[[        ------------------------------         --]]
-- Ovo ispod su blipovi glave kostura koji se nalaze u centru svake teritorije, zapamtite da ako editujete kordinate gore, da ih morate editovati i tu.
-- This here is for the Skull Blips that are in the center of each territory, keep in mind that if you change one of these coordinates above, you gotta change this down here too.
Config.Blipovi = {

    {title = "Teritorija | T1", boja = 27, id = 310, x = 1904.4,   y = 301.02,   z = 69.69}, -- Skull Blipovi
    {title = "Teritorija | T2", boja = 27, id = 310, x = -105.17,  y = -432.35,  z = 69.69}, -- Skull Blipovi
    {title = "Teritorija | T3", boja = 27, id = 310, x = -1833.99, y = -1221.03, z = 69.69}, -- Skull Blipovi
    {title = "Teritorija | T4", boja = 27, id = 310, x = 389.91,   y = -1523.68, z = 69.69}, -- Skull Blipovi
    {title = "Teritorija | T5", boja = 27, id = 310, x = 1011.28,  y = -2867.08, z = 69.69}, -- Skull Blipovi
    {title = "Teritorija | T6", boja = 27, id = 310, x = -427.37,  y = 1116.28,  z = 69.69}, -- Skull Blipovi
    {title = "Teritorija | T7", boja = 27, id = 310, x = -857.68,  y = -1771.42, z = 69.69}  -- Skull Blipovi

}
--[[        ------------------------------         --]]
--[[
 _   _          _____ _____            _____  ______ 
| \ | |   /\   / ____|  __ \     /\   |  __ \|  ____|
|  \| |  /  \ | |  __| |__) |   /  \  | |  | | |__   
| . ` | / /\ \| | |_ |  _  /   / /\ \ | |  | |  __|  
| |\  |/ ____ \ |__| | | \ \  / ____ \| |__| | |____ 
|_| \_/_/    \_\_____|_|  \_\/_/    \_\_____/|______|

                                                                                                                                                                    --]]
--[[        ------------------------------         --]]
-- Da banda koja uspješno zauzme teritoriju dobija novac? (Potreban esx_addonaccount)
-- Does the gang that successfully captures the territory become money? Money goes directly into the gang's boss menu. (Requires esx_addonaccount)
Config.NovcanaNagrada = false
Config.KolicinaNovca = 30000 -- Kolicina/Amount
--[[        ------------------------------         --]]
-- Da banda koja uspješno zauzme teritoriju dobija neku stvar/item? (Potreban esx_addoninventory)
-- Does the gang that successfully captures the territory become any items? The items are going to be placed in gang's armory menu. (Requires esx_addoninventory)
Config.ItemNagrada = false
Config.Item = "meth" -- Item
Config.ItemKolicina = 20 -- Kolicina/Amount
--[[        ------------------------------         --]]
--[[
  _____ _____  _____  _____ ____  _____  _____  
 |  __ \_   _|/ ____|/ ____/ __ \|  __ \|  __ \ 
 | |  | || | | (___ | |   | |  | | |__) | |  | |
 | |  | || |  \___ \| |   | |  | |  _  /| |  | |        discord.gg/balkanhorizonrp | Tomić#9076
 | |__| || |_ ____) | |___| |__| | | \ \| |__| |
 |_____/_____|_____/ \_____\____/|_|  \_\_____/ 
                                                
                                                                                                                                                                    --]]
-- Discord Webhook za logove, kao i url slike koja će se koristiti na botu koji slao logove.
-- Discord Webhook for the logs, aswell as the picture that goes in the second link.
Config.Webhook      = ""
Config.WebhookSlika = ""
--[[        ------------------------------         --]]
                                                                                                                                                                    --[[
        _    __   ___    __        
 /|/|  /_|  /  ) (_     / _) (__/ .
/   | (  | /(_/  /__   /(_)   /   .
                                                              
  ____   __             _                           Tomić#9076
   /    /  )  /|/|  /  / ) 
  (    (__/  /   | (  (__                                                              
                                
                                                                                                                                                                    --]]
--[[        ------------------------------         --]]

-- I am going to try and make the amount of territories editable in config, because you currently cannot manage the number of territories. 
-- If you're a customer and you want more, feel free to contact me! Discord: Tomić#9076
-- SA:MP Gang <3 :P
