fx_version 'cerulean'
game 'gta5'
lua54 'yes'
name 'MrNewbSpookySeason'
description 'A comprehensive Halloween experience by MrNewb featuring ghost hunting, pumpkin searches, grave digging, reward shops, decorations, and trick-or-treating. Built with clean architecture for a hauntingly good time!'
author 'MrNewb'
version '0.1.3'

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
	'locales/*.*',
}

dependencies {
	'/server:6116',
	'/onesync',
	'community_bridge',
}

escrow_ignore {
	'**/*.lua',
}