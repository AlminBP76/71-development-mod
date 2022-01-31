

ESX = nil
Citizen.CreateThread(function()
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	while ESX == nil do
		Citizen.Wait(200)
	end

	PlayerData = ESX.GetPlayerData()
	exports.spawnmanager:setAutoSpawn(false)
end)

local iFunkcije = {}
local AdminMeniOtvoren = false
local UItajmer = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if NetworkIsSessionStarted() then
            TriggerServerEvent("kAdmin:playerLoaded")
			TriggerServerEvent('phone:loadPhone')
            return
        end
    end
end)





RegisterNetEvent("kAdmin:tpm", function()

	local blipnajebenojmapi = GetFirstBlipInfoId(8)
	if DoesBlipExist(blipnajebenojmapi) then
		local igrac = PlayerPedId()
		local teleportianientity = igrac
		if IsPedInAnyVehicle(igrac, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(igrac, false), -1) == igrac then
		  teleportianientity = GetVehiclePedIsIn(igrac, false)
		end
		NetworkFadeOutEntity(teleportianientity, true, false)
		local kordinate = GetBlipInfoIdCoord(blipnajebenojmapi)
		local jelipronadjenpod, kodrinateZ = false, 0
		local provjerisvevisine = {0.0, 50.0, 100.0, 150.0, 200.0, 250.0, 300.0, 350.0, 400.0,450.0, 500.0, 550.0, 600.0, 650.0, 700.0, 750.0, 800.0}
		local headingodigraca = GetEntityHeading(teleportianientity)
		--for _,visina in ipairs(provjerisvevisine) do
		for _,visina in pairs(provjerisvevisine) do -- brze :)
			--ESX.Game.Teleport(teleportianientity, {x = kordinate.x, y = kordinate.y, z = visina})
			ESX.Game.Teleport(teleportianientity, {
				  x = kordinate.x,
				  y = kordinate.y,
				  z = visina,
				  heading = headingodigraca
				}, function()
			  end, true) --
			local foundGround, z = GetGroundZFor_3dCoord(kordinate.x, kordinate.y, visina)
			if foundGround then
				kodrinateZ = z + 3.01
				jelipronadjenpod = true
				break
			end
		end
		if jelipronadjenpod then
			--ESX.Game.Teleport(teleportianientity, {x = kordinate.x, y = kordinate.y, z = kodrinateZ})
			ESX.Game.Teleport(teleportianientity, {
				  x = kordinate.x,
				  y = kordinate.y,
				  z = kodrinateZ,
				  heading = headingodigraca
				}, function()
			  end, true) --
			NetworkFadeInEntity(teleportianientity, true)
		--	print('dosla baba na marker')
		else
		 --  print('nema poda te portam na prvu pronadjenu zemlju')
		   RemoveBlip(blipnajebenojmapi)
			local retval, vannjskapozicija = GetNthClosestVehicleNode(kordinate.x, kordinate.y, kodrinateZ, 0, 0, 0, 0)
			--ESX.Game.Teleport(teleportianientity, {x = vannjskapozicija.x, y = vannjskapozicija.y, z = vannjskapozicija.z})
			ESX.Game.Teleport(teleportianientity, {
				  x = vannjskapozicija.x,
				  y = vannjskapozicija.y,
				  z = vannjskapozicija.z,
				  heading = headingodigraca
				}, function()
			  end, true) --
			NetworkFadeInEntity(teleportianientity, true)
		end
	else
		ESX.ShowNotification("Morate oznaciti lokaciju na ~r~mapi")	
	 end 
end)


RegisterCommand("fix", function()
	TriggerEvent("71Admin:fixveh")
end)

RegisterNetEvent('71Admin:fixveh',function()
	local playerPed = PlayerPedId()
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)

		NetworkRequestControlOfEntity(vehicle)
		while not NetworkHasControlOfEntity(vehicle) do Wait(10) end
		SetNetworkIdExistsOnAllMachines(VehNetId, true)
		SetEntityAsMissionEntity(vehicle, true, true)

		SetVehicleEngineHealth(vehicle, 9999)
		SetVehiclePetrolTankHealth(vehicle, 9999)
		SetVehicleFixed(vehicle)

		TriggerEvent('chat:addMessage', { args = {"^4[71-admin]^0: Vozilo popravljeno!"} })
	else
		TriggerEvent('chat:addMessage', { args = {"^4[71-admin]^0: Nisi u vozilu!"} })
	end
