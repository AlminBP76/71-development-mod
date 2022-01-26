-- Made by @Tomić#9076

fx_version 'cerulean'
games { 'gta5' }

author "tomiichx"
description "tCoin / Random Coin PickUP System"

version 'Tomić Development | v1.1'

shared_script '@es_extended/imports.lua'

client_scripts { 
  'cl_strana.lua'
}

server_scripts { 
  '@oxmysql/lib/MySQL.lua',
  'sv_strana.lua',
}

shared_script 'config.lua'

--[[
████████╗░█████╗░███╗░░░███╗██╗░█████╗░
╚══██╔══╝██╔══██╗████╗░████║██║██╔══██╗
░░░██║░░░██║░░██║██╔████╔██║██║██║░░╚═╝
░░░██║░░░██║░░██║██║╚██╔╝██║██║██║░░██╗
░░░██║░░░╚█████╔╝██║░╚═╝░██║██║╚█████╔╝
░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝╚═╝░╚════╝░
--]]
