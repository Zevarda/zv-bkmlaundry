fx_version 'cerulean'
game 'gta5'

description 'Money Laundering System - Auto Target & Framework'
author 'zDev'
version '1.0.1'

shared_scripts {
    '@ox_lib/init.lua',
    '@qb-core/shared/locale.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
