fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'MrNewbSpookySeason'
description 'A comprehensive Halloween experience by MrNewb featuring ghost hunting, pumpkin searches, grave digging, reward shops, decorations, and trick-or-treating.'
author 'MrNewb'
version '1.0.0'

ox_libs {
	'locale',
}

shared_scripts {
	'@ox_lib/init.lua',
	'@Newb_Bridge/import.lua',
	'configs/config.lua',
	'resource/shared/init.lua',
}

client_scripts {
	'resource/open/client/*.lua',
	'resource/client/decorations.lua',
	'resource/client/shops.lua',
	'resource/client/pumpkins.lua',
	'resource/client/graves.lua',
	'resource/client/ghosthunt.lua',
	'resource/client/trickortreat.lua',
	'resource/client/usables.lua',
	'resource/client/sync.lua',
}

server_scripts {
	'configs/sv_config.lua',
	'resource/server/rewards.lua',
	'resource/server/pumpkins.lua',
	'resource/server/graves.lua',
	'resource/server/ghosthunt.lua',
	'resource/server/trickortreat.lua',
	'resource/server/shops.lua',
	'resource/server/usables.lua',
	'resource/server/sync.lua',
}

files {
	'locales/*.json',
}

dependencies {
	'/server:6116',
	'/onesync',
	'ox_lib',
	'Newb_Bridge',
}

escrow_ignore {
	'configs/*.lua',
	'locales/*.json',
	'resource/open/**/*.lua',
	'resource/**/*.lua',
}
