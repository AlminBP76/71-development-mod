ESX = nil

local showBankBlips = true
local atBank = false
local bankMenu = true
local inMenu = false
local atATM = false
local bankColor = "green"

local bankLocations = {
    {i = 108, c = 77, x = 241.727, y = 220.706, z = 106.286, s = 0.8, n = "Glavna Banka"}, -- blip id, blip color, x, y, z, scale, name/label
	{i = 108, c = 0, x = 150.266, y = -1040.203, z = 29.374, s = 0.7, n = "Banka"},
	{i = 108, c = 0, x = -1212.980, y = -330.841, z = 37.787, s = 0.7, n = "Banka"},
	{i = 108, c = 0, x = -2962.582, y = 482.627, z = 15.703, s = 0.7, n = "Banka"},
	{i = 108, c = 0, x = -112.202, y = 6469.295, z = 31.626, s = 0.7, n = "Banka"},
	{i = 108, c = 0, x = 314.187, y = -278.621, z = 54.170, s = 0.7, n = "Banka"},
	{i = 108, c = 0, x = -351.534, y = -49.529, z = 49.042, s = 0.7, n = "Banka"},
	{i = 108, c = 0, x = 1175.0643310547, y = 2706.6435546875, z = 38.094036102295, s = 0.7, n = "Banka"}
}

-- -- ATM Object Models
-- local ATMs = {
--     {o = -870868698, c = 'blue'}, 
--     {o = -1126237515, c = 'blue'}, 
--     {o = -1364697528, c = 'red'}, 
--     {o = 506770882, c = 'green'}
-- }

CreateThread(function()
	while ESX == nil or ORP == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(2000)
	end
	Wait(2000)
end)

--[[RegisterCommand('atm', function(source, args)
    if playerNearATM() then
        openPlayersBank('atm')
        local ped = PlayerPedId()
    else
        exports['mythic_notify']:DoHudText('error', 'You are not near an ATM')
    end
end)--]] ----AKO HOCETE PREKO KOMANDE MAKNITE KOMENTAR


RegisterNetEvent('orp:bankomati')
AddEventHandler('orp:bankomati', function(balance)
openPlayersBank('atm')
end)

RegisterNetEvent('orp:banka')
AddEventHandler('orp:banka', function(balance)
if playerNearBank() then
openPlayersBank('bank')
end
end)

function openPlayersBank(type, color)
    local dict = 'anim@amb@prop_human_atm@interior@male@enter'
    local anim = 'enter'
    local ped = PlayerPedId()
    local time = 2500

    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Wait(7)
    end

    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
exports.rprogress:Start("Umetanje kartice...", time)
    Wait(time)
    ClearPedTasks(ped)
    if type == 'bank' then
        inMenu = true
        SetNuiFocus(true, true)
        bankColor = "green"
        SendNUIMessage({type = 'openBank', color = bankColor})
        TriggerServerEvent('orp:bank:balance')
        atATM = false
    elseif type == 'atm' then
        inMenu = true
        SetNuiFocus(true, true)
        SendNUIMessage({type = 'openBank', color = bankColor})
        TriggerServerEvent('orp:bank:balance')
        atATM = true
    end
end

function playerNearATM() -- Check if a player is near ATM when they use command /atm
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    for i = 1, #ATMs do
        local atm = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, ATMs[i].o, false, false, false)
        local atmPos = GetEntityCoords(atm)
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, atmPos.x, atmPos.y, atmPos.z, true)
        if dist < 1.5 then
            bankColor = ATMs[i].c
            return true
        end
    end
end

function playerNearBank() -- Checks if a player is near a bank
    local pos = GetEntityCoords(PlayerPedId())

    for _, search in pairs(bankLocations) do
        local dist = GetDistanceBetweenCoords(search.x, search.y, search.z, pos.x, pos.y, pos.z, true)

        if dist <= 1.0 then
            color = "green"
            return true
        end
    end
end

local blipsLoaded = false

