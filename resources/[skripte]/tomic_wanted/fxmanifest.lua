fx_version 'cerulean'
games { 'gta5' }

author "tomiichx, rad0je, Basty"
description "Wanted Level Sistem. In-Development!"

client_scripts { 
  "klijent.lua"
}

server_scripts { 
  '@oxmysql/lib/MySQL.lua',
  'server.lua'
}

dependencies {
	'es_extended' -- (es_extended)
}
