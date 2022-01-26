fx_version 'adamant'
game 'gta5'

description 'Roddy\'s Identity'
version 'legacy'

shared_script '@es_extended/imports.lua'

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/cs.lua',
	'locales/pl.lua',
	'locales/fi.lua',	
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/es.lua',
	'locales/cs.lua',
	'locales/pl.lua',
	'locales/fi.lua',	
	'config.lua',
	'client/main.lua'
}

ui_page 'html/index.html'
files {
	'html/**'
}

dependency 'es_extended'
