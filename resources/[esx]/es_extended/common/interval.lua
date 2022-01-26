SetInterval = setmetatable({currentId = 0}, {
	__call = function(self, callback, timer)
		local id = self.currentId + 1
		self.currentId = id
		self[id] = timer or 0
		CreateThread(function()
			repeat
				local interval = self[id]
				Wait(interval)
				callback(interval)
			until interval == -1
			self[id] = nil
		end)
		return id
	end
})

function ClearInterval(id)
	if SetInterval[id] then
		SetInterval[id] = -1
	end
end