fx_version 'cerulean'
game 'gta5'

author 'SAFKY#2054, Aspect#4586'
version '1.0.0'
lua54 'yes'

ui_page 'html/index.html'

shared_scripts {
    "config/config.lua",
}


client_scripts {
    'client/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/*.lua',
}

files {
    'html/index.html',
    'html/css/*.css',
    'html/*.css',
    'html/js/*.js',
    'html/img/*.png',
}


escrow_ignore {
    'config/config.lua',
    'server/webhook.lua',
}
