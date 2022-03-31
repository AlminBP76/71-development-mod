local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local isBusy, deadPlayers, deadPlayerBlips, isOnDuty = false, {}, {}, false
isInShopMenu = false


Citizen.CreateThread(function()

    exports['qtarget']:AddBoxZone("hitna meni", vector3(298.4407, -597.2123, 43.86134), 5.8, 2.4, {
        name="gsf",
        heading=7,
        debugPoly=false,
        minZ=20.96,
        maxZ=47.56
	}, {
		options = {
		{
		event = "hitna:meni",
		icon = "fas fa-briefcase",
		label = "Meni Bolnicara",
		job = "all",
		},
	},
		distance = 2.0
	})
  end) 


-- Citizen.CreateThread(function()

-- 	exports['qtarget']:AddBoxZone("hitna meni", vector3(298.4407, -597.2123, 43.86134), 2.8, 2.8, {
-- 		name="hitna meni",
-- 		heading=7,
-- 		debugPoly=false,
-- 		minZ=5.96,
-- 		maxZ=10.56
-- 	}, {
-- 		options = {
-- 		{
-- 		event = "hitna:meni",
-- 		icon = "fas fa-briefcase",
-- 		label = "Meni Bolnicara",
-- 		job = "all",
-- 		},
-- 	},
-- 		distance = 2.0
-- 	})
--   end) 

  
RegisterNetEvent('hitna:meni')
AddEventHandler('hitna:meni', function()
	TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "< Nazad",
			txt = "",
			params = {
				event = "",
			}
		},
		{
			id = 2,
			header = "➪ Svlacionioca",
			txt = "",
			params = {
				event = "hitna:svlacionica",
			}
		},
		{
			id = 3,
			header = "➪ Akcije Direktora",
			txt = "",
			params = {
				event = "almin:bossmeni",
			}
		},
	})
end)

RegisterNetEvent('hitna:svlacionica')
AddEventHandler('hitna:svlacionica', function()
    TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "< Nazad",
			txt = "",
			params = {
				event = "hitna:meni",
			}
		},
        {
            id = 2,
            header = "Civilna Odjeca",
            txt = "Presvuci se u svoju gradsku odjecu",
            params = {
                event = "almin:hitnaodjeca",
                args = {
                    tipodjece = 'civilna',
                    
                }
            }
        },
        {
            id = 3,
            header = "Bolnicarsko Odjelo",
            txt = "Presvuci se u odjelo namjenjeno za duznost",
            params = {
                event = "almin:hitnaodjeca",
                args = {
                    tipodjece = 'bolnicarska',
                    
                }
            }
        },
               
    })
end)

RegisterNetEvent('almin:hitnaodjeca')
AddEventHandler('almin:hitnaodjeca', function(kurac)
	local tipodjece = kurac.tipodjece
	local xPlayer = PlayerPedId()

	
		
	if xPlayer then
		if tipodjece == 'civilna' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
				isOnDuty = false
			
				for playerId,v in pairs(deadPlayerBlips) do
					RemoveBlip(v)
					deadPlayerBlips[playerId] = nil
				end
			end)
			
		elseif 	tipodjece == 'bolnicarska' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			
				isOnDuty = true
				TriggerEvent('esx_ambulancejob:setDeadPlayers', deadPlayers)
			end)		
						   
		else
			print("Desio se bag u skripti")
		end
		
	end	

end)

RegisterNetEvent('almin:bossmeni')
AddEventHandler('almin:bossmeni', function()
	OpenAmbulanceActionsMenu()
	end)

