ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--BAN
banNiz = {}

loadFile = LoadResourceFile("aAdmin", "banlist.json")
extract = {}
extract = json.decode(loadFile)

if extract ~= nil then
    for i,j in next, extract do
        banNiz[j.steamId] = {
            name = j.name,
            admin = j.admin,
            banId = j.banId, 
            license = j.license,
            discord = j.discord, 
            razlog = j.razlog, 
            banStatus = j.banStatus, 
            banTime = j.banTime, 
            bannedOn = j.bannedOn, 
            ip = j.ip}
    end
end

function tablelength(banNiz)
    local count = 0
    for _ in pairs(banNiz) do
        count = count + 1 end
    return count
end

function saveBanList()
    local saveInfo = {}
    for i,j in next, banNiz do
        table.insert(saveInfo, {
            steamId = i,
            name = j.name,
            admin = j.admin,
            banId = j.banId,
            license = j.license,
            discord = j.discord,
            razlog = j.razlog,
            banStatus = j.banStatus,
            banTime = j.banTime,
            bannedOn = j.bannedOn,
            ip = j.ip})
    end
    SaveResourceFile("aAdmin", "banlist.json", json.encode(saveInfo, {indent = true}), -1)
end

banNizMT = {
    __index = function()
        return {banStatus = false}
    end,
    __call = function(table, banId, steamId, license, discord, banTime, razlog, localId, publicIP, name, admin)
        DropPlayer(localId, "\n \nDobili ste ban sa servera!\n \n Razlog: " ..razlog.. " | Vrijeme: " ..banTime.. " | Ban ID: " ..banId)
        table[steamId] = {
            name = name,
            admin = admin,
            banId = banId, 
            license = license, 
            discord = discord, 
            razlog = razlog, 
            banStatus = true, 
            banTime = banTime, 
            bannedOn = os.time(), 
            ip = publicIP}
        saveBanList()
    end
}

setmetatable(banNiz, banNizMT)

function GetSteamID(tempID)
    local steamIdentifier = tempID
    for i,v in next, GetPlayerIdentifiers(tempID) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
    return steamIdentifier
end

function GetLicense(tempID)
    local license  = tempID
    for k,v in pairs(GetPlayerIdentifiers(tempID))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
            break
        end
    end
    return license
end

function GetDiscord(tempID)
    local discord  = tempID
    for k,v in pairs(GetPlayerIdentifiers(tempID))do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
            break
        end
    end
    return discord
end

function onPlayerConnect(name, setKickReason)
    local player = source
    local Ip = GetPlayerEndpoint(player)
    local playerSID = GetSteamID(player)
    local license  = GetLicense(player)
    local discord  = GetDiscord(player)

    for i,j in next, banNiz do
        if playerSID ~= i and Ip == j.ip or j.license == license or j.discord == discord then
            setKickReason("\n \nDobili ste ban sa servera od strane " ..j.admin.. "!\n \n Razlog: " ..j.razlog.. " | Vrijeme: " ..j.banTime.. " | Ban ID: " ..j.banId)
            DropPlayer(player, "\n \nDobili ste ban sa servera od strane " ..j.admin.. "!\n \n Razlog: " ..j.razlog.. " | Vrijeme: " ..j.banTime.. " | Ban ID: " ..j.banId)
            CancelEvent()
            break
         end
    end

    if banNiz[playerSID].banTime == nil then return end
    if banNiz[playerSID].ip == nil then return end
    if banNiz[playerSID].banStatus then
        if (os.difftime(os.time(), banNiz[playerSID].bannedOn) > banNiz[playerSID].banTime * 86400) then
            banNiz[playerSID].banTime = nil
            banNiz[playerSID].ip = nil
            saveBanList()
        else
            setKickReason("\n \nDobili ste ban sa servera od strane " ..banNiz[playerSID].admin.. "!\n \n Razlog: " ..banNiz[playerSID].razlog.. " | Vrijeme: " ..banNiz[playerSID].banTime.. " | Ban ID: " ..banNiz[playerSID].banId)
            DropPlayer(player, "\n \nDobili ste ban sa servera od strane " ..banNiz[playerSID].admin.. "!\n \n Razlog: " ..banNiz[playerSID].razlog.. " | Vrijeme: " ..banNiz[playerSID].banTime.. " | Ban ID: " ..banNiz[playerSID].banId)
            CancelEvent()
        end
    end
end

AddEventHandler('playerConnecting', onPlayerConnect)

