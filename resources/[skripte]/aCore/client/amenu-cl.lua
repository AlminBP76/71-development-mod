RegisterNetEvent('notw:getajigrace')
AddEventHandler('notw:getajigrace', function()
    ESX.TriggerServerCallback('liberty:getajigrace', function(igraci)
        local players = GetActivePlayers()
        local menu = {}

        TriggerEvent('nh-context:sendMenu', {
            {
                id = 0,
                header = 'IGRACI >  '.. #players .. ' / 64',
                txt = ''
            },
        })

        if igraci ~= nil then
            for i=1, #igraci, 1 do
                table.insert(menu, {
                    id = k,
                    header = 'Ime Igraca > ' ..igraci[i].name,
                    txt = 'Posao Igraca > ' ..igraci[i].posao..' : '..igraci[i].cin,
                    params = {
                        event = '',
                        args = {}
                    }
                })
            end
            if #menu ~= 0 then
                TriggerEvent('nh-context:sendMenu', menu)
            else
                TriggerEvent('nh-context:sendMenu', {
                    {
                        id = 1,
                        header = 'Nema Igraca',
                        txt = ''
                    }
                })
            end
        else
            TriggerEvent('nh-context:sendMenu', {
                {
                    id = 1,
                    header = 'Nema Igraca',
                    txt = ''
                }
            })
        end
    end)
end) 

RegisterNetEvent('almin:healujIgraca')
AddEventHandler('almin:healujIgraca', function(data)

    local dialog = exports['zf_dialog']:DialogInput({
        header = "Healuj Igraca", 
        rows = {
            {
                id = 0, 
                txt = "ID Igraca"
            },
        }
    })
    
    if dialog ~= nil then
        if dialog[1].input == nil then
            ESX.ShowNotification('Ne mozete ostavljati prazna polja!')
        else
            TriggerEvent("esx_basicneeds:healPlayer", dialog[1].input)
        end
    end
end)   

AddEventHandler('dvAutaAdminMeni', function()
	TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "< Nazad",
			txt = "",
			params = {
				event = "adminContextMeni",
			}
		},
		{
			id = 2,
			header = "Obrisi trenutno vozilo",
			txt = "",
			params = {
				event = "dvAdminMeni",
			}
		},
		{
			id = 3,
			header = "Obrisi sva vozila",
			txt = "",
			params = {
				event = "dvallAdminMeni",
			}
		},
	})
end)

AddEventHandler('vozilaMeniAdmini', function()
	TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "< Nazad",
			txt = "",
			params = {
				event = "adminContextMeni",
			}
		},
		{
			id = 2,
			header = "Admin Motor",
			txt = "Stvori motor za igraca (Sanchez)",
			params = {
				event = "motorAdminMeni",
			}
		},
		{
			id = 3,
			header = "Admin Auto",
			txt = "Stvori auto za igraca (Brioso)",
			params = {
				event = "voziloAdminMeni",
			}
		},
	})
end)

RegisterCommand('+adminmeni', function()
    ESX.TriggerServerCallback("aCore:pokupiRank", function(playerRank)
      if playerRank == "owner" or playerRank == "superadmin" or playerRank == "admin" then
		TriggerEvent("adminContextMeni")
      else
		ESX.ShowNotification("Nemate pristup Admin Meniju")
      end
    end)
  end)

  RegisterKeyMapping('+adminmeni', 'Otvori Admin Meni', 'keyboard', 'F3')

  AddEventHandler('ideviAdminMeni', function()
	ExecuteCommand('id')
  end)

  AddEventHandler('voziloAdminMeni', function()
	TriggerEvent('esx:spawnVehicle', "brioso")
  end)

  AddEventHandler('motorAdminMeni', function()
	TriggerEvent('esx:spawnVehicle', "sanchez2")
  end)

  AddEventHandler('dvAdminMeni', function()
	ExecuteCommand('dv')
  end)

  AddEventHandler('dvallAdminMeni', function()
	ExecuteCommand('dvall')
  end)

  --NH CONTEXT ADMIN MENI

AddEventHandler('adminContextMeni', function()
	TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "Izaberi jednu od opcija",
			txt = ""
		},
		{
			id = 2,
			header = "Noclip",
			txt = "Udji / Izadji iz Noclipa",
			params = {
				event = "adminNoclip",
			}
		},
		{
			id = 3,
			header = "TPM",
			txt = "Teleportiraj se na marker",
			params = {
				event = "adminTPM",
			}
		},
		{
		  id = 4,
		  header = "Fix",
		  txt = "Popravi Vozilo",
		  params = {
			  event = "almin:popravi",
		  }
	  },
	  {
		id = 5,
		header = "Clean",
		txt = "Operi Vozilo",
		params = {
			event = "almin:operi",
		}
	},
	{
		id = 6,
		header = "Healuj Igraca",
		txt = "Unesi ID igraca kojeg zelis da healujes",
		params = {
			event = "almin:healujIgraca",
		}
	},
	{
		id = 7,
		header = "ID",
		txt = "Ukljuci / Iskljuci ID-eve drugih igraca",
		params = {
			event = "ideviAdminMeni",
		}
	},
	{
		id = 8,
		header = "Admin Vozila",
		txt = "Pogledaj listu vozila dostupnih za spawnanje >",
		params = {
			event = "vozilaMeniAdmini",
		}
	},
	{
		id = 9,
		header = "Brisanje Vozila",
		txt = "Pogledaj opcije za brisanje vozila >",
		params = {
			event = "dvAutaAdminMeni",
		}
	},
	{
		id = 10,
		header = "Lista igrica",
		txt = "Pogledaj igrace koji su trenutno na serveru >",
		params = {
			event = "notw:getajigrace",
		}
	}
	})
end)

AddEventHandler('almin:popravi', function()
	local playerPed = PlayerPedId()
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleEngineOn( vehicle, true, true )
		SetVehicleFixed(vehicle)
		exports['okokNotify']:Alert("POPRAVKA", "Tvoje Vozilo je popravljeno", 4500, 'success')
	else
		exports['okokNotify']:Alert("UPOZORENJE", "Nisi u Vozilu", 4500, 'error')
	end
end)

AddEventHandler('almin:operi', function()
	local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleDirtLevel(vehicle, 0)
		exports['okokNotify']:Alert("PRANJE", "Tvoje Vozilo je oprano", 4500, 'success')
	else
		exports['okokNotify']:Alert("UPOZORENJE", "Nisi u Vozilu", 4500, 'error')
	end
end)

AddEventHandler("adminNoclip", function()
 	ExecuteCommand("noclip")
end)

AddEventHandler("adminTPM", function()
 	ExecuteCommand("tpm")
end)