CreateThread(function() -- Add bank blips
    while true do
        Wait(2000)
        if not blipsLoaded then
            for k, v in ipairs(bankLocations) do
                local blip = AddBlipForCoord(v.x, v.y, v.z)
		        SetBlipSprite(blip, v.i)
		        SetBlipScale(blip, v.s)
		        SetBlipAsShortRange(blip, true)
			    SetBlipColour(blip, v.c)
		        BeginTextCommandSetBlipName("STRING")
		        AddTextComponentString(tostring(v.n))
		        EndTextCommandSetBlipName(blip) 
            end
            blipsLoaded = true
        end
    end
end)

RegisterNetEvent('orp:bank:info')
AddEventHandler('orp:bank:info', function(balance)
    local id = PlayerId()
    local playerName = GetPlayerName(id)

    SendNUIMessage({
		type = "updateBalance",
		balance = balance,
        player = playerName,
		})
end)

RegisterNUICallback('deposit', function(data)
    if not atATM then
        TriggerServerEvent('orp:bank:deposit', tonumber(data.amount))
        TriggerServerEvent('orp:bank:balance')
    else
        ESX.ShowNotification("Ne mozes uplacivati pare na bankomatu")
    end
end)

RegisterNUICallback('withdrawl', function(data)
    TriggerServerEvent('orp:bank:withdraw', tonumber(data.amountw))
    TriggerServerEvent('orp:bank:balance')
end)

RegisterNUICallback('balance', function()
    TriggerServerEvent('orp:bank:balance')
end)

RegisterNetEvent('orp:balance:back')
AddEventHandler('orp:balance:back', function(balance)
    SendNUIMessage({type = 'balanceReturn', bal = balance})
end)

function closePlayersBank()
    local dict = 'anim@amb@prop_human_atm@interior@male@exit'
    local anim = 'exit'
    local ped = PlayerPedId()
    local time = 1800

    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Wait(7)
    end

    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
    exports.rprogress:Start("Izvlacenje kartice...", time)
    Wait(time)
    ClearPedTasks(ped)
    inMenu = false
end

RegisterNUICallback('transfer', function(data)
    TriggerServerEvent('orp:bank:transfer', data.to, data.amountt)
    TriggerServerEvent('orp:bank:balance')
end)

RegisterNetEvent('orp:bank:notify')
AddEventHandler('orp:bank:notify', function(message)
    ESX.ShowNotification(message)
end)

AddEventHandler('onResourceStop', function(resource)
    inMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
end)

