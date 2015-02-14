#include "YSI\y_hooks"

//Civilian random spawns.
new Float:RandomSpawns[][] =
{
    {-2060.8259,1161.4252,46.1480,1.9959},
    {-1881.8544,823.8978,35.1759,37.2722},
    {-2314.1809,-11.7072,35.3203,87.2880},
    {-2706.1011,376.4223,4.9684,177.0331},
    {-2169.1365,742.9042,64.8667,167.9534},
    {-2116.6648,926.3867,86.0791,181.0840},
    {-2551.9285,54.4629,16.4219,178.6517},
    {-2231.2878,252.3141,35.3203,93.4476},
    {-1738.8618,860.2408,24.8828,176.3124},
    {-1988.5133,1117.8582,54.4730,272.7819},
    {-2023.8074,-405.6918,38.7344,352.9976},
    {-2126.3201,239.8671,37.3500,292.8224}
};

//lv spawns
new Float:LvSpawns[][] =
{
	{-767.6226,1605.9961,27.1172,165.6665},
	{-1512.0795,2692.2454,55.8359,186.3018},
	{-227.9389,2723.7209,62.6875,8.2335},
	{414.8211,2532.1570,19.1527,56.0772},
	{1499.3623,2031.4558,10.8203,184.8419},
	{2399.8970,2161.1951,10.8203,184.9824},
	{2628.4734,2347.6812,10.8203,207.4593},
	{2454.2258,2020.8777,11.0625,91.6823},
	{1047.3048,1017.5112,11.0000,320.8315},
	{1135.7220,2072.3811,11.0625,134.5587},
	{1433.6683,2619.5046,11.3926,180.5466},
	{1777.5951,2802.1970,10.8359,56.5565},
	{2000.8474,1521.8163,17.0682,0.5679}
};

//Stats spawns.
new Float:StatSpawns[][] =
{
	{-2185.2268,2416.2488,5.1836,179.4194},
	{-2237.9580,2353.4204,4.9802,139.6023}
};

//Prison spawns.
new Float:PrisonSpawns[][] =
{
	{1844.1732,-1710.1964,5202.5859, 180.0195},
	{1840.8458,-1711.3177,5202.5859, 178.4294},
	{1837.8181,-1710.3394,5202.5859, 177.1526},
	{1834.4927,-1710.4767,5202.5859, 177.4660},
	{1831.0245,-1710.8242,5202.5859, 181.5394},
	{1828.1056,-1710.4707,5202.5859, 175.2727},
	{1827.9836,-1733.0228,5202.5859, 3.2510},
	{1830.9801,-1732.8156,5202.5859, 1.3476},
	{1834.3823,-1732.6678,5202.5859, 4.7943},
	{1837.6591,-1733.1351,5202.5859, 3.5409},
	{1841.0846,-1733.3573,5202.5859, 3.5408},
	{1844.0811,-1733.2183,5202.5859, 3.2275},
	{1827.8147,-1710.6169,5206.1860, 180.2625},
	{1831.1543,-1710.8624,5206.1860, 177.4659},
	{1834.2919,-1711.2295,5206.1860, 178.0925},
	{1837.7046,-1711.4066,5206.1860, 175.2725},
	{1840.6288,-1710.8534,5206.1860, 181.2259},
	{1843.7250,-1711.0283,5206.1860, 183.4193},
	{1843.9293,-1732.8948,5206.1860, 2.9610},
	{1840.3569,-1732.1729,5206.1860, 358.8876},
	{1837.5135,-1732.2739,5206.1860, 3.5877},
	{1834.4385,-1733.2949,5206.1860, 1.0810},
	{1830.9943,-1733.1104,5206.1860, 2.0210},
	{1827.6725,-1732.3783,5206.1860, 358.2610},
	{1843.9635,-1731.5769,5209.6870, 359.8277},
	{1840.7863,-1732.2507,5209.6860, 3.2743},
	{1837.5128,-1732.3510,5209.6860, 2.6478},
	{1834.2958,-1732.3309,5209.6870, 1.0810},
	{1830.9833,-1732.7478,5209.6870, 2.3344},
	{1827.7363,-1732.5747,5209.6870, 1.3944},
	{1827.7745,-1710.8997,5209.6860, 178.1161},
	{1831.0967,-1711.8242,5209.6860, 181.2495}
};


