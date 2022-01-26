-- Made by @Tomić#9076

fx_version 'cerulean'
games { 'gta5' }

author "tomiichx"
description "Sistem Teritorija / Territory System (SA:MP Inspired)"

version 'Tomić Development | v1.0.8'

--shared_script '@es_extended/imports.lua' -- UKOLIKO IMATE ESX LEGACY, UKLJUCITE OVO.

client_scripts { 
  '@es_extended/locale.lua',
  'prijevod/en.lua',
  'prijevod/hr.lua',
  'cl_strana/cl_strana.lua'
}

server_scripts { 
  '@oxmysql/lib/MySQL.lua',
  '@es_extended/locale.lua',
  'prijevod/en.lua',
  'prijevod/hr.lua',
  'sv_strana/sv_strana.lua',
  'sv_strana/sv_strana_editable.lua'
}

shared_script 'config.lua'

--[[
████████╗░█████╗░███╗░░░███╗██╗░█████╗░
╚══██╔══╝██╔══██╗████╗░████║██║██╔══██╗
░░░██║░░░██║░░██║██╔████╔██║██║██║░░╚═╝
░░░██║░░░██║░░██║██║╚██╔╝██║██║██║░░██╗
░░░██║░░░╚█████╔╝██║░╚═╝░██║██║╚█████╔╝
░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝╚═╝░╚════╝░
████████╗███████╗██████╗░██╗████████╗░█████╗░██████╗░██╗░░░░░██╗███████╗
╚══██╔══╝██╔════╝██╔══██╗██║╚══██╔══╝██╔══██╗██╔══██╗██║░░░░░██║██╔════╝
░░░██║░░░█████╗░░██████╔╝██║░░░██║░░░██║░░██║██████╔╝██║░░░░░██║█████╗░░
░░░██║░░░██╔══╝░░██╔══██╗██║░░░██║░░░██║░░██║██╔══██╗██║██╗░░██║██╔══╝░░
░░░██║░░░███████╗██║░░██║██║░░░██║░░░╚█████╔╝██║░░██║██║╚█████╔╝███████╗
░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝╚═╝░╚════╝░╚══════╝
--]]
