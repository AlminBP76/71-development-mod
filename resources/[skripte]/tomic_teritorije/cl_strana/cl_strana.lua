-- Made by Tomić#9076
local PlayerData = {}
local zauzimaLiprovjera = false
local tajm = 0
local Tipke = { ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118 }

CreateThread(function()
    while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(250) end
    while ESX.GetPlayerData().job == nil do Wait(250) end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

CreateThread(function()
    while true do
        Wait(60000)
        PlayerData = ESX.GetPlayerData()
    end
end)

local blip1 = AddBlipForCoord(Config.TeritorijaKordinate1) -- T1
SetBlipSprite(blip1, 373)
SetBlipDisplay(blip1, 8)
SetBlipScale(blip1, 1.4)
SetBlipColour(blip1, 0)
SetBlipAlpha(blip1, 180)
SetBlipAsShortRange(blip1, true)

local blip2 = AddBlipForCoord(Config.TeritorijaKordinate5) -- T5
SetBlipSprite(blip2, 373)
SetBlipDisplay(blip2, 8)
SetBlipScale(blip2, 1.4)
SetBlipColour(blip2, 0)
SetBlipAlpha(blip2, 180)
SetBlipAsShortRange(blip2, true)

local blip3 = AddBlipForCoord(Config.TeritorijaKordinate7) -- T7
SetBlipSprite(blip3, 373)
SetBlipDisplay(blip3, 8)
SetBlipScale(blip3, 1.4)
SetBlipColour(blip3, 0)
SetBlipAlpha(blip3, 180)
SetBlipAsShortRange(blip3, true)

local blip4 = AddBlipForCoord(Config.TeritorijaKordinate6) -- T6
SetBlipSprite(blip4, 373)
SetBlipDisplay(blip4, 8)
SetBlipScale(blip4, 1.4)
SetBlipColour(blip4, 0)
SetBlipAlpha(blip4, 180)
SetBlipAsShortRange(blip4, true)

local blip5 = AddBlipForCoord(Config.TeritorijaKordinate4) -- T4
SetBlipSprite(blip5, 373)
SetBlipDisplay(blip5, 8)
SetBlipScale(blip5, 1.4)
SetBlipColour(blip5, 0)
SetBlipAlpha(blip5, 180)
SetBlipAsShortRange(blip5, true)

local blip6 = AddBlipForCoord(Config.TeritorijaKordinate2) -- T2
SetBlipSprite(blip6, 373)
SetBlipDisplay(blip6, 8)
SetBlipScale(blip6, 1.4)
SetBlipColour(blip6, 0)
SetBlipAlpha(blip6, 180)
SetBlipAsShortRange(blip6, true)

local blip7 = AddBlipForCoord(Config.TeritorijaKordinate3) -- T3
SetBlipSprite(blip7, 373)
SetBlipDisplay(blip7, 8)
SetBlipScale(blip7, 1.4)
SetBlipColour(blip7, 0)
SetBlipAlpha(blip7, 180)
SetBlipAsShortRange(blip7, true)

CreateThread(function()
    for _, info in pairs(Config.Blipovi) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.7)
        SetBlipColour(info.blip, info.boja)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("tomic_teritorije:zapocniZauzimanjeClient")
AddEventHandler("tomic_teritorije:zapocniZauzimanjeClient", function(job, ter)
    tajm = 0
    local igrac = PlayerPedId()
    if ESX.PlayerData.job and Config.Organizacije[ESX.PlayerData.job.name] then
        zauzimaLiprovjera = true
        TriggerEvent("esx:showNotification", _U('start_cap') .. ter)
        TriggerServerEvent("tomic_teritorije:notify", ter, job)
        while tajm < 100 and zauzimaLiprovjera do
            local kordinate = GetEntityCoords(igrac)
            if (ter == "T1") then
                if (GetDistanceBetweenCoords(Config.TeritorijaKordinate1, kordinate, true) > 50) or IsEntityDead(igrac) then
                    prekiniZauzimanje()
                    zauzimaLiprovjera = false
                end
            end
            if (ter == "T2") then
                if (GetDistanceBetweenCoords(Config.TeritorijaKordinate2, kordinate, true) > 50) or IsEntityDead(igrac) then
                    prekiniZauzimanje()
                    zauzimaLiprovjera = false
                end
            end
            if (ter == "T3") then
                if (GetDistanceBetweenCoords(Config.TeritorijaKordinate3, kordinate, true) > 50) or IsEntityDead(igrac) then
                    prekiniZauzimanje()
                    zauzimaLiprovjera = false
                end
            end
            if (ter == "T4") then
                if (GetDistanceBetweenCoords(Config.TeritorijaKordinate4, kordinate, true) > 50) or IsEntityDead(igrac) then
                    prekiniZauzimanje()
                    zauzimaLiprovjera = false
                end
            end
            if (ter == "T5") then
                if (GetDistanceBetweenCoords(Config.TeritorijaKordinate5, kordinate, true) > 50) or IsEntityDead(igrac) then
                    prekiniZauzimanje()
                    zauzimaLiprovjera = false
                end
            end
            if (ter == "T6") then
                if (GetDistanceBetweenCoords(Config.TeritorijaKordinate6, kordinate, true) > 50) or IsEntityDead(igrac) then
                    prekiniZauzimanje()
                    zauzimaLiprovjera = false
                end
            end
            if (ter == "T7") then
                if (GetDistanceBetweenCoords(Config.TeritorijaKordinate7, kordinate, true) > 50) or IsEntityDead(igrac) then
                    prekiniZauzimanje()
                    zauzimaLiprovjera = false
                end
            end

            if zauzimaLiprovjera == true then
                Wait(Config.Zauzimanje)
                tajm = tajm + 1
                TriggerEvent("esx:showNotification", _U('capture_prog') .. ter .. _U('percent') .. tajm .. "%")
            end
        end

        if tajm >= 100 then
            zauzimaLiprovjera = false
            tajm = 0
            TriggerServerEvent("tomic_teritorije:postavi", ter, job)
        end
    end
end)

function prekiniZauzimanje()
    tajm = 0
    zauzimaLiprovjera = false
    TriggerEvent("esx:showNotification", _U('canceled'))
    TriggerServerEvent("tomic_teritorije:prekiniZauzimanje")
    RemoveBlip(blip)
end


RegisterNetEvent("tomic_teritorije:blip")
AddEventHandler("tomic_teritorije:blip", function(_ter)
    RemoveBlip(blip)
    if _ter == "T1" then
        blip = AddBlipForCoord(Config.TeritorijaKordinate1)
    end
    if _ter == "T2" then
        blip = AddBlipForCoord(Config.TeritorijaKordinate2)
    end
    if _ter == "T3" then
        blip = AddBlipForCoord(Config.TeritorijaKordinate3)
    end
    if _ter == "T4" then
        blip = AddBlipForCoord(Config.TeritorijaKordinate4)
    end
    if _ter == "T5" then
        blip = AddBlipForCoord(Config.TeritorijaKordinate5)
    end
    if _ter == "T6" then
        blip = AddBlipForCoord(Config.TeritorijaKordinate6)
    end
    if _ter == "T7" then
        blip = AddBlipForCoord(Config.TeritorijaKordinate7)
    end
    SetBlipSprite(blip, 161)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 1)
    PulseBlip(blip)
    SetBlipFlashTimer(blip, 5000)
    Wait(60000 * 10) -- Trajanje pulsa
    RemoveBlip(blip)
end)

