Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
    
    while bFunkcije == nil do
        Wait(10)
        TriggerEvent('bfunkcije:init', function(resp) bFunkcije = resp end)
    end 
    

    local blip = AddBlipForCoord(vector3(705.38, 6467.69, 30.44))
    SetBlipSprite (blip, 141) -- $ Sign
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 1.0)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Ranc sa kravama")
    EndTextCommandSetBlipName(blip)

    SetBlipHighDetail(blip, true)
    SetBlipCategory(blip, 7)

end)



local RancKrave = vector3(705.38, 6467.69, 30.44)
local KraveLoc = {
    vector3(716.80, 6462.82, 29.58),
    vector3(707.92, 6463.11, 29.54),
    vector3(699.25, 6463.23, 29.62),
    vector3(699.42, 6471.94, 29.07),
    vector3(708.70, 6472.37, 28.72),
    vector3(715.50, 6471.99, 28.21),
}

local GovnaLoc = {
    {loc = vector3(717.68, 6458.83, 30.03), id = 1, CP = nil},
    {loc = vector3(710.74, 6458.20, 29.75), id = 2, CP = nil},
    {loc = vector3(701.75, 6458.32, 29.67), id = 3, CP = nil},
    {loc = vector3(693.74, 6462.69, 29.77), id = 4, CP = nil},
    {loc = vector3(691.14, 6469.59, 29.40), id = 5, CP = nil},
    {loc = vector3(695.81, 6477.52, 28.29), id = 6, CP = nil},
    {loc = vector3(705.13, 6478.53, 28.38), id = 7, CP = nil},
    {loc = vector3(711.75, 6472.55, 28.46), id = 8, CP = nil},
    {loc = vector3(706.41, 6465.35, 29.47), id = 9, CP = nil},
    {loc = vector3(700.36, 6468.47, 29.46), id = 10, CP = nil},
    {loc = vector3(696.64, 6479.43, 28.10), id = 11, CP = nil},
}

local IzabranaGovna = {}


local KraveModel = GetHashKey("a_c_cow")
local SpawnaneKrave = {}
local AlatLoc = vector3(751.66, 6459.20, 30.38)
local PreradaMlijekaLoc = vector3(747.63, 6455.18, 31.92)

AddEventHandler("onResourceStop", function(srcName)

    if GetCurrentResourceName() == srcName then
        for i = 1, #SpawnaneKrave do 
            DeleteEntity(SpawnaneKrave[i].krava)
        end
    end
end)

