poceo = false
uzeoAuto = false
kamionPun = false
uzeto = 0

-- Npcevi
local NPC = {
    {model = "a_m_m_business_01", x = -1996.24, y = 591.12, z = 117.12, h = 261.88}, -- Zapocni/zavrsi posao npc
    {model = "a_m_m_hillbilly_02", x = 2415.96, y = 4993.64, z = 45.24, h = 133.52}, -- Sledeci npc
    {model = "a_m_m_rurmeth_01", x = -1098.08, y = 4948.0, z = 217.36, h = 252.72}, -- Sledeci npc
}

CreateThread(function()
    for _, v in pairs(NPC) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do 
            Wait(1)
        end
        local npc = CreatePed(4, v.model, v.x, v.y, v.z, v.h,  false, true)
        SetPedFleeAttributes(npc, 0, 0)
        SetPedDropsWeaponsWhenDead(npc, false)
        SetPedDiesWhenInjured(npc, false)
        SetEntityInvincible(npc , true)
        FreezeEntityPosition(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        if v.seller then 
            RequestAnimDict("missfbi_s4mop")
            while not HasAnimDictLoaded("missfbi_s4mop") do
                Wait(1)
            end
            TaskPlayAnim(npc, "missfbi_s4mop" ,"guard_idle_a" ,8.0, 1, -1, 49, 0, false, false, false)
        end
    end
end)

local peds = {
    `a_m_m_business_01`,
}
exports["qtarget"]:AddTargetModel(peds, {
	options = {
		{
			event = "ajmo1",
			icon = "fas fa-business-time",
			label = "Zapocni posao",
		},
        {
			event = "zavrsiPoslic",
			icon = "fas fa-business-time",
			label = "Zavrsi posao",
		},
        {
			event = "uzmiAutic",
			icon = "fas fa-business-time",
			label = "Uzmi firmino vozilo",
		},
		},
		--job = {"all"},
	distance = 2.5
})

AddEventHandler('ajmo1', function(source)
    TriggerEvent('zf_dialog:sendMenu', {
		{
			id = 1,
			header = "Sef firme",
			txt = "Cuo si za mene i moj posao, drago mi je. Trebaju mi radnici koji ce da skupljaju jabuke i da ih odveze coveku koji ih otkupljuje. Nadam se da mogu da racunam na tebe.",
			params = {
				event = "pocniFusPoslic",
				args = {}
			}
		},
	})	
end)

local peds = {
    `a_m_m_hillbilly_02`,
}
exports["qtarget"]:AddTargetModel(peds, {
	options = {
		{
			event = "ajmo2",
			icon = "fas fa-business-time",
			label = "Zapocni skupljanje / vrati auto",
		},
        {
			event = "ajmo3",
			icon = "fas fa-business-time",
			label = "Odvezi kamion sa jabukama",
		},
		},
		--job = {"all"},
	distance = 2.5
})

AddEventHandler('ajmo2', function(source)
    TriggerEvent('zf_dialog:sendMenu', {
		{
			id = 1,
			header = "Radnik u firmi",
			txt = "Nadam se da si lepo i udobno putovao do ovde. Vraticu ti pare koje si dao sefu za vozilo i recicu ti sta dalje da radis.",
			params = {
				event = "ajmoooo",
				args = {}
			}
		},
	})	
end)

AddEventHandler('ajmo3', function(source)
    TriggerEvent('zf_dialog:sendMenu', {
		{
			id = 1,
			header = "Radnik u firmi",
			txt = "Hvala na ovim jabuka, dodane su u korpu sa ostalim i spakovane u kamion. Mozes da nastavis da beres ili da ih odvezes coveku koji ih otkupljuje ako je kamion pun.",
			params = {
				event = "uzmiKamiocic",
				args = {}
			}
		},
	})	
end)

local peds = {
    `a_m_m_rurmeth_01`,
}
exports["qtarget"]:AddTargetModel(peds, {
	options = {
        {
			event = "ajmo4",
			icon = "fas fa-business-time",
			label = "Predaj kamion sa jabukama",
		},
		},
		--job = {"all"},
	distance = 2.5
})

AddEventHandler('ajmo4', function(source)
    TriggerEvent('zf_dialog:sendMenu', {
		{
			id = 1,
			header = "Uvoznik jabuka",
			txt = "Hvala na ovim jabuka, reci sefu da imate veoma dobru isporuku. Nastavite samo sa radom.",
			params = {
				event = "ZavrsiPoslaoMrtvi",
				args = {}
			}
		},
	})	
end)

RegisterNetEvent("ZavrsiPoslaoMrtvi")
AddEventHandler("ZavrsiPoslaoMrtvi", function()
    Wait(200)
    poceo = true
    if poceo == true and kamionPun == true then
        exports.rprogress:Custom({
            Duration = 2500,
            Label = "Predajes kamion sa jabukama...",
            Animation = {
                scenario = "WORLD_HUMAN_COP_IDLES",
                animationDictionary = "idle_a",
            },
            DisableControls = {
                Mouse = false,
                Player = true,
                Vehicle = true
            }
        })
        if kamionPun == true then
            ESX.ShowNotification("", "Dovezao si kamion <span style='color:#47cf73'> sa jabukama </span> izvoli svoju isplatu za transport", 3000, "success")
            kamionPun = false
            TriggerServerEvent("isplati")
            TriggerEvent("zavrsiPoslic")
        end
    end
end)

RegisterNetEvent("uzmiKamiocic")
AddEventHandler("uzmiKamiocic", function()
    Wait(200)
    kamionPun = true
    if GlobalState.Uzeo >= 25 and poceo == true and kamionPun == true then
        ESX.Game.SpawnVehicle(Config.SpawnKamiona, vector3(Config.Lokacije2["kamionet"].coords.x, Config.Lokacije2["kamionet"].coords.y, Config.Lokacije2["kamionet"].coords.z), Config.Lokacije2["kamionet"].coords.h, function(vehicle)
        SetVehicleNumberPlateText(vehicle, "BASTY"..tostring(math.random(1000, 9999)))
        TaskWarpPedIntoVehicle(ped, vehicle, -1)
        SetVehicleEngineOn(vehicle, true, true)
        ESX.ShowNotification("", "Uzeo si kamion vozi do oznacene lokacije", 4000, "info")
        Plate = GetVehicleNumberPlateText(vehicle)
        uzeoAuto = true
        GlobalState.Uzeo = 0
        SetNewWaypoint(Config.Lokacije2["idiDoSaKamionom"].coords.x, Config.Lokacije2["idiDoSaKamionom"].coords.y, Config.Lokacije2["idiDoSaKamionom"].coords.z)
        for i, v in ipairs(Config.Lokacije) do
            v.Ubrano = false
        end
    end)
    else
        ESX.ShowNotification("", "Nema dovoljno jabuka za izvoz", 1500, "error")
    end
end)

RegisterNetEvent("ajmoooo")
AddEventHandler("ajmoooo", function()
    Wait(200)
    poceo = true
    if poceo == true and uzeoAuto == true then
        exports.rprogress:Custom({
            Duration = 2500,
            Label = "Dobijas pare nazad...",
            Animation = {
                scenario = "WORLD_HUMAN_COP_IDLES",
                animationDictionary = "idle_a",
            },
            DisableControls = {
                Mouse = false,
                Player = true,
                Vehicle = true
            }
        })
        if uzeoAuto == true then
            vratiPareCoveku()
            ESX.ShowNotification("", "Dobio si <span style='color:#47cf73'> "..Config.UzmiAutoCena.." </span> $ za vračanje vozila", 3000, "success")
            uzeoAuto = false
            TriggerServerEvent('vracajPareee')
            idemoBlipovi()
        end
    end
end)

RegisterNetEvent("uzmiAutic")
AddEventHandler("uzmiAutic", function()
ESX.TriggerServerCallback('proveriPare', function(imaPare)
    if imaPare and poceo == true then
        ESX.Game.SpawnVehicle(Config.SpawnAuta, vector3(Config.Lokacije2["avtomobil"].coords.x, Config.Lokacije2["avtomobil"].coords.y, Config.Lokacije2["avtomobil"].coords.z), Config.Lokacije2["avtomobil"].coords.h, function(vehicle)
        SetVehicleNumberPlateText(vehicle, "BASTY"..tostring(math.random(1000, 9999)))
        TaskWarpPedIntoVehicle(ped, vehicle, -1)
        SetVehicleEngineOn(vehicle, true, true)
        ESX.ShowNotification("", "Platio si <span style='color:#47cf73'> "..Config.UzmiAutoCena.." </span> $ za vađenje vozila", 3000, "success")
        Plate = GetVehicleNumberPlateText(vehicle)
        uzeoAuto = true
        SetNewWaypoint(Config.Lokacije2["idiDo"].coords.x, Config.Lokacije2["idiDo"].coords.y, Config.Lokacije2["idiDo"].coords.z)
        for i, v in ipairs(Config.Lokacije) do
            v.Ubrano = false
        end
    end)
    else
        ESX.ShowNotification("", "Nemate dovoljno novca kod sebe ili se zaposlio", 1500, "error")
        end
    end)
end)

RegisterNetEvent("pocniFusPoslic")
AddEventHandler("pocniFusPoslic", function()
    Wait(200)
    poceo = true
    if poceo == true then
        exports.rprogress:Custom({
            Duration = 2500,
            Label = "Presvlacis se...",
            Animation = {
                scenario = "WORLD_HUMAN_COP_IDLES",
                animationDictionary = "idle_a",
            },
            DisableControls = {
                Mouse = false,
                Player = true,
                Vehicle = true
            }
        })
        Wait(2500)
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, Config.Odeca.musko)
        elseif skin.sex == 1 then
            TriggerEvent('skinchanger:loadClothes', skin, Config.Odeca.zensko)
        end
        ESX.ShowNotification("", "Pokrenuo si posao", 3000, "info")
        poceo = true
        end)
    end
