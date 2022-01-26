-- Oneshot

fx_version 'adamant'

game 'gta5'

description 'Reload Death'

client_scripts {
    'config.lua',
    'client/main.lua',
    'client/death.lua',
}

server_scripts {
    'config.lua',
    'server/main.lua',
    'server/death.lua',
    "@mysql-async/lib/MySQL.lua"
}
