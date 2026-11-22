--		___  ___       _   _                  _      _____              _         _
--		|  \/  |      | \ | |                | |    /  ___|            (_)       | |
--		| .  . | _ __ |  \| |  ___ __      __| |__  \ `--.   ___  _ __  _  _ __  | |_  ___
--		| |\/| || '__|| . ` | / _ \\ \ /\ / /| '_ \  `--. \ / __|| '__|| || '_ \ | __|/ __|
--		| |  | || |   | |\  ||  __/ \ V  V / | |_) |/\__/ /| (__ | |   | || |_) || |_ \__ \
--		\_|  |_/|_|   \_| \_/ \___|  \_/\_/  |_.__/ \____/  \___||_|   |_|| .__/  \__||___/
--									          							  | |
--									          							  |_|
--
--		  Server-only: loot tables and scavenger locations. Do not load this in shared_scripts.

Config = Config or {}

Config.LootTypes = {
	pumpkin = {
		{ rewardType = 'item', name = 'candy_corn', min = 1, max = 5 },
		{ rewardType = 'item', name = 'chocolate_bar', min = 1, max = 3 },
		{ rewardType = 'cash', min = 100, max = 3000 },
	},
	grave = {
		{ rewardType = 'item', name = 'event_token', min = 1, max = 3 },
		{ rewardType = 'item', name = 'candy_corn', min = 1, max = 5 },
		{ rewardType = 'item', name = 'chocolate_bar', min = 1, max = 3 },
		{ rewardType = 'item', name = 'id_card', count = 1 },
		{ rewardType = 'cash', min = 500, max = 5000 },
	},
	trickOrTreat = {
		{ rewardType = 'item', name = 'candy_corn', min = 1, max = 5 },
		{ rewardType = 'item', name = 'chocolate_bar', min = 1, max = 3 },
		{ rewardType = 'cash', min = 100, max = 3000 },
	},
	pumpkin_basket = {
		{ rewardType = 'item', name = 'event_token', count = 1 },
		{ rewardType = 'item', name = 'candy_corn', min = 1, max = 5 },
		{ rewardType = 'item', name = 'chocolate_bar', min = 1, max = 3 },
		{ rewardType = 'cash', min = 100, max = 3000 },
	},
	rotten_casket = {
		{ rewardType = 'item', name = 'event_token', min = 1, max = 33 },
		{ rewardType = 'item', name = 'candy_corn', min = 1, max = 5 },
		{ rewardType = 'item', name = 'chocolate_bar', min = 1, max = 3 },
		{ rewardType = 'item', name = 'id_card', count = 1 },
		{ rewardType = 'cash', min = 500, max = 12000 },
	},
}

