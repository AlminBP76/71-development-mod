
Citizen.CreateThread(function()

    while not bFunkcije do 
        Wait(100)
    end
    tipke = {322,200,177,25,24,257,25,263,32,34,31,30,45,22,44,37,23,288,289,170,167,0,26,73,59,71,72,200,322,191,201,215,18,176,257,140,141,142,143,75,73,29,73,105,120,154,186,252,323,337,354,357,166,318,327,243,38,249}

    bFunkcije.text3d = function(coords, text, opacity, a)
        if opacity > 255 then
            opacity = 255
        elseif opacity < 0 then
            opacity = 0
        end
    
        local onScreen, _x, _y = World3dToScreen2d(coords["x"], coords["y"], coords["z"])
        
        if onScreen then
            SetTextScale(0.45, 0.45)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(237, 184, 121, math.floor(opacity))
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x, _y)
            local factor = string.len(text) / 350
            
            if not a then
                DrawRect(_x,_y + 0.0145, 0.030 + factor, 0.03, 28, 16, 11, 68)
            end
        end
    end
    
    RegisterNetEvent("odblokiraj")
    AddEventHandler("odblokiraj", function()
        bFunkcije.BlokTipke(false)
    end)
    
    bFunkcije.BlokTipke = function(akc)
        if akc then blokirajtipke = true else blokirajtipke = false end
    end
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if blokirajtipke then
                for i = 1, #tipke do 
                    DisableControlAction(0, tipke[i], true)
                    DisableControlAction(1, tipke[i], true)
                end
            else
                Citizen.Wait(800)
            end
        end
    end)
    
    bFunkcije.blip = function(lokacija, sprite, display, size, boja, daljina, ime)
    
        local Blip = AddBlipForCoord(lokacija)
        SetBlipSprite (Blip, sprite)
        SetBlipDisplay(Blip, display)
        SetBlipScale  (Blip, 0.5)
        SetBlipColour (Blip, boja)
        SetBlipAsShortRange(Blip, daljina)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(ime)
        EndTextCommandSetBlipName(Blip)
        return Blip
    end
    
    bFunkcije.konvertsec = function(sekunde, texth, textm, texts, kadnula)
    
        local seconds = tonumber(sekunde)
    
        if seconds <= 0 then
            return kadnula;
        else
            hours = string.format("%d", math.floor(seconds/3600));
            mins = string.format("%d", math.floor(seconds/60 - (hours*60)));
            secs = string.format("%d", math.floor(seconds - hours*3600 - mins *60));
    
            if hours == "0" then
    
                if mins == "0" then
                    return string.format("%s %s", secs, texts)
                else
                    return string.format("%s %s i %s %s",mins, textm, secs, texts)
                end
            else
                return string.format("%s %s, %s %s i %s %s", hours, texth, mins, textm, secs, texts)
            end
        end
    
    end



end)
