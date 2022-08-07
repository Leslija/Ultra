fx_version 'bodacious'
game 'gta5'
author 'SAFKY'
version '1.0.0'


dependencies {
    "PolyZone"
}

client_script {
    'client/*.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',

}

server_script {
    '@oxmysql/lib/MySQL.lua',
	'server/*.lua',
}

shared_script 'config/*.lua'


lua54 'yes'


escrow_ignore {
    'config/*.lua',
   
}
