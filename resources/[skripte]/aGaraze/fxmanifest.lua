fx_version 'cerulean'

game 'gta5'

lua54 'yes'

dependencies { 
    '/server:5104',
    '/gameBuild:1868',
    '/onesync',
}

shared_scripts {
    '@es_extended/imports.lua',
    'locale.lua',
    'locales/*.lua',
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
    'client/vehicle_names.lua',
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}
