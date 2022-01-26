local StartingJobPos = vector3(1486.81, 1408.37, 103.18)
local CheckPointsDrvosjeca = {}

local DrvoModel = GetHashKey("test_tree_cedar_trunk_001")
local logModel = GetHashKey("prop_log_01")
local KamionModel = GetHashKey("scrap")

local DrvecePos = vector3(1461.74, 1399.77, 106.89)
local KamionPos = vector3(1486.96, 1408.35, 103.17)
local PreradaDrvetaLokacija = vector3(1536.43, 2182.82, 78.94)
local KamionSpawnPos = vector3(1489.42, 1395.64, 104.41)

local DrveceCijena = {
    {
        name = "drvo",
        price = 200
    }
}

local imalKam = false
local UtovareniBalvani = 0
local BalvaniNaZemlji = {}
local MojKamion = 0

local PreradaMarkeri = {
    {lok = vector3(1523.08, 2180.31, 78.48), maker = nil},
    {lok = vector3(1525.49, 2175.14, 78.88), maker = nil},
    {lok = vector3(1529.12, 2172.51, 78.64), maker = nil},
    {lok = vector3(1532.39, 2169.65, 78.37), maker = nil},
}

local LokacijaDrvecaZaSpawn = {

    {id = 1, lok = vector3(1472.65, 1401.69, 104.93), cd = 0},
    {id = 2, lok = vector3(1466.96, 1398.60, 105.73), cd = 0},
    {id = 3, lok = vector3(1458.62, 1393.99, 106.34), cd = 0},
    {id = 4, lok = vector3(1450.67, 1389.66, 106.33), cd = 0},
    {id = 5, lok = vector3(1446.19, 1398.87, 105.96), cd = 0},
    {id = 6, lok = vector3(1454.05, 1402.23, 105.91), cd = 0},
    {id = 7, lok = vector3(1463.38, 1404.68, 105.50), cd = 0},
    {id = 8, lok = vector3(1473.33, 1406.02, 104.61), cd = 0},
    {id = 9, lok = vector3(1472.47, 1414.79, 104.54), cd = 0},
    {id = 10, lok = vector3(1463.73, 1417.07, 105.30), cd = 0},
    {id = 11, lok = vector3(1453.84, 1416.79, 105.36), cd = 0},
    {id = 12, lok = vector3(1441.90, 1417.76, 105.21), cd = 0},
    {id = 13, lok = vector3(1439.73, 1428.23, 106.39), cd = 0},
    {id = 14, lok = vector3(1447.54, 1434.80, 106.93), cd = 0},
    {id = 15, lok = vector3(1457.80, 1436.86, 106.83), cd = 0},
    {id = 16, lok = vector3(1469.87, 1437.67, 105.42), cd = 0},
    {id = 17, lok = vector3(1480.11, 1442.01, 103.37), cd = 0},
    {id = 18, lok = vector3(1469.46, 1455.23, 107.65), cd = 0},
    {id = 19, lok = vector3(1457.01, 1457.49, 109.75), cd = 0},
    {id = 20, lok = vector3(1443.45, 1454.52, 109.24), cd = 0},
    {id = 21, lok = vector3(1432.12, 1449.51, 108.27), cd = 0},

}


local SjecenjeDict = "mini@golf"
local SjecenjeAnim = "wedge_swing_intro_high"
local UzimanjeDict = "missbigscore2aig_7@gunman"
local UzimanjeAnim = "boot_r_loop"
local NosenjeDict = "anim@heists@box_carry@"
local NosenjeAnim = "walk"
local UbacivanjeDict = "mp_am_hold_up"
local UbacivanjeAnim = "purchase_beerbox_shopkeeper"

Citizen.CreateThread(function()

    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

    while bFunkcije == nil do
        TriggerEvent("bfunkcije:init", function(ev)
            bFunkcije = ev
        end)
        Citizen.Wait(0)
    end

    UzimanjePoslaBlip = Pravljenjeblip(vector3(1486.96, 1408.35, 103.17), 237, 6, 1.0, 25, true, "Sadnice Drveca - Posao")

end)

