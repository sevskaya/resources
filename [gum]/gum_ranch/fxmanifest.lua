fx_version 'adamant'

game 'rdr3'
lua54 'yes'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
    'cfg/configBase.lua',
    'cfg/configLang.lua',
    'cfg/configAnimals.lua',
    'cfg/configRanchs.lua',
    'client.lua',
}

server_scripts {
    'cfg/configBase.lua',
    'cfg/configLang.lua',
    'cfg/configAnimals.lua',
    'cfg/configRanchs.lua',
	'server.lua'
}
ui_page 'html/index.html'

files {
	'html/*',
	'html/images/*',
	'html/newimages/*',
	'html/newimages/animals/*',
	'html/images/acc/*',
	'html/images/speed/*',
	'html/images/turn/*',
	'html/images/state/*',
}
escrow_ignore {
    'cfg/configBase.lua',
    'cfg/configLang.lua',
    'cfg/configAnimals.lua',
    'cfg/configRanchs.lua',
  }
dependency '/assetpacks'