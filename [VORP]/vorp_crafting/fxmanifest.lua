fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"

lua54 'yes'
author "VORP @blue" -- edited by @Bytesizd
repository 'https://github.com/VORPCORE/vorp_crafting'
description 'A crafting script for vorpcore framework'

shared_scripts {
    'config.lua',
    'shared/locale.lua',
    'languages/*.lua'
}
client_scripts {
    'client/client.lua',
    'client/services/*.lua'
}
server_scripts {
    'server/server.lua',
}
files {
    'ui/*',
    'ui/assets/*',
    'ui/vendor/*',
    'ui/assets/fonts/*'
}
ui_page 'ui/index.html'

dependencies {
    'vorp_progressbar'
}

--dont touch
version '1.8'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/vorp_crafting'
