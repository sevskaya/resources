fx_version "adamant"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."
game "rdr3"
this_is_a_map "yes"
use_experimental_fxv2_oal 'yes'

lua54 "yes"
autor 'Madruga Dev'
description 'Annesburg Reconstruida'
version '0.0.1'

client_scripts {
	"client/*.lua",
}

escrow_ignore {
  'stream/*.ydr', -- Ignore all .ydr
  'README.md',
}

files {
  'stream/*.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'

dependency '/assetpacks'
dependency '/assetpacks'