end)

RegisterNetEvent("zavrsiPoslic")
AddEventHandler("zavrsiPoslic", function()
    if poceo == true then
    exports.rprogress:Custom({
        Duration = 2500,
        Label = "Presvlacis se...",
        Animation = {
            scenario = "WORLD_HUMAN_COP_IDLES", -- https://pastebin.com/6mrYTdQv
            animationDictionary = "idle_a", -- https://alexguirre.github.io/animations-list/
        },
        DisableControls = {
            Mouse = false,
            Player = true,
            Vehicle = true
        }
    })
    Wait(2500)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    ESX.ShowNotification("", "Završio si posao", 3000, "success")
    uzeoAuto = false
    kamionPun = false
    poceo = false
        uzeto = 0
            for i, v in ipairs(Config.Lokacije) do
                RemoveBlip(v.blip)
                v.Ubrano = true
            end
        end)
    end
end)

function idemoBlipovi()
    for l, v in ipairs(Config.Lokacije) do
        v.blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(v.blip, 285)
        SetBlipDisplay(v.blip, 4)
        SetBlipScale(v.blip, 0.4)
        SetBlipAsShortRange(v.blip, true)
        SetBlipColour(v.blip, 47)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Stablo jabuke')
        EndTextCommandSetBlipName(v.blip)
    end
