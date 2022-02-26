local chatInputActive = false
local chatInputActivating = false
RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')
-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')
RegisterNetEvent('_chat:messageEntered')
--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, color, text)
  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      color = color,
      multiline = true,
      args = args
    }
  })
end)
AddEventHandler('__cfx_internal:serverPrint', function(msg)
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      templateId = 'print',
      multiline = true,
      args = { msg }
    }
  })
end)

AddEventHandler('chat:addMessage', function(message)
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = message
  })
end)

AddEventHandler('chat:addSuggestion', function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end)



AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)

AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)

AddEventHandler('chat:clear', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)

RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false)
  if not data.canceled then
    local id = PlayerId()
    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
     -- TriggerServerEvent('logovi:komande', data)
      ExecuteCommand(data.message:sub(2))
    else
      TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
    end
  end
  cb('ok')
end)
local function refreshCommands()
  if GetRegisteredCommands then
    local registeredCommands = GetRegisteredCommands()
    local suggestions = {}
    for _, command in ipairs(registeredCommands) do
        if IsAceAllowed(('command.%s'):format(command.name)) then
            table.insert(suggestions, {
                name = '/' .. command.name,
                help = ''
            })
        end
    end
   -- TriggerEvent('chat:addSuggestions', suggestions)
  end
end
AddEventHandler('onClientResourceStart', function(resName)
  Wait(500)
  refreshCommands()
end)
RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');
  refreshCommands()
  cb('ok')
end)

RegisterCommand('chat', function()
	SetTextChatEnabled(false)
	 if not chatInputActive then
	chatInputActive = true
        chatInputActivating = true
        SendNUIMessage({
          type = 'ON_OPEN'
        })
	end
	 if chatInputActivating then
	SetNuiFocus(true)
        chatInputActivating = false
      end

end, false)

RegisterKeyMapping('chat', 'Chat', 'keyboard', 'T')
