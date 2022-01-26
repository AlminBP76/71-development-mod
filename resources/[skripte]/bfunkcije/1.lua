bFunkcije = {}
sveOtvoreno = false



randomGen = {322,200,177,25,24,257,25,263,32,34,31,30,45,22,44,37,23,288,289,170,"a","b","c","d","e","f","g","c","q","$","!","*"}

local resource = GetCurrentResourceName()
local callbacks = {}
local eventName = resource..':bfunkcijeCallback'

----------------------SERVER DIO--------------------------

if IsDuplicityVersion() then

    AddEventHandler("bfunkcije:init", function(cb)
        while not bFunkcije do Wait(100) end
        cb(bFunkcije)
    end)

    --------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------SERVER STRANA---------------------------------------------
    --------------------------------------------------------------------------------------------------------------
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


    bFunkcije = {}

    bFunkcije.idHash = function(max)
        local string = ""

        for i = 1, max do
            string = string .. randomGen[math.random(1,32)]
        end

        return string
    end

    ServerCallbacks = {}

    bFunkcije.callback_s = function(name, cb)
        ServerCallbacks[name] = cb
    end

    bFunkcije.callback = function(name, requestId, source, cb, ...)
        if ServerCallbacks[name] ~= nil then
            ServerCallbacks[name](source, cb, ...)
        else
            print(('Callback "%s" Ne postoji na serveru'):format(name))
        end
    end

        RegisterServerEvent('bfunkcije:triggerServerCallback')
        AddEventHandler('bfunkcije:triggerServerCallback', function(name, requestId, ...)
            local playerId = source
            bFunkcije.callback(name, requestID, playerId, function(...)
                TriggerClientEvent('bfunkcije:serverCallback', playerId, requestId, ...)
            end, ...)
        end)

        RegisterServerEvent("bfunkcije:notifDrugoj")
        AddEventHandler("bfunkcije:notifDrugoj", function(osoba, title, text, vrijeme, vrsta)
            TriggerClientEvent("bfunkcije:notif", osoba, title, text, vrijeme, vrsta)
        end)

        RegisterServerEvent("bfunkcije:notif_admin")
        AddEventHandler("bfunkcije:notif_admin", function(naslov, text, stil, duzina)
            local xPlayers = ESX.GetPlayers()

            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            
                if xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "admin" then
                    TriggerClientEvent("bfunkcije:notif_admin", xPlayers[i], naslov, text, false, 20)
                end
            end
        
        
        end)

else

--------------------------------------------------------------------------------------------------------------
----------------------------------------------------CLIENT STRANA---------------------------------------------
--------------------------------------------------------------------------------------------------------------
   
        ServerCallbacks           = {}
        TimeoutCallbacks          = {}
        CurrentRequestId          = 0

        bFunkcije.callback = function(name, cb, ...)
            ServerCallbacks[CurrentRequestId] = cb

            TriggerServerEvent('bfunkcije:triggerServerCallback', name, CurrentRequestId, ...)
            if CurrentRequestId < 65535 then
                CurrentRequestId = CurrentRequestId + 1
            else
                CurrentRequestId = 0
            end
        end


        RegisterNetEvent('bfunkcije:serverCallback')
        AddEventHandler('bfunkcije:serverCallback', function(requestId, ...)
            if requestId then
                ServerCallbacks[requestId](...)
                ServerCallbacks[requestId] = nil
            else
                print("nije poslao request")
            end
        end)

        AddEventHandler("bfunkcije:tajmerdosto", function(text,vrijeme,blokanje, cb)
        
            pritisnuoblok = false
            local ukupnovrijeme = vrijeme * 1000
            local fTajmer = 0
            local lok = GetEntityCoords(PlayerPedId())
            Citizen.CreateThread(function()
                while fTajmer < math.floor((ukupnovrijeme/100) + (100 - ukupnovrijeme/100)) and not pritisnuoblok do 
                    fTajmer = fTajmer + 1
                    SendNUIMessage({
                        loading = "broji",
                        postotak = fTajmer,
                        abort = blokanje,
                        naslov = text
                    })

                    Wait(math.floor(ukupnovrijeme/100))
                end
            end)

            while fTajmer < 100 and not pritisnuoblok do 
                Citizen.Wait(9)
                if blokanje then
                    if IsDisabledControlJustPressed(0, 38) then
                        pritisnuoblok = true
                        SendNUIMessage({
                            loading = "sakrij"
                        })
                        cb(true)
                    end
                end
            end

            if not pritisnuoblok then
                SendNUIMessage({
                    loading = "sakrij",
                })
                cb(false)
            end
        end)


        RegisterNetEvent("bfunkcije:notif_admin")
        AddEventHandler("bfunkcije:notif_admin", function(naslov, text, stil, duzina)
            

            SendNUIMessage({
                pokazano = "test",
                naslov = naslov,
                text = text,
                style = stil,
                duzina = duzina,
                admin = true    
            })

            PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", 1)
            Citizen.Wait(500)
            PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", 1)
            Citizen.Wait(500)
            PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", 1)
            Citizen.Wait(500)
            PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", 1)
            Citizen.Wait(500)
            PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", 1)
        
        end)


        RegisterNetEvent("bfunkcije:notif")
        AddEventHandler("bfunkcije:notif", function(naslov, text, duzina, stil)
            
            if stil then
                PlaySoundFrontend(-1, "Zone_Neutral", "DLC_Apartments_Drop_Zone_Sounds", 1)
            else
                PlaySoundFrontend(-1, "Exit_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds", 1)
            end

            SendNUIMessage({
                pokazano = "test",
                naslov = naslov,
                text = text,
                style = stil,
                duzina = duzina,     
            })

        end)
        
        Citizen.CreateThread(function()
            while true do 
                Citizen.Wait(8)
                if not sveOtvoreno and IsControlPressed(0, 243) then
                    SendNUIMessage({
                        pokazano = "sve",
                        sve = true
                    })
                    SetNuiFocus(true, true)
                    SetNuiFocusKeepInput(true)
                    sveOtvoreno = true
                end

                if sveOtvoreno then
                    DisableControlAction(0, 1, true)
                    DisableControlAction(0, 2, true)
                    DisableControlAction(0, 14, true)
                    DisableControlAction(0, 15, true)
                    DisableControlAction(0, 16, true)
                    DisableControlAction(0, 17, true)
                    if IsControlJustReleased(0,243) then
                        SendNUIMessage({
                            pokazano = "sve",
                            sve = false
                        })
                        SetNuiFocus(false, false)
                        SetNuiFocusKeepInput(false)
                        sveOtvoreno = false
                    end
                end
            end
        
        end)


        AddEventHandler("bfunkcije:ticknotif", function(bool, tick, text, time)
            
            SendNUIMessage({
                ticknotif = true,
                bool = bool,
                text = text,
                tick = tick
            })

            if time ~= -1 then
                if time ~= nil then
                    Citizen.CreateThread(function()
                        while true do 
                            Citizen.Wait(time*1000)
                            SendNUIMessage({
                                ticknotif = true,
                                bool = false,
                                tick = tick
                            })
                        end
                    end)
                end
            end
    
        end)

        AddEventHandler("bfunkcije:init", function(cb)
            while not bFunkcije do Wait(100) end
            cb(bFunkcije)
        end)


end
