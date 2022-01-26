local jabukePos = vector3(-11.01, 6854.74, 13.31)
local jabukeObjekt = 721117987
local SpawnJabuke = {}

Citizen.CreateThread(function()

    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)


AddEventHandler("onResourceStop", function(res)

    if res ~= GetCurrentResourceName() then
        return
    end

    for i = 1, #SpawnJabuke do 
        DeleteEntity(SpawnJabuke[i])
    end


end)


Citizen.CreateThread(function()

	local blip2 = AddBlipForCoord(-11.01, 6854.74, 13.31)

	SetBlipSprite (blip2, 486)
	SetBlipScale  (blip2, 1.2)
	SetBlipColour (blip2, 75)
	SetBlipAsShortRange(blip2, true)


    SetBlipHighDetail(blip2, true)
	SetBlipCategory(blip2, 7)



	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName("Jabuke")
	EndTextCommandSetBlipName(blip2)


end)


local RadiNesto = false

Citizen.CreateThread(function()
    local animdict, anim = "amb@prop_human_movie_bulb@base", "base"
    RequestAnimDict(animdict)
    while not HasAnimDictLoaded(animdict) do 
        Wait(100)
    end

    while true do 
        Citizen.Wait(500)
        ped = PlayerPedId()
        pedLoc = GetEntityCoords(ped)
        if not PrisaoJabukama and #(pedLoc - jabukePos) <= 50 then
            PrisaoJabukama = true
            TriggerEvent("bPoslovi_jabuke:Respawnaj")
           
        elseif PrisaoJabukama and #(pedLoc - jabukePos) > 50 then
            PrisaoJabukama = false

            if #SpawnJabuke > 0 then
                for i=1, #SpawnJabuke do 
                    DeleteEntity(SpawnJabuke[i])
                end
            end

        elseif PrisaoJabukama and #(pedLoc - jabukePos) <= 50 then
            local Drvo = GetClosestObjectOfType(pedLoc, 1.0, jabukeObjekt, false, false, false)

            if not RadiNesto and Drvo ~= 0 then
                TriggerEvent("bfunkcije:ticknotif", true, true, "Drzi tipku [E] da uberes jabuke!")
                if IsControlPressed(0, 38) then
                    
                    RadiNesto = true
                    ESX.TriggerServerCallback("bPoslovi_jabuka:MozelNosit", function(mozel)
                        
                        if mozel then
                            bFunkcije.BlokTipke(true)
                            TaskTurnPedToFaceEntity(ped, Drvo, 5000)
                            Wait(1000)
                            TaskPlayAnim(PlayerPedId(), animdict, anim, 8.0, 8.0, -1, 1, 0.5 , 0, 0, 0)

                            TriggerEvent("bfunkcije:tajmerdosto", "Ubiranje jabuka...", 5, true, function(jel)
                                DeleteEntity(Drvo)
                                DeleteEntity(jabukeObjekt)
                                if not jel then

                                    SetEntityCollision(Drvo, false, true)
                                    FreezeEntityPosition(Drvo, false)
                                    SetEntityVelocity(Drvo, 2.0, 0.0, 0.0)
                                    Citizen.CreateThread(function()
                                        zaobrisatdrvo = Drvo
                                        Citizen.Wait(2000)
                                        DeleteEntity(zaobrisatdrvo)
                                    end)
                                    
                                    for obj = 1, #SpawnJabuke do 
                                        if SpawnJabuke[obj] == Drvo then
                                            table.remove(SpawnJabuke, obj)
                                            if #SpawnJabuke == 0 then
                                                TriggerEvent("bPoslovi_jabuke:Respawnaj")
                                            end
                                            break
                                        end
                                    end
                                    TriggerServerEvent("bPoslovi_jabuke:done")
									TriggerEvent("BattlePass-Server:AddXP", 30, source)
                                end
                                ClearPedTasks(ped)
                                bFunkcije.BlokTipke(false)
                                RadiNesto = false
                            end)
                        else
                            RadiNesto = false

                            ESX.ShowNotification("Ne mozes nositi vise")

                        end
                    
                    end)
                    Citizen.Wait(1000)
                end
            else
                TriggerEvent("bfunkcije:ticknotif", false)
            end
        end
    end
end)


function getZ(x, y)
    local height = 0
    local foundGround = false
  
      while foundGround == false do
        Citizen.Wait(0)
        height = height + 1
        RequestCollisionAtCoord(x, y, height + 0.0)
        foundGround, zPos = GetGroundZFor_3dCoord(x, y, height + 0.0)
      end
    return zPos
end


AddEventHandler("bPoslovi_jabuke:Respawnaj", function()

    for i = 1, 15 do
        if #SpawnJabuke > 0 then

            for a = 1, #SpawnJabuke do

                local SpawnBananaLoc = GetEntityCoords(SpawnJabuke[a])

                local x,y = jabukePos.x + math.random(8, 35), jabukePos.y + math.random(8, 35)
                local SpawnBanLoc = vector3(x, y, getZ(x,y))
                
                    while #(SpawnBananaLoc - SpawnBanLoc) < 4 do 
                        x,y = jabukePos.x + math.random(8, 35), jabukePos.y + math.random(8, 35)
                        SpawnBanLoc = vector3(x, y, getZ(x,y))
                        Wait(100)
                    end

                local ObjBanana = CreateObject(jabukeObjekt, SpawnBanLoc, false, false, false)
                while not DoesEntityExist(ObjBanana) do Wait(50) end

                FreezeEntityPosition(ObjBanana, true)

                table.insert(SpawnJabuke, ObjBanana)
                break
            end

        else
            local x,y = jabukePos.x + math.random(8, 35), jabukePos.y + math.random(8, 35)
            local SpawnBanLoc = vector3(x, y, getZ(x,y))

            
            local ObjBanana = CreateObject(jabukeObjekt, SpawnBanLoc, false, false, true)
            while not DoesEntityExist(ObjBanana) do Wait(50) end

            FreezeEntityPosition(ObjBanana, true)

            table.insert(SpawnJabuke, ObjBanana)
        end
    end
end)