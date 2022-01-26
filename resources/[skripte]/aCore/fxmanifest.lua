fx_version 'cerulean'
games { 'rdr3', 'gta5' }


version '1.4.2'

server_script {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'tag/server.lua',
    'tag/config.lua',
	'me_do/bb_s.lua',
	'server/*.lua'
}	

client_script {
	'@es_extended/locale.lua',
	'config.lua',
	'tag/client.lua',
    'tag/config.lua',
    'me_do/bb_c.lua',
	'client/*.lua'
}

files {
	"me_do/bb_index.html",
	"me_do/bb_js.js"
}

ui_page {
	'me_do/bb_index.html',
}

----Ima stvari iz notwog corea da me ne smara taj bolesni retard