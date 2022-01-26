fx_version 'adamant'

game 'gta5'

description 'bulletin'

author 'Karl Saunders (Mobius1)'

version '1.1.9'

client_scripts {
    'config.lua',
    'bulletin.lua',
    'demo.lua'
}

ui_page 'ui/ui.html'

files {
    'ui/ui.html',
    'ui/images/*.jpg',
    'ui/images/*.png',
    'ui/audio/*.ogg',
    'ui/audio/*.mp3',
    'ui/audio/*.wav',
    'ui/fonts/*.ttf',
    'ui/css/*.css',
    'ui/js/*.js',
    'data/handling.meta',
	'data/vehicles.meta',
	'data/carcols.meta',
	'data/carvariations.meta',
	'audioconfig/monroec_amp.dat10',
	'audioconfig/monroec_amp.dat10.nametable',
	'audioconfig/monroec_amp.dat10.rel',
	'audioconfig/monroec_game.dat151',
	'audioconfig/monroec_game.dat151.nametable',
	'audioconfig/monroec_game.dat151.rel',
	'audioconfig/monroec_sounds.dat54',
	'audioconfig/monroec_sounds.dat54.nametable',
	'audioconfig/monroec_sounds.dat54.rel',
	'sfx/dlc_monroec/monroec.awc',
	'sfx/dlc_monroec/monroec_npc.awc'
}


data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'

data_file 'AUDIO_SYNTHDATA' 'audioconfig/monroec_amp.dat'
data_file 'AUDIO_GAMEDATA' 'audioconfig/monroec_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/monroec_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_monroec'

exports {
    'Send',
    'SendAdvanced',
    'SendSuccess',
    'SendInfo',
    'SendWarning',
    'SendError',
    'SendPinned',
    'Unpin',
    'UpdatePinned'
}
