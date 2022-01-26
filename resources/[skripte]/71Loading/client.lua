local spawn1 = false							-

AddEventHandler("playerSpawned", function () 	
	if not spawn1 then
		ShutdownLoadingScreenNui()				
		spawn1 = true
	end
end)

