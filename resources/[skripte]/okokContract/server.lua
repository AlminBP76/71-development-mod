ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Webhook = 'https://discord.com/api/webhooks/933842913434165249/K3zA4LoIuawzDOVmuNC5cQv-D69gSv4nEuFZ7k7KWNXeXrf_vZNIjC1qVKjEWgwKnY_4'

RegisterServerEvent('okokContract:changeVehicleOwner')
AddEventHandler('okokContract:changeVehicleOwner', function(data)
	_source = data.sourceIDSeller
	target = data.targetIDSeller
	plate = data.plateNumberSeller
	model = data.modelSeller
	source_name = data.sourceNameSeller
	target_name = data.targetNameSeller
	vehicle_price = tonumber(data.vehicle_price)

	local xPlayer = ESX.GetPlayerFromId(_source)
	local tPlayer = ESX.GetPlayerFromId(target)
	local webhookData = {
		model = model,
		plate = plate,
		target_name = target_name,
		source_name = source_name,
		vehicle_price = vehicle_price
	}
	local result = MySQL.query.await('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
		['@identifier'] = xPlayer.identifier,
		['@plate'] = plate
	})

	if Config.RemoveMoneyOnSign then
		local bankMoney = tPlayer.getAccount('bank').money

		if result[1] ~= nil  then
			if bankMoney >= vehicle_price then
				MySQL.query('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@target'] = tPlayer.identifier,
					['@plate'] = plate
				}, function (result2)
					if result2 ~= 0 then	
						tPlayer.removeAccountMoney('bank', vehicle_price)
						xPlayer.addAccountMoney('bank', vehicle_price)

						TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", "You successfully sold the vehicle <b>"..model.."</b> with the plate number <b>"..plate.."</b>", 10000, 'success')
						TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", "You successfully bought the vehicle <b>"..model.."</b> with the plate number <b>"..plate.."</b>", 10000, 'success')

						if Webhook ~= '' then
							sellVehicleWebhook(webhookData)
						end
					end
				end)
			else
				TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", target_name.." doesn't have enough money to buy your vehicle", 10000, 'error')
				TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", "You don't have enough money to buy "..source_name.."'s vehicle", 10000, 'error')
			end
		else
			TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", "The vehicle with the plate number <b>"..plate.."</b> isn't yours", 10000, 'error')
			TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", source_name.." tried to sell you a vehicle he doesn't owns", 10000, 'error')
		end
	else
		if result[1] ~= nil then
			MySQL.query('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
				['@owner'] = xPlayer.identifier,
				['@target'] = tPlayer.identifier,
				['@plate'] = plate
			}, function (result2)
				if result2 ~= 0 then
					TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", "You successfully sold the vehicle <b>"..model.."</b> with the plate number <b>"..plate.."</b>", 10000, 'success')
					TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", "You successfully bought the vehicle <b>"..model.."</b> with the plate number <b>"..plate.."</b>", 10000, 'success')

					if Webhook ~= '' then
						sellVehicleWebhook(webhookData)
					end
				end
			end)
		else
			TriggerClientEvent('okokNotify:Alert', _source, "VEHICLE", "The vehicle with the plate number <b>"..plate.."</b> isn't yours", 10000, 'error')
			TriggerClientEvent('okokNotify:Alert', target, "VEHICLE", source_name.." tried to sell you a vehicle he doesn't owns", 10000, 'error')
		end
	end
end)

ESX.RegisterServerCallback('okokContract:GetTargetName', function(source, cb, targetid)
	local target = ESX.GetPlayerFromId(targetid)
	local targetname = target.getName()

	cb(targetname)
end)

RegisterServerEvent('okokContract:SendVehicleInfo')
AddEventHandler('okokContract:SendVehicleInfo', function(description, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('okokContract:GetVehicleInfo', _source, xPlayer.getName(), os.date(Config.DateFormat), description, price, _source)
end)

RegisterServerEvent('okokContract:SendContractToBuyer')
AddEventHandler('okokContract:SendContractToBuyer', function(data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent("okokContract:OpenContractOnBuyer", data.targetID, data)
	TriggerClientEvent('okokContract:startContractAnimation', data.targetID)

	if Config.RemoveContractAfterUse then
		xPlayer.removeInventoryItem('contract', 1)
	end
end)

ESX.RegisterUsableItem('contract', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('okokContract:OpenContractInfo', _source)
	TriggerClientEvent('okokContract:startContractAnimation', _source)
end)

-------------------------- SELL VEHICLE WEBHOOK

function sellVehicleWebhook(data)
	local information = {
		{
			["color"] = Config.sellVehicleWebhookColor,
			["author"] = {
				["icon_url"] = Config.IconURL,
				["name"] = Config.ServerName..' - Logs',
			},
			["title"] = 'Prodaja Vozila',
			["description"] = '**Vozilo: **'..data.model..'**\nTablice: **'..data.plate..'**\nIme kupca: **'..data.target_name..'**\nIme prodavca: **'..data.source_name..'**\nCijena: **'..data.vehicle_price..'€',

			["footer"] = {
				["text"] = os.date(Config.WebhookDateFormat),
			}
		}
	}
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.BotName, embeds = information}), {['Content-Type'] = 'application/json'})
end