fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'MrNewb'
description 'A comprehensive Halloween experience by MrNewb featuring ghost hunting, pumpkin searches, grave digging, reward shops, decorations, and trick-or-treating. Built with clean architecture for a hauntingly good time!'
version '0.0.1'

shared_scripts {
	'core/init.lua',
	'configs/**/*.lua',
}

client_scripts {
	'modules/**/client.lua',
}

server_scripts {
	'modules/**/server.lua',
}

files {
	'locales/*.json'
}

dependencies {
	'/server:6116',
	'/onesync',
	'community_bridge'
}