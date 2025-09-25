fx_version 'adamant'

game 'rdr3'

lua54 'yes'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

exports {
	'getStables',
}
client_scripts {
  'cfg/config.lua',
  'cfg/configCoords.lua',
  'cfg/configLang.lua',
  'cfg/configHorses.lua',
  'cfg/configCarts.lua',
  'cfg/configJobs.lua',
  'cfg/full_database.lua',
  'colorParts.lua',
  'client.lua',
  'clientTag.lua',
  'clientCustom.lua',
}

server_scripts {
  'cfg/config.lua',
  'cfg/configCoords.lua',
  'cfg/configLang.lua',
  'cfg/configHorses.lua',
  'cfg/configCarts.lua',
  'cfg/configJobs.lua',
  'server.lua',
  'serverCustom.lua',
}

ui_page 'html/index.html'

files {
	'html/*',
	'html/images/*',
	'html/images/minigame/*',
	'html/images/minigame/wheel/*',
  'html/images/bagsManage/*',
  'html/images/compManage/*'
}

escrow_ignore {
  'cfg/*', 
  'html/*', 
  'clientCustom.lua',
    'serverCustom.lua', 
}

dependency '/assetpacks'