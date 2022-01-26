-- ty Stane <3 github.com/Stane034
ESX = nil
local PlayerLoaded = false
wanted = false

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end

        PlayerLoaded = true
        ESX.PlayerData = ESX.GetPlayerData()
    end
)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
    "esx:playerLoaded",
    function(xPlayer)
        ESX.PlayerData = xPlayer
        PlayerLoaded = true
    end
)

AddEventHandler(
    "playerSpawned",
    function()
        wanted = false
        ESX.TriggerServerCallback(
            "horizon_wanted:getajWantedLevel",
            function(wanted)
                if wanted then
                    while not PlayerLoaded do
                        Citizen.Wait(1000)
                    end
                    wanted = true
                    ESX.ShowNotification("Još uvijek ste na listi traženih, pazite se!")
                end
            end
        )
    end
)