hook OnGameModeInit()
{
	AddPlayerClass(165,-2185.2268,2416.2488,5.1836,179.4194,0,0,0,0,0,0); // statpos1
	AddPlayerClass(166,-2237.9580,2353.4204,4.9802,139.6023,0,0,0,0,0,0); // statpos2
	AddPlayerClass(287,-1345.1957,501.4555,18.2344,4.3111,0,0,0,0,0,0); // armypos1
	AddPlayerClass(179,-1345.1957,501.4555,18.2344,4.3111,0,0,0,0,0,0); // armypos2
	AddPlayerClass(285,-1040.0908,-642.3456,32.0078,116.2276,0,0,0,0,0,0); // swatpos
	AddPlayerClass(279,-1040.0908,-642.3456,32.0078,116.2276,0,0,0,0,0,0); // Firefighter
	AddPlayerClass(147,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//mayor
	AddPlayerClass(155,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//pizza boy
 	AddPlayerClass(265,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 1
  	AddPlayerClass(266,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 2
   	AddPlayerClass(267,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 3
   	AddPlayerClass(280,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 4
    AddPlayerClass(281,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 5
    AddPlayerClass(282,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 6
    AddPlayerClass(283,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 7
    AddPlayerClass(284,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 8
    AddPlayerClass(288,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 9
    AddPlayerClass(61,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // pilot
    AddPlayerClass(220,-1985.3322,137.4805,27.6875,88.6009,0,0,0,0,0,0);//Driver (taxi)
 	AddPlayerClass(247,-2060.8259,1161.4252,46.1480,1.9959,0,0,0,0,0,0); // civilainspawn1
	AddPlayerClass(1,-1881.8544,823.8978,35.1759,37.2722,0,0,0,0,0,0); // civilainspawn2
 	AddPlayerClass(2,-2314.1809,-11.7072,35.3203,87.2880,0,0,0,0,0,0); // civilianspawn3
	AddPlayerClass(3,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn4
	AddPlayerClass(4,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn5
	AddPlayerClass(5,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn6
	AddPlayerClass(6,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn7
	AddPlayerClass(7,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn8
	AddPlayerClass(8,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn9
	AddPlayerClass(9,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn10
	AddPlayerClass(10,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn11
	AddPlayerClass(11,-2169.1365,742.9042,64.8667,167.9534,0,0,0,0,0,0); // civilianspawn12
	AddPlayerClass(12,-2116.6648,926.3867,86.0791,181.0840,0,0,0,0,0,0); // civilianspawn13
    AddPlayerClass(13,-2551.9285,54.4629,16.4219,178.6517,0,0,0,0,0,0); // civilianspawn14
	AddPlayerClass(14,-2231.2878,252.3141,35.3203,93.4476,0,0,0,0,0,0); // civilianspawn15
	AddPlayerClass(15,-1738.8618,860.2408,24.8828,176.3124,0,0,0,0,0,0); // civilianspawn16
	AddPlayerClass(16,-1988.5133,1117.8582,54.4730,272.7819,0,0,0,0,0,0); // civilianspawn17
	AddPlayerClass(17,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn18
	AddPlayerClass(18,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn19
	AddPlayerClass(19,-2023.8074,-405.6918,38.7344,352.9976,0,0,0,0,0,0); // civilianspawn20
	AddPlayerClass(20,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn21
	AddPlayerClass(21,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn22
	AddPlayerClass(22,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn23
	AddPlayerClass(23,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn24
	AddPlayerClass(24,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn25
	AddPlayerClass(25,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn26
	AddPlayerClass(26,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn27
	AddPlayerClass(27,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn28
	AddPlayerClass(28,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn29
	AddPlayerClass(29,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn30
	AddPlayerClass(30,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn31
	AddPlayerClass(31,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn32
	AddPlayerClass(32,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn33
	AddPlayerClass(33,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn34
	AddPlayerClass(34,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn35
	AddPlayerClass(35,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn36
	AddPlayerClass(36,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn37
	AddPlayerClass(37,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn38
	AddPlayerClass(38,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn39
	AddPlayerClass(39,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn40
	AddPlayerClass(40,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn41
	AddPlayerClass(41,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn42
	AddPlayerClass(43,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn43
	AddPlayerClass(45,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn44
	AddPlayerClass(46,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn45
	AddPlayerClass(47,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn46
	AddPlayerClass(48,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn47
	AddPlayerClass(49,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn48
	AddPlayerClass(51,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn49
	AddPlayerClass(52,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn50
	AddPlayerClass(53,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn51
	AddPlayerClass(54,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn52
	AddPlayerClass(55,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn53
	AddPlayerClass(56,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn54
	AddPlayerClass(57,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn55
	AddPlayerClass(58,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn56
	AddPlayerClass(59,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn57
	AddPlayerClass(60,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn58
	AddPlayerClass(62,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn60
	AddPlayerClass(63,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn61
	AddPlayerClass(64,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn62
	AddPlayerClass(65,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn63
	AddPlayerClass(66,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn64
	AddPlayerClass(67,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn65
	AddPlayerClass(68,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn66
	AddPlayerClass(69,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn67
	AddPlayerClass(70,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn68
	AddPlayerClass(71,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn69
	AddPlayerClass(72,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn70
	AddPlayerClass(73,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn71
	AddPlayerClass(74,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn72
	AddPlayerClass(86,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn73
	AddPlayerClass(76,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn74
	AddPlayerClass(77,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn75
	AddPlayerClass(78,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn78
	AddPlayerClass(79,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn79
	AddPlayerClass(80,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn80
	AddPlayerClass(81,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn81
	AddPlayerClass(82,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn82
	AddPlayerClass(83,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn83
	AddPlayerClass(84,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn84
	AddPlayerClass(85,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn85
	AddPlayerClass(87,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn86
	AddPlayerClass(88,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn87
	AddPlayerClass(89,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn88
	AddPlayerClass(90,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn89
	AddPlayerClass(91,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn90
	AddPlayerClass(92,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn91
	AddPlayerClass(93,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn92
	AddPlayerClass(94,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn93
	AddPlayerClass(95,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn94
	AddPlayerClass(96,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn95
	AddPlayerClass(97,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn96
	AddPlayerClass(98,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn97
	AddPlayerClass(99,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn98
	AddPlayerClass(100,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn99
	AddPlayerClass(247,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn100
	AddPlayerClass(248,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn101
	AddPlayerClass(254,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn102
    AddPlayerClass(170,-2765.9897,375.4386,6.3347,278.5965,0,0,0,0,0,0);//civilianspawn103
    AddPlayerClass(264,-2767.3179,788.7258,52.7813,262.3263,0,0,0,0,0,0);//civilianspawn104
    AddPlayerClass(216,-2442.7800,752.9677,35.1719,179.2369,0,0,0,0,0,0);//civilianspawn105
    AddPlayerClass(75,-2359.2136,1006.7867,50.6953,87.5064,0,0,0,0,0,0);//civilianspawn106
    AddPlayerClass(170,-1725.3872,1356.5693,7.1799,107.8884,0,0,0,0,0,0);//civilianspawn107
    AddPlayerClass(143,-1985.3896,665.8715,46.5683,275.6404,0,0,0,0,0,0);//civilianspawn108
    AddPlayerClass(101,-2383.1177,-584.4406,132.1172,90.4442,0,0,0,0,0,0);//civilianspawn109
    AddPlayerClass(246,-1989.2987,1118.1178,54.4688,272.2214,0,0,0,0,0,0);//civilianspawn110
    AddPlayerClass(276,-2651.2454,609.7889,14.4531,191.8591,0,0,0,0,0,0);//medic
    AddPlayerClass(202,-1547.2676,126.4054,3.5547,137.0018,0,0,0,0,0,0);//trucker
    AddPlayerClass(42,-2030.6611,156.5619,28.8359,272.7437,0,0,0,0,0,0);//mechanic
    AddPlayerClass(223,-1712.3699,7.4375,3.5547,316.8104,0,0,0,0,0,0);//hitman
    AddPlayerClass(158,-1712.3699,7.4375,3.5547,316.8104,0,0,0,0,0,0);//farmer
}

hook OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid, 0);
	SetCameraBehindPlayer(playerid);
   	StopAudioStreamForPlayer(playerid);
   	SetPlayerTeam(playerid, 0);
   	SendFormattedMessageP(playerid, COLOR_WHITE, "Welcome to the server, " EMBED_GREEN "%s", PlayerName[playerid]);
   	HideCasualTextdraw(playerid);
   	PlayerVariables[playerid] |= PLAYER_SPAWNED;
   	switch(gTeam[playerid])
	{
	    case HITMAN:
	    {
	        switch(City[playerid])
	        {
	            case 0:
	            {
	            	printf("city 1");
			        Rand = random(sizeof(RandomSpawns));
			    	SetPlayerPos(playerid, RandomSpawns[Rand][0], RandomSpawns[Rand][1], RandomSpawns[Rand][2]);
			    	SetPlayerFacingAngle(playerid, RandomSpawns[Rand][3]);
				}
				case 1:
				{
					printf("city 2");
				    Rand = random(sizeof(LvSpawns));
				    SetPlayerPos(playerid, LvSpawns[Rand][0], LvSpawns[Rand][1], LvSpawns[Rand][2]);
			    	SetPlayerFacingAngle(playerid, LvSpawns[Rand][3]);
				}
			}
	    	SetPlayerColor(playerid, COLOR_WHITE);
	    	GivePlayerWeapon(playerid, 22, 500);
 			GivePlayerWeapon(playerid, 28, 500);
 			GivePlayerWeapon(playerid, 31, 500);
 			SetPlayerTeam(playerid, NO_TEAM);
		}
		case CIVILIAN || TERRORIST:
		{
		    switch(City[playerid])
	        {
	            case 0:
	            {
	            	printf("city 1");
			        //Rand = random(sizeof(RandomSpawns));
			    	//SetPlayerPos(playerid, RandomSpawns[Rand][0], RandomSpawns[Rand][1], RandomSpawns[Rand][2]);
			    	//SetPlayerFacingAngle(playerid, RandomSpawns[Rand][3]);
				}
				case 1:
				{
					printf("city 2");
				    Rand = random(sizeof(LvSpawns));
				    SetPlayerPos(playerid, LvSpawns[Rand][0], LvSpawns[Rand][1], LvSpawns[Rand][2]);
			    	SetPlayerFacingAngle(playerid, LvSpawns[Rand][3]);
				}
			}
	    	SetPlayerColor(playerid, COLOR_WHITE);
	    	ShowPlayerDialog(playerid, DIALOG_CLASS, DIALOG_STYLE_LIST, "Choose your class", "Drug Dealer\nPedo\nGun merchant\nThief\nItems dealer\nRapist\nKidnapper\nTerrorist\nCar Jacker\nWhore", "select", "cancel");
		}
		case ARMY:
		{
			SetPlayerColor(playerid, COLOR_PURPLE);
			GivePlayerWeapon(playerid, 24, 500);
 			GivePlayerWeapon(playerid, 31, 500);
		}
		case STAT:
		{
		    Rand = random(sizeof(StatSpawns));
	    	SetPlayerPos(playerid, StatSpawns[Rand][0], StatSpawns[Rand][1], StatSpawns[Rand][2]);
	    	SetPlayerFacingAngle(playerid, StatSpawns[Rand][3]);
	    	SetPlayerColor(playerid, COLOR_BLACK);
    		GivePlayerWeapon(playerid, 24, 500);
 			GivePlayerWeapon(playerid, 31, 500);
	    }
	    case POLICE:
		{
	 		SetPlayerColor(playerid, COLOR_BLUE1);
	 		GivePlayerWeapon(playerid, 3, 1);
	 		GivePlayerWeapon(playerid, 22, 500);
		}
	    case RAPIST: SetPlayerColor(playerid, COLOR_WHITE);
	    case MECHANIC:
		{
	 		SetPlayerColor(playerid, COLOR_WHITE);
	 		GivePlayerWeapon(playerid, 22, 500);
 			GivePlayerWeapon(playerid, 28, 500);
		}
	    case MEDIC:
		{
	 		SetPlayerColor(playerid, COLOR_PINK);
	 		GivePlayerWeapon(playerid, 22, 500);
 			GivePlayerWeapon(playerid, 28, 500);
 			Injections[playerid] = 10;
		}
	    case DRUG: SetPlayerColor(playerid, COLOR_WHITE);
	    case ROB: SetPlayerColor(playerid, COLOR_WHITE);
	    case WEP: SetPlayerColor(playerid, COLOR_WHITE);
	    case ITEMS: SetPlayerColor(playerid, COLOR_WHITE);
	    case KIDNAPPER: SetPlayerColor(playerid, COLOR_WHITE);
	    case PEDO: SetPlayerColor(playerid, COLOR_WHITE);
	    case TRUCKER:
		{
	 		SetPlayerColor(playerid, COLOR_GREEN);
	 		GivePlayerWeapon(playerid, 22, 500);
 			GivePlayerWeapon(playerid, 28, 500);
		}
	    case TAXI:
		{
	 		SetPlayerColor(playerid, COLOR_WHITE);
	 		GivePlayerWeapon(playerid, 22, 500);
 			GivePlayerWeapon(playerid, 28, 500);
		}
	    case SWAT:
		{
	 		SetPlayerColor(playerid, COLOR_LIGHTBLUE);
	 		GivePlayerWeapon(playerid, 24, 500);
 			GivePlayerWeapon(playerid, 31, 500);
		}
	}
	return 1;
}

hook OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 510.4452,-85.3122,999.8295);
	SetPlayerFacingAngle(playerid, 275.6374-190);
	SetPlayerCameraPos(playerid, 506.8546,-82.0858,998.9609);
	SetPlayerCameraLookAt(playerid, 510.4452,-85.3122,999.8295);
	SetPlayerInterior(playerid, 11);
	printf("spawn OnPlayerRequestClass(playerid, classid)");
	switch(classid)
	{
	    case 0..1:
	    {
	        ShowCasualTextdraw(playerid, "S.T.A.T");
			gTeam[playerid] = STAT;
			printf("spawn OnPlayerRequestClass(playerid, classid)??");
		}
		case 2..3:
		{
		    ShowCasualTextdraw(playerid, "ARMY");
		    gTeam[playerid] = ARMY;
		}
		case 4:
		{
            ShowCasualTextdraw(playerid, "S.W.A.T");
			gTeam[playerid] = SWAT;
		}
		case 5:
		{
			ShowCasualTextdraw(playerid, "FIREFIGHTER");
			gTeam[playerid] = FIREFIGHTER;
		}
		case 6:
		{
		    ShowCasualTextdraw(playerid, "MAYOR");
		    gTeam[playerid] = MAYOR;
		}
		case 7:
		{
		    ShowCasualTextdraw(playerid, "PIZZA BOY");
		    gTeam[playerid] = PIZZABOY;
		}
		case 8..16:
		{
			ShowCasualTextdraw(playerid, "POLICE OFFICER");
			gTeam[playerid] = POLICE;
		}
		case 17:
		{
		    ShowCasualTextdraw(playerid, "PILOT");
			gTeam[playerid] = PILOT;
		}
		case 18:
		{
		    ShowCasualTextdraw(playerid, "TAXI DRIVER");
		    gTeam[playerid] = TAXI;
		}
		case 19..125:
		{
		    ShowCasualTextdraw(playerid, "CIVILIAN~n~Choose a job");
		    gTeam[playerid] = CIVILIAN;
		}
		case 126:
		{
		    ShowCasualTextdraw(playerid, "MEDIC");
		    gTeam[playerid] = MEDIC;
		}
		case 127:
		{
		    ShowCasualTextdraw(playerid, "TRUCKER");
		    gTeam[playerid] = TRUCKER;
		}
		case 128:
		{
		    ShowCasualTextdraw(playerid, "MECHANIC");
		    gTeam[playerid] = MECHANIC;
		}
		case 129:
		{
		    ShowCasualTextdraw(playerid, "HITMAN");
		    gTeam[playerid] = HITMAN;
		}
		case 130:
		{
		    ShowCasualTextdraw(playerid, "FARMER");
		    gTeam[playerid] = FARMER;
		}
	}

	return 1;
}

hook OnPlayerRequestSpawn(playerid)
{
	if(!(PlayerVariables[playerid] & PLAYER_LOGGED_IN))
	{
		return 0;
	}

	if(gTeam[playerid] == CIVILIAN)
	{
		ToggleClassSelection(playerid);
		PlayerTextDrawHide(playerid, Casual[playerid]);
		return 0;
	}
	return 1;
}