end

CreateThread(function()
    while true do 
        local spavaj = 0
        if poceo == true then
        ESX.Game.Utils.DrawText3D({x = 2415.96, y = 4993.64, z = 45.24 + 0.3}, '~g~Ima ~w~[~r~' ..GlobalState.Uzeo.. '~w~] ~g~jabuka od 25 ostavljenih da bi kamion mogao da krene', 0.8)
    end
        Wait(spavaj)
    end
end)

CreateThread(function()
    while true do
        local spavaj = 500
        local ped = PlayerPedId()
        local pozicija = GetEntityCoords(ped)

        if poceo == true then
            for k,v in ipairs(Config.Lokacije) do
                    if (GetDistanceBetweenCoords(pozicija, v.x, v.y, v.z, true) < 2) and not v.Ubrano then
                        spavaj = 6
                        DrawText3D(v.x, v.y, v.z, '~w~[~r~ E ~w~] ~w~da uberes jabuke', 0.6)
                        if IsControlJustPressed(0, Dugmici["E"]) then
                            ESX.Streaming.RequestAnimDict('amb@prop_human_movie_bulb@idle_a', function()
                                TaskPlayAnim(PlayerPedId(), 'amb@prop_human_movie_bulb@idle_a', 'idle_a', 8.0, -8.0, -1, 2, 0, false, false, false)
                            end)
                            exports.rprogress:Custom({
                                Duration = 5500,
                                Label = "Beres jabuke...",
                                DisableControls = {
                                    Mouse = false,
                                    Player = true,
                                    Vehicle = true
                                }
                            })
                            Wait(5500)
                            v.Ubrano = true
                            uzeto = uzeto + 1
                            TriggerServerEvent('dodajSvima')
                            RemoveBlip(v.blip)
                            ClearPedTasks(ped)
                            print(uzeto)
                            if uzeto == 25 then
                                ESX.ShowNotification("", "Pokupili ste sve jabuke , idite do radnika da ostavite jabuke.", 5000, "info")
                            v.Ubrano = false
                        end
                    end
                end
            end
        end
        Wait(spavaj)
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local factor = (string.len(text)) / 370

    SetTextScale(0.30, 0.30)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
end

function vratiPareCoveku()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    ESX.Game.DeleteVehicle(vehicle)
    uzeoAuto = false
end

local blipovi = {
    {title="Biznismen", colour=2, id=108, x = -1996.24, y = 591.12, z = 117.12},
}

CreateThread(function()
    for _, info in pairs(blipovi) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.6)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)
