#include <YSI\y_hooks>

new MapIcons[][] =
{
	{1, float:-2672.3062,float:260.3582,float:4.6328, 14},
	{2, float:-2625.1279,float:211.0532,float:4.6379, 6},
	{3, float:-2569.8640,float:244.8265,float:10.1505, 7},
	{4, float:-1911.8213,float:831.1151,float:35.1749, 10},
	{5, float:-1806.8922,float:943.1697,float:24.8915, 29},
 	{6, float:-2332.5122,float:-167.6378,float:35.5547, 10},
	{7, float:-2648.7676,float:625.9666,float:14.4531, 22},
	{8, float:-2267.5876,float:-154.7548,float:35.3203, 54},
	{9, float:-2493.7827,float:-29.5148,float:25.7656, 45},
	{10, float:-2245.1411,float:-88.3401,float:36.3377, 49},
	{11, float:-2493.4409,float:-39.3892,float:25.7656, 39},
	{12, float:-2714.6047,float:217.2768,float:4.2957, 27},
	{13, float:-2553.3040,float:193.2317,float:6.1514, 48},
	{14, float:-1605.5450,float:711.4048,float:13.8672, 30},
	{15, float:-1886.2000,float:862.4730,float:35.1719, 45},
	{16, float:-1698.6287,float:950.0814,float:24.8906, 45},
	{17, float:-1754.1758,float:962.8541,float:24.8828, 32},
	{18, float:-2047.1050,float:456.4027,float:35.1719, 52},
	{19, float:-1904.4305,float:277.4406,float:41.0469, 63},
	{20, float:-1974.6096,float:293.3269,float:35.1719, 55},
	{21, float:-2023.1322,float:79.7627,float:28.1035, 20},
	{22, float:-1815.9147,float:617.2796,float:35.1719, 14},
	{23, float:-2376.9775,float:909.4905,float:45.4453, 45},
	{24, float:-2378.4629,float:910.0603,float:45.4453, 45},
	{25, float:-2360.5127,float:1007.7167,float:50.2666, 10},
	{26, float:2308.9724,float:-1645.0209,float:14.8270, 49},
	{27, float:2244.4797,float:-1664.3837,float:15.4766, 45},
	{28, float:2229.1326,float:-1722.1294,float:13.5625, 54},
	{29, float:2398.0269,float:-1897.4221,float:13.5469, 14},
	{30, float:2400.3484,float:-1980.2557,float:13.5469, 18},
	{31, float:2644.7324,float:-2038.8052,float:13.5500, 27},
	{32, float:2068.6638,float:-1778.8785,float:13.5596, 39},
	{33, float:2070.7095,float:-1795.2527,float:13.5533, 7},
	{34, float:2104.3325,float:-1806.4725,float:13.5547, 29},
	{35, float:1832.4546,float:-1843.3956,float:13.5781, 38},
	{36, float:1835.5005,float:-1681.7039,float:13.3871, 48},
	{37, float:1552.4500,float:-1674.9900,float:16.1953, 30},
	{38, float:2131.8159,float:-1151.2303,float:24.0703, 55},
	{39, float:1458.7700,float:-1140.0200,float:24.0692, 45},
	{40, float:1365.3500,float:-1279.0601,float:13.5469, 18},
	{41, float:1172.6821,float:-1323.4216,float:15.4021, 22},
	{42, float:1038.1914,float:-1340.7318,float:13.7423, 17},
	{43, float:1041.3888,float:-1027.0856,float:32.1016, 27},
	{44, float:1025.1978,float:-1029.2343,float:32.1016, 63},
	{45, float:1199.1300,float:-920.5710,float:43.0292, 10},
	{46, float:998.8726,float:-920.0972,float:42.1797, 38},
	{47, float:926.5330,float:-1352.6971,float:13.3766, 14},
	{48, float:822.4584,float:-1590.0729,float:13.5545, 7},
	{49, float:812.9810,float:-1616.1400,float:13.5469, 10},
	{50, float:488.2863,float:-1735.5543,float:11.1378, 63},
	{51, float:453.1553,float:-1478.3121,float:30.8133, 45},
	{52, float:459.9349,float:-1500.2183,float:31.0618, 45},
	{53, float:501.7810,float:-1358.5000,float:16.1252, 45}
};

hook OnGameModeInit()
{
	for(new i = 0; i < 52; i++)
	{
		printf("(%d) (%f) (%f) (%f) (%d)", MapIcons[i][0], MapIcons[i][1], MapIcons[i][2], MapIcons[i][3], MapIcons[i][4]);
	}
	return 1;
}

hook OnPlayerConnect(playerid)
{
	new returned;
	for(new i = 0; i < 52; i++)
	{
		returned = SetPlayerMapIcon(playerid, MapIcons[i][0], MapIcons[i][1], MapIcons[i][2], MapIcons[i][3], MapIcons[i][4], 0, MAPICON_LOCAL);
		printf("setplayermpicon returned %d", returned);
	}
	printf("Map icons loaded");
	return 1;
}