RegisterNetEvent("tomic_teritorije:prekiniZauzimanje")
AddEventHandler("tomic_teritorije:prekiniZauzimanje", function()
    RemoveBlip(blip)
end)

CreateThread(function()
    while true do
        Wait(5)
        local spavaj = true
        if ESX.PlayerData.job and Config.Organizacije[ESX.PlayerData.job.name] then
            --T1
            local igrac = PlayerPedId()
            local kordinate = GetEntityCoords(igrac)
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate1, kordinate, true) < Config.RadiusPrekidanja) then
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate1, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.15, 0.15, 0.15, 0, 0, 255, 255, true, true, 2, true, false, false, false)
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate1, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 150, false, true, 1, true, false, false, false)
                spavaj = false
            end
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate1, kordinate, true) < 1.5) then
                if not zauzimaLiprovjera then
                    DisplayHelpText("Pritisnite ~INPUT_VEH_HORN~ da zapocnete zauzimanje!")
                    if IsControlJustReleased(0, Tipke["E"]) then
                        if not zauzimaLiprovjera then
                            TriggerServerEvent("tomic_teritorije:zapocniZauzimanje", "T1")
                            tajm = 0
                            Wait(2000)
                        else
                            ESX.ShowNotification("Ova teritorija se vec zauzima!")
                        end
                    end
                end
            end

            --T2
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate2, kordinate, true) < Config.RadiusPrekidanja) then
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate2, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.15, 0.15, 0.15, 0, 0, 255, 255, true, true, 2, true, false, false, false)
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate2, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 150, false, true, 1, true, false, false, false)
                spavaj = false
            end
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate2, kordinate, true) < 1.5) then
                if not zauzimaLiprovjera then
                    DisplayHelpText("Pritisnite ~INPUT_VEH_HORN~ da zapocnete zauzimanje!")
                    if IsControlJustReleased(0, Tipke["E"]) then
                        if not zauzimaLiprovjera then
                            TriggerServerEvent("tomic_teritorije:zapocniZauzimanje", "T2")
                            tajm = 0
                            Wait(2000)
                        else
                            ESX.ShowNotification("Ova teritorija se vec zauzima!")
                        end
                    end
                end
            end

            --T3
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate3, kordinate, true) < Config.RadiusPrekidanja) then
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate3, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.15, 0.15, 0.15, 0, 0, 255, 255, true, true, 2, true, false, false, false)
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate3, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 150, false, true, 1, true, false, false, false)
                spavaj = false
            end
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate3, kordinate, true) < 1.5) then
                if not zauzimaLiprovjera then
                    DisplayHelpText("Pritisnite ~INPUT_VEH_HORN~ da zapocnete zauzimanje!")
                    if IsControlJustReleased(0, Tipke["E"]) then
                        if not zauzimaLiprovjera then
                            TriggerServerEvent("tomic_teritorije:zapocniZauzimanje", "T3")
                            tajm = 0
                            Wait(2000)
                        else
                            ESX.ShowNotification("Ova teritorija se vec zauzima!")
                        end
                    end
                end
            end

            --T4
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate4, kordinate, true) < Config.RadiusPrekidanja) then
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate4, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.15, 0.15, 0.15, 0, 0, 255, 255, true, true, 2, true, false, false, false)
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate4, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 150, false, true, 1, true, false, false, false)
                spavaj = false
            end
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate4, kordinate, true) < 1.5) then
                if not zauzimaLiprovjera then
                    DisplayHelpText("Pritisnite ~INPUT_VEH_HORN~ da zapocnete zauzimanje!")
                    if IsControlJustReleased(0, Tipke["E"]) then
                        if not zauzimaLiprovjera then
                            TriggerServerEvent("tomic_teritorije:zapocniZauzimanje", "T4")
                            tajm = 0
                            Wait(2000)
                        else
                            ESX.ShowNotification("Ova teritorija se vec zauzima!")
                        end
                    end
                end
            end

            --T5
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate5, kordinate, true) < Config.RadiusPrekidanja) then
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate5, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.15, 0.15, 0.15, 0, 0, 255, 255, true, true, 2, true, false, false, false)
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate5, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 150, false, true, 1, true, false, false, false)
                spavaj = false
            end
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate5, kordinate, true) < 1.5) then
                if not zauzimaLiprovjera then
                    DisplayHelpText("Pritisnite ~INPUT_VEH_HORN~ da zapocnete zauzimanje!")
                    if IsControlJustReleased(0, Tipke["E"]) then
                        if not zauzimaLiprovjera then
                            TriggerServerEvent("tomic_teritorije:zapocniZauzimanje", "T5")
                            tajm = 0
                            Wait(2000)
                        else
                            ESX.ShowNotification("Ova teritorija se vec zauzima!")
                        end
                    end
                end
            end

            --T6
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate6, kordinate, true) < Config.RadiusPrekidanja) then
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate6, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.15, 0.15, 0.15, 0, 0, 255, 255, true, true, 2, true, false, false, false)
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate6, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 150, false, true, 1, true, false, false, false)
                spavaj = false
            end
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate6, kordinate, true) < 1.5) then
                if not zauzimaLiprovjera then
                    DisplayHelpText("Pritisnite ~INPUT_VEH_HORN~ da zapocnete zauzimanje!")
                    if IsControlJustReleased(0, Tipke["E"]) then
                        if not zauzimaLiprovjera then
                            TriggerServerEvent("tomic_teritorije:zapocniZauzimanje", "T6")
                            tajm = 0
                            Wait(2000)
                        else
                            ESX.ShowNotification("Ova teritorija se vec zauzima!")
                        end
                    end
                end
            end

            --T7
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate7, kordinate, true) < Config.RadiusPrekidanja) then
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate7, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.15, 0.15, 0.15, 0, 0, 255, 255, true, true, 2, true, false, false, false)
                DrawMarker(Config.TipMarkera, Config.TeritorijaKordinate7, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 150, false, true, 1, true, false, false, false)
                spavaj = false
            end
            if (GetDistanceBetweenCoords(Config.TeritorijaKordinate7, kordinate, true) < 1.5) then
                if not zauzimaLiprovjera then
                    DisplayHelpText("Pritisnite ~INPUT_VEH_HORN~ da zapocnete zauzimanje!")
                    if IsControlJustReleased(0, Tipke["E"]) then
                        if not zauzimaLiprovjera then
                            TriggerServerEvent("tomic_teritorije:zapocniZauzimanje", "T7")
                            tajm = 0
                            Wait(2000)
                        else
                            ESX.ShowNotification("Ova teritorija se vec zauzima!")
                        end
                    end
                end
            end
        end
        if spavaj then Wait(1337) end
    end
end)