RegisterNUICallback('NUIFocusOff', function()
    closePlayersBank()
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local bankomatUkopani = {
    -1126237515,
    506770882,
    -870868698,
    150237004,
    -239124254,
    -1364697528,
}

exports['qtarget']:AddTargetModel(bankomatUkopani, {
    options = {
        {
            event = "orp:bankomati",
            icon = "fas fa-credit-card",
            label = "Pristupi Bankomatu",
        },
    },
    distance = 1.8
})

exports['qtarget']:AddBoxZone("FleecaLegionRight", vector3(145.8462, -1035.6, 29.33044), 0.5, 1.0, {
    name="FleecaLegionRight",
    debugPoly=false,
    heading=160.0,
    minZ=29.0,
    maxZ=30.5
    },{
    options = {
        {
            event = "orp:banka",
            icon = "fas fa-piggy-bank fa-lg",
            label = "Pristupi bankovnom racunu",
        },
    },
    distance = 1.2
})

exports['qtarget']:AddBoxZone("FleecaLegionLeft", vector3(147.5, -1036.2, 29.33044), 0.5, 1.0, {
    name="FleecaLegionLeft",
    debugPoly=false,
    heading=160.0,
    minZ=29.0,
    maxZ=30.5
    },{
    options = {
        {
            event = "orp:banka",
            icon = "fas fa-piggy-bank fa-lg",
            label = "Pristupi bankovnom racunu",
        },
    },
    distance = 1.2
})

exports['qtarget']:AddBoxZone("Pacific-standard", vector3(247.66, 223.78, 106.29), 0.5, 12.5, {
	name= "Pacific-standard",
	heading= 342.50,
	debugPoly= false,
	minZ= 105.29,
	maxZ= 106.99
}, {
	options = {
	{
	event = 'orp:banka',
	icon = "fas fa-money-bill-wave",
	label = "Pristupi bankovnom racunu.",
	},
},
	distance = 3.0
})

exports['qtarget']:AddBoxZone("Hawick Avenu-Bank", vector3(313.84, -279.69, 53.37), 1.0, 3.8, {
	name= "bennys-shop",
	heading= 163.17,
	debugPoly= false,
	minZ= 53.27,
	maxZ= 54.99
}, {
	options = {
	{
	event = 'orp:banka',
	icon = "fas fa-money-bill-wave",
	label = "Pristupi bankovnom racunu.",
	},
},
	distance = 2.5
})

exports['qtarget']:AddBoxZone("Hawick Avenue-Bank2", vector3(-351.82, -50.28, 48.54), 1.0, 3.8, {
	name= "Hawick Avenue-Bank2",
	heading= 180.00,
	debugPoly= false,
	minZ= 48.44,
	maxZ= 49.99
}, {
	options = {
	{
	event = 'orp:banka',
	icon = "fas fa-money-bill-wave",
	label = "Pristupi bankovnom racunu.",
	},
},
	distance = 2.5
})

exports['qtarget']:AddBoxZone("Boulevard Del-Perro-Bank", vector3(-1212.96, -331.67, 37.79), 1.5, 4.0, {
	name= "Boulevard Del-Perro-Bank",
	heading= 207.85,
	debugPoly= false,
	minZ= 37.00,
	maxZ= 38.00
}, {
	options = {
	{
	event = 'orp:banka',
	icon = "fas fa-money-bill-wave",
	label = "Pristupi bankovnom racunu.",
	},
},
	distance = 3.5
})

exports['qtarget']:AddBoxZone("Vespucci Boulevard-Bank", vector3(149.06, -1041.02, 28.47), 1.0, 3.8, {
	name= "Vespucci Boulevard-Bank",
	heading= 160.00,
	debugPoly= false,
	minZ= 28.44,
	maxZ= 29.99
}, {
	options = {
	{
	event = 'orp:banka',
	icon = "fas fa-money-bill-wave",
	label = "Pristupi bankovnom racunu.",
	},
},
	distance = 2.5
})

exports['qtarget']:AddBoxZone("Great Ocean Highway-Bank", vector3(-2962.18, 482.17, 15.5), 1.0, 3.8, {
	name= "Great Ocean Highway-Bank",
	heading= 269.57,
	debugPoly= false,
	minZ= 14.44,
	maxZ= 15.99
}, {
	options = {
	{
	event = 'orp:banka',
	icon = "fas fa-money-bill-wave",
	label = "Pristupi bankovnom racunu.",
	},
},
	distance = 2.5
})

exports['qtarget']:AddBoxZone("Route 68-Bank", vector3(1175.67, 2707.55, 37.89), 1.0, 3.8, {
	name= "Route 68-Bank",
	heading= 0.57,
	debugPoly= false,
	minZ= 37.19,
	maxZ= 38.99
}, {
	options = {
	{
	event = 'orp:banka',
	icon = "fas fa-money-bill-wave",
	label = "Pristupi bankovnom racunu.",
	},
},
	distance = 2.5
})

exports['qtarget']:AddBoxZone("Grapeseed-Bank", vector3(1652.55, 4851.05, 41.82), 1.0, 3.8, {
	name= "Grapeseed-Bank",
	heading= 97.14,
	debugPoly= false,
	minZ= 41.69,
	maxZ= 42.99
}, {
	options = {
	{
	event = 'orp:banka',
	icon = "fas fa-money-bill-wave",
	label = "Pristupi bankovnom racunu.",
	},
},
	distance = 2.5
})

exports['qtarget']:AddBoxZone("Blaine County Savings-Bank", vector3(-112.07, 6470.23, 30.82), 1.0, 3.8, {
	name= "Blaine County Savings-Bank",
	heading= 316.09,
	debugPoly= false,
	minZ= 30.69,
	maxZ= 31.99
}, {
	options = {
	{
	event = 'orp:banka',
	icon = "fas fa-money-bill-wave",
	label = "Pristupi bankovnom racunu.",
	},
},
	distance = 2.5
})
