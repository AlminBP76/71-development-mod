local t = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)



AddEventHandler("odbaguj:sve", function()

  SetNuiFocus(false, false)
  SendNUIMessage({                         
    pokazano = false,
  })
  uMeniju = false
  
end)

local info = {

  Lokacije = {
    {ime = "Rent-a-Car", lokacija = vector3(133.64, -1086.08, 28.29), spawnlokacija = vector3(132.37, -1081.12, 29.02), heading = 0.69 },
    {ime = "Rent-a-Car 2", lokacija = vector3(1602.42, 1022.71, 79.10), spawnlokacija = vector3(1605.07, 1027.25, 79.60), heading = 340.42},
    {ime = "Rent-a-Car 3", lokacija = vector3(2045.49, 3762.92, 32.0), spawnlokacija = vector3(2044.79, 3766.72, 32.18), heading = 26.27},
    {ime = "Rent-a-Car 4", lokacija = vector3(-3108.59, 1276.92, 20.0), spawnlokacija = vector3(-3110.74, 1273.58, 20.24), heading = 173.42},
    {ime = "Rent-a-Car 5", lokacija = vector3(2000.87, 6240.82, 44.9), spawnlokacija = vector3(2000.11, 6245.12, 45.84), heading = 23.12},
    {ime = "Rent-a-Car 6", lokacija = vector3(1850.24, 2559.85, 45.1), spawnlokacija = vector3(1854.15, 2560.37, 45.67), heading = 267.58},
    {ime = "Rent-a-Car 7", lokacija = vector3(-1016.15, -2696.38, 12.98), spawnlokacija = vector3(-1028.74, -2690.7, 13.83), heading = 153.25},
  },
  VrijemeRenta = 1800,
  Auta = {
    {naziv = "Blista", model = "blista", cijena = 500, opis = "", slika = "https://i.imgur.com/7zFSmQd.png"},
    {naziv = "Vespa", model = "faggio2", cijena = 300, opis = "", slika = "https://i.imgur.com/ul9ms6k.png"},
    {naziv = "Cruiser", model = "cruiser", cijena = 10, opis = "", slika = "https://i.imgur.com/Pnye9r4.png"},
    {naziv = "BMX", model = "bmx", cijena = 10, opis = "", slika = "https://i.imgur.com/pPA8GyQ.png"},
  }

}
local rentao, uMeniju = false

RegisterNUICallback('zatvori', function()
  SetNuiFocus(false, false)
  uMeniju = false
end)

RegisterNetEvent("aRent:haveMoney")
AddEventHandler("aRent:haveMoney", function(pare)
  imalPare = pare
end)

RegisterNUICallback('rentaj', function(a)
  SetNuiFocus(false, false)
  imalPare = nil
  for k,v in pairs(info.Auta) do 
    if a.model == v.model then 
      if ESX.Game.IsSpawnPointClear(info.Lokacije[a.lokacija].spawnlokacija, 5.0) then 
        TriggerServerEvent("rent:checkMoney", v.cijena)
        while imalPare == nil do Wait(100) end
          if imalPare then 
            rentao = true 
            RequestModel(GetHashKey(a.model))
            while not HasModelLoaded(GetHashKey(a.model)) do Wait(100) print("ahh") end

            local VOZILO = CreateVehicle(GetHashKey(a.model), info.Lokacije[a.lokacija].spawnlokacija, info.Lokacije[a.lokacija].heading, true, false)
            ESX.ShowNotification("Iznajmio si vozilo")
            TaskEnterVehicle(PlayerPedId(), VOZILO, 10000, -1, 2.0, 1)
            ZapocniBrojac(VOZILO)
          else
            ESX.ShowNotification("Nemas novca")
          end
          break
      else
        ESX.ShowNotification("Vozilo je vec napolju")
      end
    end
  end
end)


CreateThread(function()
  for k,v in pairs(info.Lokacije) do 
    local Blip = AddBlipForCoord(v.lokacija)
		SetBlipSprite (Blip, 147)
		SetBlipDisplay(Blip, 4)
		SetBlipScale  (Blip, 0.8)
		SetBlipColour (Blip, 4)
		SetBlipAsShortRange(Blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("RENT-a-CAR")
    EndTextCommandSetBlipName(Blip)
  end

  while true do
    Wait(0)
        local lokacija = GetEntityCoords(PlayerPedId())
        for k,v in pairs(info.Lokacije) do 
          local udaljenost = #(lokacija - v.lokacija)
            if udaljenost < 10 and not uMeniju then 
              DrawMarker(v.markerType or 27, v.lokacija, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8,  0.8, 55,  255,  55, 100, false, true, 2, true, false, false, false)
                if udaljenost < 2 then 
                  ESX.ShowHelpNotification("Pritisni ~b~E ~w~da otvoris rentu")
                  if IsControlJustReleased(0, t["E"]) then 
                    SetNuiFocus(true, true)
                    SendNUIMessage({
                        auta = info.Auta,                          
                        pokazano = true,
                        lokacija = k
                    })
                    uMeniju = true
                end
            end
        end
      end
  end
end)


function ZapocniBrojac(vozilo, vrijeme)
    tajmerRent = 0

      while rentao do
        Wait(1100)
        if tajmerRent >= info.VrijemeRenta then
          tajmerRent = tajmerRent + 1
          break
        end  
          tajmerRent = tajmerRent + 1
      end

      TaskLeaveVehicle(PlayerPedId(), VOZILO, 64)
      while IsPedInAnyVehicle(PlayerPedId(), false) do 
        Wait(100)
      end

      if GetVehicleEngineHealth(VOZILO) < 200 then
        ESX.ShowNotification("Nanio si stetu vozilu i platio je")
        TriggerServerEvent("aRent:payDamage")
      else
        ESX.ShowNotification("Tvoja renta je istekla")
      end
      NetworkFadeInEntity(VOZILO, 0, true)
      DeleteEntity(VOZILO)
      rentao = false
end


AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  print(VOZILO)
  DeleteVehicle(VOZILO)
end)



CreateThread(function()
	while true do 
		Wait(2)

		if rentao and IsPedInVehicle(PlayerPedId(), VOZILO, false) then
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.3)
			SetTextColour(128, 128, 128, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
      SetTextEntry("STRING")
      mins = string.format("%02.f", math.floor((info.VrijemeRenta - tajmerRent)/60));
      secs = string.format("%02.f", math.floor((info.VrijemeRenta - tajmerRent) - mins *60));
			AddTextComponentString("U rentanom si vozilu, imas jos " .. mins..":"..secs .. " do isteka rente.")
			DrawText(0.005, 0.040)
    else
      Wait(1000)
    end

	end
end)
