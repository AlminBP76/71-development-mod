postar = {
	randomlokacije = {

		[1] = vector3(2505.28, 4099.53, 38.50) , 
		[2] = vector3(1699.18, 3584.12, 35.51) , 
		[3] = vector3(592.31, 2737.04, 42.06) , 
		[4] = vector3(-1119.99, 2679.51, 18.47) , 
		[5] = vector3(-319.08, 2745.61, 67.48) , 
		[6] = vector3(200.49, 1232.25, 225.46) , 
		[7] = vector3(-1511.22, 1491.30, 116.02) , 
		[8] = vector3(-3016.69, 88.83, 11.61), 
		[9] = vector3(-1331.24, -1091.62, 6.98) , 
		[10] = vector3(-1014.55, -2733.86, 13.68) , 
		[11] = vector3(437.14, -2090.04, 21.58) , 
		[12] = vector3(490.54, -1458.58, 29.16) , 
		[13] = vector3(744.34, -969.12, 24.60) , 
		[14] = vector3(1255.81, -359.48, 69.08) , 
		[15] = vector3(2574.80, 314.11, 108.46) , 
		[16] = vector3(-321.88, 478.67, 111.67) , 
		[17] = vector3(-1042.11, 497.74, 83.43) , 
		[18] = vector3(-1567.91, -290.11, 48.28) , 
		[19] = vector3(-1088.95, -885.03, 3.71) , 
		[20] = vector3(-314.75, -1027.15, 30.39) , 
		[21] = vector3(453.59, -708.32, 27.36) , 
		[22] = vector3(229.11, -160.43, 58.76) , 
		[23] = vector3(-592.40, 753.99, 183.72) ,
		[24] = vector3(-2529.49, 2322.92, 33.06) ,
		[25] = vector3(548.95, -139.16, 59.02) ,
		[26] = vector3(-2316.80, 281.54, 169.47)
	},

	randomheading = {

		[1] = 329.81, 
		[2] = 33.42, 
		[3] = 0.63, 
		[4] = 127.20, 
		[5] = 355.29, 
		[6] = 101.24, 
		[7] = 70.92, 
		[8] = 142.62, 
		[9] = 120.41, 
		[10] = 238.69, 
		[11] = 328.42, 
		[12] = 178.85, 
		[13] = 88.81, 
		[14] = 345.15, 
		[15] = 178.18, 
		[16] = 296.30, 
		[17] = 36.74, 
		[18] = 134.29, 
		[19] = 32.44, 
		[20] = 254.85, 
		[21] = 170.21, 
		[22] = 238.62, 
		[23] = 77.98,
		[24] = 268.19,
		[25] = 356.70,
		[26] = 201.66
	
	},

	posolokacije = {

		zapocniposao = vector3(77.26, 106.53, 79.10),
		uzmiauto = vector3(66.51, 115.80, 79.10),
		autospawn = vector3(62.26, 101.63, 79.00),
		vratiauto = vector3(57.99, 103.70, 79.01)
	}
}



ESX								= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

NaPoslu1 = false
VecIznajmio1 = false
PoceoSmjenu1 = false
VoziDoMarkera1 = false
DosaoDoMarkera1 = false
Broji1 = false
UzeoStvari1 = false
Proslaruta1 = 0


