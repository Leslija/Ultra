fx_version 'adamant'
games { 'gta5' }
lua54 'yes'

client_script 'client/*.lua'


server_script 'server/*.lua'


shared_scripts { 
	'config/*.lua',
}


escrow_ignore {
    'config/*.lua',
   
}
