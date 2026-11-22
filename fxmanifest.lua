fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'MrNewbSpookySeason'
description 'A comprehensive Halloween experience by MrNewb featuring ghost hunting, pumpkin searches, grave digging, reward shops, decorations, and trick-or-treating.'
author 'MrNewb'
version '1.0.1'

ox_libs {
	'locale',
}

shared_scripts {
	'@ox_lib/init.lua',
	'@Newb_Bridge/import.lua',
	'resource/open/shared/config.lua',
}

client_scripts {
	'resource/open/client/*.lua',
	'resource/modules/decorations/client/decorations.lua',
	'resource/modules/shops/client/shops.lua',
	'resource/modules/pumpkins/client/pumpkins.lua',
	'resource/modules/graves/client/graves.lua',
	'resource/modules/ghosthunt/client/ghosthunt.lua',
	'resource/modules/trickortreat/client/trickortreat.lua',
	'resource/modules/usables/client/usables.lua',
	'resource/modules/core/client/sync.lua',
}

server_scripts {
	'resource/open/server/config.lua',
	'resource/modules/core/server/rewards.lua',
	'resource/modules/pumpkins/server/pumpkins.lua',
	'resource/modules/graves/server/graves.lua',
	'resource/modules/ghosthunt/server/ghosthunt.lua',
	'resource/modules/trickortreat/server/trickortreat.lua',
	'resource/modules/shops/server/shops.lua',
	'resource/modules/usables/server/usables.lua',
	'resource/modules/core/server/sync.lua',
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
	'resource/open/**/*.lua',
	'locales/*.json',
	'resource/**/*.lua',
}