AddEventHandler("onResourceStop", function(res)

    if res == GetCurrentResourceName() then
        for i = 1, #LokacijaDrvecaZaSpawn do
            DeleteEntity(LokacijaDrvecaZaSpawn[i].obj)
        end
        DeleteEntity(MojKamion)

        for i = 1,#BalvaniNaZemlji do
            DeleteEntity(BalvaniNaZemlji[i].obj)
        end
    end

end)

local function RestartWholeJob()
    UzeoPoso, UzimaBalvan, NosiBalvan = false, false, false
    UtovareniBalvani = 0
    UzimaVecBalvan = false
    imalKam = false

    DeleteEntity(MojKamion)
    DeleteEntity(Nosecibalvan)

    for i = 1,#BalvaniNaZemlji do
        DeleteEntity(BalvaniNaZemlji[i].obj)
    end

    for i = 1, #LokacijaDrvecaZaSpawn do
        DeleteEntity(LokacijaDrvecaZaSpawn[i].obj)
    end

    UtovareniBalvani = 0

    RemoveBlip(PreradaBLIP)
end


Citizen.CreateThread(function()

    RequestModel(DrvoModel) RequestModel(logModel) RequestModel(KamionModel)
    while not HasModelLoaded(DrvoModel) or not HasModelLoaded(logModel) or not HasModelLoaded(KamionModel) do
        Wait(5)
    end

    RequestAnimDict(SjecenjeDict) RequestAnimDict(UzimanjeDict) RequestAnimDict(NosenjeDict) RequestAnimDict(UbacivanjeDict)
    while not HasAnimDictLoaded(SjecenjeDict) or not HasAnimDictLoaded(UzimanjeDict) or not HasAnimDictLoaded(NosenjeDict) or not HasAnimDictLoaded(UbacivanjeDict) do
        Wait(100)
    end

    while true do
        Citizen.Wait(800)
        local PPed = PlayerPedId()
        local PedPos = GetEntityCoords(PPed)
        local disttoTakingJobLoc = #(PedPos - StartingJobPos)

        DelMarkPoints()

        if UzeoPoso then
            local Gepek = GetOffsetFromEntityInWorldCoords(MojKamion, 0.0, -4.0, 0.0)

            if disttoTakingJobLoc < 40 then
                table.insert(CheckPointsDrvosjeca, CreateCheckpoint(47, StartingJobPos, StartingJobPos, 1.5, 255,0,0, 255, 0))

                if disttoTakingJobLoc < 2 then
                    TriggerEvent("bfunkcije:ticknotif", true, true, "Drzi tipku [E] da zavrsis posao drvosjece")
                    if IsControlPressed(0, 38) then
                        UzeoPoso = false
                        RestartWholeJob()
                    end
                end
            end

            if #(PedPos - PreradaDrvetaLokacija) < 50 then

                for i = 1, #PreradaMarkeri do
                    table.insert(CheckPointsDrvosjeca, CreateCheckpoint(47, PreradaMarkeri[i].lok, PreradaMarkeri[i].lok, 1.5, 0,255,0, 255, 0))

                    if NosiBalvan and not PreradjujeVecDrvo and #(PedPos - PreradaMarkeri[i].lok) < 2 then
                        TriggerEvent("bfunkcije:ticknotif", true, true, "Drzi tipku [E] da pocnes sjecu balvana")
                        if IsControlPressed(0,38) then
                            PreradjujeVecDrvo = true
                            bFunkcije.BlokTipke(true)
                            ClearPedTasks(PPed)

                            TaskPlayAnim(PPed, 'mp_am_hold_up', 'purchase_beerbox_shopkeeper', 5.0, 5.0, -1, 81, 0, 0, 0, 0)

                            TriggerEvent("bfunkcije:tajmerdosto", "Sjecenje balvana...", 10, false, function(prekinuo)
                                if not prekinuo then
                                    DeleteEntity(Nosecibalvan)
                                    NosiBalvan, Nosecibalvan, PreradjujeVecDrvo = false, nil, false

                                    ESX.ShowNotification("Prerada drveta gotova, svoje proizvode mozes naci pored stola")

                                    TriggerServerEvent("bPoslovi:DrvosjecaZavrsioSjecenje", PreradaMarkeri[i].lok)
                                end
                                PreradjujeVecDrvo = false
                                ClearPedTasks(PPed)
                                bFunkcije.BlokTipke(false)
                            end)
                        end
                    end
                end

                if not NosiBalvan and #(Gepek - PedPos) < 2 then
                    if not UzimaBalvan and UtovareniBalvani > 0 then
                        TriggerEvent("bfunkcije:ticknotif", true, true, "Drzi tipku [E] da istovaris balvan")
                        if IsControlPressed(0, 38) then
                            UzimaBalvan = true
                            bFunkcije.BlokTipke(true)
                            TaskPlayAnim(PlayerPedId(), "missbigscore2aig_7@gunman", "boot_r_loop", 1.0, 1.0, -1, 51)

                            TriggerEvent("bfunkcije:tajmerdosto", "Istovaranje balvana...", 5, true, function(prekinuo)
                                if not prekinuo then
                                    Nosecibalvan = CreateObjectNoOffset(logModel, PedPos, true, true, true)
                                    AttachEntityToEntity(Nosecibalvan, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, -0.02, -0.02, 350.0, 100.00, 280.0, true, true, false, true, 1, true)
                                    NosiBalvan = true
                                    UtovareniBalvani = UtovareniBalvani - 1
                                    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "walk", 8.0, 8.0, -1, 51)
                                else
                                    ClearPedTasks(PPed)
                                    UzimaVecBalvan = false
                                end
                                bFunkcije.BlokTipke(false)
                                UzimaBalvan = false
                            end)
                        end
                    end
                end
            end


            if #BalvaniNaZemlji == 0 then
                for i = 1, #LokacijaDrvecaZaSpawn do
                    if LokacijaDrvecaZaSpawn[i].cd <= GetGameTimer() and #(LokacijaDrvecaZaSpawn[i].lok - PedPos) < 2 then

                        if UtovareniBalvani < 9 then
                            TriggerEvent("bfunkcije:ticknotif", true, true, "Drzi tipku [E] da pocnes sjecenje drveta")
                            if IsControlPressed(0, 38) then
                                bFunkcije.BlokTipke(true)
                                TaskPlayAnim(PlayerPedId(), SjecenjeDict, SjecenjeAnim, 8.0, 8.0, -1, 1, 0.5 , 0, 0, 0)

                                sjekira = CreateObject(GetHashKey('prop_w_me_hatchet'), 0, 0, 0, false, true, false)
                                AttachEntityToEntity(sjekira, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, -0.02, -0.02, 350.0, 100.00, 280.0, true, true, false, true, 1, true)

                                TriggerEvent("bfunkcije:tajmerdosto", "Sjeca drveta...", 10, true, function(prekinuo)

                                    if not prekinuo then
                                        LokacijaDrvecaZaSpawn[i].cd = GetGameTimer() + 30000
                                        FreezeEntityPosition(LokacijaDrvecaZaSpawn[i].obj, false)
                                        SetEntityVelocity(LokacijaDrvecaZaSpawn[i].obj, 2.0, 0.0, 0.0)
                                        ClearPedTasks(PPed)
                                        Wait(1000)
                                        DeleteEntity(LokacijaDrvecaZaSpawn[i].obj)

                                        DeleteEntity(sjekira)
                                        bFunkcije.BlokTipke(false)

                                        for a = 1, 3 do
                                            balvan = CreateObjectNoOffset(logModel, LokacijaDrvecaZaSpawn[i].lok.x + a, LokacijaDrvecaZaSpawn[i].lok.y, LokacijaDrvecaZaSpawn[i].lok.z, true, true, true)
                                            while not DoesEntityExist(balvan) do Wait(5) end
                                            FreezeEntityPosition(balvan, true)
                                            table.insert(BalvaniNaZemlji, {obj = balvan, lok = GetEntityCoords(balvan)})
                                        end


                                        ESX.ShowNotification("Posjekao si drvo, utovari balvane u kamion")

                                    end

                                    DeleteEntity(sjekira)
                                    bFunkcije.BlokTipke(false)
                                end)
                                break
                            end
                        else

                            ESX.ShowNotification("Tvoj kamion je pun")

                        end
                    end
                end
            end

            if not NosiBalvan and not UzimaBalvan then
                for i = 1, #BalvaniNaZemlji do
                    if #(BalvaniNaZemlji[i].lok - PedPos) < 2 then

                        TriggerEvent("bfunkcije:ticknotif", true, true, "Drzi tipku [E] da uzmes balvan")

                        if IsControlPressed(0, 38) then
                            UzimaBalvan, BalvanKojiUzima = true, BalvaniNaZemlji[i].obj
                            bFunkcije.BlokTipke(true)
                            TaskPlayAnim(PlayerPedId(), "missbigscore2aig_7@gunman", "boot_r_loop", 1.0, 1.0, -1, 51)

                            TriggerEvent("bfunkcije:tajmerdosto", "Uzimanje balvana...", 5, true, function(prekinuo)
                                if not prekinuo then
                                    AttachEntityToEntity(BalvanKojiUzima, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.15, -0.02, -0.02, 350.0, 100.00, 280.0, true, true, false, true, 1, true)
                                    NosiBalvan = true
                                    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "walk", 8.0, 8.0, -1, 51)

                                    ESX.ShowNotification("Uzeo si balvan sa poda, nosi ga u kamion pa na preradu")

                                else
                                    UzimaVecBalvan = false
                                end
                                bFunkcije.BlokTipke(false)
                                UzimaBalvan = false
                            end)
                            break
                        end
                        break
                    end
                end
            elseif NosiBalvan and #(PedPos - PreradaDrvetaLokacija) > 50 then
                if #(Gepek - PedPos) < 2 then

                    if UtovareniBalvani < 9 then
                        TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] da utovaris balvan!")

                        if IsControlPressed(0,38) then

                            bFunkcije.BlokTipke(true)
                            TaskPlayAnim(PlayerPedId(), NosenjeDict, NosenjeAnim, 1.0, 1.0, -1, 51, 1)
                            TriggerEvent("bfunkcije:tajmerdosto", "Utovaranje balvana...", 5, false, function(prekinuo)
                                if not prekinuo then

                                    for bal = 1, #BalvaniNaZemlji do
                                        if BalvaniNaZemlji[bal].obj == BalvanKojiUzima then
                                            DeleteEntity(BalvanKojiUzima)
                                            table.remove(BalvaniNaZemlji, bal)
                                            UtovareniBalvani = UtovareniBalvani + 1
                                            break
                                        end
                                    end

                                    NosiBalvan, BalvanKojiUzima = false, nil
                                    ClearPedTasks(PPed)

                                    ESX.ShowNotification("Utovario si balvan u kamion")

                                else
                                    UtovaraVecbalvan = false
                                end
                                bFunkcije.BlokTipke(false)
                            end)

                        end
                    end

                end
            end


        elseif not UzeoPoso then

            if disttoTakingJobLoc < 20 then

                table.insert(CheckPointsDrvosjeca, CreateCheckpoint(47, StartingJobPos, StartingJobPos, 1.5, 0,255,0, 255, 0))

                if disttoTakingJobLoc < 2 then
                    TriggerEvent("bfunkcije:ticknotif", true, true, "Drzi tipku [E] da zapocnes posao drvosjece")
                    if IsControlPressed(0, 38) then

                        UzeoPoso = true
                        MojKamion = CreateVehicle(KamionModel, KamionSpawnPos, 100.0, true, false)
                        SpawnAllTrees()
     
                        ESX.ShowNotification("Zapoceo si posao, kamion se nalazi iza tebe, sretno")

                        PreradaBLIP = Pravljenjeblip(PreradaDrvetaLokacija, 237, 6, 1.0, 25, true, "Prerada Balvana")
                    end
                end
			end
		end
	end
