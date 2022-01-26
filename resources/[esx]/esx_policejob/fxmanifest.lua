fx_version 'adamant'

game 'gta5'

description 'ESX Police Job'

version 'legacy'

shared_script '@es_extended/imports.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'locales/fr.lua',
	'locales/fi.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/ko.lua',
	'locales/cs.lua',
	'locales/nl.lua',
	'locales/tr.lua',
	'config.lua',
	'server/main.lua',
	'server/auta.lua',
	"core/_config/cfg_vehicleCustomisation.lua",
    "core/server/sv_bennys.lua"
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'locales/fr.lua',
	'locales/fi.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/ko.lua',
	'locales/cs.lua',
	'locales/nl.lua',
	'locales/tr.lua',
	'config.lua',
	'client/main.lua',
	'client/auta.lua',
	"core/_config/cfg_vehicleCustomisation.lua",
    "core/client/ui/cl_ui.lua",
    "core/client/cl_bennys.lua"
}

dependencies {
	'es_extended',
	'esx_billing'
}

ui_page "core/client/ui/html/index.html"

files {
    "core/client/ui/html/index.html",
    "core/client/ui/html/css/menu.css",
    "core/client/ui/html/js/ui.js",
    "core/client/ui/html/imgs/logo.png",
    "core/client/ui/html/sounds/wrench.ogg",
    "core/client/ui/html/sounds/respray.ogg"
}