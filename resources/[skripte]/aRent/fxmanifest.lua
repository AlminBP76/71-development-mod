-- Resource Metadata
fx_version 'adamant'
game 'gta5'

ui_page 'html/index.html'

-- What to run
client_scripts {
  'client.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server.lua',
}


files {
    "html/index.html",
    "html/style.css",
    "html/glavno.js",
    "html/bootstrap.min.css",
    'html/fonts/*.ttf'
}