end)

				
function DelMarkPoints()
    for i = 1, #CheckPointsDrvosjeca do
        DeleteCheckpoint(CheckPointsDrvosjeca[i])
    end
    CheckPointsDrvosjeca = {}
end

function SpawnAllTrees()

    for i = 1, #LokacijaDrvecaZaSpawn do
        if LokacijaDrvecaZaSpawn[i].cd <= GetGameTimer() then

            LokacijaDrvecaZaSpawn[i].obj = CreateObjectNoOffset(DrvoModel, LokacijaDrvecaZaSpawn[i].lok, false, true, true)
            while not DoesEntityExist(LokacijaDrvecaZaSpawn[i].obj) do
                Wait(10)
            end
            SetEntityAsMissionEntity(LokacijaDrvecaZaSpawn[i].obj, true, true)
            FreezeEntityPosition(LokacijaDrvecaZaSpawn[i].obj, true)

        end
    end

end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if not IsPedInAnyVehicle(PlayerPedId(), false) and UzeoPoso and UtovareniBalvani > 0 then
            local KamionPos = GetEntityCoords(MojKamion)
            if #(KamionPos - GetEntityCoords(PlayerPedId())) < 10 then
                if UtovareniBalvani < 9 then
                    text3d(KamionPos, string.format("Broj balvana u kamionu: %d", UtovareniBalvani), 255)
                else
                    text3d(KamionPos, string.format("Broj balvana u kamionu: %d\nKamion je pun!", UtovareniBalvani), 255)
                end
            end
        else
            Wait(1000)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if NosiBalvan then
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 44, true)
            DisableControlAction(0, 12, true)
            DisableControlAction(0, 13, true)
            DisableControlAction(0, 14, true)
            DisableControlAction(0, 15, true)
            DisableControlAction(0, 16, true)
            DisableControlAction(0, 17, true)
            DisableControlAction(1, 323, true)
            DisableControlAction(0, 323, true)
            DisableControlAction(0, 36, true)
            DisableControlAction(0, 73, true)
            DisableControlAction(0, 105, true)
            DisableControlAction(0, 120, true)
            DisableControlAction(0, 154, true)
            DisableControlAction(0, 186, true)
            DisableControlAction(0, 323, true)
            DisableControlAction(0, 345, true)
            DisableControlAction(0, 354, true)
            DisableControlAction(0, 357, true)
            DisableControlAction(0, 22, true)
        else
            Wait(1000)
        end
    end
end)


text3d = function(coords, text, opacity, a)

    local onScreen, _x, _y = World3dToScreen2d(coords["x"], coords["y"], coords["z"])

    if onScreen then
        SetTextScale(0.45, 0.45)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(237, 184, 121, math.floor(opacity))
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = string.len(text) / 350

        if not a then
            DrawRect(_x,_y + 0.0145, 0.030 + factor, 0.03, 28, 16, 11, 68)
        end
    end
end


Pravljenjeblip = function(lokacija, sprite, display, size, boja, daljina, ime)

    local Blip = AddBlipForCoord(lokacija)
    SetBlipSprite (Blip, sprite)
    SetBlipDisplay(Blip, display)
    SetBlipScale  (Blip, size)
    SetBlipColour (Blip, boja)

    SetBlipHighDetail(blip, true)
	SetBlipCategory(blip, 7)
    SetBlipAsShortRange(Blip, daljina)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(ime)
    EndTextCommandSetBlipName(Blip)
    return Blip
end
