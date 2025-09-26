fx_version "adamant"
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

lua54 "yes"
autor 'Madruga Dev'
description 'Barco Pirata'
version '0.0.1'

data_file 'DLC_ITYP_REQUEST' 'stream/tl_pirate_ship.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/prop_flag_pp.ytyp'

escrow_ignore {
    'stream/*.ydr', -- Ignore all .ydr
    'stream/*.yft', -- Ignore all .yft
}

client_scripts {
	"client/*.lua",
}


dependency '/assetpacks'
dependency '/assetpacks'