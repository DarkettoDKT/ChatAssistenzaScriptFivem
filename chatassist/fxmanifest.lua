fx_version 'adamant'
game 'gta5'

author 'Darketto'
description 'chatassistenza'
version '1.0.2'

ui_page 'html/index.html'

client_scripts {
    'config.lua',
    'client/*.lua'
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/*.lua'
}

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/jquery.datetimepicker.min.css',
    'html/jquery.datetimepicker.full.min.js',
    'html/date.format.js'
}