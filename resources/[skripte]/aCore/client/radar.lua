CreateThread(function()
	SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0)
  end)

  --PAUZA
CreateThread(function()
  AddTextEntry('PM_PANE_LEAVE', '~y~Izadji sa servera')
  AddTextEntry('PM_PANE_QUIT', '~y~Napusti igricu')
  AddTextEntry('PM_SCR_MAP', '~y~Mapa')
  AddTextEntry('PM_SCR_GAM', '~y~Igrica')
  AddTextEntry('PM_SCR_INF', '~y~Informacije')
  AddTextEntry('PM_SCR_SET', '~y~Podesavanja')
  AddTextEntry('PM_SCR_STA', '~y~Statistika')
  AddTextEntry('PM_SCR_GAL', '~y~Galerija')
  AddTextEntry('PM_SCR_RPL', '~y~Rockstar ∑')
end)

function SetData()
    local name = GetPlayerName(PlayerId())
    local id = GetPlayerServerId(PlayerId())
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~b~[71 Development Mod] ~y~Tvoj RolePlay | ~y~ID~y~:~b~ ' .. id .. ' | ~y~Ime~y~: ~b~' .. name)
end

CreateThread(function()
    while true do
        Wait(3000)
        SetData()
    end
end)

function AddTextEntry(key, value)
    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end