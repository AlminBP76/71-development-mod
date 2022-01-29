local PlayerData = {}
local idovi = false
local disPlayerNames = 25

RegisterCommand("id", function()
    ESX.TriggerServerCallback("aCore:pokupiRank", function(playerRank)
        if playerRank == "admin" or playerRank == "superadmin" then
          if not idovi then
	          ESX.ShowNotification("ID-evi ukljuceni")
            idovi = true
          else
            idovi = false
            ESX.ShowNotification("ID-evi iskljuceni")
          end
        else
          ESX.ShowNotification("Nemas Permisije")
        end
    end)
end)

playerDistances = {}

Citizen.CreateThread(function()
    Wait(100)
    while true do
    Citizen.Wait(0)
      if not idovi then
        Citizen.Wait(2000)
      else
        for _, player in ipairs(GetActivePlayers()) do
          local ped = GetPlayerPed(player)
          if GetPlayerPed(player) ~= PlayerPedId() then
            if playerDistances[player] ~= nil and playerDistances[player] < disPlayerNames then
              x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
              if not NetworkIsPlayerTalking(player) then
                iscrtajTekstIDD(x2, y2, z2+0.94, '[~w~' .. GetPlayerServerId(player) .. '~w~] ~w~' .. GetPlayerName(player))
              else
                iscrtajTekstIDD(x2, y2, z2+0.94, '[~w~' .. GetPlayerServerId(player) .. ' ~w~] ~w~' .. GetPlayerName(player))
              end
            end
          end
        end
      end
    end
end)


Citizen.CreateThread(function()
    while true do
        for _, player in ipairs(GetActivePlayers()) do
            if GetPlayerPed(player) ~= PlayerPedId() then
                x1, y1, z1 = table.unpack(GetEntityCoords(PlayerPedId(), true))
                x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
                playerDistances[player] = distance
            end
        end
        Citizen.Wait(1000)
    end
end)

function iscrtajTekstIDD(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*5
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.22*scale)
        SetTextFont(6)
        SetTextProportional(4)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