Config.Pumpkins = {
	{ position = vector4(-216.8822, -1158.6768, 22.0072, 185.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(-67.5085, -1119.6282, 25.7516, 325.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(136.4705, -1047.7775, 28.1542, 350.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(180.5575, -1004.1796, 28.3289, 171.0651), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(213.5388, -936.5656, 33.7048, 345.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(200.3691, -914.0460, 30.6942, 20.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(213.9480, -859.9841, 29.3282, 150.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(212.8926, -807.0546, 29.8338, 260.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(299.4326, -581.1901, 42.2606, 255.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(166.2912, -580.8372, 42.8748, 310.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(-162.5075, -1079.9672, 41.1393, 205.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(-118.9408, -436.9402, 34.9728, 105.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(-295.1995, -342.3416, 29.0529, 135.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(-263.8620, 85.9506, 72.5682, 160.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(-926.7548, 65.0278, 49.8495, 35.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(-1134.3274, -0.6681, 47.9822, 280.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(-1731.0610, 149.0108, 63.3710, 0.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(-1672.2808, -126.0016, 59.3433, 0.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(-1685.8265, -154.5253, 58.5212, 280.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(-1706.3062, -183.4076, 56.3800, 115.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(-1755.2286, -219.5816, 54.1860, 345.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(-1757.4226, -278.9693, 46.5170, 295.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(-1735.8490, -294.2338, 47.6711, 275.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(-1680.4137, -265.2946, 50.8833, 205.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(-1672.3844, -223.7726, 54.0624, 75.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(-1805.2039, -1185.6615, 12.0174, 115.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(-1678.0460, -1163.1912, 12.0174, 0.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(-1432.6516, -1509.4844, 1.1509, 285.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(-1180.7650, -1776.8574, 2.9085, 150.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(-246.0632, -2030.4442, 28.9460, 35.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(1210.2307, -3121.8044, 4.5453, 235.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(1209.4111, -3116.6157, 5.5877, 330.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(1197.7168, -3113.4312, 4.5453, 110.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(1239.2852, -2939.5867, 8.3193, 0.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(1524.0521, -2149.6697, 76.4172, 190.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(1743.5336, -1621.8273, 111.4144, 330.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(2503.3691, -383.8588, 93.1200, 100.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(2559.1726, 367.7379, 107.6210, 100.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(2578.8037, 464.7706, 107.6248, 15.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(2273.6936, 1707.5983, 67.0398, 0.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(2947.4392, 2743.9446, 42.3449, 210.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(2748.2646, 3474.9182, 54.6709, 70.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(1991.9335, 3053.1980, 46.2148, 175.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(1852.3180, 2582.7100, 44.6724, 110.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(1223.6882, 2728.3711, 37.0049, 25.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(563.3268, 2741.4355, 41.8739, 10.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(546.0172, 2674.3086, 41.1606, 210.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(259.2702, 2584.8020, 43.9541, 185.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(347.8700, 3406.1384, 35.4451, 230.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(463.4991, 3565.3765, 32.2386, 170.00), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(2003.5345, 3780.9888, 31.1808, 0.00), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(1980.5256, 3818.7271, 31.4426, 70.00), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(388.6989, 3584.8079, 32.2922, 180.0000), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(14.4580, 3687.6931, 38.6607, 30.0000), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(-368.3953, 2960.5742, 23.8298, 50.0000), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(-459.9670, 2968.8386, 24.2556, 215.0000), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(-1096.9902, 2704.5247, 18.0463, 30.0000), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(-1506.4576, 1509.4708, 114.2886, 85.0000), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
	{ position = vector4(-3184.2812, 1081.9805, 19.8407, 260.0000), model = `reh_Prop_REH_Lantern_PK_01b`, lootTable = 'pumpkin' },
	{ position = vector4(-3239.0637, 1005.9996, 11.4226, 65.0000), model = `reh_Prop_REH_Lantern_PK_01c`, lootTable = 'pumpkin' },
	{ position = vector4(441.2881, -1378.8818, 42.5536, 24.8638), model = `reh_Prop_REH_Lantern_PK_01a`, lootTable = 'pumpkin' },
}

Config.Graves = {
	{ position = vector4(-1750.25, -310.35, 46.25, 0.55), lootTable = 'grave' },
	{ position = vector4(-1751.4830, -310.0671, 46.25, 0.55), lootTable = 'grave' },
	{ position = vector4(-1757.8959, -306.5391, 46.25, 0.55), lootTable = 'grave' },
	{ position = vector4(-1764.8162, -299.5303, 45.25, 0.55), lootTable = 'grave' },
	{ position = vector4(-1770.1857, -293.6639, 44.9266, 0.55), lootTable = 'grave' },
	{ position = vector4(-1777.0476, -287.1644, 44.8689, 0.55), lootTable = 'grave' },
	{ position = vector4(-1748.1027, -293.3860, 47.2094, 0.55), lootTable = 'grave' },
}

Config.GhostHunts = {
	{ position = vector4(2541.7759, 4807.7173, 32.6210, 195.8603), model = `u_m_y_zombie_01` },
	{ position = vector4(1344.9027, 4388.6294, 43.3437, 195.8190), model = `u_m_y_staggrm_01` },
	{ position = vector4(3866.7502, 4463.8862, 1.7264, 85.3708), model = `u_m_y_prisoner_01` },
	{ position = vector4(3616.7026, 5024.5093, 10.4145, 108.0216), model = `a_m_m_business_01` },
	{ position = vector4(3420.2307, 5166.7661, 4.8581, 144.9698), model = `G_M_M_Zombie_02` },
	{ position = vector4(-3426.3721, 967.6293, 7.3467, 268.3922), model = `a_m_m_hasjew_01` },
	{ position = vector4(-500.3494, -1032.3447, 51.4762, 132.6398), model = `u_m_y_proldriver_01` },
	{ position = vector4(-1687.4844, -138.2782, 58.4075, 103.5277), model = `G_M_M_Zombie_02` },
	{ position = vector4(-1776.0190, -220.1026, 52.2398, 308.1767), model = `G_M_M_Zombie_02` },
}

Config.TrickOrTreat = {
	{
		targetPoint = vector4(980.5, -628.0, 59.5, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(980.0365, -627.6028, 59.2359, 38.0947),
		lootTable = 'trickOrTreat',
	},
	{
		targetPoint = vector4(1205.25, -557.75, 69.75, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(1204.6893, -557.7281, 69.6152, 86.3501),
		lootTable = 'trickOrTreat',
	},
	{
		targetPoint = vector4(1201.4, -575.2, 69.45, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(1200.7372, -575.7219, 69.1391, 136.0746),
		lootTable = 'trickOrTreat',
	},
	{
		targetPoint = vector4(1203.5, -597.75, 68.25, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(1203.4042, -598.7507, 68.0636, 181.1797),
		lootTable = 'trickOrTreat',
	},
	{
		targetPoint = vector4(1207.75, -620.25, 66.5, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(1206.8939, -620.2889, 66.4386, 95.2523),
		lootTable = 'trickOrTreat',
	},
	{
		targetPoint = vector4(1221.55, -669.7, 63.9, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(1221.4474, -669.1683, 63.4931, 11.9250),
		lootTable = 'trickOrTreat',
	},
	{
		targetPoint = vector4(1241.0, -566.75, 70.0, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(1241.7499, -566.1091, 69.6574, 313.8681),
		lootTable = 'trickOrTreat',
	},
	{
		targetPoint = vector4(1240.0, -601.7, 70.0, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(1240.9003, -601.6566, 69.7826, 273.8802),
		lootTable = 'trickOrTreat',
	},
	{
		targetPoint = vector4(1250.65, -620.5, 70.0, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(1251.0496, -621.1631, 69.4133, 213.1818),
		lootTable = 'trickOrTreat',
	},
	{
		targetPoint = vector4(1265.75, -649.0, 68.25, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(1265.5721, -648.0392, 67.9214, 352.6507),
		lootTable = 'trickOrTreat',
	},
	{
		targetPoint = vector4(1271.0, -684.25, 66.25, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(1271.0432, -683.6273, 66.0316, 5.9877),
		lootTable = 'trickOrTreat',
	},
	{
		targetPoint = vector4(1264.25, -702.5, 65.0, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(1264.9215, -702.9536, 64.7157, 240.2819),
		lootTable = 'trickOrTreat',
	},
	{
		targetPoint = vector4(1230.1, -725.35, 61.3, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(1229.2303, -725.3120, 60.7980, 100.5075),
		lootTable = 'trickOrTreat',
	},
	{
		targetPoint = vector4(1220.9, -689.85, 61.5, 0.5),
		model = `g_m_m_armgoon_01`,
		pedSpawn = vector4(1220.6885, -689.1962, 61.1032, 9.5837),
		lootTable = 'trickOrTreat',
	},
}