end)

RegisterCommand("clean", function()
	TriggerEvent("71Admin:ocisti")
end)

RegisterNetEvent("71Admin:ocisti", function()
	local playerPed = PlayerPedId()
	if IsPedInAnyVehicle(playerPed, false) then
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	SetVehicleDirtLevel(vehicle, 0)
	    TriggerEvent('chat:addMessage', { args = {"^4[71-admin]^0: Vozilo ocisceno!"} })
	else
		TriggerEvent('chat:addMessage', { args = {"^4[71-admin]^0: Nisi u vozilu!"} })
	end
end)


RegisterCommand("dajauto", function(source, args)


		if jel then
			if args[1] and args[2] and args[3] then
				vehicle = args[1]
				id = args[2]
				tablice = args[3]

				local model = (type(vehicle) == 'number' and vehicle or GetHashKey(vehicle))

				if IsModelInCdimage(model) then
					local playerPed = PlayerPedId()
					local playerCoords, playerHeading = GetEntityCoords(playerPed), GetEntityHeading(playerPed)

					ESX.Game.SpawnVehicle(model, playerCoords, playerHeading, function(vehicle)
						TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						SetVehicleNumberPlateText(vehicle, tablice)

						local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
						vehicleProps.plate = tablice

						TriggerServerEvent("kAdmin:AutouBazu", vehicleProps, args[2])
					end)

					
				else
					TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', 'Invalid vehicle model.' } })
				end

			end
		end

	end, false)




