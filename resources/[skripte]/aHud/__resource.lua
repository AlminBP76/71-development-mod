fx_version 'adamant'
game 'gta5'
lua54 'no'

name 'BIC HUDARA'

version '1.2.0'

ui_page ('html/index.html')
files (
    {
        '**/**/*.js',
        '**/**/*.png',
        '**/**/*.css',
        '**/**/*.ttf',
        '**/*.html'
    }
)

server_scripts (
    {
        'server/*.lua'
    }
)

client_scripts (
    {
        'client/*.lua'
    }
)


shared_scripts (
    {
        'config/*.lua'
    }
)