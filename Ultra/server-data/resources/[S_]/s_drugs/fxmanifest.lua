fx_version 'cerulean'
game 'gta5'

author 'SAFKY#2054'
description 'Drugs System'
version '1.0'
lua54 'yes'

shared_scripts {
    'config/config.lua',
}

server_scripts {
	'server/server.lua',
    'server/webhook.lua',
}

client_scripts {
	'client/client.lua',
}

escrow_ignore {
    'config/config.lua',
    'server/webhook.lua',
}