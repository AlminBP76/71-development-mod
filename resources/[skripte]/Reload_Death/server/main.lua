-- Reload Death ESX server stuff

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

