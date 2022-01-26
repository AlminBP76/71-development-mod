ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

RegisterNetEvent("aPranjePara:obavjestiDrotove")
AddEventHandler("aPranjePara:obavjestiDrotove", function()
	if Config.obavjestiPoliciju then
    	local player = ESX.GetPlayerData()
    	if player.job.name == "police" then
		local playerCoords = GetEntityCoords(PlayerPedId())
        local data = {displayCode = '211', description = 'Sumnjiva Aktivnost', isImportant = 0, recipientList = {'police'}, length = '10000', infoM = 'fa-info-circle', info = 'Potencijalno Pranje para'}
        local dispatchData = {dispatchData = data, caller = 'Alarm', coords = vector3(-633.9, -241.7, 38.1)}
        TriggerEvent('wf-alerts:svNotify', dispatchData)
    	end
	end
end)

function operiPare(kolicinaPranje)
    if Config.potrebnaKartica then
        ESX.TriggerServerCallback("aPranjePara:provjeriKarticu", function(result)
            if result == true then
                local dialog = exports['zf_dialog']:DialogInput({
                    header = "Koliko novca zelite oprati?", 
                    rows = {
                        {
                            id = 0, 
                            txt = "Kolicina"
                        }
                    }
                })
                if dialog ~= nil then
                    if dialog[1].input == nil then return end
                    local kolicinaPranje = tonumber(dialog[1].input)
                        TriggerServerEvent("aPranjePara:provjeraMozeLi", kolicinaPranje)
					end
            else
				exports['okokNotify']:Alert("Pranje Para", "Nemas karticu potrebnu za pranje.", 5000, 'error')
            end
        end)
    else
        local dialog = exports['zf_dialog']:DialogInput({
            header = "Koliko novca zelite oprati?", 
            rows = {
                {
                    id = 0, 
                    txt = "Kolicina"
                }
            }
        })
        if dialog ~= nil then
            if dialog[1].input == nil then return end
            local kolicinaPranje = tonumber(dialog[1].input)
                        TriggerServerEvent("aPranjePara:provjeraMozeLi", kolicinaPranje)
					end
    end
end

RegisterNetEvent("aPranjePara:funkcijaPranje")
AddEventHandler("aPranjePara:funkcijaPranje", function(kolicinaPranje)
        exports['rprogress']:Custom(
            {
                Async = true,
				Duration = 25000,
                Label = "Novac se pere. . .",
				Easing = "easeLinear",
                DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = true
                }
            },
            function(e)
                if not e then
                    ClearPedTasks(PlayerPedId())
                else
                    ClearPedTasks(PlayerPedId())
                end
            end) 
	Citizen.Wait(25000)
    TriggerServerEvent("aPranjePara:operiPare", kolicinaPranje)
    local praona = vector3(1137.46, -991.97, 46.11)
    local vjerovatnoca = math.random(0,100)
    if vjerovatnoca > 27 then
        TriggerServerEvent("aPranjePara:posaljiKerove", praona)
    end
end)

Citizen.CreateThread(function()
    exports['qtarget']:AddBoxZone("ParoPraona", vector3(1135.65, -990.48, 46.11), 5.8, 2.4, {
        name="ParoPraona",
        heading=7,
        debugPoly=false,
        minZ=45.76,
        maxZ=47.56
    }, {
        options = {
        {
        event = "operi:pare",
        icon = "fas fa-money-bill",
        label = "Operi Pare",
        required_item = "kartica_pranje",
        },
    },
        distance = 4.0
    })
end)

RegisterNetEvent('operi:pare')
AddEventHandler('operi:pare', function()
    operiPare(kolicinaPranje)
end)  