RegisterNetEvent("kAdmin:slay", function()
	SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent("kAdmin:tp", function(coords)
	local x = tonumber(coords[1]) + 0.0
	local y = tonumber(coords[2]) + 0.0
	local z = tonumber(coords[3]) + 0.0

 	SetPedCoordsKeepVehicle(PlayerPedId(), x, y, z)
 	TriggerEvent('chat:addMessage', { templateId = 'kAdmin', args = {"Teleportovao si se na zeljene koordinate (".. x .. ", " .. y .. ", " .. z ..")!"}})
end)

local showPos = false
RegisterNetEvent("kAdmin:pozicija", function()
	showPos = not showPos
	if showPos then
		SendNUIMessage({akcija = "pozicija", akcija2 = "show"})
		local playerPed = PlayerPedId()

		while showPos do
			Wait(5)

			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
			local playerH = GetEntityHeading(playerPed)
			local kordinata = string.format("vector3(%.2f, %.2f, %.2f) h = %.2f", playerX, playerY, playerZ, playerH)
			local kordinata2 = string.format('vector4(%.2f, %.2f, %.2f, %.2f)', playerX, playerY, playerZ, playerH)

			SendNUIMessage({
				akcija = "pozicija",
				akcija2 = "update",
				coord1 = kordinata,
				coord2 = kordinata2
			})

			if IsControlPressed(0, 131) and IsControlJustReleased(0, 26) then
				SendNUIMessage({akcija = "pozicija", akcija2 = "copy2"})
			elseif IsControlJustPressed(0, 26) then
				SendNUIMessage({akcija = "pozicija", akcija2 = "copy1"})
			end
		end
	else
		SendNUIMessage({akcija = "pozicija", akcija2 = "hide"})
	end
end)



RegisterNUICallback("kickuj", function(data, cb)
	TriggerServerEvent('kAdmin:izbaci', data.playerid, data.reason)
end)

RegisterNUICallback("ban", function(data, cb)
	--TriggerServerEvent("kAdmin:meni:ban", tonumber(data.playerid), data.reason, tonumber(data.lenght))
	TriggerServerEvent("kAdmin:banPlayer", tonumber(data.playerid), tonumber(data.lenght), data.reason)
end)

RegisterKeyMapping("adminmenu2", "Admin meni", "keyboard", "DELETE")
RegisterCommand("adminmenu2", function()
	ESX.TriggerServerCallback('kAdmin:getGroup', function(group)
		if group ~= "user" then
			TriggerEvent("kAdmin:meni:show")
			end
	end)
end)

RegisterNetEvent("kAdmin:meni:show", function()
	SendNUIMessage({akcija = "adminmeni"})
	SetNuiFocus(true, true)
end)

RegisterNUICallback("zatvori", function()
	SetNuiFocus(false, false)
	showMeni = false
end)



RegisterNUICallback("getPlayers", function(data, cb)
	local igr = {}
    local igraci = ESX.Game.GetPlayers()

    for i=1, #igraci, 1 do
		local ime = GetPlayerName(igraci[i])
        local pid = GetPlayerFromServerId(igraci[i])
        local id = GetPlayerServerId(igraci[i])
        local playerped = GetPlayerPed(pid)

		igr[#igr+1] = {ime = ime, id = id}
    end
	--json.encode(igr)
	cb({igr = igr})
	--print(igr[2].ime)

end)

local InvisiblePlayers = {}
local DoingUpdate = false


RegisterNetEvent("kAdmin:ForwardDeleteInvisPlayer", function(id)
	DoingUpdate = true
	if GetPlayerFromServerId(id) ~= 0 then
		NetworkConcealPlayer(GetPlayerFromServerId(id), false, false)
	end
	Wait(500)
	DoingUpdate = false
end)

local SpectatedPlayer = 0
local SpectatedName = "N/N"
local PosBeforeSpec = nil
local RouteBeforeSpec = 0
local Spectate = false
local PauseNextSpec = false

--[[RegisterNUICallback("spectate", function(data, cb)

	if tonumber(data.playerid) ~= GetPlayerServerId(PlayerId()) then
			
			NetworkSetInSpectatorMode(false, GetPlayerPed(SpectatedPlayer))
			local TargetID, myCoords = TriggerServerCallback("kAdmin:StartSpectate", tonumber(data.playerid))
			local OtherCoords = TriggerServerCallback("kAdmin:StartSpectate2", tonumber(data.playerid))
			Wait(1000)
	
			if not Spectate then
				TriggerServerEvent("kAdmin:AddToInvisible")
				ExecuteCommand("duznost")
				PosBeforeSpec = myCoords
			end

			SpectatedPlayer = 0

			while SpectatedPlayer == 0 or SpectatedPlayer == -1 do
				SpectatedPlayer = GetPlayerFromServerId(TargetID)
				SetEntityCoords(PlayerPedId(), OtherCoords, 0, 0, 0, 0)
			end

			SpectatedName = GetPlayerName(SpectatedPlayer)
			Spectate = true

			NetworkSetInSpectatorMode(true, GetPlayerPed(SpectatedPlayer))

			SendNUIMessage({
				action = "OpenSpecBox",
				playerName = SpectatedName
			})
	end
	local admin = GetPlayerName(PlayerId())
	TriggerServerEvent("StiflerLogovi:StartSpectateLog", SpectatedName, admin)
	
end) ]]--

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DisablePlayerVehicleRewards(PlayerId())
		local LetSleep = true
		local playerPed = PlayerPedId()
		local player = PlayerId()
		local spec_ped = GetPlayerPed(SpectatedPlayer)

		if Spectate then
			LetSleep = false
			if SpectatedPlayer then
				SetEntityVisible(playerPed, false)
				SetEntityCoords(playerPed, GetEntityCoords(GetPlayerPed(SpectatedPlayer)))
				SetEntityInvincible(playerPed, true)
				SetPlayerInvincible(player, true)
				SetEntityCompletelyDisableCollision(playerPed, false, false)

				local ped_maxhealth = GetPedMaxHealth(spec_ped)
				local ped_currenthealth = GetEntityHealth(spec_ped)
				local ped_armour = GetPedArmour(spec_ped)
				local ped_maxarmour = GetPlayerMaxArmour(SpectatedPlayer)

				SendNUIMessage({
					action = "updateSpecBox",
					ped_maxhealth = ped_maxhealth,
					ped_currenthealth = ped_currenthealth,
					ped_armour = ped_armour,
					ped_maxarmour = ped_maxarmour
				})
			end

			if IsControlJustPressed(0, 38) then
				Spectate = false
				ExecuteCommand("duznost")
				NetworkSetInSpectatorMode(false, PlayerPedId())
				SetEntityCoords(PlayerPedId(), PosBeforeSpec - vector3(0.0, 0.0, 0.5), 0, 0, 0, 0)
				TriggerServerEvent("kAdmin:RemoveFromInvisible", RouteBeforeSpec)
				PosBeforeSpec, SpectatedPlayer, SpectatedName = nil, 0, nil

				SetEntityVisible(playerPed, true)
				SetEntityCompletelyDisableCollision(playerPed, true, true)
				SetEntityInvincible(playerPed, false)
				SetPlayerInvincible(player, false)

				SendNUIMessage({
					action = "CloseSpecBox"
				})
			end
		end
		if LetSleep then
			Citizen.Wait(500)
		end
	end
end)

---tag
local showIDs = false

local bojeTagova = {
    ["vlasnik"] = "204, 0, 0, 1.0",
    ["developer"] = "53, 56, 55, 1.0",
  	["admin"] = "0, 255, 0, 1.0",
  	["headadmin"] = "56, 219, 255, 1.0",
  	["drug"] = "255, 0, 255, 1.0",
    ["helper"] = "255, 0, 255, 1.0",
}

RegisterNetEvent("kAdmin:showIDs", function()
  if not showIDs then
    print("ID ukljucen")
    showIDs = true
  else
    showIDs = false
    print("ID iskljucen")
  end
end)

local pokazuje = false

CreateThread(function()
	while true do
		Wait(20)
		local pPed = PlayerPedId()
		local coord = GetEntityCoords(pPed)
		local igraci = GetActivePlayers()
		local letSleep = true

		for i = 1, #igraci do
			local coord2 = GetEntityCoords(GetPlayerPed(igraci[i]))
			local srvID = GetPlayerServerId(igraci[i])

			local playerData = Player(srvID).state
			local bojaTag = bojeTagova[playerData.aGroup]

			if not pokazuje then 
				if #(coord - coord2) < 20 and not showIDs then
					if bojeTagova[playerData.aGroup] then
						if playerData.duznost then
							letSleep = false
							draw3dNUI( " <span style = 'color:rgba(".. bojaTag .."); font-size: 1.5em;'> [ " .. playerData.aGroup .." ] </span> <br> "..GetPlayerName(igraci[i]), coord2 + vector3(0.0, 0.0, 1.1), "player-"..srvID)
						end
					end
				end
			end

			if showIDs then
				if #(coord - coord2) < 100 then
					letSleep = false
					draw3dNUI( " [ " .. srvID .." ] | "..GetPlayerName(igraci[i]), coord2 + vector3(0.0, 0.0, 1.1), "ids-"..srvID)
				end
			end 
		end
		if letSleep then
			Wait(500)
		end
	end
end)




function draw3dNUI(text, coords, id)
	local paused = false
	if IsPauseMenuActive() then paused = true end
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z)
	if not paused then
		isDrawing = true
		if paused then SendNUIMessage ({action = "hide"}) else SendNUIMessage({action = "display", x = _x, y = _y, text = text, id = id}) end
		last_x, last_y, lasttext = _x, _y, text
		Citizen.Wait(0)
	end
