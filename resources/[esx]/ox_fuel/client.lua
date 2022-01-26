local inStation = false
local isFueling = false
local inStationInterval

local function findClosestPump(coords, radius)
    for i = 1, #ox.pumpModels do
        local pumpObject = GetClosestObjectOfType(coords.x, coords.y, coords.z, radius, ox.pumpModels[i], false, false, false)

        if pumpObject ~= 0 then
            return pumpObject
        end
    end

    return false
end

local function notify(message)
    ESX.ShowNotification(message)
end

for i = 1, #ox.stations do
    ox.stations[i]:onPlayerInOut(function(isInside)
        inStation = isInside

        if not ox.qtarget and not inStationInterval and isInside then
            inStationInterval = SetInterval(function()
                local ped = PlayerPedId()
                local playerCoords = GetEntityCoords(ped)
                local pumpObject = findClosestPump(playerCoords, 1.5)

                if not pumpObject then return end

                if IsPedInAnyVehicle(ped) then
                    DisplayHelpTextThisFrame('fuelLeaveVehicleText', false)
                elseif not isFueling then
                    DisplayHelpTextThisFrame('fuelHelpText', false)
                end
            end)
        elseif not isInside and inStationInterval then
            ClearInterval(inStationInterval)
            inStationInterval = nil
        end
    end)

    if ox.showBlips == 2 then
        local coords = ox.stations[i]:getBoundingBoxCenter()
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 415)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 23)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Benzinska Pumpa')
        EndTextCommandSetBlipName(blip)
    end
end

if ox.showBlips == 1 then
    local currentBlip
    local closestStation
    local currentStation

    SetInterval(function()
        local playerCoords = GetEntityCoords(PlayerPedId())
        local closestDistance

        for i = 1, #ox.stations do
            local station = ox.stations[i]
            local distance = #(playerCoords - station:getBoundingBoxCenter())

            if not closestDistance or distance < closestDistance then
                closestDistance = distance
                closestStation = station
            end
        end

        if not currentStation or closestStation ~= currentStation then
            if DoesBlipExist(currentBlip) then
                RemoveBlip(currentBlip)
            end

            local coords = closestStation:getBoundingBoxCenter()
            currentBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
            SetBlipSprite(currentBlip, 415)
            SetBlipDisplay(currentBlip, 4)
            SetBlipScale(currentBlip, 0.6)
            SetBlipColour(currentBlip, 23)
            SetBlipAsShortRange(currentBlip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName('Najbliza Benzinska Pumpa')
            EndTextCommandSetBlipName(currentBlip)
        end

        currentStation = closestStation
    end, 5000)
end

-- Synchronize fuel
SetInterval(function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped, false)

	if vehicle == 0 or GetPedInVehicleSeat(vehicle, -1) ~= ped or not GetIsVehicleEngineRunning(vehicle) then
        return
    end

    local usage = ox.rpmUsage[math.floor(GetVehicleCurrentRpm(vehicle) * 10) / 10]
    local multiplier = ox.classUsage[GetVehicleClass(vehicle)] or 1.0

    local Vehicle = Entity(vehicle).state
    local fuel = Vehicle.fuel

    local newFuel = fuel and fuel - usage * multiplier or GetVehicleFuelLevel(vehicle)

    if newFuel < 0 or newFuel > 100 then
        newFuel = GetVehicleFuelLevel(vehicle)
    end

    SetVehicleFuelLevel(vehicle, newFuel)
    -- print(newFuel) -- debug
    Vehicle:set('fuel', newFuel, true)
end, 1000)

local function StartFueling(vehicle)
    isFueling = true
    local price = 0
    local moneyAmount = exports.ox_inventory:Search(2, 'money')

    local Vehicle = Entity(vehicle).state
    local fuel = Vehicle.fuel

    if 100 - fuel < ox.refillValue then
        return notify('Rezervoar pun')
    end

    local duration = math.ceil((100 - fuel) / ox.refillValue) * ox.refillTick

    TaskTurnPedToFaceEntity(ped, vehicle, duration)

    Wait(0)

    exports.ox_inventory:Progress({
        duration = duration,
        label = 'Tocenje goriva',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false
        },
        anim = {
            dict = 'timetable@gardener@filling_can',
            clip = 'gar_ig_5_filling_can',
            flags = 49,
        },
    }, function(cancel)
        if cancel then
            isFueling = false
        end
    end)

    while isFueling do
        price += ox.priceTick

        -- Commented out for debug
        -- if price >= moneyAmount then
        --     exports.ox_inventory:CancelProgress()
        -- end

        fuel += ox.refillValue

        if(fuel >= 100) then
            isFueling = false
            fuel = 100.0
        end

        Wait(ox.refillTick)
    end

    Vehicle:set('fuel', fuel, true)
    SetVehicleFuelLevel(vehicle, fuel)
    TriggerServerEvent('ox_fuel:pay', price)
    -- DEBUG
    notify(fuel)
end

RegisterCommand('gorivo', function()
    local ped = PlayerPedId()

    if not inStation or isFueling or IsPedInAnyVehicle(ped) then
        -- print('skipping fuel -- debug')
        return
    end

    local playerCoords = GetEntityCoords(ped)

    local pumpObject = findClosestPump(playerCoords, 1.5)

    if not pumpObject then
        return notify('Primakni se pumpi')
    end

    local vehicle = GetPlayersLastVehicle()

    if vehicle == 0 or #(GetEntityCoords(vehicle) - playerCoords) > 3 then
        return notify('Vozilo predaleko od pumpe')
    end

    StartFueling(vehicle)
end)

RegisterKeyMapping('gorivo', 'Natoci gorivo u auto', 'keyboard', 'e')
TriggerEvent('chat:removeSuggestion', '/gorivo')
AddTextEntry('fuelHelpText', 'Pritisni ~INPUT_C2939D45~ da natocis gorivo')
AddTextEntry('fuelLeaveVehicleText', 'Izadji iz vozila da punis gorivo')
