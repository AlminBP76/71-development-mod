-- This file manages the main menu parts of the code. 
-- I separated it here becuase it relies on nh-context and nh-keyboard and you may wish to replace it with your own method, maybe using ESX Menu Default? 

-- The event called by the qtarget to open the menu
RegisterNetEvent('qidentification:requestLicense')
AddEventHandler('qidentification:requestLicense',function()

	local sendMenu = {
		{
			id = 1,
			header = "<h6>Licence</h6>",
			txt = "",
			params = { 
				event = "fakeevent",
				args = {}
			}
		}
	}

	-- loop through identification data defined in config.lua and add options for each entry
	for i=1,#Config.IdentificationData,1 do 
		data = Config.IdentificationData[i]
		print(ESX.DumpTable(data))
		table.insert(sendMenu,{
			id = #sendMenu + 1,
			header = "<span class='target-icon'><i class='fa-solid fa-id-card fa-fw'></i></span> Podnesi zahtjev za "..data.label,
			txt = "$"..data.cost,
			params = { 
				event = "qidentification:applyForLicense",
				args = {
					item = data.item
				}
			}
		})
	end

	-- not necessary as you can hit "escape" to leave the nh-context menu, but I define a cancel button because it looks nice and makes sense from a user experience perspective
	table.insert(sendMenu,
	{
		id = 99,
		header = "<span class='target-icon'><i class='fa-solid fa-circle-xmark fa-fw'></i></span> Prekini",
		txt = "",
		params = {
			event = "qidentification:cancel",
		}
	})

	-- actually trigger the menu event 
	TriggerEvent('nh-context:sendMenu', sendMenu)
end)


-- the event that handles applying for license
RegisterNetEvent('qidentification:applyForLicense')
AddEventHandler('qidentification:applyForLicense',function(data)
	local identificationData = nil

	-- Loop through identificationdata and match item and set a variable for future use
	for k,v in pairs(Config.IdentificationData) do 
		if v.item == data.item then 
			identificationData = v
			break
		end
	end

	if Config.CustomMugshots then 
		local data = exports.ox_inventory:Keyboard('URL vase slike za licencu (Ostavi prazno za default)', {'Direktni link za sliku (na kraju .png ili .jpg)'})
	
		if data then
			mugshotURL = data[1]
		else
			print('Nista nije uneseno!')
		end
	else
		local mugshotURL = exports[Config.MugshotScriptName]:GetMugShotBase64(PlayerPedId(), false)
	end 
	TriggerServerEvent('qidentification:server:payForLicense',identificationData,mugshotURL)
end)
