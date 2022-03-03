ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

GlobalState.Uzeo = 0

RegisterServerEvent('isplati')
AddEventHandler('isplati', function()
    local igrac = ESX.GetPlayerFromId(source) 

	igrac.addAccountMoney('bank', Config.CenaIsplate)
end)

RegisterServerEvent("dodajSvima")
AddEventHandler("dodajSvima", function()
	GlobalState.Uzeo = GlobalState.Uzeo + 1
	print(GlobalState.Uzeo)
end)

RegisterServerEvent('vracajPareee')
AddEventHandler('vracajPareee', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local Payout = Config.UzmiAutoCena
	
	xPlayer.addAccountMoney('bank', Config.UzmiAutoCena)
end)

ESX.RegisterServerCallback('proveriPare', function(playerId, cb)
	local igrac = ESX.GetPlayerFromId(playerId)
    local name = ESX.GetPlayerFromId(playerId)

	if igrac.getMoney() >= Config.UzmiAutoCena then
        igrac.removeMoney(Config.UzmiAutoCena)
		cb(true)
    elseif igrac.getAccount('bank').money >= Config.UzmiAutoCena then
        igrac.removeAccountMoney('bank', Config.UzmiAutoCena)
        cb(true)
	else
		cb(false)
	end
end)