--RegisterCommand("ban", function(source, args, rawCommand)

RegisterCommand("ban", function()
  TriggerEvent("kAdmin:banPlayer", tonumber(data.playerid), tonumber(data.lenght), data.reason)
end)


RegisterNetEvent('kAdmin:banPlayer')
AddEventHandler('kAdmin:banPlayer', function(target, time, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "headadmin" or xPlayer.getGroup() == "owner" then
        if target ~= nil and time ~= nil then

            --local ime = GetPlayerName(target)
            local pBanId = #banNiz + 1
            local ip = GetPlayerEndpoint(target)
            local playerSID = GetSteamID(target)
            local license  = GetLicense(target)
            local discord  = GetDiscord(target)
            local ime = GetPlayerName(target)
            local admin = GetPlayerName(source)

            banNiz(pBanId, playerSID, license, discord, time, reason, target, ip ,ime, admin)

            TriggerClientEvent("chatMessage", xPlayer.source, string.format("^4Almin ^7» ^0Igrac ^4(%s)^0 je banovan (Vreme, Razlog): ^4%s", playerSID, reason))
        else
            TriggerClientEvent("chatMessage", xPlayer.source, "^4Almin ^7» ^0/ban ID VREME(DAN) RAZLOG")
        end
    end
end)

RegisterCommand("unban", function()
  TriggerEvent("kAdmin:unbanPlayer", id)
end)

RegisterNetEvent('kAdmin:unbanPlayer')
AddEventHandler('kAdmin:unbanPlayer', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "headadmin" or xPlayer.getGroup() == "owner" then
        if id ~= nil then
            banNiz[id].banTime = nil
            banNiz[id].ip = nil
            banNiz[id].banStatus = false
            saveBanList()
            TriggerClientEvent("chatMessage", xPlayer.source, "^4Almin ^7» ^0Steam: " .. id .. " je unbanovan!")
        else
            TriggerClientEvent("chatMessage", xPlayer.source, "^4Almin ^7» ^0/unban steamId")
        end
    end
end)

ESX.RegisterServerCallback("kAdmin:getGroup", function(source, cb)
  local player = ESX.GetPlayerFromId(source)

  if player ~= nil then
      local playerGroup = player.getGroup()

      if playerGroup ~= nil then 
          cb(playerGroup)
      else
          cb("user")
      end
  else
      cb("user")
  end
end)

ESX.RegisterServerCallback('kAdmin:fetchBanned', function(source, cb)
	local banovi = LoadResourceFile("aAdmin", "banlist.json")
    banovi = json.decode(banovi)
    cb(banovi)
end)

--Bring


RegisterNetEvent('announce:ime')
AddEventHandler('announce:ime', function()
local xIgrac = GetPlayerFromId()
local imeIgraca = xIgrac.getName()
end)

RegisterNetEvent('kAdmin:otvoriInventory')
AddEventHandler('kAdmin:otvoriInventory', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    if group ~= "user" and target then
			TriggerClientEvent("almin_inventar:otvoriInvIgraca", source, target, targetXPlayer.name)
    end
end)


RegisterNetEvent('kAdmin:izbaci')
AddEventHandler('kAdmin:izbaci', function(target, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local group = xPlayer.getGroup()
    local tgroup = xTarget.getGroup()
    if group ~= "user" and target and reason then
        if tgroup ~= "owner" then
            local Executioner = GetPlayerName(source) or "Nepoznato"
            DropPlayer(target, '🥾 Izbacen si sa servera.\n \n \n \nIzbacio te: ' .. Executioner .. '\nRazlog: '..reason)
        else
            TriggerClientEvent("chatMessage", source, "[GREŠKA]: ", {255,0,0}, "Ne mozes izbaciti ovog igrača.")
        end
    end
end)


ESX.RegisterServerCallback('kAdmin:DohvatiCacheovane', function(source, callback, type)
  local xPlayer = ESX.GetPlayerFromId(source)
  local identifier = xPlayer.getIdentifier()
  local igraci = {}

  MySQL.Async.fetchAll('SELECT firstname FROM users', {}, function(results)
      if results[1] ~= nil then
          for k, v in pairs(results) do
              table.insert(igraci, {firstname = v.firstname})
          end
          callback(igraci)
      else
          callback(nil)
      end
  end)
end)



---Komande
RegisterCommand("gorivo", function(source)
  local igrac = ESX.GetPlayerFromId(source)
  if (igrac.getGroup() == "owner") and igrac.proveriDuznost() == true then
    TriggerClientEvent("gorivo_napuni", source)
  else
    TriggerClientEvent('chatMessage', source, 'Almin >> ', {250, 0, 0 }, 'Nisi na admin duznosti!')
  end
end)