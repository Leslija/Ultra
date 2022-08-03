fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '2.5'

author 'SAFKY & ASPECT'

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/CircleZone.lua',
	'client/main.lua',
	'client/gui.lua',
	'client/creation.lua',
	'client/territories.lua'
}

server_scripts {
	'server/leaders.lua',
	'server/main.lua',
	'server/territories.lua',
	'server/version.lua'
}

files {
	'config/*.json',

	'html/img/*.png',
	'html/sounds/*.wav',
	
	'html/index.html',
	'html/js/*.js',
	'html/css/*.css'
} 

ui_page 'html/index.html'


escrow_ignore {
    'config/config.json',
    'config/gangs.json',
	'server/leaders.lua',
}

