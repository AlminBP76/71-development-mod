ESX = nil

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

ESX.RegisterServerCallback(
    "horizon_wanted:getajWantedLevel",
    function(source, cb)
        local identifier = GetPlayerIdentifiers(source)[1]

        MySQL.Async.fetchScalar(
            "SELECT wanted FROM users WHERE identifier = @identifier",
            {
                ["@identifier"] = identifier
            },
            function(wanted)
                if wanted then
                end

                cb(wanted)
            end
        )
    end
)

RegisterServerEvent("horizon_wanted:postaviWantedLevel")
AddEventHandler(
    "horizon_wanted:postaviWantedLevel",
    function(iden, wanted)

        if type(wanted) ~= "boolean" then
            return
        end

        MySQL.Sync.execute(
            "UPDATE users SET wanted = @wanted WHERE identifier = @identifier",
            {
                ["@identifier"] = iden,
                ["@wanted"] = wanted
            }
        )
    end
)

RegisterCommand(
    "dosije",
    function(source, args, user)
        local identifier = GetPlayerIdentifiers(source)[1]
        MySQL.Async.fetchScalar(
            "SELECT wanted FROM users WHERE identifier = @identifier",
            {
                ["@identifier"] = identifier
            },
            function(wanted)
                if wanted then
                    TriggerClientEvent(
                        "chat:addMessage",
                        source,
                        {args = {"^0^*[^4^_DRŽAVA^r^0^*]^0 Traženi ste od državnih organizacija!"}}
                    )
                else
                    TriggerClientEvent(
                        "chat:addMessage",
                        source,
                        {
                            args = {
                                "^0^*[^4^_DRŽAVA^r^0^*]^0 Niste više na listi traženih, možete slobodno kretati se gradom!"
                            }
                        }
                    )
                end
            end
        )
    end
)

RegisterCommand(
    "provjeridosije",
    function(source, args, user)
        local identifier = GetPlayerIdentifiers(source)[1]
        MySQL.Async.fetchScalar(
            "SELECT wanted FROM users WHERE identifier = @identifier",
            {
                ["@identifier"] = identifier
            },
            function(wanted)
                local xPlayer = ESX.GetPlayerFromId(source)
                if xPlayer.job.name == "police" then
                    if args[1] ~= nil then
                        if GetPlayerName(tonumber(args[1])) ~= nil and wanted then
                            TriggerClientEvent(
                                "chat:addMessage",
                                source,
                                {
                                    args = {
                                        "^0^*[^4^_DRŽAVA^r^0^*]^0 Građanin je počinio krivično djelo i tražen je od državnih organizacija."
                                    }
                                }
                            )
                        elseif GetPlayerName(tonumber(args[1])) ~= nil and not wanted then
                            TriggerClientEvent(
                                "chat:addMessage",
                                source,
                                {args = {"^0^*[^4^_DRŽAVA^r^0^*]^0 Građanin nije počinio nikakvo krivično djelo."}}
                            )
                        end
                    end
                else
                    TriggerClientEvent(
                        "chat:addMessage",
                        source,
                        {args = {"^0^*[^4^_DRŽAVA^r^0^*]^0 Niste član državne organizacije."}}
                    )
                end
            end
        )
    end
)

RegisterCommand(
    "dajwanted",
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)
        local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
        if xPlayer.job.name == "police" then
            if args[1] ~= nil then
                if GetPlayerName(tonumber(args[1])) ~= nil then
                    TriggerClientEvent(
                        "chat:addMessage",
                        args[1],
                        {args = {"^0^*[^4^_DRŽAVA^r^0^*]^0 Traženi ste od strane državnih organizacija."}}
                    )
                    TriggerEvent("horizon_wanted:postaviWantedLevel", tPlayer.identifier, true)
                end
            else
                TriggerEvent("horizon_wanted:postaviWantedLevel", xPlayer.identifier, true)
            end
        else
            TriggerClientEvent(
                "chat:addMessage",
                source,
                {args = {"^0^*[^4^_DRŽAVA^r^0^*]^0 Niste član državne organizacije."}}
            )
        end
    end
)

RegisterCommand(
    "skiniwanted",
    function(source, args, user)
        local xPlayer = ESX.GetPlayerFromId(source)
        local tPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
        if xPlayer.job.name == "police" then
            if args[1] ~= nil then
                if GetPlayerName(tonumber(args[1])) ~= nil then
                    TriggerEvent("horizon_wanted:postaviWantedLevel", tPlayer.identifier, false)
                    TriggerClientEvent(
                        "chat:addMessage",
                        args[1],
                        {args = {"^0^*[^4^_DRŽAVA^r^0^*]^0 Niste više na listi traženih."}}
                    )
                end
            else
                TriggerEvent("horizon_wanted:postaviWantedLevel", xPlayer.identifier, false)
            end
        else
            TriggerClientEvent(
                "chat:addMessage",
                source,
                {args = {"^0^*[^4^_DRŽAVA^r^0^*]^0 Niste član državne organizacije."}}
            )
        end
    end
)
