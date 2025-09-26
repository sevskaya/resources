fx_version "adamant"
game "rdr3"

rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

 

files {
    'stream/ConcreteWallGate.ytyp';
    'stream/ConcreteWallColumn.ytyp';
    'stream/ConcreteWallLong.ytyp';
    'stream/ConcreteWallShort.ytyp';


}
escrow_ignore {
	'stream/*.ydr',
    'stream/*.ytd',
}

lua54 'yes'



data_file 'DLC_ITYP_REQUEST' 'stream/ConcreteWallGate.ytyp';
data_file 'DLC_ITYP_REQUEST' 'stream/ConcreteWallColumn.ytyp';
data_file 'DLC_ITYP_REQUEST' 'stream/ConcreteWallLong.ytyp';
data_file 'DLC_ITYP_REQUEST' 'stream/ConcreteWallShort.ytyp';



dependency '/assetpacks'