fx_version "adamant"

game "rdr3"

this_is_a_map "yes"

rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

lua54 "yes"
autor 'Madruga Dev'
description 'Fazenda Chadwick'
version '0.0.1'

files {

    'stream/*.ytyp',
    'val_chadwick_timecycle.xml',
}


data_file "TIMECYCLEMOD_FILE" "val_chadwick_timecycle.xml"


escrow_ignore {
    'stream/*.ydr', 
}


dependency '/assetpacks'
dependency '/assetpacks'