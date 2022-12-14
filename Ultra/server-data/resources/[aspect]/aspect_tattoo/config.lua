Config = {}
AutoHideClothes = true
Config.AllTattooList = json.decode(LoadResourceFile(GetCurrentResourceName(), 'tattoos.json'))
Config.TattooCats = {
	{"ZONE_HEAD", "Cabeça", {vec(0.0, 0.7, 0.7), vec(0.7, 0.0, 0.7), vec(0.0, -0.7, 0.7), vec(-0.7, 0.0, 0.7)}, vec(0.0, 0.0, 0.5)},
	{"ZONE_TORSO", "Torso", {vec(0.0, 0.7, 0.2), vec(0.0, -0.7, 0.2)}, vec(0.0, 0.0, 0.2)},
	{"ZONE_LEFT_LEG", "Perna Esq.", {vec(-0.2, 0.7, -0.7), vec(-0.7, 0.0, -0.7), vec(-0.2, -0.7, -0.7)}, vec(-0.2, 0.0, -0.6)},
	{"ZONE_LEFT_ARM", "Braço Esq.", {vec(-0.4, 0.5, 0.2), vec(-0.7, 0.0, 0.2), vec(-0.4, -0.5, 0.2)}, vec(-0.2, 0.0, 0.2)},
	{"ZONE_RIGHT_LEG", "Perna Dir.", {vec(0.2, 0.7, -0.7), vec(0.7, 0.0, -0.7), vec(0.2, -0.7, -0.7)}, vec(0.2, 0.0, -0.6)},
	{"ZONE_RIGHT_ARM", "Braço Dir.", {vec(0.4, 0.5, 0.2), vec(0.7, 0.0, 0.2), vec(0.4, -0.5, 0.2)}, vec(0.2, 0.0, 0.2)},
}

Config.Shops = {
	{1321.6098, -1654.342, 52.27547, 350.00183},
	{-1155.318, -1427.821, 4.9544591, 341.57278},
	{324.76235, 180.69274, 103.5865, 110.91837},
	{-3169.968, 1078.0466, 20.82916, 198.3395},
	{1863.0594, 3746.4157, 33.03189, 341.93487},
	{-293.0064, 6201.5268, 31.487119, 169.61817},
}