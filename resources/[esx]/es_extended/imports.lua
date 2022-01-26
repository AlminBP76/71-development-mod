ESX = exports['es_extended']:getSharedObject()
------------------------------------------------------------------------
-- SHARED
------------------------------------------------------------------------
-- Setup imported functions to use on your server

------------------------------------------------------------------------
if IsDuplicityVersion() then
------------------------------------------------------------------------
-- Setup imported functions to use on your server

------------------------------------------------------------------------
else -- CLIENT
------------------------------------------------------------------------
	ESX.UI.RegisteredTypes, ESX.PlayerData.inventory = nil, {}

	AddEventHandler('esx:setPlayerData', function(key, val, last)
		if GetInvokingResource() == 'es_extended' then
			ESX.PlayerData[key] = val
			if OnPlayerData ~= nil then OnPlayerData(key, val, last) end
		end
	end)

------------------------------------------------------------------------
end
------------------------------------------------------------------------