function OpenAmbulanceActionsMenu()
	local elements = {
		-- {label = "Svlacionica nije ovdje", value = 'cloakroom'}
	  }
  

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			ESX.ShowNotification("U slucaju da zelis da se presvuces vrati se u prethodni meni")
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenMobileAmbulanceActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = {
			{label = _U('ems_menu'), value = 'citizen_interaction'}
	}}, function(data, menu)
		if data.current.value == 'citizen_interaction' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('ems_menu_title'),
				align    = 'top-left',
				elements = {
					{label = _U('ems_menu_revive'), value = 'revive'},
					{label = _U('ems_menu_small'), value = 'small'},
					{label = _U('ems_menu_big'), value = 'big'},
					{label = _U('ems_menu_putincar'), value = 'put_in_vehicle'},
					{label = _U('ems_menu_search'), value = 'search'}
			}}, function(data, menu)
				if isBusy then return end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if data.current.value == 'search' then
					TriggerServerEvent('esx_ambulancejob:svsearch')
				elseif closestPlayer == -1 or closestDistance > 1.0 then
					ESX.ShowNotification(_U('no_players'))
				else
					if data.current.value == 'revive' then
						revivePlayer(closestPlayer)
					elseif data.current.value == 'small' then
						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									isBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									isBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_bandage'))
							end
						end, 'bandage')

					elseif data.current.value == 'big' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									isBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									isBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end
						end, 'medikit')

					elseif data.current.value == 'put_in_vehicle' then
						TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function revivePlayer(closestPlayer)
	isBusy = true

	ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
		if quantity > 0 then
			local closestPlayerPed = GetPlayerPed(closestPlayer)

			if IsPedDeadOrDying(closestPlayerPed, 1) then
				local playerPed = PlayerPedId()
				local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
				ESX.ShowNotification(_U('revive_inprogress'))

				for i=1, 15 do
					Citizen.Wait(900)

					ESX.Streaming.RequestAnimDict(lib, function()
						TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
					end)
				end

				TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
				TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
			else
				ESX.ShowNotification(_U('player_not_unconscious'))
			end
		else
			ESX.ShowNotification(_U('not_enough_medikit'))
		end
		isBusy = false
	end, 'medikit')
end

Citizen.CreateThread(function()

	exports['qtarget']:AddBoxZone("auta", vector3(301.1464, -574.906, 43.262), 2.0, 2.0, {
		name="auta",
		heading=7,
		debugPoly=false,
        minZ=20.96,
        maxZ=47.56
	}, {
		options = {
		{
		event = "auta:meni",
		icon = "fas fa-briefcase",
		label = "Meni Bolnicarskih Vozila",
		job = "ambulance",
		},
	},
		distance = 2.0
	})
  end) 

RegisterNetEvent('auta:meni')
AddEventHandler('auta:meni', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Bolnicarska Auta",
            txt = ""
        },
        {
            id = 2,
            header = "Bolnicarsko Vozilo",
            txt = "Izvuci Bolnicarski Masserati",
            params = {
                event = "almin:bolnicarksapickamokra",
                args = {
                    vozilo = 'ambulance',
                    
                }
            }
        },
        {
            id = 3,
            header = "Bolnicarsko Vozilo 2",
            txt = "Izvuci Bolnicarski Dodge Charger",
            params = {
                event = "almin:bolnicarksapickamokra",
                args = {
                    vozilo = 'ambulance2',
                    
                }
            }
        },
               
    })
end)

AddEventHandler('almin:bolnicarksapickamokra', function(lol)
	local vozilo = lol.vozilo
	local xPlayer = PlayerPedId()

	
		
	if xPlayer then
		if vozilo == 'ambulance' then
			ESX.Game.SpawnVehicle(vozilo, vector3(291.0094, -588.191, 42.576), 130.57, function(need)
			end)
			
		elseif 	vozilo == 'ambulance2' then
			ESX.Game.SpawnVehicle(vozilo, vector3(291.0094, -588.191, 42.576), 130.57, function(need)
			end)
			
						   
		else
			ESX.ShowNotification("Model nije validni upo ti labilni LOL")
		end
		
	end	

end)


---------------KONTROLE

RegisterKeyMapping('+hitnae', 'HITNA E', 'keyboard', 'E')
-- Main thread
RegisterCommand('-hitnae', function()
    ---prazno mora biti
end, false)
RegisterCommand('+hitnae', function()
	if CurrentAction then
		ESX.ShowHelpNotification(CurrentActionMsg)

		if CurrentAction == 'AmbulanceActions' then
			OpenAmbulanceActionsMenu()
		elseif CurrentAction == 'Pharmacy' then
			OpenPharmacyMenu()
		elseif CurrentAction == 'Vehicles' then
			OpenVehicleSpawnerMenuHitna()
		elseif CurrentAction == 'Helikopteri' then
			OpenHelicopterSpawnerMenuHitna() 
		elseif CurrentAction == 'ParkirajAuto' then
			ObrisiVozilo() 
		elseif CurrentAction == 'ParkirajHeli' then
			ObrisiVozilo() 
		elseif CurrentAction == 'FastTravelsPrompt' then
			FastTravel(CurrentActionData.to, CurrentActionData.heading)
		end

		CurrentAction = nil
	end
end, false)

