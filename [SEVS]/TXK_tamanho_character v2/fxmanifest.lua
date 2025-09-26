fx_version 'adamant'
games { 'rdr3' }

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'TXK STORE'
description 'Sistema de ajuste de tamanho do personagem'
lua54 'yes'
version '0.0.3'

shared_scripts {
    'config.lua'
}

server_scripts { 
    '@oxmysql/lib/MySQL.lua',
    'config.lua', 
    'server/server.lua'
}

client_scripts {
    'config.lua', 
    'client/client.lua'
}

escrow_ignore {
	'config.lua', 
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}
dependency '/assetpacks'