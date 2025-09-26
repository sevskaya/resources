fx_version "adamant"
game "rdr3"

rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

lua54 "yes"
autor 'Madruga Dev'
description 'Armaria Strawberry'
version '0.0.2'


  files {
   'stream/*.ytyp'

  } 

  client_scripts {
    "client/*.lua",
  }
  
escrow_ignore {
    'stream/*.ydr'   -- Ignore all .ydr
  }
  
  data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'


dependency '/assetpacks'
dependency '/assetpacks-redm'