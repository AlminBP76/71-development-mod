local ox_inventory = exports.ox_inventory

AddEventHandler('onServerResourceStart', function(resourceName)
	if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
		local stashes = MySQL.query.await('SELECT * FROM addon_inventory')

		for i=1, #stashes do
			local stash = stashes[i]
			local jobStash = stash.name:find('society') and string.sub(stash.name, 9)
			ox_inventory:RegisterStash(stash.name, stash.label, 100, 200000, stash.shared == 0 and true or false, jobStash)
		end
	end
end)
