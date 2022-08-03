fx_version 'adamant'

game 'gta5'

author 'SAFKY'
name 's_tatuagens'
description 'SAFKY Tatuagens'
version '1.0.0'

ui_page "html/index.html"

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	"config.lua",
	"server/*.lua"
}

client_scripts {
	"config.lua",
	"client/*.lua"
}

files {
	'html/index.html',
	'html/css/*.css',
	'html/js/*.js',
	'html/img/*.png',
}

provide {
	'skinchanger',
	'esx_skin'
}