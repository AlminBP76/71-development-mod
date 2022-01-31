Config = {}
Translation = {}

Config.Shopkeeper = 0x18CE57D0 -- hash of the shopkeeper ped
Config.Locale = 'en' -- 'en', 'sv' or 'custom'

Config.Shops = {
    -- {coords = vector3(x, y, z), heading = peds heading, money = {min, max}, cops = amount of cops required to rob, blip = true: add blip on map false: don't add blip, name = name of the store (when cops get alarm, blip name etc)}
    {coords = vector3(24.03, -1345.63, 29.5-0.98), heading = 266.0, money = {5000, 15000}, cops = 0, blip = true, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-705.73, -914.91, 19.22-0.98), heading = 91.0, money = {7500, 20000}, cops = 0, blip = true, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false}

}

Translation = {
    ['en'] = {
        ['shopkeeper'] = 'Pljacka Prodavnice',
        ['robbed'] = "Upravo sam opljackan i nemam vise para, molim vas ostavite me na miru",
        ['cashrecieved'] = 'Dobio si:',
        ['currency'] = '$',
        ['scared'] = 'Usro se:',
        ['no_cops'] = 'Trenutno nema policije u gradu!',
        ['cop_msg'] = 'Primili ste fotografiju razbojnika!',
        ['set_waypoint'] = 'Postavite waypoint do prodavnice',
        ['hide_box'] = 'Sakrite ovu kutiju',
        ['robbery'] = 'Pljacka je u toku',
        ['walked_too_far'] = 'Previše si se odaljio od prodavnice!'
    }
}
