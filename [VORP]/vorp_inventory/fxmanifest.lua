fx_version 'cerulean'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
author 'VORP'
name 'vorp inventory'
description 'Inventory System for RedM VORPCore framework'

lua54 'yes'

shared_scripts {
  "config/config.lua",
  "config/groups.lua",
  "config/weapons.lua",
  "config/ammo.lua",
  "languages/*.lua",
  "shared/models/*.lua",
  'shared/handler/*.lua',
  "shared/services/*.lua",
  "shared/services/Regex.js",
}

client_scripts {
  'client/exports.lua',
  'client/client.lua',
  'client/models/*.lua',
  'client/services/*.lua',
  'client/controllers/*.lua',
  '@vorp_core/client/dataview.lua',
}

server_scripts {
  "config/logs.lua",
  '@oxmysql/lib/MySQL.lua',
  'server/vorpInventoryApi.lua',
  'server/server.lua',
  'server/models/*.lua',
  'server/services/*.lua',
  'server/controllers/*.lua',
  'server/respawn.lua',

}

files { 'html/**/*' }
ui_page 'html/ui.html'

---@deprecated
server_exports { 'vorp_inventoryApi' }

-- version
version '4.2'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_inventory-lua'