Citizen.CreateThread(function()

      PocniPosaoBlip = AddBlipForCoord(postar.posolokacije.zapocniposao)
      SetBlipSprite(PocniPosaoBlip, 67)
      SetBlipDisplay(PocniPosaoBlip, 4)
      SetBlipScale(PocniPosaoBlip, 0.7)
      SetBlipColour(PocniPosaoBlip, 0)
      SetBlipAsShortRange(PocniPosaoBlip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Postar")
      EndTextCommandSetBlipName(PocniPosaoBlip)

	  SetBlipCategory(PocniPosaoBlip, 7)
	  SetBlipAsShortRange(PocniPosaoBlip, true)

end)

----------------------MARKER ZA ZAPOCINJANJE POSLA-----------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local igrac1 = PlayerPedId()
		local igrac1ord = GetEntityCoords(igrac1)
		local udaljenost1 = Vdist(igrac1ord, postar.posolokacije.zapocniposao)
			if udaljenost1 < 15 then

				if not CPmain1 then
					CPmain1 =  CreateCheckpoint(47, postar.posolokacije.zapocniposao.x, postar.posolokacije.zapocniposao.y, postar.posolokacije.zapocniposao.z - 1, postar.posolokacije.zapocniposao, 2.0, 128, 57, 30, 255, 180)
					SetCheckpointCylinderHeight(CPmain1, 2.0, 2.0, 5.0, 2.0)
				end

					if udaljenost1 < 2 and not NaPoslu1 then 

							TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] da zapocnes posao")
						
					
							if IsControlPressed(0,38) then 
								NaPoslu1 = true
								
								ESX.ShowNotification("Zapoceo si posao postara, idi do mjesta za izvlacenje auta i pocni smjenu")

								TriggerEvent("bfunkcije:ticknotif", false)
							end

					elseif udaljenost1 < 2 and NaPoslu1 then
				
						TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] da zavrsis posao")

							if IsControlPressed(0,38) and not VecIznajmio1 then 
								NaPoslu1 = false
								VecIznajmio1 = false
								Broji1Gepek1 = false
								UzeoStvari1 = false
								VoziDoMarkera1 = false
								DosaoDoMarkera1 = false
								PoceoSmjenu1 = false
								RemoveBlip(posomarker1)
								TriggerEvent("bfunkcije:notif", "Postar", "Zavrsio si posao postara", 5, true)
								DeleteCheckpoint(CPmain1) DeleteCheckpoint(CPauto1) DeleteCheckpoint(CPautoNazad1) DeleteCheckpoint(CP1) DeleteCheckpoint(CPgepek1)
								CPmain1, CPauto1, CPautoNazad1, CP1, CPgepek1 = false, false, false, false, false
							elseif VecIznajmio1 then
									TriggerServerEvent("postar:nemaauta")
									
									ESX.ShowNotification("Zavrsio si posao postara - Nisi vratio prijasnje auto, uzeto ti je 500$")

									NaPoslu1 = false
									VecIznajmio1 = false
									Broji1Gepek1 = false
									UzeoStvari1 = false
									VoziDoMarkera1 = false
									DosaoDoMarkera1 = false
									PoceoSmjenu1 = false
									RemoveBlip(posomarker1)
									DeleteVehicle(SADASNJEvozilo1)
								Citizen.Wait(5000)

							end
					end
			else
				if CPmain1 then
					DeleteCheckpoint(CPmain1)
					CPmain1 = nil
				end
				Citizen.Wait(500)
			end
	end


end)

-----------------------------------------------------------------------------

