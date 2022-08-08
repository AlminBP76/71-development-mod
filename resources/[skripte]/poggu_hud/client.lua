ESX = nil
local lastJob = nil
local isAmmoboxShown = false
local PlayerData = nil

CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Wait(10)
  end
  Wait(3000)
  if PlayerData == nil or PlayerData.job == nil then
	  	PlayerData = ESX.GetPlayerData()
	end
	SendNUIMessage({
		action = 'initGUI',
		data = { whiteMode = Config.enableWhiteBackgroundMode, enableAmmo = Config.enableAmmoBox, colorInvert = Config.disableIconColorInvert }
	})
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('poggu_hud:retrieveData')
AddEventHandler('poggu_hud:retrieveData', function(data)
	SendNUIMessage({
		action = 'setMoney',
		cash = data.cash,
		bank = data.bank,
		black_money = data.black_money,
		society = data.society
	})
end)

function showAlert(message, time, color)
	SendNUIMessage({
		action = 'showAlert',
		message = message,
		time = time,
		color = color
	})
end

RegisterNetEvent('poggu_hud:showAlert')
AddEventHandler('poggu_hud:showAlert', function(message, time, color)
	showAlert(message, time, color)
end)


CreateThread(function()
	while true do
		Wait(5000)
		TriggerServerEvent('poggu_hud:retrieveData')

		--[[
		ESX.TriggerServerCallback('poggu_hud:retrieveData', function(data)
				SendNUIMessage({
					action = 'setMoney',
					cash = data.cash,
					bank = data.bank,
					black_money = data.black_money,
					society = data.society
				})
		end)
		]]--
	end
end)

CreateThread(function()
	while true do
		Wait(9000)
		if(PlayerData ~= nil) and (PlayerData.job ~= nil) then
			local jobName = PlayerData.job.label..' - '..PlayerData.job.grade_label
			if(lastJob ~= jobName) then
				lastJob = jobName
				SendNUIMessage({
					action = 'setJob',
					data = jobName
				})
			end
		end
	end
end)

CreateThread(function()
 while true do
		Wait(200)
		if Config.enableAmmoBox then
			local playerPed = PlayerPedId()
			local weapon, hash = GetCurrentPedWeapon(playerPed, 1)
			if(weapon) then
				isAmmoboxShown = true
				local _,ammoInClip = GetAmmoInClip(playerPed, hash)
				SendNUIMessage({
						action = 'setAmmo',
						data = ammoInClip..'/'.. GetAmmoInPedWeapon(playerPed, hash) - ammoInClip
				})
			else
				if isAmmoboxShown then
					isAmmoboxShown = false
					SendNUIMessage({
						action = 'hideAmmobox'
					})
				end
			end
		end
	end
end)

local isMenuPaused = false

function menuPaused()
	SendNUIMessage({
		action = 'disableHud',
		data = isMenuPaused
	})
end

CreateThread(function()
	while true do
		Wait(1)
		if IsPauseMenuActive() then
			if not isMenuPaused then
				isMenuPaused = true
				menuPaused()
			end
		elseif isMenuPaused then
			isMenuPaused = false
			menuPaused()
		end
		if IsControlJustPressed(1, 56) then
			SendNUIMessage({
				action = 'showAdvanced'
			})
		end
	end
end)

RegisterCommand("testPoguAlert", function()
	TriggerEvent("poggu_hud:showAlert", "Testiraj Boga", 5000, blue)
end)