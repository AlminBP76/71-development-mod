# Discord
https://discord.gg/AYf7nWF

# Preview
https://streamable.com/g0yfj

# Description
This mod adds the following:

- Body will die in the same place for everyone.
- Allows you to look around whilst dead.
- All buttons you wish to be able to press are easy to add.
- Does not ragdoll the player so a carry extension will not have the body hovering but actually carrying.
- Animation resets every 5 seconds so if someone arrives late the player will reset animation and not be standing for them.

# How to use
- Die and animation will happen.
- Revive and animation will happen.

# Installation
Add to folder '[esx]'
Execute SQL : 'reload_death.sql'
Write 'start Reload_Death' in your server.cfg

First add these 2 Eventhandlers to esx_ambulancejob/client/main.lua under this, 

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

----------------------------------------------------------------
AddEventHandler('reload_death:onPlayerDeath', function(data)
	OnPlayerDeath()
	isDead = true
end)

AddEventHandler('reload_death:onPlayerRevive', function(data)
	isDead = false
end)
----------------------------------------------------------------

Add the following 'reload_death' callbacks and events to your esx_ambulancejob. I have added "<< HERE" below,
to show where I have added them. Yours may look a little different dependant on your version of esx_ambulancejob.

esx_ambulancejob/client/main.lua
----------------------------------------------------------------
function RespawnPed(ped, coords, heading)
        SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
        SetPlayerInvincible(ped, false)
        TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	TriggerEvent('reload_death:reviveRPDeath', playerPed)                           << HERE
        ClearPedBloodDamage(ped)

        ESX.UI.Menu.CloseAll()
end
----------------------------------------------------------------

esx_ambulancejob/client/job.lua
----------------------------------------------------------------
ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
	if quantity > 0 then
		local closestPlayerPed = GetPlayerPed(closestPlayer)
		ESX.TriggerServerCallback('reload_death:isPlayerDead', function(isPedDead)                       << HERE
			if isPedDead then
			local playerPed = PlayerPedId()
----------------------------------------------------------------
and here,
----------------------------------------------------------------
ESX.Streaming.RequestAnimDict(lib, function()
	TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
     end)
end

TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
TriggerServerEvent('reload_death:revive', GetPlayerServerId(closestPlayer))                                  << HERE

if Config.ReviveReward > 0 then
----------------------------------------------------------------

esx_ambulancejob/server/main.lua with this,
----------------------------------------------------------------
RegisterServerEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('reload_death:revive', target)                                           << HERE
	else
		print(('esx_ambulancejob: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)
----------------------------------------------------------------
and here,
----------------------------------------------------------------
TriggerEvent('es:addGroupCommand', 'revive', 'mod', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			print(('esx_ambulancejob: %s used admin revive'):format(GetPlayerIdentifiers(source)[1]))
			TriggerClientEvent('reload_death:revive', tonumber(args[1]))                                           << HERE
		end
	else
		TriggerClientEvent('reload_death:revive', source)                                           << HERE
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = _U('revive_help'), params = {{ name = 'id' }} })
----------------------------------------------------------------



To use other scripts such as carrying scripts you must add the 2 event handlers as seen at the top and IsDead = false

then you must Trigger the following event when starting the carry,
----------------------------------------------------------------
TriggerEvent('reload_death:stopAnim')
----------------------------------------------------------------

And you must Trigger the following event when stopping the carry,
----------------------------------------------------------------
TriggerEvent('reload_death:startAnim')
----------------------------------------------------------------


#LICENSE
This mod was made by Reload with the intention to distribute.
He and he alone reserves the right to sell this script. Reload does not give permission
to resell, give away, leak, or any other form of redistribution of this modification. Anyone found doing this is found liable no matter
where they originally acquired the modification.
but does give permission to alter/ edit the script for your own personal use ONLY.

























































































































































-- FiveMBulgaria