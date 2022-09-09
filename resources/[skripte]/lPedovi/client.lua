ESX = nil 
CreateThread(function()
    while ESX == nil do
        Wait(0)

        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
    end
end)

--[[ ZATRAŽI MODEL PEDA ]]--
_RequestModel = function(hash)
    if type(hash) == "string" then hash = GetHashKey(hash) end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
end

--[[ OBRIŠI PEDOVE ]]--
BrisiPeda = function()
    for i=1, #Config.Lokacijepedova do
        local ped = Config.Lokacijepedova[i]["ped"]
        if DoesEntityExist(ped["entity"]) then
            DeletePed(ped["entity"])
            SetPedAsNoLongerNeeded(ped["entity"])
        end
    end
end

CreateThread(function()
    local defaultHash = 416176080
    for i=1, #Config.Lokacijepedova do
        local ped = Config.Lokacijepedova[i]["ped"]
        if ped then
            ped["hash"] = ped["hash"] or defaultHash
            _RequestModel(ped["hash"])
            if not DoesEntityExist(ped["entity"]) then
                ped["entity"] = CreatePed(4, ped["hash"], ped["x"], ped["y"], ped["z"], ped["h"])
                SetEntityAsMissionEntity(ped["entity"])
                SetBlockingOfNonTemporaryEvents(ped["entity"], true)
                FreezeEntityPosition(ped["entity"], true)
                SetEntityInvincible(ped["entity"], true)
            end
            SetModelAsNoLongerNeeded(ped["hash"])
        end
    end
end)

--[[ Deletes the peds when the resource stops ]]--
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        BrisiPeda()
    end
end)