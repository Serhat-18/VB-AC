fx_version 'adamant'

author 'VisiBait (VB-SCRIPTS: https://discord.gg/YrbBzwu59q)'
description 'VB-AC: FiveM AntiCheat (Free) by VB-SCRIPTS (VisiBait#0712) https://discord.gg/YrbBzwu59q'
version '3.0'

game 'gta5'

client_scripts {
    '@menuv/menuv.lua',
    'configs/client_config.lua',
    'client/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'configs/server_config.lua',
    'server/main.lua'
}
