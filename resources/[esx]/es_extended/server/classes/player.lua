local Inventory
AddEventHandler('ox_inventory:loadInventory', function(module)
	Inventory = module
end)

local function emptytable() return {} end
local function emptyfn() end

function CreateExtendedPlayer(playerId, identifier, group, accounts, job, name, coords)
	local self = {
		accounts = accounts,
		coords = coords,
		group = group,
		identifier = identifier,
		inventory = {},
		job = job,
		name = name,
		playerId = playerId,
		source = playerId,
		variables = {},
		weight = 0,
		maxWeight = Config.MaxWeight,
		loadout = {}, -- babymode, activate
	}
	if Config.Multichar then self.license = Config.Identifier .. identifier:sub(identifier:find(':'), identifier:len()) else self.license = Config.Identifier .. ':'..identifier end

	ExecuteCommand(('add_principal player.%s group.%s'):format(self.source, self.group))
	ExecuteCommand(('add_principal player.%s group.%s'):format(self.source, self.job.name))

	self.triggerEvent = function(eventName, ...)
		TriggerClientEvent(eventName, self.source, ...)
	end

	self.setCoords = function(coords)
		self.updateCoords(coords)
		self.triggerEvent('esx:teleport', coords)
	end

	self.updateCoords = function(coords)
		self.coords = {x = ESX.Math.Round(coords.x, 1), y = ESX.Math.Round(coords.y, 1), z = ESX.Math.Round(coords.z, 1), heading = ESX.Math.Round(coords.heading or 0.0, 1)}
	end

	self.getCoords = function(vector)
		if vector then
			return vector3(self.coords.x, self.coords.y, self.coords.z)
		else
			return self.coords
		end
	end

	self.kick = function(reason)
		DropPlayer(self.source, reason)
	end

	self.setMoney = function(money)
		money = ESX.Math.Round(money)
		self.setAccountMoney('money', money)
	end

	self.getMoney = function()
		return self.getAccount('money').money
	end

	self.addMoney = function(money)
		money = ESX.Math.Round(money)
		self.addAccountMoney('money', money)
	end

	self.removeMoney = function(money)
		money = ESX.Math.Round(money)
		self.removeAccountMoney('money', money)
	end

	self.getIdentifier = function()
		return self.identifier
	end

	self.setGroup = function(newGroup)
		ExecuteCommand(('remove_principal player.%s group.%s'):format(self.source, self.group))
		self.group = newGroup
		ExecuteCommand(('add_principal player.%s group.%s'):format(self.source, self.group))
		Player(playerId).state.admin = Core.IsPlayerAdmin(self.source)
	end

	self.getGroup = function()
		return self.group
	end

	self.set = function(k, v)
		self.variables[k] = v
	end

	self.get = function(k)
		return self.variables[k]
	end

	self.getAccounts = function(minimal)
		if minimal then
			local minimalAccounts = {}

			for k,v in ipairs(self.accounts) do
				minimalAccounts[v.name] = v.money
			end

			return minimalAccounts
		else
			return self.accounts
		end
	end

	self.getAccount = function(account)
		for k,v in ipairs(self.accounts) do
			if v.name == account then
				return v
			end
		end
	end

	self.getInventory = function(minimal)
		if minimal and next(self.inventory) then
			local inventory = {}
			for k, v in pairs(self.inventory) do
				if v.count and v.count > 0 then
					local metadata = v.metadata
					if v.metadata and next(v.metadata) == nil then metadata = nil end
					inventory[#inventory+1] = {
						name = v.name,
						count = v.count,
						slot = k,
						metadata = metadata
					}
				end
			end
			return inventory
		end
		return self.inventory
	end

	self.getJob = function()
		return self.job
	end

	self.getName = function()
		return self.name
	end

	self.setName = function(newName)
		self.name = newName
	end

	self.setAccountMoney = function(accountName, money)
		if money >= 0 then
			local account = self.getAccount(accountName)

			if account then
				local prevMoney = account.money
				local newMoney = ESX.Math.Round(money)
				account.money = newMoney
				if accountName ~= 'bank' then Inventory.SetItem(self.source, accountName, money) end
				self.triggerEvent('esx:setAccountMoney', account)
			end
		end
	end

	self.addAccountMoney = function(accountName, money)
		if money > 0 then
			local account = self.getAccount(accountName)

			if account then
				local newMoney = account.money + ESX.Math.Round(money)
				account.money = newMoney
				if accountName ~= 'bank' then Inventory.AddItem(self.source, accountName, money) end
				self.triggerEvent('esx:setAccountMoney', account)
			end
		end
	end

	self.removeAccountMoney = function(accountName, money)
		if money > 0 then
			local account = self.getAccount(accountName)

			if account then
				local newMoney = account.money - ESX.Math.Round(money)
				account.money = newMoney
				if accountName ~= 'bank' then Inventory.RemoveItem(self.source, accountName, money) end
				self.triggerEvent('esx:setAccountMoney', account)
			end
		end
	end

	self.getInventoryItem = function(name, metadata)
		return Inventory.GetItem(self.source, name, metadata)
	end

	self.addInventoryItem = function(name, count, metadata, slot)
		Inventory.AddItem(self.source, name, count or 1, metadata, slot)
	end

	self.removeInventoryItem = function(name, count, metadata)
		Inventory.RemoveItem(self.source, name, count or 1, metadata)
	end

	self.setInventoryItem = function(name, count, metadata)
		Inventory.SetItem(self.source, name, count, metadata)
	end

	self.getWeight = function()
		return self.weight
	end

	self.getMaxWeight = function()
		return self.maxWeight
	end

	self.canCarryItem = function(name, count)
		return Inventory.CanCarryItem(self.source, name, count, metadata)
	end

	self.canSwapItem = function(firstItem, firstItemCount, testItem, testItemCount)
		return Inventory.CanSwapItem(self.source, firstItem, firstItemCount, testItem, testItemCount)
	end

	self.setMaxWeight = function(newWeight)
		self.maxWeight = newWeight
		return Inventory.Set(self.source, 'maxWeight', newWeight)
	end

	self.setJob = function(job, grade)
		grade = tostring(grade)
		if ESX.DoesJobExist(job, grade) then

			if self.job.name ~= job then
				ExecuteCommand(('remove_principal player.%s group.%s'):format(self.source, self.job.name))
			end

			local lastJob = table.clone(self.job)
			local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]

			self.job.id    = jobObject.id
			self.job.name  = jobObject.name
			self.job.label = jobObject.label

			self.job.grade        = tonumber(grade)
			self.job.grade_name   = gradeObject.name
			self.job.grade_label  = gradeObject.label
			self.job.grade_salary = gradeObject.salary

			if gradeObject.skin_male then
				self.job.skin_male = json.decode(gradeObject.skin_male)
			else
				self.job.skin_male = {}
			end

			if gradeObject.skin_female then
				self.job.skin_female = json.decode(gradeObject.skin_female)
			else
				self.job.skin_female = {}
			end

			if self.job.name ~= job then
				ExecuteCommand(('add_principal player.%s group.%s'):format(self.source, self.job.name))
			end

			local Player = Player(self.source).state

			TriggerEvent('esx:setJob', self.source, self.job, lastJob)
			self.triggerEvent('esx:setJob', self.job)
			Player.job = jobObject.name
			Player.grade = gradeObject.name
		else
			print(('[es_extended] [^3WARNING^7] Ignoring invalid .setJob() usage for "%s"'):format(self.identifier))
		end
	end

	self.getLoadout = function() return {} end

	self.showNotification = function(msg)
		self.triggerEvent('esx:showNotification', msg)
	end

	self.showHelpNotification = function(msg, thisFrame, beep, duration)
		self.triggerEvent('esx:showHelpNotification', msg, thisFrame, beep, duration)
	end

	self.syncInventory = function(weight, maxWeight, items, money)
		self.weight, self.maxWeight = weight, maxWeight
		self.inventory = items
		if money then
			for k, v in pairs(money) do
				local account = self.getAccount(k)
				if ESX.Math.Round(account.money) ~= v then
					account.money = v
					self.triggerEvent('esx:setAccountMoney', account)
				end
			end
		end
	end

	self.getPlayerSlot = function(slot)
		return self.inventory[slot]
	end

	-- babymode
	self.getLoadout = emptytable
	self.addWeapon = emptyfn
	self.addWeaponComponent = emptyfn
	self.addWeaponAmmo = emptyfn
	self.updateWeaponAmmo = emptyfn
	self.setWeaponTint = emptyfn
	self.getWeaponTint = emptyfn
	self.removeWeapon = emptyfn
	self.removeWeaponComponent  = emptyfn
	self.removeWeaponAmmo = emptyfn
	self.hasWeaponComponent = emptyfn
	self.hasWeapon = emptyfn
	self.getWeapon = emptyfn

	return self
end
