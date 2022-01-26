ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('aPranjePara:posaljiKerove')
AddEventHandler('aPranjePara:posaljiKerove', function()
    TriggerClientEvent("aPranjePara:obavjestiDrotove", -1)
end)

RegisterServerEvent('aPranjePara:provjeraMozeLi')
AddEventHandler('aPranjePara:provjeraMozeLi',function(kolicinaPranje)
    local igrac = ESX.GetPlayerFromId(source)
    local prljavePare = igrac.getAccount('black_money').money
    if prljavePare > kolicinaPranje and igrac.getAccount('black_money').money >= prljavePare then
        igrac.removeAccountMoney('black_money', kolicinaPranje)
        TriggerClientEvent("aPranjePara:funkcijaPranje", source, kolicinaPranje)
    else
		TriggerClientEvent('okokNotify:Alert', source, "Pranje Novca", "Nemas dovoljno prljavog kesa!", 5000, 'error')
    end
end)

RegisterServerEvent('aPranjePara:operiPare')
AddEventHandler('aPranjePara:operiPare',function(kolicinaPranje)
	local igrac = ESX.GetPlayerFromId(source)
    if Config.provizija then
        local provizija = Config.provizijaProcenat
        local brisanje = kolicinaPranje / 100 * provizija
        local cisto = kolicinaPranje - brisanje
        igrac.addMoney(cisto)
		TriggerClientEvent('okokNotify:Alert', source, "Pranje Novca", "Vase pare su oprane dobili ste: "..cisto.."€!", 5000, 'success')
    else
        igrac.addMoney(kolicinaPranje)
		TriggerClientEvent('okokNotify:Alert', source, "Pranje Novca", "Vase pare su oprane dobili ste: "..kolicinaPranje.."€!", 5000, 'info')
    end
end)

ESX.RegisterServerCallback("aPranjePara:provjeriKarticu", function(source, cb)
    local igrac = ESX.GetPlayerFromId(source)
    local kartica = igrac.getInventoryItem("kartica_pranje")

    if kartica.count >= 1 then
        cb(true)
    else
        cb(false)
    end
end)

