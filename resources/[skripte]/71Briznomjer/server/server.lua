
RegisterServerEvent('hudevents:leftVehicle')
AddEventHandler('hudevents:leftVehicle', function()	
    TriggerClientEvent('hudevents:leftVehicle', source)
end)

RegisterServerEvent('hudevents:enteredVehicle')
AddEventHandler('hudevents:enteredVehicle', function(currentVehicle, currentSeat, vehicle_name, net_id)	
    TriggerClientEvent('hudevents:enteredVehicle', source, currentVehicle, currentSeat, vehicle_name, net_id)
end)