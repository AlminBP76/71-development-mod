--------CHATOVI ZA ORG---------- KODOVI OD NOTW ----------------

RegisterCommand("policija", function(source, args)
  local xPlayer = ESX.GetPlayerFromId(source)
  local _source = source
    if xPlayer.job.name == 'police' then
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(27,27,233 , 0.5); border-radius: 10px;"><i class="far fa-bell"></i> {0}:<br> {1}</div>',
        args = {"POLICIJA - OBAVESTENJE ", " » " .. table.concat(args, " ")}
      })
    else
      print('Niste policajac')    
      end
  end, false)

  RegisterCommand("mehanicarska", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source
      if xPlayer.job.name == 'mechanic' then
        TriggerClientEvent('chat:addMessage', -1, {
          template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(44,236,22 , 0.5); border-radius: 10px;"><i class="far fa-bell"></i> {0}:<br> {1}</div>',
          args = {"MEHANICARSKA - OBAVESTENJE ", " » " .. table.concat(args, " ")}
        })
      else
        print('Niste Mehanicar')    
        end
    end, false)

RegisterCommand("hitna", function(source, args)
  local xPlayer = ESX.GetPlayerFromId(source)
  local _source = source
    if xPlayer.job.name == 'ambulance' then
      TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 1vw; margin: 0.5vw; background-color: rgba(236,22,29 , 0.5); border-radius: 10px;"><i class="far fa-bell"></i> {0}:<br> {1}</div>',
        args = {"HITNA POMOC - OBAVESTENJE ", " » " .. table.concat(args, " ")}
      })
    else
      print('Niste Bolnicar')    
      end
  end, false)
