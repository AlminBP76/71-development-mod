RegisterCommand("testSveNotify", function()
ESX.ShowNotification("TEST NOTIFIKACIJA") --defaulto sam ovaj notify, ako vam ne odgovara es_extended/client/functions.lua (bfunkcije)
exports["okokNotify"]:Alert("TEST", "test", 10000, "info") --okok
exports.bulletin:SendAdvanced({
    message = 'TEST',
    title = 'TEST',
    subject = 'TEST',
    icon = 'CHAR_BANK_FLEECA',
})
end)