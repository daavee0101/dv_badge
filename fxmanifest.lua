fx_version 'adamant'
games { 'gta5' }

author 'daavee'
description 'Police and Ambulance Badge System for ESX'
version '1.1'

client_script {
	'@es_extended/locale.lua',
	'locales/hu.lua',
	'config.lua',
	'client/main.lua'
}

server_script {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/hu.lua',
	'config.lua',
	'server/main.lua'
}

dependency {
	'es_extended',
	'esx_identity'
}