-------------------------MARKER ZA UZIMANJE AUTA-----------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if NaPoslu1 then
			local igrac1 = PlayerPedId()
			local igrac1ord = GetEntityCoords(igrac1)
			local udaljenost1 = Vdist(igrac1ord, postar.posolokacije.uzmiauto)

			if udaljenost1 < 10 and not IsPedInAnyVehicle(PlayerPedId(), false) then 
				if not CPauto1 then
					CPauto1 =  CreateCheckpoint(47, postar.posolokacije.uzmiauto.x, postar.posolokacije.uzmiauto.y, postar.posolokacije.uzmiauto.z - 1, postar.posolokacije.uzmiauto, 2.0, 128, 57, 30, 255, 180)
					SetCheckpointCylinderHeight(CPauto1, 2.0, 2.0, 2.0, 2.0)
				end

				if udaljenost1 < 1 and not IsPedInAnyVehicle(PlayerPedId(), false) then
					TriggerEvent("bfunkcije:ticknotif", true, true, "Drzi tipku [E] da uzmes poslovno vozilo1!")
						if IsControlPressed(0,38) then 
							if not VecIznajmio1 then
								if ESX.Game.IsSpawnPointClear(postar.posolokacije.autospawn, 6.0) then
									Lokalnetablice1 = "POSTAR ".. math.random(00,99)

									ESX.Game.SpawnVehicle("boxville2", postar.posolokacije.autospawn, 160.0, function(vehicle)
									SetVehicleNumberPlateText(vehicle, Lokalnetablice1)
									TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
									SetEntityAsMissionEntity(vehicle, 1, 1)
									SADASNJEvozilo1 = vehicle
									end)
									VecIznajmio1 = true

								else

									ESX.ShowNotification("Mjesto isparkiravanja auta je blokirano")

								end
							else

								ESX.ShowNotification('Imas vec jedno uzeto vozilo sa tablicama ' ..Lokalnetablice1.. '')

							end

						end
				end

			else
				if CPauto1 then
					DeleteCheckpoint(CPauto1)
					CPauto1 = nil
				end
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end

end)



function notif(text)

	SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end

-----------------------------------------------------------------------------

-------------------------MARKER ZA VRACANJE AUTA-----------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if NaPoslu1 and VecIznajmio1 then
			local igrac1 = PlayerPedId()
			local igrac1ord = GetEntityCoords(igrac1)
			local udaljenost1 = Vdist(igrac1ord, postar.posolokacije.vratiauto)

			if udaljenost1 <= 10 and IsPedInAnyVehicle(PlayerPedId(), false) then 
				local vozilo1 = GetVehiclePedIsIn(igrac1)
				if not CPautoNazad1 then
					CPautoNazad1 =  CreateCheckpoint(47, postar.posolokacije.vratiauto.x, postar.posolokacije.vratiauto.y, postar.posolokacije.vratiauto.z - 1, postar.posolokacije.vratiauto, 2.0, 128, 57, 30, 255, 180)
					SetCheckpointCylinderHeight(CPautoNazad1, 2.0, 2.0, 2.0, 2.0)
				end	

				if udaljenost1 < 2 then
					TriggerEvent("bfunkcije:ticknotif", true, true, "Drzi tipku [E] da vratis poslovno vozilo1!")
						if IsControlPressed(0,38) then 
							if vozilo1 == SADASNJEvozilo1 then
								DeleteVehicle(vozilo1)
								VecIznajmio1 = false
							else

								ESX.ShowNotification("Ovo nije vozilo od firme")

							end

						end
				end

			elseif CPautoNazad1 and udaljenost1 > 10 then
				DeleteCheckpoint(CPautoNazad1)
				CPautoNazad1 = nil
			end
		end
	end

end)

-----------------------------------------------------------------------------
------------------------------POCNI POSAO U AUTU-----------------------------

