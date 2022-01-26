-- Made by Tomić#9076
ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterServerEvent("tomic_teritorije:postavi")
AddEventHandler("tomic_teritorije:postavi", function(teritorija, _pripada)
    if _pripada ~= "nil" then
        _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        TriggerClientEvent("esx:showNotification", source, _U('territory_success'))
    end
    -----------------------------------------------------------------------------
    TeritorijeLogovi("Zauzeta teritorija!","**" ..GetPlayerName(source) .."** je zauzeo teritoriju: **" .. teritorija .. "**. Teritorija sada pripada bandi **__" .. _pripada .. "__**")
    -----------------------------------------------------------------------------
    if Config.ItemNagrada then
        if _pripada ~= "nil" then
            local inventory = nil
            TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'.._pripada, function(inventory)
                inventory.addItem(Config.Item, Config.ItemKolicina)
            end)
        end
    end
    -----------------------------------------------------------------------------
    if Config.NovcanaNagrada then
        if _pripada ~= "nil" then
            local account = nil
            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'.._pripada,  function(account)
                account.addMoney(Config.KolicinaNovca)
            end)
        end
    end
    -----------------------------------------------------------------------------
    pripada = "society_" .. _pripada
    -----------------------------------------------------------------------------
    MySQL.Sync.execute("UPDATE tomic_teritorije SET pripada=@pripada WHERE teritorija=@teritorija", {["@pripada"] = pripada, ["@teritorija"] = teritorija} )
    -----------------------------------------------------------------------------
    if pripada ~= "society_nil" then
        MySQL.Sync.execute("UPDATE tomic_teritorije SET time=@time WHERE teritorija=@teritorija", {["@teritorija"] = teritorija, ["@time"] = 1})
    end
    -----------------------------------------------------------------------------
end)

RegisterServerEvent("tomic_teritorije:zapocniZauzimanje")
AddEventHandler("tomic_teritorije:zapocniZauzimanje", function(ter)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll("SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija", {["@teritorija"] = ter}, function(result)
        if result[1] ~= nil then
            if result[1].time > Config.Cooldown then
                local zauzimaLiprovjera = false
                local job = xPlayer.job.name
                if job ~= nil then
                    local Posao = xPlayer.job
                    if Posao and Config.Organizacije[Posao.name] then
                        zauzimaLiprovjera = true
                        TriggerClientEvent("tomic_teritorije:zapocniZauzimanjeClient", _source, job, ter)
                        TeritorijeLogovi("Zauzimanje teritorije u tijeku!", "**" .. GetPlayerName(_source) .. "** iz **".. job .."** je zapoceo zauzimanje teritorije: **" .. ter .. "**")
                        if Config.InstantCooldown then
                            MySQL.Sync.execute("UPDATE tomic_teritorije SET time=@time WHERE teritorija=@teritorija", {["@teritorija"] = ter, ["@time"] = 1})
                        else
                            TriggerClientEvent("esx:showNotification", _source,	_U('recent'))
                        end
                    else
                        TriggerClientEvent("esx:showNotification", _source,	_U('wrong_job'))
                    end
                end
            else
                TriggerClientEvent("esx:showNotification", _source,	_U('recent'))
            end
        end
    end)
end)

RegisterServerEvent("tomic_teritorije:notify")
AddEventHandler("tomic_teritorije:notify", function(ter)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local Posao = xPlayer.job
        if Posao and Config.Organizacije[Posao.name] then
            TriggerClientEvent("esx:showNotification", xPlayers[i], _U('attacked'), ''.. ter .. '')
            TriggerClientEvent("esx:showNotification", xPlayers[i], _U('attacked2'))
            TriggerClientEvent("tomic_teritorije:blip", xPlayers[i], ter)
        end
    end
end)

RegisterServerEvent("tomic_teritorije:prekiniZauzimanje")
AddEventHandler("tomic_teritorije:prekiniZauzimanje", function()
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local Posao = xPlayer.job
        if Posao and Config.Organizacije[Posao.name] then
            TriggerClientEvent("tomic_teritorije:prekiniZauzimanje", xPlayers[i])
            TriggerClientEvent("esx:showNotification", xPlayers[i], _U('killed'))
        end
    end
    TeritorijeLogovi("Zauzimanje prekinuto!","**" .. GetPlayerName(source) .."** je napustio teritoriju ili je ubijen. Teritorija se vise ne zauzima.")
end)

CreateThread(function()
    while true do
    Wait(60000)
    --T1
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T1"
        },
        function(result)
            if result[1] ~= nil then
                Bpripada = result[1].pripada
                if Bpripada ~= nil then
                    MySQL.Sync.execute("UPDATE tomic_teritorije SET time=@time WHERE teritorija=@teritorija", {["@teritorija"] = "T1", ["@time"] = result[1].time + 1})
                end
            end
        end)

    --T2
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T2"
        },
        function(result)
            if result[1] ~= nil then
                Bpripada = result[1].pripada
                if Bpripada ~= nil then
                    MySQL.Sync.execute("UPDATE tomic_teritorije SET time=@time WHERE teritorija=@teritorija", {["@teritorija"] = "T2", ["@time"] = result[1].time + 1})
                end
            end
        end)

    --T3
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T3"
        },
        function(result)
            if result[1] ~= nil then
                Bpripada = result[1].pripada
                if Bpripada ~= nil then
                    MySQL.Sync.execute("UPDATE tomic_teritorije SET time=@time WHERE teritorija=@teritorija", {["@teritorija"] = "T3", ["@time"] = result[1].time + 1})
                end
            end
        end)

    --T4
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T4"
        },
        function(result)
            if result[1] ~= nil then
                Bpripada = result[1].pripada
                if Bpripada ~= nil then
                    MySQL.Sync.execute("UPDATE tomic_teritorije SET time=@time WHERE teritorija=@teritorija", {["@teritorija"] = "T4", ["@time"] = result[1].time + 1})
                end
            end
        end)

    --T5
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T5"
        },
        function(result)
            if result[1] ~= nil then
                Bpripada = result[1].pripada
                if Bpripada ~= nil then
                    MySQL.Sync.execute("UPDATE tomic_teritorije SET time=@time WHERE teritorija=@teritorija", {["@teritorija"] = "T5", ["@time"] = result[1].time + 1})
                end
            end
        end)

    --T6
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T6"
        },
        function(result)
            if result[1] ~= nil then
                Bpripada = result[1].pripada
                if Bpripada ~= nil then
                    MySQL.Sync.execute("UPDATE tomic_teritorije SET time=@time WHERE teritorija=@teritorija", {["@teritorija"] = "T6", ["@time"] = result[1].time + 1})
                end
            end
        end)

    --T7
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T7"
        },
        function(result)
            if result[1] ~= nil then
                Bpripada = result[1].pripada
                if Bpripada ~= nil then
                    MySQL.Sync.execute("UPDATE tomic_teritorije SET time=@time WHERE teritorija=@teritorija", {["@teritorija"] = "T7", ["@time"] = result[1].time + 1})
                end
            end
        end)
    end
end)


function TeritorijeLogovi(name, message, color)
    local vrijeme = os.date('*t')
    local poruka = {
        {
            ["color"] = 0,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "@Tomić | Logovi\nVrijeme: " .. vrijeme.hour .. ":" .. vrijeme.min .. ":" .. vrijeme.sec,
            },
        }
    }
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = "Teritorije", embeds = poruka, avatar_url = Config.WebhookSlika}), { ['Content-Type'] = 'application/json' })
end
