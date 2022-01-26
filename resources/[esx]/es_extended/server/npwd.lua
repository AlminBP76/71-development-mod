-- New Phone Who Dis compatability

if GetResourceState('npwd') ~= 'missing' then

    AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
        repeat Wait(0) until GetResourceState('npwd') == 'started'

        exports.npwd:newPlayer({
            source = playerId,
            identifier = xPlayer.identifier,
            phoneNumber = xPlayer.get('phoneNumber'),
            firstname = xPlayer.get('firstName'),
            lastname = xPlayer.get('lastName')
        })
    end)

    AddEventHandler('esx:playerLogout', function(playerId)
        exports.npwd:unloadPlayer(playerId)
    end)

    Core.GeneratePhoneNumber = function(identifier)
        local count = 0
        while GetResourceState('npwd') ~= 'started' and count < 100 do Wait(0) count += 1 end

        local phoneNumber = exports.npwd:generatePhoneNumber()
        MySQL.update('UPDATE users SET phone_number = ? WHERE identifier = ?', { phoneNumber, identifier })
        return phoneNumber
    end

    AddEventHandler('onServerResourceStart', function(resource)
        if resource == 'npwd' then
            repeat Wait(500) until GetResourceState('npwd') == 'started'
            local xPlayers = ESX.GetExtendedPlayers()
            if next(xPlayers) then

                for i=1, #xPlayers do
                    local xPlayer = xPlayers[i]

                    exports.npwd:newPlayer({
                        source = xPlayer.source,
                        identifier = xPlayer.identifier,
                        phoneNumber = xPlayer.get('phoneNumber'),
                        firstname = xPlayer.get('firstName'),
                        lastname = xPlayer.get('lastName')
                    })
                end
            end
        end
    end)

else Config.NPWD = false end
