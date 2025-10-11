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

Config.TrickOrTreatBlips = true -- enable/disable house blips on map

Config.TrickOrTreat = {
    {
        --vec3 + sphere radius repacked in vec4
        targetPoint = vector4(980.5, -628.0, 59.5, 0.5),
        -- ped model that spawns after knocking
        model = `g_m_m_armgoon_01`,
        -- if its a ped or a prop
        entityType = "ped",
        -- where ped spawns after knocking
        pedSpawn = vector4(980.0365, -627.6028, 59.2359, 38.0947),
        -- which loot table to use from loot tables config
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1205.25, -557.75, 69.75, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1204.6893, -557.7281, 69.6152, 86.3501),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1201.4, -575.2, 69.45, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1200.7372, -575.7219, 69.1391, 136.0746),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1203.5, -597.75, 68.25, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1203.4042, -598.7507, 68.0636, 181.1797),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1207.75, -620.25, 66.5, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1206.8939, -620.2889, 66.4386, 95.2523),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1221.55, -669.7, 63.9, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1221.4474, -669.1683, 63.4931, 11.9250),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1241.0, -566.75, 70.0, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1241.7499, -566.1091, 69.6574, 313.8681),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1240.0, -601.7, 70.0, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1240.9003, -601.6566, 69.7826, 273.8802),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1250.65, -620.5, 70.0, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1251.0496, -621.1631, 69.4133, 213.1818),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1265.75, -649.0, 68.25, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1265.5721, -648.0392, 67.9214, 352.6507),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1265.75, -649.0, 68.25, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1265.5721, -648.0392, 67.9214, 352.6507),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1271.0, -684.25, 66.25, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1271.0432, -683.6273, 66.0316, 5.9877),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1264.25, -702.5, 65.0, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1264.9215, -702.9536, 64.7157, 240.2819),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1264.25, -702.5, 65.0, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1264.9215, -702.9536, 64.7157, 240.2819),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1230.1, -725.35, 61.3, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1229.2303, -725.3120, 60.7980, 100.5075),
        lootTable = "trickOrTreat",
    },
    {
        targetPoint = vector4(1220.9, -689.85, 61.5, 0.5),
        model = `g_m_m_armgoon_01`,
        entityType = "ped",
        pedSpawn = vector4(1220.6885, -689.1962, 61.1032, 9.5837),
        lootTable = "trickOrTreat",
    },
}