-----------------------F6 DUGME

RegisterKeyMapping('+emsf6', 'HITNA F6', 'keyboard', 'F6')
-- Main thread
RegisterCommand('-emsf6', function()
	---prazno mora biti
end, false)
RegisterCommand('+emsf6', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and not isDead then
		OpenMobileAmbulanceActionsMenu()
	end
end, false)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local vehicle, distance = ESX.Game.GetClosestVehicle()

	if vehicle and distance < 5 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
		end
	end
end)


Citizen.CreateThread(function()

	exports['qtarget']:AddBoxZone("ljekarna", vector3(310.7755, -568.5673, 43.73684), 5.8, 2.4, {
		name="ljekarna",
		heading=7,
		debugPoly=false,
        minZ=20.96,
        maxZ=47.56
	}, {
		options = {
		{
		event = "farmacija:uzmiljekove",
		icon = "fas fa-briefcase",
		label = "Uzmi ljekove",
		job = "ambulance",
		},
	},
		distance = 2.0
	})
  end)

RegisterNetEvent('farmacija:uzmiljekove')
AddEventHandler('farmacija:uzmiljekove', function()
	TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "< Nazad",
			txt = "",
			params = {
				event = "",
			}
		},
		{
			id = 2,
			header = "➪ Uzmi MedKit",
			txt = "",
			params = {
				event = "medikit:bolnica",
			}
		},
		{
			id = 3,
			header = "➪ Uzmi Bandazu",
			txt = "",
			params = {
				event = "bandaza:bolnica",
			}
		},
	})
end)

AddEventHandler('medikit:bolnica', function()
	local dialog = exports['zf_dialog']:DialogInput({
        header = "Koliko zelite Medikita", 
        rows = {
            {
                id = 0, 
                txt = "Kolicina"
            },
        }
    })
    
    if dialog ~= nil then
        if dialog[1].input == nil then
            ESX.ShowNotification('Ne mozete ostavljati prazna polja!')
        else
			TriggerServerEvent('esx_ambulancejob:giveItem', 'medikit', dialog[1].input)
        end
    end
end)

AddEventHandler('bandaza:bolnica', function()
	local dialog = exports['zf_dialog']:DialogInput({
        header = "Koliko zelite Bandaza", 
        rows = {
            {
                id = 0, 
                txt = "Kolicina"
            },
        }
    })
    
    if dialog ~= nil then
        if dialog[1].input == nil then
            ESX.ShowNotification('Ne mozete ostavljati prazna polja!')
		else
			TriggerServerEvent('esx_ambulancejob:giveItem', 'bandage', dialog[1].input)
        end
    end
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if isOnDuty and job ~= 'ambulance' then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		isOnDuty = false
	end
end)

RegisterNetEvent('esx_ambulancejob:setDeadPlayers')
AddEventHandler('esx_ambulancejob:setDeadPlayers', function(_deadPlayers)
	deadPlayers = _deadPlayers

	if isOnDuty then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		for playerId,status in pairs(deadPlayers) do
			if status == 'distress' then
				local player = GetPlayerFromServerId(playerId)
				local playerPed = GetPlayerPed(player)
				local blip = AddBlipForEntity(playerPed)

				SetBlipSprite(blip, 303)
				SetBlipColour(blip, 1)
				SetBlipFlashes(blip, true)
				SetBlipCategory(blip, 7)

				BeginTextCommandSetBlipName('STRING')
				AddTextComponentSubstringPlayerName(_U('blip_dead'))
				EndTextCommandSetBlipName(blip)

				deadPlayerBlips[playerId] = blip
			end
		end
	end
end)
