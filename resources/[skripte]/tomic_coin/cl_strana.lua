-- Made by Tomić#9076
ESX = nil
local tCoinStvoren = false

 CreateThread(function() 
     while ESX == nil do 
         TriggerEvent('esx:getSharedObject', function(obj) 
             ESX = obj 
         end) 
         Wait(0) 
     end 
 end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D(x, y, z, text, scale) 
    local onScreen, _x, _y = World3dToScreen2d(x, y, z) 
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) 
    SetTextScale(scale, scale) 
    SetTextFont(4) 
    SetTextProportional(1) 
    SetTextEntry("STRING") 
    SetTextCentre(true) 
    SetTextColour(255, 255, 255, 215) 
    AddTextComponentString(text)
    DrawText(_x, _y) 
    local factor = (string.len(text)) / 700 
    DrawRect(_x, _y + 0.0150, 0.095 + factor, 0.03, 41, 11, 41, 0) 
end

local function tCoin()
    ESX.TriggerServerCallback("tCoin:randomx", function(imax)
        if imax then
            --print(imax)
            ESX.TriggerServerCallback("tCoin:randomy", function(imay)
                if imay then
                    --print(imay)
                    ESX.TriggerServerCallback("tCoin:randomz", function(imaz)
                        if imaz then
                            --print(imaz)
                            ESX.TriggerServerCallback("tCoin:randoml", function(imal)
                                if imal then
                                    --print(imal)
                                    CreateThread(function()
                                        if not tCoinStvoren then
                                            tCoinStvoren = true
                                            TriggerEvent('chat:addMessage', {color = Config.PrefixColor, multiline = false, args = {Config.PrefixPoruke, "tCoin je spawn-an u blizni: "..imal..". (/"..Config.ProvjeriStanjeKomanda..", /"..Config.NagradaKomanda..")"}})
                                            while tCoinStvoren do
                                                Wait(0)
                                                local igrac = PlayerPedId()
                                                local igrackordinate = GetEntityCoords(igrac)
                                                local spavaj = true
                                                if (GetDistanceBetweenCoords(igrackordinate, imax, imay, imaz, true) < 200.0) then 
                                                    spavaj = false
                                                    DrawMarker(2, imax, imay, imaz, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.30, 0.30, 0.30, 255, 255, 255, 150, false, true, 2, true, false, false, false)
                                                    DrawMarker(2, imax, imay, imaz, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.25, 0.25, 0.25, 51, 102, 153, 255, true, true, 2, true, false, false, false)
                                                    if (GetDistanceBetweenCoords(igrackordinate, imax, imay, imaz, true) < 4) then
                                                        DrawText3D(imax, imay, imaz+0.55, Config.First3DMessage, 0.5)
                                                        DrawText3D(imax, imay, imaz+0.4, Config.Second3DMessage, 0.5)
                                                        if (GetDistanceBetweenCoords(igrackordinate, imax, imay, imaz, true) < 1.5) then
                                                            if IsControlJustPressed(0, 38) then
                                                                TriggerServerEvent("tCoin:pokupio", false)
                                                                TriggerServerEvent("tCoin:postavi")
                                                                TriggerServerEvent("tCoin:pokupioPoruka")
                                                                tCoinStvoren = false
                                                            end
                                                        end
                                                    end
                                                end
                                                if spavaj then Wait(1337) end
                                            end
                                        else
                                            tCoinStvoren = false
                                            TriggerEvent('chat:addMessage', {color = Config.PrefixColor, multiline = false, args = {Config.PrefixPoruke, "tCoin nikada nije pronadjen... Vise sreće drugi put!"}})
                                        end
                                    end)
                                end
                            end)
                        end
                    end)
                end
            end)
        end
    end)
end

RegisterNetEvent('tCoin:zapocniClient')
AddEventHandler('tCoin:zapocniClient', function(zapocni)
    tCoin()
end)

RegisterNetEvent('tCoin:pokupio')
AddEventHandler('tCoin:pokupio', function(vr)
    tCoinStvoren = vr
end)

