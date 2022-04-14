local points = {}
local nearby = {}

function points.new(coords, distance, data)
	local id = #points + 1

	local self = {
		id = id,
		coords = coords,
		distance = distance
	}

	for k, v in pairs(data) do
		self[k] = v
	end

	points[id] = self

	return self
end

CreateThread(function()
	while true do
		local coords = GetEntityCoords(cache.ped)
		Wait(300)
		table.wipe(nearby)

		for i = 1, #points do
			local point = points[i]
			local distance = #(coords - point.coords)

			if distance <= point.distance then
				point.currentDistance = distance

				if point.nearby then
					nearby[#nearby + 1] = point
				end

				if point.onEnter and not point.inside then
					point.inside = true
					point:onEnter()
				end
			elseif point.currentDistance then
				if point.onExit then point:onExit() end
				point.inside = nil
				point.currentDistance = nil
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		for i = 1, #nearby do
			nearby[i]:nearby()
		end
	end
end)

return points