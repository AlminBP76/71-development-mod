CreateThread(function()
	while true do
		Wait(60000) -- 30000
		local id = GetPlayerServerId(player)
		SetDiscordAppId(865709119914246165)
		SetDiscordRichPresenceAsset('logo')
		SetDiscordRichPresenceAssetText("Almin Development")
		SetDiscordRichPresenceAssetSmall('discord')
		SetDiscordRichPresenceAssetSmallText('discord.gg/X5Bc8CjZqz')
		SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/X5Bc8CjZqz")
		SetDiscordRichPresenceAction(1, "Connect", "fivem://connect/cfx.re/join/ip") 
		SetRichPresence("ID: " .. GetPlayerServerId(PlayerId()) .. " | " .. GlobalState["BrojIgraca"] .. "/48")
	end
  end)