RegisterNetEvent("benno_skilovi:Pancir")
AddEventHandler("benno_skilovi:Pancir", function()


	bFunkcije.BlokTipke(true)

	TriggerEvent("bfunkcije:tajmerdosto", "Stavljanje pancira...", 5, true, function(jel)
		if not jel then
			SetPedArmour(GetPlayerPed(-1), 100)
		end

		ClearPedTasks(PlayerPedId())
		bFunkcije.BlokTipke(false)

	end)

end)


RegisterNetEvent("benno_skilovi:bandage")
AddEventHandler("benno_skilovi:bandage", function()

	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	while not bFunkcije do 
        TriggerEvent('bfunkcije:init', function(resp) bFunkcije = resp end)
        Wait(10)
    end

	TriggerEvent("bfunkcije:tajmerdosto", "Apliciranje zavoja...", 5, true, function(jel)
		if not jel then
			while GetEntityHealth(PlayerPedId()) < GetEntityMaxHealth(PlayerPedId()) do
				Citizen.Wait(1000)
				SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 5)
			end
		end
		bFunkcije.BlokTipke(false)

	end)


end)


RegisterNetEvent("benno_skilovi:prvaPomoc")
AddEventHandler("benno_skilovi:prvaPomoc", function()

	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	while not bFunkcije do 
        TriggerEvent('bfunkcije:init', function(resp) bFunkcije = resp end)
        Wait(10)
    end

	bFunkcije.BlokTipke(true)
	TriggerEvent("bfunkcije:tajmerdosto", "Apliciranje prve pomoci...", 7, true, function(jel)
		if not jel then
			SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
		end
		bFunkcije.BlokTipke(false)
	end)


end)