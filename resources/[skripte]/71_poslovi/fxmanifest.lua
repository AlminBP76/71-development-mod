fx_version 'bodacious'
game 'gta5'

author 'BennoBaba'
description 'Kolekcija poslova'
version '1.0.0'

client_scripts {
    'config.lua',
    'klijent/*.lua',
}


server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/*.lua',
    'config.lua',
}
