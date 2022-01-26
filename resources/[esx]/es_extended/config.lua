local function loadConvar(name)
	local convar = json.decode(GetConvar(name, '{}'))
	if type(convar) == 'nil' then
		CreateThread(function()
			error(('^1Convar setting `%s` is malformed, ensure you are using a valid JSON format.^0'):format(name))
		end)
	end
	return convar or {}
end

local Config = loadConvar('es_extended')

-- Convar overrides (add to server.cfg or use exec)
-- Optional of course, you can just set them in here if you prefer
--[[
setr primary_identifier "license"

setr es_extended {
  "Multichar": true,
  "NPWD": true,
  "EnableHud": false,
  "StartingAccountMoney": {"bank":500}
}
]]

Config = {
	Locale = Config.Locale or 'en',
	StartingAccountMoney = Config.StartingAccountMoney or {bank = 50000},

	-- Players receive payment from their employer society account (requires: esx_society)
	EnableSocietyPayouts = Config.EnableSocietyPayouts or false,

	-- Display the default hud, showing current job and accounts
	EnableHud = Config.EnableHud or false,

	-- The amount of weight a player can carry
	MaxWeight = Config.MaxWeight or 30000,

	-- The frequency that paychecks are triggered by the server in milliseconds (default: 7 minutes)
	PaycheckInterval = Config.PaycheckInterval or (7 * 60000),

	-- Enable debug options
	EnableDebug = Config.EnableDebug or false,

	-- Use GTA's wanted level
	EnableWantedLevel = Config.EnableWantedLevel or false,

	-- Allow player versus player combat
	EnablePVP = Config.EnablePVP or true,

	-- Enable compatability for esx_multicharacter
	Multichar = Config.Multichar or false,

	-- Load character identity data during initial player loading (requires: esx_identity, not required with Config.Multichar)
	Identity = Config.Identity or false,

	-- Enable support when using NPWD
	NPWD = Config.NPWD or false,
}

_ENV.Config = Config

Config.Accounts = {
	bank = _U('account_bank'),
	black_money = _U('account_black_money'),
	money = _U('account_money')
}

-- Set identifier to ip when using FxDK or sv_lan
Config.Identifier = GetConvar('sv_lan', '') == 'true' and 'ip' or GetConvar('primary_identifier', 'license')
