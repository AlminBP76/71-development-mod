fx_version 'cerulean'
game 'gta5'

version '1.0.0'

ui_page 'html/hud.html'

files {
	'html/*.html',
	'html/js/*.js',
	'html/css/*.css',
	'html/fonts/*',
	'html/images/*.png'
}

client_script 'config.lua'

client_script 'client/*.lua'
server_script 'server/*.lua'