fx_version 'bodacious'
game 'gta5'
author 'Ali Exacute'
description 'Admin commands'
version '1.0.0'

ui_page 'html/ui.html'

shared_scripts {
	'locales/en.lua',
	'locales/fa.lua',
    'config.lua',
}
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
	'config.lua',
	'server/*.lua',
	's_utils/*.lua',
	's_utils/*.js',
	'queue.lua',
	'import.lua',
	'misc_s.lua',
}

client_scripts {
	'client/*.lua',
	'client.lua',
	'config.lua',
	'server/lista.lua',
	'c_utils/*.lua',
	'import.lua',
	'misc_s.lua',

}


files {
	"html/ui.html",
	"html/script.js",
	"html/main.css",
	"html/**/*",
}
	
server_export "AdminCheck"
server_export "IDeviIgraca"