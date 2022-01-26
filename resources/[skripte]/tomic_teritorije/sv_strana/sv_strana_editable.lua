-- Made by Tomić#9076
RegisterCommand(Config.Komanda, function(source, args)
    -----------------------------------------------------------------------------
    -------------------------------------T1--------------------------------------
    -----------------------------------------------------------------------------
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T1"
        },
        function(result)
            local own = " ^0Slobodna Teritorija"
            if result[1].pripada == "society_nil" then
                own = " ^0Slobodna Teritorija"
            end
            if result[1].pripada == "society_gsf" then
                own = " ^2GSF"
            end
            if result[1].pripada == "society_ballas" then
                own = " ^6Ballas"
            end
            if result[1].pripada == "society_vagos" then
                own = " ^3Vagos"
            end
            if result[1].pripada == "society_ms13" then
                own = " ^8Radovci"
            end
            if result[1].pripada == "society_bloods" then
                own = " ^8Bloods"
            end
            if result[1].pripada == "society_marabunta" then
                own = " ^4Marabunta"
            end
            if result[1].pripada == "society_crips" then
                own = " ^5Crips"
            end
            if result[1].pripada == "society_pinkpanters" then
                own = " ^8Brazilian Gang"
            end
            if result[1].pripada == "society_mungosi" then
                own = " ^9Zabjelcani"
            end
            TriggerClientEvent("chatMessage", source, Config.TeritorijaIme1, {255, 255, 255}, own)
        end)
    Wait(50)
    -----------------------------------------------------------------------------
    -------------------------------------T2--------------------------------------
    -----------------------------------------------------------------------------
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T2"
        },
        function(result)
            local own = " ^0Slobodna Teritorija"
            if result[1].pripada == "society_nil" then
                own = " ^0Slobodna Teritorija"
            end
            if result[1].pripada == "society_gsf" then
                own = " ^2GSF"
            end
            if result[1].pripada == "society_ballas" then
                own = " ^6Ballas"
            end
            if result[1].pripada == "society_vagos" then
                own = " ^3Vagos"
            end
            if result[1].pripada == "society_ms13" then
                own = " ^8Radovci"
            end
            if result[1].pripada == "society_bloods" then
                own = " ^8Bloods"
            end
            if result[1].pripada == "society_marabunta" then
                own = " ^4Marabunta"
            end
            if result[1].pripada == "society_crips" then
                own = " ^5Crips"
            end
            if result[1].pripada == "society_pinkpanters" then
                own = " ^8Brazilian Gang"
            end
            if result[1].pripada == "society_mungosi" then
                own = " ^9Zabjelcani"
            end
            TriggerClientEvent("chatMessage", source, Config.TeritorijaIme2, {255, 255, 255}, own)
        end)
    Wait(50)
    -----------------------------------------------------------------------------
    --------------------------------------T3-------------------------------------
    -----------------------------------------------------------------------------
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T3"
        },
        function(result)
            local own = " ^0Slobodna Teritorija"
            if result[1].pripada == "society_nil" then
                own = " ^0Slobodna Teritorija"
            end
            if result[1].pripada == "society_gsf" then
                own = " ^2GSF"
            end
            if result[1].pripada == "society_ballas" then
                own = " ^6Ballas"
            end
            if result[1].pripada == "society_vagos" then
                own = " ^3Vagos"
            end
            if result[1].pripada == "society_ms13" then
                own = " ^8Radovci"
            end
            if result[1].pripada == "society_bloods" then
                own = " ^8Bloods"
            end
            if result[1].pripada == "society_marabunta" then
                own = " ^4Marabunta"
            end
            if result[1].pripada == "society_crips" then
                own = " ^5Crips"
            end
            if result[1].pripada == "society_pinkpanters" then
                own = " ^8Brazilian Gang"
            end
            if result[1].pripada == "society_mungosi" then
                own = " ^9Zabjelcani"
            end
            TriggerClientEvent("chatMessage", source, Config.TeritorijaIme3, {255, 255, 255}, own)
        end)
    Wait(50)
    -----------------------------------------------------------------------------
    ------------------------------------T4---------------------------------------
    -----------------------------------------------------------------------------
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T4"
        },
        function(result)
            local own = " ^0Slobodna Teritorija"
            if result[1].pripada == "society_nil" then
                own = " ^0Slobodna Teritorija"
            end
            if result[1].pripada == "society_gsf" then
                own = " ^2GSF"
            end
            if result[1].pripada == "society_ballas" then
                own = " ^6Ballas"
            end
            if result[1].pripada == "society_vagos" then
                own = " ^3Vagos"
            end
            if result[1].pripada == "society_ms13" then
                own = " ^8Radovci"
            end
            if result[1].pripada == "society_bloods" then
                own = " ^8Bloods"
            end
            if result[1].pripada == "society_marabunta" then
                own = " ^4Marabunta"
            end
            if result[1].pripada == "society_crips" then
                own = " ^5Crips"
            end
            if result[1].pripada == "society_pinkpanters" then
                own = " ^8Brazilian Gang"
            end
            if result[1].pripada == "society_mungosi" then
                own = " ^9Zabjelcani"
            end
            TriggerClientEvent("chatMessage", source, Config.TeritorijaIme4, {255, 255, 255}, own)
        end)
    Wait(50)
    -----------------------------------------------------------------------------
    ------------------------------------T5---------------------------------------
    -----------------------------------------------------------------------------
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T5"
        },
        function(result)
            local own = " ^0Slobodna Teritorija"
            if result[1].pripada == "society_nil" then
                own = " ^0Slobodna Teritorija"
            end
            if result[1].pripada == "society_gsf" then
                own = " ^2GSF"
            end
            if result[1].pripada == "society_ballas" then
                own = " ^6Ballas"
            end
            if result[1].pripada == "society_vagos" then
                own = " ^3Vagos"
            end
            if result[1].pripada == "society_ms13" then
                own = " ^8Radovci"
            end
            if result[1].pripada == "society_bloods" then
                own = " ^8Bloods"
            end
            if result[1].pripada == "society_marabunta" then
                own = " ^4Marabunta"
            end
            if result[1].pripada == "society_crips" then
                own = " ^5Crips"
            end
            if result[1].pripada == "society_pinkpanters" then
                own = " ^8Brazilian Gang"
            end
            if result[1].pripada == "society_mungosi" then
                own = " ^9Zabjelcani"
            end
            TriggerClientEvent("chatMessage", source, Config.TeritorijaIme5, {255, 255, 255}, own)
        end)
    Wait(50)
    -----------------------------------------------------------------------------
    ------------------------------------T6---------------------------------------
    -----------------------------------------------------------------------------
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T6"
        },
        function(result)
            local own = " ^0Slobodna Teritorija"
            if result[1].pripada == "society_nil" then
                own = " ^0Slobodna Teritorija"
            end
            if result[1].pripada == "society_gsf" then
                own = " ^2GSF"
            end
            if result[1].pripada == "society_ballas" then
                own = " ^6Ballas"
            end
            if result[1].pripada == "society_vagos" then
                own = " ^3Vagos"
            end
            if result[1].pripada == "society_ms13" then
                own = " ^8Radovci"
            end
            if result[1].pripada == "society_bloods" then
                own = " ^8Bloods"
            end
            if result[1].pripada == "society_marabunta" then
                own = " ^4Marabunta"
            end
            if result[1].pripada == "society_crips" then
                own = " ^5Crips"
            end
            if result[1].pripada == "society_pinkpanters" then
                own = " ^8Brazilian Gang"
            end
            if result[1].pripada == "society_mungosi" then
                own = " ^9Zabjelcani"
            end
            TriggerClientEvent("chatMessage", source, Config.TeritorijaIme6, {255, 255, 255}, own)
        end)
    Wait(50)
    -----------------------------------------------------------------------------
    -------------------------------------T7--------------------------------------
    -----------------------------------------------------------------------------
    MySQL.Async.fetchAll(
        "SELECT * FROM tomic_teritorije WHERE teritorija = @teritorija",
        {
            ["@teritorija"] = "T7"
        },
        function(result)
            local own = " ^0Slobodna Teritorija"
            if result[1].pripada == "society_nil" then
                own = " ^0Slobodna Teritorija"
            end
            if result[1].pripada == "society_gsf" then
                own = " ^2GSF"
            end
            if result[1].pripada == "society_ballas" then
                own = " ^6Ballas"
            end
            if result[1].pripada == "society_vagos" then
                own = " ^3Vagos"
            end
            if result[1].pripada == "society_ms13" then
                own = " ^8Radovci"
            end
            if result[1].pripada == "society_bloods" then
                own = " ^8Bloods"
            end
            if result[1].pripada == "society_marabunta" then
                own = " ^4Marabunta"
            end
            if result[1].pripada == "society_crips" then
                own = " ^5Crips"
            end
            if result[1].pripada == "society_pinkpanters" then
                own = " ^8Brazilian Gang"
            end
            if result[1].pripada == "society_mungosi" then
                own = " ^9Zabjelcani"
            end
            TriggerClientEvent("chatMessage", source, Config.TeritorijaIme7, {255, 255, 255}, own)
        end)
    Wait(50)
end)
