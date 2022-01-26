ESX              = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local PlayerData = {}
local genderNum = 0
local distancecheck = false


Citizen.CreateThread(function()

	while true do
		Citizen.Wait(100)
		for k,v in pairs (Config.main) do
			local id = GetEntityCoords(PlayerPedId())
			local distancia = #(id - v.coords)
			
			if distancia < Config.Distancia and distancecheck == false then
				spawn(v.modelo, v.coords, v.heading, v.gender, v.animDict, v.animName)
				distancecheck = true
			end
			if distancia >= Config.Distancia and distancia <= Config.Distancia + 1 then
				
				distancecheck = false
				DeletePed(ped)
			end
		end
	end
	
	
end)

function spawn(modelo, coords, heading, gender, animDict, animName)
	
	RequestModel(GetHashKey(modelo))
	while not HasModelLoaded(GetHashKey(modelo)) do
		Citizen.Wait(1)
	end
	
	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	end	

	
	local x, y, z = table.unpack(coords)
	ped = CreatePed(genderNum, GetHashKey(modelo), x, y, z - 1, heading, false, true)
		
	
	
	SetEntityAlpha(ped, 255, false)
	FreezeEntityPosition(ped, true) 
	SetEntityInvincible(ped, true) 
	SetBlockingOfNonTemporaryEvents(ped, true) 
	
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
	
	
end

---police
RegisterNetEvent('almin:policijska2')
AddEventHandler('almin:policijska2', function(lol)
	local vozilo = lol.vozilo
	local xPlayer = PlayerPedId()

	
		
	if xPlayer then
		if vozilo == 'police' then
			ESX.Game.SpawnVehicle(vozilo, vector3(449.799988,-1022.400024,28.500000), 86.57, function(need)
			end)
			
		elseif 	vozilo == 'police2' then
			ESX.Game.SpawnVehicle(vozilo, vector3(449.799988,-1022.400024,28.500000), 86.57, function(need)
			end)
			
						
		elseif vozilo == 'police3' then
			ESX.Game.SpawnVehicle(vozilo, vector3(449.799988,-1022.400024,28.500000), 86.57, function(need) 
			end)

		elseif vozilo == 'police4' then
			ESX.Game.SpawnVehicle(vozilo, vector3(449.799988,-1022.400024,28.500000), 86.57, function(need) 
			end)

		elseif vozilo == 'police5' then
			ESX.Game.SpawnVehicle(vozilo, vector3(449.799988,-1022.400024,28.500000), 86.56, function(need) 
			end)

        elseif vozilo == 'ambulance' then
			ESX.Game.SpawnVehicle(vozilo, vector3(298.22,-605.52,43.25), 64.27, function(need) 
			end)
			
						   
		else
			notifies('Model nije validan')
		end
		
	end	

end)



RegisterNetEvent('almin:garaza1', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Policijska Auta",
            txt = ""
        },
        {
            id = 2,
            header = "Policijsko Vozilo 1",
            txt = "Izvuci Patrolno Vozilo",
            params = {
                event = "almin:policijska2",
                args = {
                    vozilo = 'police',
                    
                }
            }
        },
        {
            id = 3,
            header = "Policijsko Vozilo 2",
            txt = "Izvuci Patrolno Vozilo",
            params = {
                event = "almin:policijska2",
                args = {
                    vozilo = 'police2',
                    
                }
            }
        },
        {
            id = 4,
            header = "Policijsko Vozilo 3",
            txt = "Izvuci Patrolno Vozilo",
            params = {
                event = "almin:policijska2",
                args = {
                    vozilo = 'police3',
                    
                }
            }
        },
        {
		id = 5,
		header = "Policijsko Vozilo 4",
		txt = "Izvuci Patrolno Vozilo",
		params = {
			event = "almin:policijska2",
			args = {
				vozilo = 'police4',
				
			}
		}
	},
               
    })
end)

RegisterNetEvent('almin:ambulanta', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Bolnicarska Kola",
            txt = ""
        },
        {
            id = 2,
            header = "Bolnicarski Kombi",
            txt = "Izvuci bolnicarski kombi",
            params = {
                event = "almin:policijska2",
                args = {
                    vozilo = 'ambulance',
                    
                }
            }
        },
               
    })
end)

RegisterNetEvent('almin:garaza2', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Policijski Helikopteri",
            txt = ""
        },
        {
            id = 2,
            header = "Helikopter",
            txt = "Izvuci Helis",
            params = {
                event = "almin:policijska2",
                args = {
                    vozilo = 'polmav',
                    
                }
            }
        },
               
    })
end)

    local policajac = {
		`cs_prolsec_02`
    }

    exports['qtarget']:AddTargetModel(policajac, {
        options = {
            {
                event = "almin:garaza1",
                icon = 'fas fa-car',
                label = "Pogledaj policijska vozila",
				job = "police"
            },
        },
        distance = 2.0
    })

    local policajka = {
		`s_f_y_ranger_01`
    }

    exports['qtarget']:AddTargetModel(policajka, {
        options = {
            {
                event = "almin:garaza2",
                icon = 'fas fa-helicopter',
                label = "Pogledaj helikoptere",
				job = "police"
            },
        },
        distance = 2.0
    })

    local gologuzaBolnicarka = {
		`csb_stripper_01`
    }

    exports['qtarget']:AddTargetModel(gologuzaBolnicarka, {
        options = {
            {
                event = "almin:ambulanta",
                icon = 'fas fa-car',
                label = "Pogledaj bolnicarska vozila",
				job = "ambulance"
            },
        },
        distance = 2.0
    })

function notifies(message)
ESX.ShowNotification(message)
end   