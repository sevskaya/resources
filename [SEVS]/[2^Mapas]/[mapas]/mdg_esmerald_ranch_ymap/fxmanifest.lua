fx_version "adamant"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."
game "rdr3"
this_is_a_map "yes"


lua54 "yes"
autor 'Madruga Dev'
description 'Esmerald House'
version '0.0.1'

escrow_ignore {
  'stream/*.ydr',
  'README.md',

}

client_scripts {
	"client/*.lua",
}


files {
}

data_file 'DLC_ITYP_REQUEST' 'stream/eme_barn_int.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/eme_saloon.ytyp'




dependency '/assetpacks'
dependency '/assetpacks-redm'