local PlayersHarvesting, PlayersHarvesting2, PlayersHarvesting3, PlayersCrafting, PlayersCrafting2, PlayersCrafting3  = {}, {}, {}, {}, {}, {}

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'mechanic', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'mechanic', _U('mechanic_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'mechanic', 'mechanic', 'society_mechanic', 'society_mechanic', 'society_mechanic', {type = 'private'})

RegisterServerEvent('esx_mechanicjob:onNPCJobMissionCompleted')
AddEventHandler('esx_mechanicjob:onNPCJobMissionCompleted', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total   = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max);

	if xPlayer.job.grade >= 3 then
		total = total * 2
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
		account.addMoney(total)
	end)

	TriggerClientEvent("esx:showNotification", _source, _U('your_comp_earned').. total)
end)
