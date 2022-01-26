ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('night_garage:checkmoney', function(source,cb, money)
    local xPlayer = ESX.GetPlayerFromId(source) 
    local has = xPlayer.getMoney()

    if money ~= nil then
        if has >= money then
            print('good')
            cb(true)
        else
            print('no good')
            cb(false)
        end
    end

end) 

ESX.RegisterServerCallback('night_garage:checkbank', function(source,cb, account)
    local xPlayer = ESX.GetPlayerFromId(source) 
    local bank = xPlayer.getAccount(account)["money"]

    
    if bank >= account then
        print(''.. bank ..'')
        cb(true)
    else
            
        cb(false)
    end
   

end) 

RegisterNetEvent('night_money:garage')
AddEventHandler('night_money:garage', function(money,dinero)
    local user = source
    local xPlayer = ESX.GetPlayerFromId(user)

    if xPlayer then
        xPlayer.removeAccountMoney(money,dinero)
    end
end) 



