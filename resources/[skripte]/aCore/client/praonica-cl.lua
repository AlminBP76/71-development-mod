PranjeAuta = {}

PranjeAuta.Lokacije = {
  vector3(26.5906, -1392.0261, 27.3634),
  vector3(167.1034, -1719.4704, 27.2916),
  vector3(-74.5693, 6427.8715, 29.4400),
  vector3(-699.6325, -932.7043, 17.0139)
}

CreateThread(function()
  for i=1, #PranjeAuta.Lokacije, 1 do 
    carWashLocation = PranjeAuta.Lokacije[i]

    local blip = AddBlipForCoord(carWashLocation)
    SetBlipSprite(blip, 100)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)


    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Auto Perionica')
    EndTextCommandSetBlipName(blip)
  end
end)

CreateThread(function()
  while true do
    Wait(0)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local canSleep = true

    if CanWashVehicle() then

      for i=1, #PranjeAuta.Lokacije, 1 do
        local carWashLocation = PranjeAuta.Lokacije[i]
        local distance = GetDistanceBetweenCoords(coords, carWashLocation, true)

        if distance < 5 then
          canSleep = false

		  stvoriLeteciTekst(GetEntityCoords(PlayerPedId()), "Pritisni ~g~ E ~w~ da operes Vozilo", 2)

          if IsControlJustReleased(0, 38) then
            local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1),false)

            if GetVehicleDirtLevel(vehicle) > 1 then
              WashVehicle()
            else
				exports['okokNotify']:Alert("INFO", "Vase vozilo je vec cisto", 5500, 'info')
            end
          end
        end
      end

      if canSleep then
        Wait(1000)
      end

    else
      Wait(1000)
    end
  end
end)

function CanWashVehicle()
  local playerPed = PlayerPedId()

  if IsPedSittingInAnyVehicle(playerPed) then
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if GetPedInVehicleSeat(vehicle, -1) == playerPed then
      return true
    end
  end

  return false
end

function WashVehicle()
  ESX.TriggerServerCallback('almin_pranjeauta:StanjePara', function(novac)
    if novac then
      local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1),false)
      DoScreenFadeOut(1000)
      Wait(5000)
      SetVehicleDirtLevel(vehicle, 0.0)
      DoScreenFadeIn(1000)
      Wait(500)
      exports['okokNotify']:Alert("INFO", "Oprali ste auto za 5€", 5500, 'success')
      
    else
		exports['okokNotify']:Alert("INFO", "Nemate dovoljno novca", 5500, 'error')
      Wait(5000)
    end
  end)
end

--LETECI TEKST FUNKCIJA

stvoriLeteciTekst = function(pos, text, boja)
	local pocni = text
    local pocetak, kraj = string.find(text, '~([^~y~]+)~')
    if pocetak then
        pocetak = pocetak - 2
        kraj = kraj + 2
        pocni = ''
        pocni = pocni .. string.sub(text, 0, pocetak) .. '   '.. string.sub(text, pocetak+2, kraj-2) .. string.sub(text, kraj, #text)
    end
    AddTextEntry(GetCurrentResourceName(), pocni)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(2, false, false, -1)
    SetFloatingHelpTextWorldPosition(1, pos + vector3(0.0, 0.0, 1.0))
    SetFloatingHelpTextStyle(1, 1, boja, -1, 3, 0)
end