Citizen.CreateThread(function()
    RequestModel(KraveModel)
    while not HasModelLoaded(KraveModel) do 
        Wait(10)
    end

    while true do
        Citizen.Wait(800)
        local pPed = PlayerPedId()
        local pPedLoc = GetEntityCoords(pPed)
        
        if not RadiAkciju then
            if #(RancKrave - pPedLoc) <= 80 then
                if not PrisaoVecKravama then

                    NapraviKrave()
                    AlatCP = CreateCheckpoint(47, AlatLoc, AlatLoc, 2.0, 255, 0, 0, 255, 0)
                    PrisaoVecKravama = true

                end

            elseif PrisaoVecKravama and #(RancKrave - pPedLoc) > 80 then

                Resetuj()
                PrisaoVecKravama = false
            end

            if not OcistioGovna then
                if not UzeoAlat then
                    if #(AlatLoc - pPedLoc) < 1.5 then
                        TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] da uzmes alat")
                        if IsControlPressed(0, 38) then
                            RadiAkciju = true
                            bFunkcije.BlokTipke(true)
                            TriggerEvent("bfunkcije:tajmerdosto", "Uzimanje alata...", 5, true, function(jel)
                            
                                if not jel then
                                  UzeoAlat = true
                                
                                  ESX.ShowNotification("Uzeo si potreban alat, prvo ocisti govna, pa onda pomuzi krave")

                                end
                               
                                bFunkcije.BlokTipke(false)
                                RadiAkciju = false

                            end)
                        end
                    end
                elseif UzeoAlat then  
                    if not DobioGovna then
                        DobioGovna = true
                        NapraviGovna()
                    end

                    for gov = 1, #IzabranaGovna do 
                        if #(IzabranaGovna[gov].loc - pPedLoc) < 1.5 then
                            TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] da ocistis govna")
                            if IsControlPressed(0, 38) then
                                RadiAkciju = true
                                
                                TaskStartScenarioInPlace(pPed, 'world_human_gardener_plant', 0, true)

                                bFunkcije.BlokTipke(true)
                                TriggerEvent("bfunkcije:tajmerdosto", "Ciscenje govana...", 5, true, function(jel)
                                    
                                    if not jel then
                                        DeleteCheckpoint(IzabranaGovna[gov].CP)
                                        table.remove(IzabranaGovna, gov)

                                        if #IzabranaGovna == 0 then
                                            OcistioGovna = true
                                            TriggerServerEvent("bPoslovi:kraveGotovoCiscenje")

                                            ESX.ShowNotification("Ocistio si sva govna, sada pomuzi krave")

                                        end
                                    end
                                    ClearPedTasks(pPed)
                                    bFunkcije.BlokTipke(false)
                                    RadiAkciju = false
                                end)
                            end
                        end
                    end
                end

            elseif OcistioGovna and UzeoAlat and not ZavrsioKrave then
                for sKrava = 1, #SpawnaneKrave do
                    if not SpawnaneKrave[sKrava].zavrseno then
                        if SpawnaneKrave[sKrava].tempcp then DeleteCheckpoint(SpawnaneKrave[sKrava].tempcp) end

                        KravaLoc = GetEntityCoords(SpawnaneKrave[sKrava].krava)
                        SpawnaneKrave[sKrava].tempcp = CreateCheckpoint(47, KravaLoc, KravaLoc, 0.5, 0, 255, 0, 255, 0)

                        if PrisaoVecKravama and #(KravaLoc - pPedLoc) < 2 and not MuzeKravu then
                            TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] da pomuzes kravu")
                            if IsControlPressed(0,38) then
                                bFunkcije.BlokTipke(true)
                                RadiAkciju = true
                                TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                                TriggerEvent("bfunkcije:tajmerdosto", "Mu", 5, true, function(jel)
                                        
                                    if not jel then
                                        DeleteCheckpoint(SpawnaneKrave[sKrava].tempcp)
                                        SpawnaneKrave[sKrava].zavrseno = true

                                        ZavrseneKrave = 0
                                        for h = 1, #SpawnaneKrave do 
                                            if SpawnaneKrave[h].zavrseno then
                                                ZavrseneKrave = ZavrseneKrave + 1 
                                            end
                                        end

                                        if ZavrseneKrave >= 6 then
                                            ZavrsioKrave = true
 
                                            ESX.ShowNotification("Pomuzao si krave, odvuci mlijeko na preradu")

                                        end
                                    end
                                    ClearPedTasks(pPed)
                                    bFunkcije.BlokTipke(false)
                                    RadiAkciju = false
                                end)
                            end
                        end
                    end
                end
            end

            if UzeoAlat then
                if #(AlatLoc - pPedLoc) < 1.5 then
                    TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] da vratis alat")
                    if IsControlPressed(0, 38) then
                        RadiAkciju = true
                        bFunkcije.BlokTipke(true)
                        TriggerEvent("bfunkcije:tajmerdosto", "Vracanje alata...", 5, true, function(jel)
                            if not jel then
                                Resetuj()
                            end
                            bFunkcije.BlokTipke(false)
                        end)
                    end
                end
            end

            if ZavrsioKrave then
                if not ImaMarkerPreradaMlijeka then
                    PreradaCPMlijeko = CreateCheckpoint(47, PreradaMlijekaLoc, PreradaMlijekaLoc, 1.5, 0, 0, 255, 255, 0)
                    ImaMarkerPreradaMlijeka = true
                end

                if not RadiAkciju and #(PreradaMlijekaLoc - pPedLoc) < 1.5 then
                    TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] preradis mlijeko")
                    if IsControlPressed(0,38) then
                        RadiAkciju = true
                        TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                        bFunkcije.BlokTipke(true)
                        TriggerEvent("bfunkcije:tajmerdosto", "Prerada mlijeka...", 5, true, function(jel)
                            if not jel then
                                TriggerServerEvent("bPoslovi:mlijekoprerada")
                                Resetuj()

                                ESX.ShowNotification("Preradio si mlijeko, ako zelis ponovi postupak za jos")

                            end
                            bFunkcije.BlokTipke(false)
                            ClearPedTasksImmediately(pPed)
                        end)
                    end
                end

            end
        end
    end
end)


function NapraviKrave()
    for krava = 1, #KraveLoc do 
        local krava = CreatePed(28, KraveModel, KraveLoc[krava], 120.0, false, true)
        SetEntityInvincible(krava, true)
        SetBlockingOfNonTemporaryEvents(krava, true)
        SetPedCanBeTargetted(krava, false)
        table.insert(SpawnaneKrave, {krava = krava, tempcp = nil})
    end
end

function NapraviGovna()
    for a = 1, 5 do
        local IzabBroj = math.random(1, #GovnaLoc)
        for d = 1, #IzabranaGovna do
            while IzabranaGovna[d].id == GovnaLoc[IzabBroj].id do
                IzabBroj = math.random(1, #GovnaLoc)
            end
        end

        GovnaLoc[IzabBroj].CP = CreateCheckpoint(47, GovnaLoc[IzabBroj].loc, GovnaLoc[IzabBroj].loc, 2.0, 0, 255, 0, 150, 0)
        table.insert(IzabranaGovna, GovnaLoc[IzabBroj])
    end
end

function Resetuj()

    for i = 1, #SpawnaneKrave do 
        DeleteCheckpoint(SpawnaneKrave[i].tempcp)
        SpawnaneKrave[i].zavrseno = false
    end

    DeleteCheckpoint(PreradaCPMlijeko)

    for d = 1, #IzabranaGovna do
        DeleteCheckpoint(IzabranaGovna[d].CP)
    end

    UzeoAlat = false
    DobioGovna = false
    OcistioGovna = false
    ZavrsioKrave = false
    RadiAkciju = false

end

function StartAnimaciju(a ,b)

    RequestAnimDict(a)
    while not HasAnimDictLoaded(a) do 
        Wait(5)
    end

    TaskPlayAnim(PlayerPedId(), a, b, 2.0, 2.0, -1, 57, 1.0, 0, 0, 0)

end