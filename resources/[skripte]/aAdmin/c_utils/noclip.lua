RNE = function(e, ...) RegisterNetEvent(e) AddEventHandler(e, ...) end
CT = function(h) Citizen.CreateThread(h) end
CW = function(a) Citizen.Wait(a) end
TE = function(e, ...) TriggerEvent(e, ...) end
TSE = function(e, ...) TriggerServerEvent(e, ...) end
TCE = function(e, ...) TriggerClientEvent(e, ...) end
EH = function(e, ...) AddEventHandler(e, ...) end

--==--==--==--
-- Config
--==--==--==--

local config = {
    controls = {
        -- [[Controls, list can be found here : https://docs.fivem.net/game-references/controls/]]
        openKey = 288, -- [[F2]]
        goUp = 172, -- [[Q]]
        goDown = 173, -- [[Z]]
        turnLeft = 34, -- [[A]]
        turnRight = 35, -- [[D]]
        goForward = 32,  -- [[W]]
        goBackward = 33, -- [[S]]
        changeSpeed = 21, -- [[L-Shift]]
    },

    speeds = {
        -- [[If you wish to change the speeds or labels there are associated with then here is the place.]]
        { label = "Veoma Sporo", speed = 0},
        { label = "Sporo", speed = 0.5},
        { label = "Normalno", speed = 2},
        { label = "Brzo", speed = 4},
        { label = "Veoma Brzo", speed = 6},
        { label = "Jos Brze", speed = 10},
        { label = "Jos Brze v2", speed = 20},
        { label = "zummmm", speed = 25}
    },

    offsets = {
        y = 0.5, -- [[How much distance you move forward and backward while the respective button is pressed]]
        z = 0.2, -- [[How much distance you move upward and downward while the respective button is pressed]]
        h = 5, -- [[How much you rotate. ]]
    },

    -- [[Background colour of the buttons. (It may be the standard black on first opening, just re-opening.)]]
    bgR = 0, -- [[Red]]
    bgG = 0, -- [[Green]]
    bgB = 0, -- [[Blue]]
    bgA = 50, -- [[Alpha]]
}

--==--==--==--
-- End Of Config
--==--==--==--

noclipActive = false -- [[Wouldn't touch this.]]
index = 1 -- [[Used to determine the index of the speeds table.]]

RegisterNetEvent("aAdmin:noclip", function()
    noclipActive = not noclipActive

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
    else
        noclipEntity = PlayerPedId()
    end

    SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
    FreezeEntityPosition(noclipEntity, noclipActive)
    SetEntityInvincible(noclipEntity, noclipActive)
    SetVehicleRadioEnabled(noclipEntity, not noclipActive) -- [[Stop radio from appearing when going upwards.]]

    if not noclipActive then
        SetEntityInvincible(PlayerPedId(), false)
        SetPlayerInvincible(PlayerId(), false)
    end

    if noclipActive then

        Citizen.CreateThread(function()

            buttons = setupScaleform("instructional_buttons")

            currentSpeed = config.speeds[index].speed
            while noclipActive do
                Citizen.Wait(1)
                    DrawScaleformMovieFullscreen(buttons)

                local yoff = 0.0
                local zoff = 0.0

                if IsControlJustPressed(1, config.controls.changeSpeed) then
                    if index ~= 8 then
                        index = index+1
                        currentSpeed = config.speeds[index].speed
                    else
                        currentSpeed = config.speeds[1].speed
                        index = 1
                    end
                    setupScaleform("instructional_buttons")
                end

                if IsControlPressed(0, config.controls.goForward) then
                    yoff = config.offsets.y
                end
                
                if IsControlPressed(0, config.controls.goBackward) then
                    yoff = -config.offsets.y
                end
                
                if IsControlPressed(0, config.controls.turnLeft) then
                    SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)+config.offsets.h)
                end
                
                if IsControlPressed(0, config.controls.turnRight) then
                    SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)-config.offsets.h)
                end
                
                if IsControlPressed(0, config.controls.goUp) then
                    zoff = config.offsets.z
                end
                
                if IsControlPressed(0, config.controls.goDown) then
                    zoff = -config.offsets.z
                end
                
                local newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, yoff * (currentSpeed + 0.3), zoff * (currentSpeed + 0.3))
                local heading = GetEntityHeading(noclipEntity)
                SetEntityVelocity(noclipEntity, 0.0, 0.0, 0.0)
                SetEntityRotation(noclipEntity, 0.0, 0.0, 0.0, 0, false)
                SetEntityHeading(noclipEntity, heading)
                SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, noclipActive, noclipActive, noclipActive)
            end
        end)
    end

end)

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function setupScaleform(scaleform)

    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(4)
    Button(GetControlInstructionalButton(2, config.controls.goUp, true))
    ButtonMessage("Gore")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(3)
    Button(GetControlInstructionalButton(2, config.controls.goDown, true))
    ButtonMessage("Dole")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(1, config.controls.turnRight, true))
    Button(GetControlInstructionalButton(1, config.controls.turnLeft, true))
    ButtonMessage("Okreni se lijevo/desno")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(1, config.controls.goBackward, true))
    Button(GetControlInstructionalButton(1, config.controls.goForward, true))
    ButtonMessage("Naprijed/Nazad")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, config.controls.changeSpeed, true))
    ButtonMessage("Brzina ("..config.speeds[index].label..")")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(config.bgR)
    PushScaleformMovieFunctionParameterInt(config.bgG)
    PushScaleformMovieFunctionParameterInt(config.bgB)
    PushScaleformMovieFunctionParameterInt(config.bgA)
    PopScaleformMovieFunctionVoid()

    return scaleform
end