fx_version "adamant"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."
game "rdr3"

this_is_a_map "yes"


lua54 "yes"
autor 'Madruga Dev'
description 'Escritorio jornalista'
version '0.0.2'

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