function NapraviPosao1()
	VoziDoMarkera1 = true
	ruta1 = math.random(1, #postar.randomlokacije)
	while ruta1 == Proslaruta1 do 
		ruta1 = math.random(1, #postar.randomlokacije)
	end
	ruta1Izabrana1 = postar.randomlokacije[ruta1]
	Proslaruta1 = ruta1
	Headingruta11 = postar.randomheading[ruta1]

	posomarker1 = AddBlipForCoord(ruta1Izabrana1)
	SetBlipSprite(posomarker1, 50)
	SetBlipRoute(posomarker1,  true)

	ESX.ShowNotification("Ruta ti je oznacena na mapi")

end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if NaPoslu1 and IsPedInAnyVehicle(PlayerPedId(), false) then
			local igrac1 = PlayerPedId()
			local vozilo1 = GetVehiclePedIsIn(igrac1, false)
			local tablice1 = GetVehicleNumberPlateText(vozilo1)
				if tablice1 == Lokalnetablice1 and not PoceoSmjenu1 then
					TriggerEvent("bfunkcije:ticknotif", true, true, "Drzi tipku [G] da zapocnes posao")
					
					if IsControlPressed(0,47) then
						PoceoSmjenu1 = true
						NapraviPosao1()
					end

				end
		end
	end

end)



Citizen.CreateThread(function(prop_name)
	while true do 
		Citizen.Wait(500)
			if VoziDoMarkera1 then
				local igrac1 = PlayerPedId()
				local igrac1ord = GetEntityCoords(igrac1)
				local udaljenost1 = Vdist(igrac1ord, ruta1Izabrana1)
					if not CP1 and udaljenost1 <= 50 then
						CP1 =  CreateCheckpoint(47, ruta1Izabrana1.x, ruta1Izabrana1.y, ruta1Izabrana1.z - 1, ruta1Izabrana1, 2.0, 128, 57, 30, 255, 180)
						SetCheckpointCylinderHeight(CP1, 2.0, 2.0, 2.0, 2.0)
					elseif CP1 and udaljenost1 > 50 then
						DeleteCheckpoint(CP1)
						CP1 = nil
					end

					if udaljenost1 < 15 and IsPedInAnyVehicle(PlayerPedId(), false) and not DosaoDoMarkera1 then
							DosaoDoMarkera1 = true
							RemoveBlip(posomarker1)
							if IsPedInAnyVehicle(PlayerPedId(), false) then

								ESX.ShowNotification("Stigao si na odrediste, izadji iz auta i uzmi stvari iz gepeka")

							end
					end

					if DosaoDoMarkera1 and not UzeoStvari1 and not IsPedInAnyVehicle(PlayerPedId()) then

						local vozilo1 = GetVehiclePedIsIn(igrac1, 1)
						local gepekpos1 = GetWorldPositionOfEntityBone(vozilo1, GetEntityBoneIndexByName(vozilo1, "exhaust"))
						local udaljenost1Gepek1 = Vdist(igrac1ord, gepekpos1)


						if udaljenost1Gepek1 > 2 then
							TriggerEvent("bfunkcije:ticknotif", true, true, "Uzmi stvari iz gepeka")
						end

						
						if not CPgepek1 then
							CPgepek1 =  CreateCheckpoint(47, gepekpos1.x, gepekpos1.y, gepekpos1.z - 1, gepekpos1, 2.0, 128, 57, 30, 255, 180)
							SetCheckpointCylinderHeight(CPgepek1, 2.0, 2.0, 2.0, 2.0)
						end
						
						if not UzeoStvari1 and DosaoDoMarkera1 and udaljenost1Gepek1 <= 2 then
							
							TriggerEvent("bfunkcije:ticknotif", true, true, "Drzi tipku [E] da uzmes stvari iz gepeka")

							if IsControlPressed(0,38) and not UzeoStvari1 then
								tajmer1 = 0
								Broji1Gepek1 = true
								blokirajtipke1 = true
								FreezeEntityPosition(igrac1, true)
								ESX.Streaming.RequestAnimDict('mini@repair', function()
									TaskPlayAnim(PlayerPedId(), 'mini@repair', 'fixing_a_player', 1.0, -1, -1, 49, 0, 0, 0, 0)
								end)

								while tajmer1 < 100 do
									Wait(50)
									tajmer1 = tajmer1 + 1
								end
								ClearPedTasks(PlayerPedId())

								blokirajtipke1 = false
								Broji1Gepek1 = false
								UzeoStvari1 = true
								FreezeEntityPosition(igrac1, false)
								DeleteCheckpoint(CPgepek1)
								CPgepek1 = nil
	
								ESX.ShowNotification("Uzeo si stvari, Idi i dostavi paket")

							end
						end
					end

					if DosaoDoMarkera1 and udaljenost1 < 1 and not IsPedInAnyVehicle(PlayerPedId()) then

						if UzeoStvari1 then

								TriggerEvent("bfunkcije:ticknotif", true, true, "Stisni tipku [E] da dostavis paket")

							if IsControlPressed(0, 38) then
								DeleteCheckpoint(CP1)
								DeleteCheckpoint(CPautoNazad1)
								CP1 = nil
								tajmer1 = 0
								Broji1Instal1 = true
								SetEntityHeading(PlayerPedId(), Headingruta11)
								FreezeEntityPosition(igrac1, true)
								blokirajtipke1 = true

								AnimacijaInstalacije()

								while tajmer1 < 100 do
									Wait(200)
									tajmer1 = tajmer1 + 1
								end
								blokirajtipke1 = false
								Broji1Instal1 = false
								FreezeEntityPosition(igrac1, false)
								ESX.TriggerServerCallback('poslovipostar:zavrsiposo', function(cb)
									
								end)
								VoziDoMarkera1 = false
								PoceoSmjenu1 = false
								UzeoStvari1 = false
								DosaoDoMarkera1 = false
							end

						else
							if IsControlPressed(0, 38) then
			
								ESX.ShowNotification("Nisi uzeo stvari iz gepeka")

							end
						end
					end
			end

	end
end)



function DrawText3d(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(0.3, 0.3)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		local spavam = 1000
        if blokirajtipke1 then
			spavam = false
            DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
        else
            Wait(spavam)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
		local spavam = 1000
        Citizen.Wait(1)
            if Broji1Instal1 == true then
				spavam = false
	            Koordinate1 = GetEntityCoords(PlayerPedId())
	            progres1 = "Dostavljanje posiljke... " .. tajmer1 .. "%"
	            DrawText3d(Koordinate1.x,Koordinate1.y,Koordinate1.z, progres1)
  			elseif Broji1Gepek1 == true then
  				Koordinate1 = GetEntityCoords(PlayerPedId())
	            progres1 = "Uzimanje stvari iz gepeka... " .. tajmer1 .. "%"
	            DrawText3d(Koordinate1.x,Koordinate1.y,Koordinate1.z, progres1)
  			else

  				Citizen.Wait(spavam)
  			end
  	end
end)


AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  DeleteVehicle(SADASNJEvozilo1)
end)



