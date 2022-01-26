-- Made by Tomić#9076
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

local TrenutniCoinL = {} -- Tabela u koju se store-a trenutno ime lokacije coin-a.
local TrenutniCoinX = {} -- Tabela u koju se store-a trenutna X kordinata.
local TrenutniCoinY = {} -- Tabela u koju se store-a trenutna Y kordinata.
local TrenutniCoinZ = {} -- Tabela u koju se store-a trenutna Z kordinata.
local hLokacije = {
    -- Glavna Garaža
    [1] = {x = 228.28, y = -754.6, z = 34.64, lokacija = "Glavna Garaža"},
    [2] = {x = 242.68, y = -748.72, z = 30.84, lokacija = "Glavna Garaža"},
    [3] = {x = 265.2, y = -755.44, z = 30.84, lokacija = "Glavna Garaža"},
    [4] = {x = 257.72, y = -785.64, z = 30.48, lokacija = "Glavna Garaža"},
    [5] = {x = 196.64, y = -872.08, z = 31.48, lokacija = "Glavna Garaža"},
    [6] = {x = 202.0, y = -904.44, z = 31.12, lokacija = "Glavna Garaža"},
    [7] = {x = 247.4, y = -874.96, z = 30.28, lokacija = "Glavna Garaža"},
    [8] = {x = 214.72, y = -930.76, z = 24.16, lokacija = "Glavna Garaža"},
    [9] = {x = 181.24, y = -969.16, z = 29.56, lokacija = "Glavna Garaža"},
    [10] = {x = 139.36, y = -980.12, z = 29.4, lokacija = "Glavna Garaža"},
    -- Vinewood
    [11] = {x = 682.48, y = 1204.96, z = 345.32, lokacija = "Vinewood Znak"},
    [12] = {x = 732.92, y = 1195.56, z = 326.36, lokacija = "Vinewood Znak"},
    [13] = {x = 808.36, y = 1183.48, z = 323.68, lokacija = "Vinewood Znak"},
    [14] = {x = 786.2, y = 1269.64, z = 360.28, lokacija = "Vinewood Znak"},
    [15] = {x = 719.08, y = 1297.64, z = 360.28, lokacija = "Vinewood Znak"},
    [16] = {x = 656.36, y = 1282.8, z = 360.28, lokacija = "Vinewood Znak"},
    [17] = {x = 651.84, y = 1189.8, z = 310.88, lokacija = "Vinewood Znak"},
    [18] = {x = 714.36, y = 1158.56, z = 304.8, lokacija = "Vinewood Znak"},
    -- Sandy Shores
    [19] = {x = 1869.96, y = 3763.32, z = 33.0, lokacija = "Sandy Shores (Blok: 1032)"},
    [20] = {x = 1771.76, y = 3738.16, z = 34.0, lokacija = "Sandy Shores (Blok: 1028)"},
    [21] = {x = 1754.48, y = 3789.56, z = 34.0, lokacija = "Sandy Shores (Blok: 1027)"},
    [22] = {x = 1815.56, y = 3848.2, z = 33.72, lokacija = "Sandy Shores (Blok: 1031)"},
    [23] = {x = 1938.36, y = 3831.88, z = 32.24, lokacija = "Sandy Shores (Blok: 1035)"},
    [24] = {x = 1993.04, y = 3760.16, z = 32.2, lokacija = "Sandy Shores (Blok: 1036)"},
    [25] = {x = 1906.56, y = 3719.52, z = 32.8, lokacija = "Sandy Shores (Blok: 1033)"},
    [26] = {x = 1827.2, y = 3692.88, z = 34.24, lokacija = "Sandy Shores (Blok: 1029)"},
    [27] = {x = 1743.76, y = 3698.36, z = 34.36, lokacija = "Sandy Shores (Blok: 1024)"},
    [28] = {x = 1646.24, y = 3629.8, z = 35.36, lokacija = "Sandy Shores (Blok: 1023)"},
}

