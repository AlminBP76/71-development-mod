ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
    end
end)

-- Display Markera

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local sleep = true
        local igr = PlayerPedId()
        local kordeigr = GetEntityCoords(igr, true)
        local dist = #(kordeigr - konfig.Lokacija)
        if dist < 5 then
            sleep = false
            DrawMarker(29, konfig.Lokacija, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 18, 196, 36, 50, false, true, 2, nil, nil, false)
        end
        if dist < 3 then
            ESX.ShowHelpNotification('Pritisni ~INPUT_CONTEXT~ da pogledas meni kredita.')
            if IsControlJustPressed(0,38) then
                OtvoriMeni()
            end
        end
        if sleep then
          Citizen.Wait(500)
        end
    end
end)

function OtvoriMeni()
       local elementi = {
         {label = 'Podigni Kredit | 💸', value = 'podigniK'},
         {label = 'Stanje Kredita | 💸', value = 'stanjek'}
       }
       ESX.UI.Menu.CloseAll()
         ESX.UI.Menu.Open(
         'default', GetCurrentResourceName(), 'admin_meni',
         {
           css      = 'meni',
           title    = '💸 Kredit 💸',
           align    = 'top-left',
           elements = elementi
         },
           
           function(data, menu)
       
             if data.current.value == 'podigniK' then
                 OtvoriMeniDizanja()
             elseif data.current.value == 'stanjek' then
                 OtvoriMeniStatusa()
             end
         end,
         function(data, menu)
           menu.close()
         end
       )
end

function OtvoriMeniDizanja()
  ESX.TriggerServerCallback('Kredit:fetchStatus', function(baza)
     local elementi = {
     
     }
     if baza.kredit == 0 then
        table.insert(elementi, {label = 'Podigni Kredit 50000$ ( Kamata : 75000$ ) | 💸', value = '50k'})
        table.insert(elementi, {label = 'Podigni Kredit 70000$ ( Kamata : 95000$ ) | 💸', value = '70k'})
        table.insert(elementi, {label = 'Podigni Kredit 100000$ ( Kamata : 125000$ ) | 💸', value = '100k'})
        table.insert(elementi, {label = 'Podigni Kredit 500000$ ( Kamata : 625000$ ) | 💸', value = '500k'})
     else
        table.insert(elementi, {label = 'Vec si podigao kredit | 💸', value = 'digao'})
     end
     ESX.UI.Menu.CloseAll()
         ESX.UI.Menu.Open(
         'default', GetCurrentResourceName(), 'admin_meni',
         {
           css      = 'meni',
           title    = '💸 Kredit 💸',
           align    = 'top-left',
           elements = elementi
         },
           
           function(data, menu)
       
             if data.current.value == '50k' then
              menu.close()
              local unos = UnosTastatura('DA/NE', '', 120)
                if unos == 'DA' then
                  TriggerServerEvent('Krediti:digni', 50000)
                end
             elseif data.current.value == '70k' then
                menu.close()
                local unos = UnosTastatura('DA/NE', '', 120)
                if unos == 'DA' then
                  TriggerServerEvent('Krediti:digni', 70000)
                end
             elseif data.current.value == '100k' then
              menu.close()
              local unos = UnosTastatura('DA/NE', '', 120)
              if unos == 'DA' then
                menu.close()
                TriggerServerEvent('Krediti:digni', 100000)
              end
             elseif data.current.value == '500k' then
              menu.close()
              local unos = UnosTastatura('DA/NE', '', 120)
              if unos == 'DA' then
                TriggerServerEvent('Krediti:digni', 500000)
              end
             end
         end,
         function(data, menu)
           menu.close()
         end
       )
     end)
 end

function OtvoriMeniStatusa()
 ESX.TriggerServerCallback('Kredit:fetchStatus', function(baza)
    local elementi = {
    
    }

    if baza.kredit ~= 0 then
        table.insert(elementi, {label = 'Stanje Kredita ' .. baza.kredit .. ' $ | 💸 ', value = 'kreditstanje'})
        table.insert(elementi, {label = 'Vrati Novac | 💸', value = 'vratinovac'})
      if (7 - tonumber(baza.danikredita)) ~= 0 then
        table.insert(elementi, {label = 'Automatsko oduzimanje sa racuna za ' .. 7 - tonumber(baza.danikredita) .. ' dana | 💸'})
      else
        table.insert(elementi, {label = 'Automatsko oduzimanje sa racuna je u toku | 💸'})
      end
    else
        table.insert(elementi, {label = 'Niste podigli kredit | 💸', value = 'nijepodignut'})
    end  
    ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'admin_meni',
        {
          css      = 'meni',
          title    = '💸 Kredit 💸',
          align    = 'top-left',
          elements = elementi
        },
          
          function(data, menu)
      
            if data.current.value == 'vratinovac' then
              menu.close()
                 local kolicina = UnosTastatura('Koliko novca zelis uplatiti ?', '', 120)
                    if kolicina ~= nil then
                        TriggerServerEvent('Kredit:vracajNovac', kolicina)
                    end
            elseif data.current.value == 'stanjek' then
                OtvoriMeniStatusa()
            end
        end,
        function(data, menu)
          menu.close()
        end
      )
    end)
end

UnosTastatura = function(TextEntry, ExampleText, MaxStringLength)
    AddTextEntry("FMMC_KEY_TIP1", TextEntry .. ":")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        DisableAllControlActions(0)
        if IsDisabledControlPressed(0, 322) then return "" end
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
      print(GetOnscreenKeyboardResult())
      return GetOnscreenKeyboardResult()
    end
end