local cucnuo = false

RegisterKeyMapping('cucni', 'cucni', 'keyboard', 'LCONTROL')

RegisterCommand('cucni', function()
    DisableControlAction(0, 36, true)

    local ped = PlayerPedId()

    RequestAnimSet( "move_ped_crouched" )

    if ( cucnuo == true ) then 
        ResetPedMovementClipset( ped, 0 )
        cucnuo = false 
    elseif ( cucnuo == false ) then
        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
        cucnuo = true 
    end 
end)
---CUCANJE----
