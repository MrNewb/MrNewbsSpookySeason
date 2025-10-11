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

Config.LootTypes = {
    ["pumpkin"] = {
        {rewardType = "item", name = "candy_corn", count = math.random(1,5), metadata = {}},
        {rewardType = "item", name = "chocolate_bar", count = math.random(1,3), metadata = {}},
        {rewardType = "cash", name = "money", count = math.random(100, 3000)},
    },
    ["grave"] = {
        {rewardType = "item", name = "event_token", count = math.random(1,3), metadata = {}},
        {rewardType = "item", name = "candy_corn", count = math.random(1,5), metadata = {}},
        {rewardType = "item", name = "chocolate_bar", count = math.random(1,3), metadata = {}},
        {rewardType = "item", name = "id_card", count = 1, metadata = {}},
        {rewardType = "cash", name = "money", count = math.random(500, 5000)},
    },
    ["trickOrTreat"] = {
        {rewardType = "item", name = "candy_corn", count = math.random(1,5), metadata = {}},
        {rewardType = "item", name = "chocolate_bar", count = math.random(1,3), metadata = {}},
        {rewardType = "cash", name = "money", count = math.random(100, 3000)},
    },
    ["pumpkin_basket"] = {
        {rewardType = "item", name = "event_token", count = 1, metadata = {}},
        {rewardType = "item", name = "candy_corn", count = math.random(1,5), metadata = {}},
        {rewardType = "item", name = "chocolate_bar", count = math.random(1,3), metadata = {}},
        {rewardType = "cash", name = "money", count = math.random(100, 3000)},
    },
    ["rotten_casket"] = {
        {rewardType = "item", name = "event_token", count = math.random(1,33), metadata = {}},
        {rewardType = "item", name = "candy_corn", count = math.random(1,5), metadata = {}},
        {rewardType = "item", name = "chocolate_bar", count = math.random(1,3), metadata = {}},
        {rewardType = "item", name = "id_card", count = 1, metadata = {}},
        {rewardType = "cash", name = "money", count = math.random(500, 12000)},
    },
}