name "s_mineiros"
author "SAFKY & ASPECT"
fx_version "cerulean"
game "gta5"

dependencies {
	'qb-menu',
    's_target',
}

shared_scripts {
	'config/*.lua',
	'locales/*.lua'
}

client_scripts { 'client/*.lua' }

server_script { 'server/*.lua' }

lua54 'yes'

escrow_ignore {
    'config/*.lua',
	'locales/*.lua',
   
}
