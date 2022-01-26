-- Leaked By: Leaking Hub | J. Snow | leakinghub.com

function Alert(title, message, time, type)
	SendNUIMessage({
		action = 'open',
		title = title,
		type = type,
		message = message,
		time = time,
	})
end

RegisterNetEvent('okokNotify:Alert')
AddEventHandler('okokNotify:Alert', function(title, message, time, type)
	Alert(title, message, time, type)
end)