ESX = nil
PlayerData = {}

CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Wait(200) -- 0 ne moze, msm moze al resmon u kurcu, 200 refresha svakih 2 sekunde
	end
	while ESX.GetPlayerData().job == nil do
		Wait(200) -- 0 ne moze, msm moze al resmon u kurcu, 200 refresha svakih 2 sekunde
	end
	PlayerData = ESX.GetPlayerData()
end)

s = 1000

local food = 0
local thirst = 0
local stress = 0
local spavanje = 0
CreateThread(function()
    while true do
        Wait(200)

        TriggerEvent('esx_status:getStatus', 'hunger',
            function(status) food = status.val / 10000 end)
        TriggerEvent('esx_status:getStatus', 'thirst',
            function(status) thirst = status.val / 10000 end)
    end
end)



CreateThread(
    function()
        while true do
            Wait(1000)
            
            local hudPosition

            if IsPedSittingInAnyVehicle(PlayerPedId()) or not Config.HideMinimap then
                hudPosition = "right"
            else
                hudPosition = "left"
            end

            local sourceID = GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId()))

            SendNUIMessage(
                {
                    hud = Config.Hud,
                    pauseMenu = IsPauseMenuActive(),
                    armour = GetPedArmour(PlayerPedId()),
                    health = GetEntityHealth(PlayerPedId()) - 100,
                    food = food,
                    thirst = thirst,
                    stress = stress,
                    spavanje = spavanje,
                    banka = bankara,
                    kes = kesara,
                    prljav = prljavee,
                    posao = poslic,
                    sefb = sefara,
                    sef = sef,
                    idigraca = sourceID,
                    hudPosition = hudPosition
                }
            )
        end
    end
)

CreateThread(function()
    while true do
		Wait(1)
		if IsPedOnFoot(PlayerPedId()) then 
			SetRadarZoom(1100)
		elseif IsPedInAnyVehicle(PlayerPedId(), true) then
			SetRadarZoom(1100)
		end
    end
end)