end
---


local DelObjekt = false

RegisterNetEvent("kAdmin:delObjekt", function()
	if not DelObjekt then 
		DelObjekt = true 
		brObjekt()
	else
		DelObjekt = false
		ClearInterval('del')
	end
end)



brObjekt = function()
	SetInterval("del", 0, function()
		local isAim, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
		if IsControlJustPressed(0, 38) then
			if isAim then
				SetEntityAsMissionEntity(entity, true, true)
				NetworkRegisterEntityAsNetworked(entity)
				TriggerServerEvent("kAdmin:objektDel", NetworkGetNetworkIdFromEntity(entity))
			end
		end
	end)
end

RegisterNUICallback("TeleportTo", function(data, cb)
	local players = GetActivePlayers()
	for i = 1, #players do
			local currentplayer = players[i]
            local ped = GetPlayerPed(currentplayer)
	SetEntityCoords(PlayerPedId(), GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z, 0, 0, 0, false)
	end
end)

RegisterNUICallback("Inventar", function(data, cb)
	SendNUIMessage({
		sise = "zatvarajsve"
	})
		SetNuiFocus(false, false)
	showMeni = false
	Wait(500)
	TriggerServerEvent("kAdmin:otvoriInventory", tonumber(data.playerid))
end)

RegisterNetEvent("kAdmin:bring")
AddEventHandler("kAdmin:bring", function(coords) SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, 1, 0, 0, 1) end)