function tCoinRandomLokacija(variable)
    return variable[math.random(1, #variable)]
end

RegisterServerEvent("tCoin:pokreni")
AddEventHandler("tCoin:pokreni", function()
    TrenutniCoinL = {} 
    TrenutniCoinX = {}
    TrenutniCoinY = {}
    TrenutniCoinZ = {}
    local tCoinX = tCoinRandomLokacija(hLokacije)
    table.insert(TrenutniCoinL, tCoinX.lokacija)
    table.insert(TrenutniCoinX, tCoinX.x)
    table.insert(TrenutniCoinY, tCoinX.y)
    table.insert(TrenutniCoinZ, tCoinX.z)
    -- print(TrenutniCoinL[1])
    -- print(TrenutniCoinX[1])
    -- print(TrenutniCoinY[1])
    -- print(TrenutniCoinZ[1])
    ESX.RegisterServerCallback('tCoin:randomx', function(source, cb)
        local xPlayer  = ESX.GetPlayerFromId(source)
        cb(TrenutniCoinX[1])
    end)
    ESX.RegisterServerCallback('tCoin:randomy', function(source, cb)
        local xPlayer  = ESX.GetPlayerFromId(source)
        cb(TrenutniCoinY[1])
    end)
    ESX.RegisterServerCallback('tCoin:randomz', function(source, cb)
        local xPlayer  = ESX.GetPlayerFromId(source)
        cb(TrenutniCoinZ[1])
    end)
    ESX.RegisterServerCallback('tCoin:randoml', function(source, cb)
        local xPlayer  = ESX.GetPlayerFromId(source)
        cb(TrenutniCoinL[1])
    end)
end)

RegisterServerEvent('tCoin:pokupio')
AddEventHandler('tCoin:pokupio', function(vr)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ime = GetPlayerName(xPlayer.source)
    TriggerClientEvent('chat:addMessage', -1, {color = Config.PrefixColor, multiline = false, args = {Config.PrefixPoruke, "tCoin je bio na lokaciji: "..TrenutniCoinL[1].." i pronašao ga je "..ime.."!"}})
    TriggerClientEvent('tCoin:pokupio', -1, vr)
end)

RegisterServerEvent("tCoin:postavi")
AddEventHandler("tCoin:postavi", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Sync.execute("UPDATE users SET tCoin = tCoin + @tCoin WHERE identifier = @identifier", { ["@identifier"] = xPlayer.identifier, ["@tCoin"] = 1 })
    tCoinLogovi("tCoin Pronađen!", "**" ..GetPlayerName(xPlayer.source) .."** je pronašao tCoin. Lokacija: **"..TrenutniCoinL[1].."**.")
end)

RegisterServerEvent('tCoin:zapocniClient')
AddEventHandler('tCoin:zapocniClient', function(zapocni)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('tCoin:zapocniClient', -1, zapocni)
end)

CreateThread(function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    while true do
        Wait(Config.Vrijeme * 60000)
        TriggerEvent("tCoin:pokreni")
        Wait(500)
        TriggerEvent("tCoin:zapocniClient")
    end
end)

RegisterCommand(Config.ProvjeriStanjeKomanda, function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT tCoin FROM users WHERE identifier = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)
        if tonumber(result[1].tCoin) > 0 then
            --print(json.encode(result[1].tCoin))
            TriggerClientEvent('chat:addMessage', xPlayer.source, {color = Config.PrefixColor, multiline = false, args = {Config.PrefixPoruke, "Trenutno imate "..result[1].tCoin.." hz-a!"}})
        else
            --print(json.encode(result[1].tCoin))
            TriggerClientEvent('chat:addMessage', xPlayer.source, {color = Config.PrefixColor, multiline = false, args = {Config.PrefixPoruke, "Nemate niti jedan tCoin kod sebe!"}})
        end
    end)
end)

RegisterCommand(Config.NagradaKomanda, function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT tCoin FROM users WHERE identifier = @identifier", {["@identifier"] = xPlayer.identifier}, function(result)
        if tonumber(result[1].tCoin) >= 100 then
            xPlayer.addMoney(Config.CoinNagrada)
            TriggerClientEvent('chat:addMessage', xPlayer.source, {color = Config.PrefixColor, multiline = false, args = {Config.PrefixPoruke, "Dobili ste $"..Config.CoinNagrada.."!"}})
            MySQL.Sync.execute("UPDATE users SET tCoin = tCoin - @tCoin WHERE identifier = @identifier", { ["@identifier"] = xPlayer.identifier, ["@tCoin"] = 100 })
            tCoinLogovi("tCoin Nagrada!","**"..GetPlayerName(xPlayer.source) .."** je iskoristio 100 tCoin-a i dobio $**"..Config.CoinNagrada.."**.")
        else
            TriggerClientEvent('chat:addMessage', xPlayer.source, {color = Config.PrefixColor, multiline = false, args = {Config.PrefixPoruke, "Potrebno vam je 100 tCoin-a da biste dobili $"..Config.CoinNagrada.."!"}})
        end
    end)
end)

function tCoinLogovi(name, message, color)
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
    PerformHttpRequest("https://discord.com/api/webhooks/933088032939188304/d3H_K87oXOZlMqIC5IUXNSWeRizMIIL_VEYL9uAGvSIoX-rHVIon02e-3X-FIFzmB9Ny", function(err, text, headers) end, 'POST', json.encode({username = "TomićDev | tCoin", embeds = poruka, avatar_url = "https://cdn.discordapp.com/attachments/855163728130211921/863374970678411274/horizon.png"}), { ['Content-Type'] = 'application/json' })
end
