fx_version 'cerulean'
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'erebus3222'
description 'Erebus Cattle Drive - for VORP framework (more frameworks coming soon)'
version '1.0.0'

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    'config.lua',
    'locale.lua',
    'languages/*.lua'
}
escrow_ignore {
	'config.lua',
    'locale.lua',
    'languages/*.lua'
}

lua54 'yes'

dependency '/assetpacks'