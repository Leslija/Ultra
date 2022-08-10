fx_version 'cerulean'
game 'gta5'

description 'aspect-hud'
version '2.1.0'

shared_scripts {
	'@qb-core/shared/locale.lua',
	'locales/pt.lua',
	'config/config.lua',
	'config/uiconfig.lua'
}

client_script 'client/client.lua'
server_script 'server/server.lua'
lua54 'yes'
use_fxv2_oal 'yes'

ui_page 'html/index.html'

files {
	'html/*',
}
