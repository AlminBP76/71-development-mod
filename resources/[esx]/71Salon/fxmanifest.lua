fx_version 'cerulean'
game 'gta5'

server_scripts {
	'@mysql-async/lib/MySQL.lua',			
	'config.lua',
	'71_ListaVozila.lua',
	'server/server.lua',
}

client_scripts {		
	'config.lua',
	'71_ListaVozila.lua',
	'client/utils.lua',
	'client/client.lua'
}

files {
    'html/index.html',
	'html/carousel.css',	
    'html/carousel.js',
	'html/design.css',
	'html/script.js',		
	'html/pickr.es5.min.js',	
	'html/picker.js',	
	'html/jquery-ui.js',
	'html/jqueri-ui.css',
	'html/nano.min.css',	
    'html/images/*.png',
    'html/fonts/*.ttf',
    'imgs/*.png',
	'imgs/brands/*.png',	
}

ui_page 'html/index.html'

dependencies {
	'es_extended'
}

export 'GeneratePlate'