function AnimacijaInstalacije()

	Citizen.CreateThread(function()

	clipboard1 = CreateObject(GetHashKey('p_cs_clipboard'), 0, 0, 0, true, true, true) 
	AttachEntityToEntity(clipboard1, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x49d9), 0.05, 0.04, 0.15, 360.0, 130.00, 230.0, true, true, false, true, 1, true) 
	RequestAnimDict("anim@amb@business@meth@meth_monitoring_cooking@monitoring@")
	while not HasAnimDictLoaded("anim@amb@business@meth@meth_monitoring_cooking@monitoring@") do
		Citizen.Wait(1)
	end
	RequestAnimDict("anim@amb@nightclub@peds@")
	while not HasAnimDictLoaded("anim@amb@nightclub@peds@") do
		Citizen.Wait(1)
	end

		TaskPlayAnim(PlayerPedId(), 'anim@amb@nightclub@peds@', 'amb_world_human_clipboard_male_idle_a', 1.0, 1.5, -1, 49, 0, 0, 0, 0)
		Citizen.Wait(10000)
		TaskPlayAnim(PlayerPedId(), 'anim@amb@business@meth@meth_monitoring_cooking@monitoring@', 'check_guages_v2_monitor', 1.0, 1.5, -1, 49, 0, 0, 0, 0)
		Citizen.Wait(5000)
		TaskPlayAnim(PlayerPedId(), 'anim@amb@business@meth@meth_monitoring_cooking@monitoring@', 'look_around_v5_monitor', 1.0, 1.5, -1, 49, 0, 0, 0, 0)
		Citizen.Wait(5000)
		ClearPedTasks(PlayerPedId())

		DeleteObject(clipboard1)
	end)

end

