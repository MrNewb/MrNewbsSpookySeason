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
--		  If you need help with configuration or have any questions, please do not hesitate to ask.
--		  Docs Are Always Available At -- https://mrnewbs-scrips.gitbook.io/guide
--        For paid scripts get them here :) https://mrnewbscripts.tebex.io/


Config = Config or {}

Config.Shops = {
    ["SpookyShop"] = {
        position = vector4(-1726.4633, -192.4515, 58.8, 270.3187),
        model = `m24_1_prop_m41_ghost_dom_01a`,
        entityType = "object",
        inventory = {
            ["pumpkin_basket"] = 25,
            ["rotten_casket"] = 50,
        }
    },
}

-- You can just add the item above, I just had little confidence in people adding these correctly so I made this check.
if GetResourceState("ox_inventory") ~= "missing" and GetResourceState("pengu_digiscanner") ~= "missing" then
    Config.Shops["SpookyShop"].inventory["WEAPON_DIGISCANNER"] = 15
elseif GetResourceState("pengu_digiscanner") ~= "missing" then
    Config.Shops["SpookyShop"].inventory["weapon_digiscanner"] = 15
end