RegisterNUICallback('toTeleport', function(data, cb)
  ExecuteCommand('tome '..data['id'])
  cb(true)
end)




RegisterNUICallback("freeze", function(data, cb)
	TriggerServerEvent("kAdmin:freeze", tonumber(data.playerid))
end)

local jelVisible = true
RegisterNUICallback("invisible", function(data, cb)

	if jelVisible then
		TriggerServerEvent("kAdmin:AddToInvisible")
		TriggerEvent('chat:addMessage', { templateId = 'kAdmin', args = {"Sada si nevidljiv ostalim igracima!"}})
		SetEntityAlpha(PlayerPedId(), 120, false)
	else
		TriggerServerEvent("kAdmin:RemoveFromInvisible")
		TriggerEvent('chat:addMessage', { templateId = 'kAdmin', args = {"Sada si vidljiv ostalim igracima!"}})
		SetEntityAlpha(PlayerPedId(), 255, false)
	end

	jelVisible = not jelVisible

end)

RegisterNUICallback("getOfflinePlayers", function(data, cb)
	ESX.TriggerServerCallback("kAdmin:DohvatiCacheovane", function(cacheovani)
		cb(cacheovani)
	end)
end)

RegisterNUICallback("banOffline", function(data, cb)
	--TriggerServerEvent("kAdmin:meni:ban", tonumber(data.playerid), data.reason, tonumber(data.lenght))
	TriggerServerEvent("kAdmin:banPlayer", tonumber(data.playerid), tonumber(data.lenght), data.reason)
end)

RegisterNUICallback("getBannedPlayers", function(data, cb)
	ESX.TriggerServerCallback("kAdmin:fetchBanned", function(banovi)
		cb(banovi)
	end)
end)

RegisterNUICallback("Unbanban_igraca", function(data, cb)
	TriggerServerEvent("kAdmin:meni:unban", tonumber(data.banid))
end)


RegisterCommand("clear", function()
	TriggerEvent("chat:clear")
end)

RegisterNetEvent("kAdmin:DonatorskoDaj:c", function(org, model)
	local has = GetHashKey(model)

	if not IsModelInCdimage(has) then return end

	RequestModel(has)
	while not HasModelLoaded(has) do Wait(10) end

	ESX.Game.SpawnVehicle(has, GetEntityCoords(PlayerPedId()), GetEntityHeading(GetPlayerPed(playerSrc)), function(veh)
		local vehData = ESX.Game.GetVehicleProperties(veh)
		TSE("kAdmin:DonatorskoDaj", org, vehData, model)
	end)

end)
local listOpen = false
RegisterNetEvent("kAdmin:discordlista", function(data)
	listOpen = not listOpen

	SendNUIMessage({
		action = "discordLista",
		discordi = data,
		action2 = listOpen
	})

	SetNuiFocus(listOpen, listOpen)
end)

RegisterNUICallback("focusOff", function()
		SetNuiFocus(false, false)
		SendNUIMessage({
			actison = "discordLista",
			action2 = false
		})

		listOpen = false
end)



RegisterNetEvent('kAdmin:gotoadmin')
AddEventHandler('kAdmin:gotoadmin', function(x, y, z)
  SetEntityCoords(PlayerPedId(), x, y, z)
end)



-- BEZ NPCOVA

CreateThread(function()
    SetMaxWantedLevel(0)
    SetGarbageTrucks(false)
    SetRandomBoats(false)
    SetRandomTrains(false)
    SetCreateRandomCops(false)
    SetCreateRandomCopsNotOnScenarios(false)
    SetCreateRandomCopsOnScenarios(false)
    SetDispatchCopsForPlayer(PlayerId(), false)
    SetPedPopulationBudget(0)
    SetVehiclePopulationBudget(0)
    for i = 0, 15 do
        EnableDispatchService(i, false)
    end
end)


RegisterNetEvent("gorivo_napuni", function()
AddEventHandler("gorivo_napuni")	
	local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	exports["LegacyFuel"]:SetFuel(vehicle, 100)
	end
end)
