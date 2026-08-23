--		___  ___       _   _                  _      _____              _         _
--		|  \/  |      | \ | |                | |    /  ___|            (_)       | |
--		| .  . | _ __ |  \| |  ___ __      __| |__  \ `--.   ___  _ __  _  _ __  | |_  ___
--		| |\/| || '__|| . ` | / _ \\ \ /\ / /| '_ \  `--. \ / __|| '__|| || '_ \ | __|/ __|
--		| |  | || |   | |\  ||  __/ \ V  V / | |_) |/\__/ /| (__ | |   | || |_) || |_ \__ \
--		\_|  |_/|_|   \_| \_/ \___|  \_/\_/  |_.__/ \____/  \___||_|   |_|| .__/  \__||___/
--									          							  | |
--									          							  |_|
--
--		  Need support? Join our Discord server for help: https://discord.gg/mrnewbscripts
--		  Docs: https://mrnewb.github.io/docs/

Config = Config or {}

Config.WeatherFeature = true
Config.TrickOrTreatBlips = true

Config.Shops = {
	SpookyShop = {
		position = vector4(-1726.4633, -192.4515, 58.8, 270.3187),
		model = `m24_1_prop_m41_ghost_dom_01a`,
		inventory = {
			pumpkin_basket = 25,
			rotten_casket = 50,
		},
	},
}

if GetResourceState('pengu_digiscanner') ~= 'missing' then
	if GetResourceState('ox_inventory') ~= 'missing' then
		Config.Shops.SpookyShop.inventory.WEAPON_DIGISCANNER = 15
	else
		Config.Shops.SpookyShop.inventory.weapon_digiscanner = 15
	end
end

Config.Decorations = {
	{ position = vector4(-1724.7832, -184.3276, 56.8140, 70.0000), model = `prop_hayb_st_01_cr` },
	{ position = vector4(-1722.4785, -189.7418, 57.3856, 10.0000), model = `prop_hayb_st_01_cr` },
	{ position = vector4(-1722.2195, -196.7976, 56.9444, 355.0000), model = `prop_hayb_st_01_cr` },
	{ position = vector4(-1730.7734, -197.6669, 56.9536, 270.0000), model = `prop_hayb_st_01_cr` },
	{ position = vector4(-1735.6693, -195.0284, 56.9102, 0.0000), model = `prop_hayb_st_01_cr` },
	{ position = vector4(-1735.6946, -187.2373, 56.9095, 320.0000), model = `prop_hayb_st_01_cr` },
}
