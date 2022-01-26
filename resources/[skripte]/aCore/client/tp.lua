RegisterCommand("tp", function(source, args, rawCommand)
	if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil and tonumber(args[3]) ~= nil then
	local posx = tonumber(args[1])
	local posy = tonumber(args[2])
	local posz = tonumber(args[3])
	local coords = { x = posx, y = posy, z = posz}
	ESX.Game.Teleport(PlayerPedId(), coords)
	end
	end)