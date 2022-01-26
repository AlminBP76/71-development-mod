ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('Kredit:fetchStatus', function(source, cb)
    local igrac = ESX.GetPlayerFromId(source)
    local identifier = igrac.identifier
    local status = MySQL.query.await('SELECT * FROM users WHERE identifier = @id', {
        ['@id'] = identifier
    })
    cb(status[1])
end)

RegisterServerEvent('Kredit:vracajNovac')
AddEventHandler('Kredit:vracajNovac', function(kolicina)
    local src = source
    local igrac = ESX.GetPlayerFromId(src)
    local identifier = igrac.identifier
    local bazap = MySQL.query.await('SELECT * FROM users WHERE identifier = @id', {
        ['@id'] = identifier
    })
    local trenutnostanje = bazap[1].kredit
    local updatovanostanje = trenutnostanje - tonumber(kolicina)
        if igrac.getMoney() >= tonumber(kolicina) then
    
            igrac.showNotification('Trenutno stanje tvog kredita je : ' .. trenutnostanje - tonumber(kolicina) .. '$')
        
            MySQL.execute('UPDATE users SET kredit = @updatovanostanje WHERE identifier = @id ', {
                ['@id'] = identifier, 
                ['@updatovanostanje'] = updatovanostanje,
            })
            igrac.removeMoney(tonumber(kolicina))
        else
            igrac.showNotification('Nemas dovoljno novca kod sebe.')
        end
end)

TriggerEvent('cron:runAt', 21, 01, VratiNovac)

TriggerEvent('cron:runAt', 18, 18, VratiDane)

function VratiDane()
    local krediti = MySQL.query.await('SELECT * FROM users')
    for i = 1, #krediti, 1 do 
        if krediti[i].danikredita < 7 and krediti[i].kredit > 0 then
            MySQL.execute('UPDATE users SET danikredita = danikredita + 1 WHERE identifier = @id', {
                ['@id'] = krediti[i].identifier,
            })
        end
    end
end

function VratiNovac()
 local krediti = MySQL.query.await('SELECT * FROM users WHERE danikredita = 7')
 local svinaSrw = ESX.GetPlayers()

  for i = 1, #svinaSrw, 1 do
   local xPlayer = ESX.GetPlayerFromId(svinaSrw[i])
   for i = 1, #krediti, 1 do 
    if xPlayer.identifier == krediti[i].identifier then
        if krediti[i].kredit == 0 then
            xPlayer.showNotification('Odplatili ste kredit.')
            return MySQL.execute('UPDATE users SET danikredita = 0 WHERE identifier = @id', { 
                ['@id'] = xPlayer.identifier,
            })
        end
        xPlayer.removeAccountMoney('bank', konfig.RataKredita)
        xPlayer.showNotification('Oduzeto vam je ' .. konfig.RataKredita .. '$ kao rata kredita.')
        MySQL.execute('UPDATE users SET kredit = kredit - @rata WHERE identifier = @id', { 
            ['@rata'] = konfig.RataKredita,
            ['@id'] = xPlayer.identifier,
        })
    end 
   end
    if krediti[i].identifier ~= xPlayer.identifier then
       VratiOfflineBackEnd(krediti)
    end
  end
end

function VratiOfflineBackEnd(krediti)
    for i = 1, #krediti, 1 do
       local statusi = json.decode(krediti[i].accounts)

        print('ostao je jos : ' .. krediti[i].ime)
        if krediti[i].kredit == 0 then
            MySQL.query.await('UPDATE users SET danikredita = 0 WHERE identifier = @id', { 
                ['@id'] = krediti[i].identifier,
            })
        end
       
        local updatovaniStatusi = { 
            bank = statusi.bank - konfig.RataKredita,
            money = statusi.money,
            black_money = statusi.black_money
        }

        MySQL.query.await('UPDATE users SET accounts = @acc WHERE identifier = @id', { 
            ['@acc'] = json.encode(updatovaniStatusi),
            ['@id'] = krediti[i].identifier,
        })

        MySQL.query.await('UPDATE users SET kredit = kredit - @rata WHERE identifier = @id', { 
            ['@rata'] = konfig.RataKredita,
            ['@id'] = krediti[i].identifier,
        })

    end
end


RegisterServerEvent('Krediti:digni')
AddEventHandler('Krediti:digni', function(koliko)
  local src = source 
  local igrac = ESX.GetPlayerFromId(src)
  local id = igrac.identifier
  local bazap = MySQL.query.await('SELECT * FROM users WHERE identifier = @id', {
    ['@id'] = id
  })
  if bazap[1].kredit > 0 then
    return DropPlayer(src, 'Cemu citovanje allah te pojeo ?')
  end
    if koliko == 50000 then
        igrac.addMoney(50000)
        igrac.showNotification('Dignuo si kredit od 50000$ isplata krece za 7 dana, da proveris status pogledaj meni Status Kredita')
        MySQL.execute('UPDATE users SET kredit = kredit + 75000 WHERE identifier = @id', {
            ["@id"] = id
        })
    elseif koliko == 70000 then
        igrac.addMoney(70000)
        igrac.showNotification('Dignuo si kredit od 70000$ isplata krece za 7 dana, da proveris status pogledaj meni Status Kredita')
        MySQL.execute('UPDATE users SET kredit = kredit + 95000 WHERE identifier = @id', {
            ["@id"] = id
        })
    elseif koliko == 100000 then
        igrac.addMoney(100000)
        igrac.showNotification('Dignuo si kredit od 100000$ isplata krece za 7 dana, da proveris status pogledaj meni Status Kredita')
        MySQL.execute('UPDATE users SET kredit = kredit + 125000 WHERE identifier = @id', {
            ["@id"] = id
        })
    elseif koliko == 500000 then
        igrac.addMoney(500000)
        igrac.showNotification('Dignuo si kredit od 500000$ isplata krece za 7 dana, da proveris status pogledaj meni Status Kredita')
        MySQL.execute('UPDATE users SET kredit = kredit + 625000 WHERE identifier = @id', {
            ["@id"] = id
        })
    else
        DropPlayer(src, 'Sukurac matori')
    end
end)