ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_basicneeds:healPlayer')
	args.playerId.triggerEvent('chat:addMessage', {args = {'^5HEAL', 'Healovan si.'}})
end, true, {help = 'Healuj igraca ili sebe - resetuje glad i health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})
