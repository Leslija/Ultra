--[[ FX Information ]]--
fx_version   'cerulean'
use_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'

--[[ Resource Information ]]--
lua54 'yes'
name         'aspect_doorlock'
version      '1.4.0'
license      'GPL-3.0-or-later'
author       'Overextended'

--[[ Manifest ]]--
shared_scripts {
	'@ox_lib/init.lua',
	'config.lua',
}

client_scripts {
	'client/main.lua',
	'client/utils.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'convert/main.lua',
	'server/framework.lua',
	'server/main.lua',
}

ui_page 'web/build/index.html'

files {
	'web/build/index.html',
	'web/build/**/*',
	'locales/pt.json'
}

dependencies {
	'oxmysql',
	'ox_lib',
	's_target',
}

escrow_ignore {
	'config.lua',
	'locales/*.json',
	'sql/*.sql'
  }