RegisterCommand("pomoc", function(source, args, rawCommand)
  local mrtvak = ESX.GetPlayerFromId(source)
  TriggerClientEvent('chat:addMessage', source, {
    args = {"^3POMOĆ", " ^7(^3^*" .. GetPlayerName(source) .. " ^7| ^3^*" .. source .. "^7) ^7» ^3" .. table.concat(args, " ")}
  })

  posaljiLog('71 Development - Pomoc', "" .. mrtvak.getName() .."  je poslao pomoc    " .. table.concat(args, " "), 2061822)

    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
          if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin'
 and xPlayer.source ~= source then
              TriggerClientEvent('chat:addMessage', xPlayer.source, {
          args = {"^3POMOĆ", " ^7(^3^*" .. GetPlayerName(source) .. " ^7| ^3^*" .. source .. "^7) ^7» ^3" .. table.concat(args, " ")}
          })
        end
    end
end, false)


------funkcija za log-----------
function posaljiLog(name,message,color)
    local kurac = "webhook"
  
    local embeds = {
      {
          ["title"]=message,
          ["type"]="rich",
          ["color"] = 6965387,
          ["footer"]=  {
            ["text"]= "majestic RolePlay » Logovi",
          },
      }
  }

if message == nil or message == '' then return FALSE end
    PerformHttpRequest(kurac, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
