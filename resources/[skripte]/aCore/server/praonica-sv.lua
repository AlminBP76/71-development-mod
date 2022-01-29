ESX.RegisterServerCallback('almin_pranjeauta:StanjePara', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.getMoney() >= 150 then
    xPlayer.removeMoney(150)
    cb(true)
  else
    cb(false)
  end
end)
