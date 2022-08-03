fx_version 'cerulean'
game 'gta5'

author 'SAFKY#2054'
description 'SAFKY Territories'
version '1.0'
lua54 'yes'


shared_scripts {
	'config/config.lua',
	'config/translations.lua',
}

client_scripts {
	'client/client.lua',
	'client/menu.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/server.lua',
	'server/webhook.lua'
}

escrow_ignore {
    'config/config.lua',
	'config/translations.lua',
	'server/webhook.lua'
}

