local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local started = false
local displayed = false
local progress = 0
local CurrentVehicle 
local pause = false
local selection = 0
local quality = 0
ESX = nil

local LastCar

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(100)
	end
end)

RegisterNetEvent('trp_meth:stop')
AddEventHandler('trp_meth:stop', function()
	started = false
	DisplayHelpText("Proizvodnja stala...")
	FreezeEntityPosition(LastCar, false)
end)
RegisterNetEvent('trp_meth:stopfreeze')
AddEventHandler('trp_meth:stopfreeze', function(id)
	FreezeEntityPosition(id, false)
end)
RegisterNetEvent('trp_meth:notify')
AddEventHandler('trp_meth:notify', function(message)
	ESX.ShowNotification(message)
end)

RegisterNetEvent('trp_meth:startprod')
AddEventHandler('trp_meth:startprod', function()
	DisplayHelpText("Pokretanje radnje")
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	displayed = false
	ESX.ShowNotification("Proizvodnja Meta je pocela")	
	SetPedIntoVehicle(PlayerPedId(), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
end)

RegisterNetEvent('trp_meth:blowup')
AddEventHandler('trp_meth:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2,23, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Wait(6000)
	StopParticleFxLooped(fire, 0)
	
end)


RegisterNetEvent('trp_meth:smoke')
AddEventHandler('trp_meth:smoke', function(posx, posy, posz, bool)

	if bool == 'a' then

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_flare", posx, posy, posz + 1.7, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
		Wait(22000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end

end)
RegisterNetEvent('trp_meth:drugged')
AddEventHandler('trp_meth:drugged', function()
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(PlayerPedId(), true)
	SetPedMovementClipset(PlayerPedId(), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(PlayerPedId(), true)

	Wait(300000)
	ClearTimecycleModifier()
end)



CreateThread(function()
	while true do
		Wait(50)
		
		playerPed = PlayerPedId()
		local pos = GetEntityCoords(PlayerPedId())
		if IsPedInAnyVehicle(playerPed) then
			
			
			CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId())

			car = GetVehiclePedIsIn(playerPed, false)
			LastCar = GetVehiclePedIsUsing(playerPed)
	
			local model = GetEntityModel(CurrentVehicle)
			local modelName = GetDisplayNameFromVehicleModel(model)
			
			if modelName == 'JOURNEY' and car then
				
					if GetPedInVehicleSeat(car, -1) == playerPed then
						if started == false then
							if displayed == false then
								DisplayHelpText("Pritisni ~INPUT_THROW_GRENADE~ da zapocnes preradu")
								displayed = true
							end
						end
						if IsControlJustReleased(0, Keys['G']) then
							if pos.y >= 3500 then
								if IsVehicleSeatFree(CurrentVehicle, 3) then
									TriggerServerEvent('trp_meth:start')	
									progress = 0
									pause = false
									selection = 0
									quality = 0
									
								else
									DisplayHelpText('Vozilo je vec zauzeto')
								end
							else
								ESX.ShowNotification('Previse si blizu grada, otidji sjevernije kako bi zapoceo preradu')
							end
							
							
							
							
		
						end
					end
					
				
				
			
			end
			
		else

				
				if started then
					started = false
					displayed = false
					TriggerEvent('trp_meth:stop')
					FreezeEntityPosition(LastCar,false)
				end
		end
		
		if started == true then
			
			if progress < 96 then
				Wait(6000)
				if not pause and IsPedInAnyVehicle(playerPed) then
					progress = progress +  1
					ESX.ShowNotification('Proizvodnja Meta: ' .. progress .. '%')
					Wait(6000) 
				end

				--
				--   EVENT 1
				--
				if progress > 22 and progress < 24 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Cev za propan curi, sta uciniti?')	
						ESX.ShowNotification('1. Popraviti pomocu lepljive trake')
						ESX.ShowNotification('2. Ne dirati ')
						ESX.ShowNotification('3. Zameniti je')
						ESX.ShowNotification('Pritisni broj zeljenog odgovora')
					end
					if selection == 1 then
						
						ESX.ShowNotification('Traka je delimicno zaustavila curenje')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						
						ESX.ShowNotification('Rezervoar sa propanom je eksplodirao, zeznuo si stvar...')
						TriggerServerEvent('trp_meth:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(PlayerPedId(), 10, false)
					end
					if selection == 3 then
						
						ESX.ShowNotification('Odlican posao, cev je bila u veoma losem stanju')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 5
				--
				if progress > 30 and progress < 32 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Prosuo si bocu acetona na pod, sta uciniti?')	
						ESX.ShowNotification('1. Otvoriti prozor da miris izadje')
						ESX.ShowNotification('2. Nista')
						ESX.ShowNotification('3. Staviti gasmasku')
						ESX.ShowNotification('Pritisni broj zeljenog odgovora')
					end
					if selection == 1 then
						
						ESX.ShowNotification('Otvorio si prozor kako bi se resio jakog mirisa')
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						
						ESX.ShowNotification('Jak miris acetona te omamio')
						pause = false
						TriggerEvent('trp_meth:drugged')
					end
					if selection == 3 then
						
						ESX.ShowNotification('To je jednostavan odgovor na ovakav problem.. ')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 2
				--
				if progress > 38 and progress < 40 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Met se poceo stvrdnjavati prebrzo, sta uciniti? ')	
						ESX.ShowNotification('1. Povecati pritisak')
						ESX.ShowNotification('2. Povecati temperaturu')
						ESX.ShowNotification('3. Smanjiti pritisak')
						ESX.ShowNotification('Pritisni broj zeljenog odgovora')
					end
					if selection == 1 then
						
						ESX.ShowNotification('Povecao si pritisak i propan je poceo da curi, zatim si smanjio pritisak i sada je sve uredu')
						pause = false
					end
					if selection == 2 then
						
						ESX.ShowNotification('Povecanje temperature je pomoglo...')
						quality = quality + 5
						pause = false
					end
					if selection == 3 then
						
						ESX.ShowNotification('Smanjenje temperature je napravilo jos goru situaciju...')
						pause = false
						quality = quality -4
					end
				end
				--
				--   EVENT 8 - 3
				--
				if progress > 41 and progress < 43 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Slucajno si stavio vise acetona, sto uciniti?')	
						ESX.ShowNotification('1. Nista')
						ESX.ShowNotification('2. Pokusati ga isisati pomocu sprica')
						ESX.ShowNotification('3. Staviti jos litijuma da uravnotezis smesu')
						ESX.ShowNotification('Pritisni broj zeljenog odgovora')
					end
					if selection == 1 then
						
						ESX.ShowNotification('Met ne mirise toliko na aceton')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						
						ESX.ShowNotification('Pomoglo je malo ali i dalje je previse acetona')
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						
						ESX.ShowNotification('Uspesno si izbalansirao smesu, sada je sve uredu')
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 3
				--
				if progress > 46 and progress < 49 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Pronasao si malo vodene boje, sto uciniti?')	
						ESX.ShowNotification('1. Staviti ju u smjesu')
						ESX.ShowNotification('2. Odloziti je')
						ESX.ShowNotification('3. Popiti je')
						ESX.ShowNotification('Pritisni broj zeljenog odgovora')
					end
					if selection == 1 then
						
						ESX.ShowNotification('Dobra ideja, ljudi vole boje')
						quality = quality + 4
						pause = false
					end
					if selection == 2 then
						
						ESX.ShowNotification('Pametno, mozda unisti okus Meta')
						pause = false
					end
					if selection == 3 then
						
						ESX.ShowNotification('Osjecas se cudno i malaksalo, ali sve je uredu')
						pause = false
					end
				end
				--
				--   EVENT 4
				--
				if progress > 55 and progress < 58 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Filter je zacepljen, sta uciniti?')	
						ESX.ShowNotification('1. Ocistiti ga pomocu kompresora')
						ESX.ShowNotification('2. Zameniti filter')
						ESX.ShowNotification('3. Ocistiti ga pomocu cetkice za zube')
						ESX.ShowNotification('Pritisni broj zeljenog odgovora')
					end
					if selection == 1 then
						
						ESX.ShowNotification('Zrak iz kompresora te pospricao tecnim metom')
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						
						ESX.ShowNotification('Zamena filtera je ipak najpametnija opcija')
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						
						ESX.ShowNotification('Ovo resenje nije lose mada je filter i dalje malo prljav')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 5
				--
				if progress > 58 and progress < 60 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Prosuo si bocu acetona na pod, sta uciniti?')	
						ESX.ShowNotification('1. Otvoriti prozor da miris izadje')
						ESX.ShowNotification('2. Nista')
						ESX.ShowNotification('3. Staviti gasmasku')
						ESX.ShowNotification('Pritisni broj zeljenog odgovora')
					end
					if selection == 1 then
						
						ESX.ShowNotification('Otvorio si prozor kako bi se resio jakog mirisa')
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						
						ESX.ShowNotification('Jak miris acetona te omamio')
						pause = false
						TriggerEvent('trp_meth:drugged')
					end
					if selection == 3 then
						
						ESX.ShowNotification('To je jednostavan odgovor na ovakav problem.. ')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 1 - 6
				--
				if progress > 63 and progress < 65 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Cev za propan curi, sto uciniti?')	
						ESX.ShowNotification('1. Popraviti pomocu lepljive trake')
						ESX.ShowNotification('2. Ne dirati ')
						ESX.ShowNotification('3. Zameniti je')
						ESX.ShowNotification('Pritisni broj zeljenog odgovora')
					end
					if selection == 1 then
						
						ESX.ShowNotification('Traka je delimicno zaustavila curenje')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						
						ESX.ShowNotification('Rezervoar sa propanom je eksplodirao, zeznuo si stvar...')
						TriggerServerEvent('trp_meth:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(PlayerPedId(), 10, false)
					end
					if selection == 3 then
						
						ESX.ShowNotification('Odlican posao, cev je bila u veoma losem stanju')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 4 - 7
				--
				if progress > 71 and progress < 73 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Filter je zacepljen, sta uciniti?')	
						ESX.ShowNotification('1. Ocistiti ga pomocu kompresora')
						ESX.ShowNotification('2. Zameniti filter')
						ESX.ShowNotification('3. Ocistiti ga pomocu cetkice za zube')
						ESX.ShowNotification('Pritisni broj zeljenog odgovora')
					end
					if selection == 1 then
						
						ESX.ShowNotification('Vazduh iz kompresora te pospricao tecnim metom')
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						
						ESX.ShowNotification('Zamena filtera je ipak najpametnija opcija')
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						
						ESX.ShowNotification('Ovo resenje nije lose mada je filter i dalje malo prljav')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 8
				--
				if progress > 76 and progress < 78 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Slucajno si stavio vise acetona, sto uciniti?')	
						ESX.ShowNotification('1. Nista')
						ESX.ShowNotification('2. Pokusati ga isisati pomocu sprica')
						ESX.ShowNotification('3. Staviti jos litijuma da uravnotezis smesu')
						ESX.ShowNotification('Pritisni broj zeljenog odgovora')
					end
					if selection == 1 then
						
						ESX.ShowNotification('Met ne mirise toliko na aceton')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						
						ESX.ShowNotification('Pomoglo je malo ali i dalje je previse acetona')
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						
						ESX.ShowNotification('Uspesno si izbalansirao smesu, sada je sve uredu')
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 9
				--
				if progress > 82 and progress < 84 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Moras da seres, sta uciniti?')	
						ESX.ShowNotification('1. Pokusati istrpiti')
						ESX.ShowNotification('2. Izaci napolje i obaviti nuzdu')
						ESX.ShowNotification('3. Obaviti nuzdu unutra')
						ESX.ShowNotification('Pritisni broj zeljenog odgovora')
					end
					if selection == 1 then
						
						ESX.ShowNotification('Dobar posao, prvo moras raditi, onda srati')
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						
						ESX.ShowNotification('Dok si bio napolje pala je puna casa sa stola i prosula se po podu...')
						pause = false
						quality = quality - 2
					end
					if selection == 3 then
						
						ESX.ShowNotification('Vazduh smrdi na govna, Met smrdi na govna')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 10
				--
				if progress > 88 and progress < 90 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('Da li ces dodati delice stakla u Met kako bi izgledalo da ga ima vise?')	
						ESX.ShowNotification('1. Da!')
						ESX.ShowNotification('2. Ne')
						ESX.ShowNotification('3. Sta ako dodam Met u staklo?')
						ESX.ShowNotification('Pritisni broj zeljenog odgovora')
					end
					if selection == 1 then
						
						ESX.ShowNotification('Sad vam je ostalo nekoliko vrecica')
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						
						ESX.ShowNotification('Imas dobru proizvodnju, kvalitet droge je odlican')
						pause = false
						quality = quality + 1
					end
					if selection == 3 then
						
						ESX.ShowNotification('To je previse, ima vise stakla nego Meta')
						pause = false
						quality = quality - 1
					end
				end
				
				
				
				
				
				
				
				if IsPedInAnyVehicle(playerPed) then
					TriggerServerEvent('trp_meth:make', pos.x,pos.y,pos.z)
					if pause == false then
						selection = 0
						quality = quality + 1
						progress = progress +  math.random(1, 2)
						ESX.ShowNotification('Proizvodnja Meta: ' .. progress .. '%')
					end
				else
					TriggerEvent('trp_meth:stop')
				end

			else
				TriggerEvent('trp_meth:stop')
				progress = 100
				ESX.ShowNotification('Proizvodnja Meta: ' .. progress .. '%')
				ESX.ShowNotification('Proizvodnja zavrsena')
				TriggerServerEvent('trp_meth:finish', quality)
				FreezeEntityPosition(LastCar, false)
			end	
			
		end
		
	end
end)
CreateThread(function()
	while true do
		Wait(1000)
			if IsPedInAnyVehicle(PlayerPedId()) then
			else
				if started then
					started = false
					displayed = false
					TriggerEvent('trp_meth:stop')
					FreezeEntityPosition(LastCar,false)
				end		
			end
	end

end)

CreateThread(function()
	while true do
		Wait(10)		
		if pause == true then
			if IsControlJustReleased(0, Keys['1']) then
				selection = 1
				ESX.ShowNotification('Odabrani odgovor broj 1')
			end
			if IsControlJustReleased(0, Keys['2']) then
				selection = 2
				ESX.ShowNotification('Odabrani odgovor broj 2')
			end
			if IsControlJustReleased(0, Keys['3']) then
				selection = 3
				ESX.ShowNotification('Odabrani odgovor broj 3')
			end
		end

	end
end)




-- Holster
