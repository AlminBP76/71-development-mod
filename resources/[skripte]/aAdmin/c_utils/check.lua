Citizen.CreateThread(function()

  while not GlobalState["AC-Weps"] or not PlayerData or not PlayerData.job do
    Wait(100)
  end

  local forbLista = GlobalState["AC-Weps"]

  while true do
    Citizen.Wait(500)
    pPed = PlayerPedId()

    if LocalPlayer.state.aGroup == nil and LocalPlayer.state.aGroup == "user" then

      for i = 1, #forbLista do
          if HasPedGotWeapon(pPed, forbLista[i], false) then
              --TriggerServerEvent("aAdmin:flagged", "weapon", tostring(forbLista[i]))
              RemoveWeaponFromPed(pPed, forbLista[i])
          end
      end
      if NetworkIsInSpectatorMode() then
        TriggerServerEvent("aAdmin:flagged", "spectate")
        return
      end

    end
end
end)

RegisterNetEvent("aAdmin:car", function(model, pose, head)
RequestModel(model)
while not HasModelLoaded(model) do Wait(10) end

ESX.Game.SpawnVehicle(model, pose, head, function(veh)
  TriggerEvent('npclock:register', GetVehicleNumberPlateText(veh))
  TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
end)
end)

RegisterNetEvent("aAdmin:expNotif", function(ime, id, vrsta, broj)
if LocalPlayer.state.aGroup ~= "user" then
  TriggerEvent('chatMessage', "^3[aAdmin - AC]^0: ^1EXPLOZIJA^0  - Uzrokovao: ^3("..id..")".. ime.."^0 | Vrsta Explozije: ^3"..vrsta.."^0 | [".. broj .."]!")
end
end)




RegisterNUICallback('callback', function()
TriggerServerEvent('aAdmin:Browser')
end)
