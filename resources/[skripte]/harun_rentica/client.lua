local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--test
-- Spawn forklift
function prvoauto()

	local ped = GetPlayerPed(-1)
	local vehicleName = 'sultan'
  
   RequestModel(vehicleName)
  
   -- wait for the model to load
	while not HasModelLoaded(vehicleName) do
		Wait(500) -- often you'll also see Citizen.Wait
	end
  
	local vehicle = CreateVehicle(vehicleName, -1026.61, -2736.58, 20.59, 5.60, true, false)
	-- set the player ped into the vehicle's driver seat
	SetEntityAsMissionEntity(vehicle, true, true)
  
	SetModelAsNoLongerNeeded(vehicleName)
	JobStarted = true
  exports.extreme_notifikacije:Notify({
	type = 'success',
	title = 'Sistem',
	message = 'Uspjesno ste iznajmili vozilo!'
  })
  
  
  end
  
  --test
  -- Spawn forklift
  function drugoauto()
  
	local ped = GetPlayerPed(-1)
	local vehicleName = 'blista'
  
   RequestModel(vehicleName)
  
   -- wait for the model to load
	while not HasModelLoaded(vehicleName) do
		Wait(500) -- often you'll also see Citizen.Wait
	end
  
	local vehicle = CreateVehicle(vehicleName, -1026.61, -2736.58, 20.59, 5.60, true, false)
	-- set the player ped into the vehicle's driver seat
	SetEntityAsMissionEntity(vehicle, true, true)
  
	SetModelAsNoLongerNeeded(vehicleName)
	JobStarted = true
  exports.extreme_notifikacije:Notify({
	type = 'success',
	title = 'Sistem',
	message = 'Uspjesno ste iznajmili vozilo!'
  })
  
  
  end
  
  --test
  -- Spawn forklift
  function treceauto()
  
	  local ped = GetPlayerPed(-1)
	  local vehicleName = 'rmodx6'
  
	 RequestModel(vehicleName)
  
	 -- wait for the model to load
	  while not HasModelLoaded(vehicleName) do
		  Wait(500) -- often you'll also see Citizen.Wait
	  end
  
	  local vehicle = CreateVehicle(vehicleName, -1026.61, -2736.58, 20.59, 5.60, true, false)
	  -- set the player ped into the vehicle's driver seat
	  SetEntityAsMissionEntity(vehicle, true, true)
  
	  SetModelAsNoLongerNeeded(vehicleName)
	  JobStarted = true
	  exports.extreme_notifikacije:Notify({
		  type = 'success',
		  title = 'Sistem',
		  message = 'Uspjesno ste iznajmili vozilo!'
	  })
  
  
  end
  
Citizen.CreateThread(function()
    while true do
        for i = 1, #Config.Kordinati, 1 do -- vuce iz Configa
            sleep = 1500 -- sleep koji je definisan kako bi se koristio u Citizen.Wait(sleep) kako bi marker spavao i manje vukao dok se ne koristi!
            local playerPed = PlayerPedId() -- definiran igrac
			local dict = "missminuteman_1ig_2"
			local igrac = PlayerPedId()
            local korde = GetEntityCoords(playerPed) -- definirano dobijanje Kordinata od igraca
            local udaljenost = #(korde - Config.Kordinati[i]) -- definirana provera udaljenosti izmedju jedne i druge tacke, vuce iz Configa
            if udaljenost < 10 then  -- provera ako je udaljenost 10 ili manja
                sleep = 0 -- sleep na 0 tako da ako si blizu markera on vise ne spava i zapravo se moze koristiti
                DrawMarker(2, Config.Kordinati[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8,  0.8, 255,  0,  5, 100, false, true, 2, true, false, false, false)  -- Crtanje Markera, vuce iz Configa
                if udaljenost < 2 then -- provera ako je udaljenost 2 ili manja   
                    ESX.ShowHelpNotification("Pritisni ~INPUT_PICKUP~") -- Notifikacija gore ljevo da se klikne tipka E, ~INPUT_PICKUP~ = E
					if IsControlJustPressed(0,38) then
						SetNuiFocus(true, true)
						SendNUIMessage({
						ativa = true
						})
					end
                end -- end
            end -- end
            Citizen.Wait(sleep) -- wait, ne diraj
        end -- end
    end -- end
end)-- end
--pocetak misije

RegisterNUICallback('button2', function(data, cb)
	prvoauto()
   TriggerServerEvent('skinikes')
		cb('ok')
  end)
  
  RegisterNUICallback('button1', function(data, cb)
	drugoauto()
	TriggerServerEvent('skinikes')
	  cb('ok')
  end)
  
  RegisterNUICallback('button3', function(data, cb)
	treceauto()
	TriggerServerEvent('skinikes')
	  cb('ok')
  end)
  

RegisterNUICallback('harunskloni', function(data, cb)
	SetNuiFocus( false )
	SendNUIMessage({
	ativa = false
	})
  	cb('ok')
end)

