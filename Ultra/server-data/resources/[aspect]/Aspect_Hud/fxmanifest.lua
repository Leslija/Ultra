fx_version 'cerulean'
game 'gta5'

description 'UI for ESX and QBCore Framework'
version '1.0.0'

ui_page 'client/html/index.html'

files {
	'client/html/scripts/loader.js',
	'client/html/scripts/windowListener.js',
	'client/html/scripts/**/*.js',
	'client/html/css/*.css',
	'client/html/css/**/*.css',
	'client/html/metadata/*.wav',
	'client/html/index.html'
}

shared_scripts {
	--'@qb-core/import.lua',
	'shared/config.lua',
}

client_scripts {
	'client/functions/cl_fn_main.lua',
	'client/cl_main.lua'
}

server_scripts {
	'server/functions/sv_fn_main.lua',
	'server/sv_main.lua'
}

dependencies {
	'Aspect_UIHandler'
}