#include <a_samp>
#include <sscanf2>
#include <a_mysql>
#include <zcmd>
#include <streamer>
#include <foreach>

//defines

//misc
#define         SERVER_NAME                 ("Epanetrics Universe")
#define         MAX_WARNS                   (3)
#define         MAX_STORES                  (1000)
#define         MAX_HOUSES                  (1000)

//mysql
#define         MYSQL_HOST                  ("localhost")
#define         MYSQL_USER                  ("root")
#define         MYSQL_DATABASE              ("ue")
#define         MYSQL_PASSWORD              ("")

//dialogs
#define         DIALOG_LOGIN                (0)
#define         DIALOG_REGISTER             (1)
#define         DIALOG_COPDIALOG            (2)


//admin ranks
#define         ADMIN                       (2)
#define         MOD                         (1)
#define         SENIOR_ADMIN                (3)

//teams
#define         CIVILIAN                    (1)
#define         POLICE                      (2)
#define         HITMAN                      (3)

//color
#define			COLOR_ORANGE				0xFF8000FF
#define 		COLOR_GREY 					0xAFAFAFAA
#define 		COLOR_GREEN 				0x33AA33AA
#define 		COLOR_BLUE1 				0x0066FFFF
#define 		COLOR_LIGHTBLUE 			0x33CCFFAA
#define 		COLOR_LIGHTGREEN 			0x9ACD32AA
#define 		COLOR_YELLOW 				0xFFFF00AA
#define 		COLOR_VIP 					0xC93CCE00
#define 		COLOR_WHITE 				0xFFFFFFAA
#define 		COLOR_PURPLE 				0xC2A2DAAA
#define 		COLOR_PINK 					0xFF66FFAA
#define 		COLOR_DBLUE 				0x2641FEAA
#define 		COLOR_RED2					0xFF0000FF
#define         COLOR_FIRE              	0xC11B17FF
#define         COLOR_BLACK             	0x000000FF
#define         COLOR_COOLBLUE          	0x00cacaFF //Only used for random messages.
#define         COLOR_SKYBLUE           	0xC11B17FF

//Variables

new Gconnection; //Global connection to the database
new G_String[128]; // Global string
new PlayerText:ClassSelection[MAX_PLAYERS];
new bool:LoggedIn[MAX_PLAYERS];//if the player is logged in or not
new Registed[MAX_PLAYERS];//if the player is registered
new MaxPassAttempts[MAX_PLAYERS];//how many attempts did they take in logging in
new Spawned[MAX_PLAYERS];//is the player spawned?
new Time[MAX_PLAYERS];//how long since the last cmd
new Muted[MAX_PLAYERS];//is the player muted
new Kicked[MAX_PLAYERS];//is the player up for a kick?
new Frozen[MAX_PLAYERS];//is the player frozen
new Warns[MAX_PLAYERS];//how many warnings does this player have?
new WantedLevel[MAX_PLAYERS];//the wanted level of the player
new bool:CreatedVehicle[MAX_VEHICLES];//the vehicle is created by command
new StoreRobbing[MAX_PLAYERS];//is the store being robbed
new bool:StoreRobbed[MAX_STORES];//is the store robbed?
new gTeam[MAX_PLAYERS];//what team is the player on
new checkpoints[100];//checkpoint array
new PlayerRobberyID[MAX_PLAYERS];//the robbery interior id
new RobberyTime[MAX_PLAYERS] =15;//the robbery time left
new PlayerText:RobberyText[MAX_PLAYERS];//The robbery textdraw
new Rand;//global random variable
new OneSec[MAX_PLAYERS];//timer
new bool:HCreated[MAX_HOUSES];

//natives
native WP_Hash(buffer[], len, const str[]);



//forwards
forward OnPlayerRequestLoginRegister(playerid);
forward Mysql_Register(playerid, password[]);
forward Mysql_Login(playerid, password[]);
forward OnPlayerRequestLogin(playerid);
forward OnPlayerLogin(playerid);
forward OnPlayerRegister(playerid);
forward OneSecTimer(playerid);
forward CoolDownShops(shopid);

//enums

enum IconsInfo
{
	iconid,
	Float:x,
	Float:y,
	Float:z,
	type,
	colour
}

enum PInfo
{
	Pusername[24],
	Ppassword[24],
	Pscore,
	Pmoney,
	Padmin
}

new PlayerInfo[MAX_PLAYERS][PInfo];

enum RobberyInfo
{
	Float:Xpos,
	Float:Ypos,
	Float:Zpos,
	RobberyType[100],
	RobberyZone[100],
	RobberyID
}

enum Hinfo
{
    HID,
    Float:Xpos,
    Float:Ypos,
    Float:Zpos,
    Howner[24],
    bool:Howned,
    Interiorname[100],
    Float:IntXpos,
    Float:IntYpos,
    Float:IntZpos,
    interiorid,
    pass[400],
    SqlID,
    Text3D:Doortext,
    Hsaleprice,
    Hrentprice,
    bool:Hrented,
    bool:Hsale

}
new HouseInfo[MAX_HOUSES][Hinfo];

enum InteriorInfo
{
    InteriorName[100],
    InteriorID,
    Float:InteriorX,
    Float:InteriorY,
    Float:InteriorZ,
	UID
}


//arrays

new MapIcons[][IconsInfo] =
{
	{1, -2672.3062,260.3582,4.6328, 14, 0},
	{2, -2625.1279,211.0532,4.6379, 6, 0},
	{3, -2569.8640,244.8265,10.1505, 7, 0},
	{4, -1911.8213,831.1151,35.1749, 10, 0},
	{5, -1806.8922,943.1697,24.8915, 29, 0},
 	{6, -2332.5122,-167.6378,35.5547, 10, 0},
	{7, -2648.7676,625.9666,14.4531, 22, 0},
	{8, -2267.5876,-154.7548,35.3203, 54, 0},
	{9, -2493.7827,-29.5148,25.7656, 45, 0},
	{10, -2245.1411,-88.3401,36.3377, 49, 0},
	{11, -2493.4409,-39.3892,25.7656, 39, 0},
	{12, -2714.6047,217.2768,4.2957, 27, 0},
	{13, -2553.3040,193.2317,6.1514, 48, 0},
	{14, -1605.5450,711.4048,13.8672, 30, 0},
	{15, -1886.2000,862.4730,35.1719, 45, 0},
	{16, -1698.6287,950.0814,24.8906, 45, 0},
	{17, -1754.1758,962.8541,24.8828, 32, 0},
	{18, -2047.1050,456.4027,35.1719, 52, 0},
	{19, -1904.4305,277.4406,41.0469, 63, 0},
	{20, -1974.6096,293.3269,35.1719, 55, 0},
	{21, -2023.1322,79.7627,28.1035, 20, 0},
	{22, -1815.9147,617.2796,35.1719, 14, 0},
	{23, -2376.9775,909.4905,45.4453, 45, 0},
	{24, -2378.4629,910.0603,45.4453, 45, 0},
	{25, -2360.5127,1007.7167,50.2666, 10, 0},
	{26, 2308.9724,-1645.0209,14.8270, 49, 0},
	{27, 2244.4797,-1664.3837,15.4766, 45, 0},
	{28, 2229.1326,-1722.1294,13.5625, 54, 0},
	{29, 2398.0269,-1897.4221,13.5469, 14, 0},
	{30, 2400.3484,-1980.2557,13.5469, 18, 0},
	{31, 2644.7324,-2038.8052,13.5500, 27, 0},
	{32, 2068.6638,-1778.8785,13.5596, 39, 0},
	{33, 2070.7095,-1795.2527,13.5533, 7, 0},
	{34, 2104.3325,-1806.4725,13.5547, 29, 0},
	{35, 1832.4546,-1843.3956,13.5781, 38, 0},
	{36, 1835.5005,-1681.7039,13.3871, 48, 0},
	{37, 1552.4500,-1674.9900,16.1953, 30, 0},
	{38, 2131.8159,-1151.2303,24.0703, 55, 0},
	{39, 1458.7700,-1140.0200,24.0692, 45, 0},
	{40, 1365.3500,-1279.0601,13.5469, 18, 0},
	{41, 1172.6821,-1323.4216,15.4021, 22, 0},
	{42, 1038.1914,-1340.7318,13.7423, 17, 0},
	{43, 1041.3888,-1027.0856,32.1016, 27, 0},
	{44, 1025.1978,-1029.2343,32.1016, 63, 0},
	{45, 1199.1300,-920.5710,43.0292, 10, 0},
	{46, 998.8726,-920.0972,42.1797, 38, 0},
	{47, 926.5330,-1352.6971,13.3766, 14, 0},
	{48, 822.4584,-1590.0729,13.5545, 7, 0},
	{49, 812.9810,-1616.1400,13.5469, 10, 0},
	{50, 488.2863,-1735.5543,11.1378, 63, 0},
	{51, 453.1553,-1478.3121,30.8133, 45, 0},
	{52, 459.9349,-1500.2183,31.0618, 45, 0},
	{53, 501.7810,-1358.5000,16.1252, 45, 0}
};

new Interiors [][InteriorInfo] =
{
    {"Ammunation 1", 1, 286.148986,-40.644397,1001.515625, 0},
    {"Ammunation 2", 4, 286.800994,-82.547599,1001.515625, 1},
    {"Ammunation 3", 6, 296.919982,-108.071998,1001.515625, 2},
    {"Ammunation 4", 7, 314.820983,-141.431991,999.601562, 3},
    {"Ammunation 5", 6, 316.524993,-167.706985,999.593750, 4},
    {"Ammunation booths", 7, 302.292877,-143.139099,1004.062500, 5},
    {"Ammunation range", 7, 298.507934,-141.647048,1004.054748, 6},
    {"Budget inn motel room", 12, 444.646911,508.239044,1001.419494, 7},
    {"Jefferson motel", 15, 2215.454833,-1147.475585,1025.796875, 8},
    {"Off track betting shop", 3, 833.269775,10.588416,1004.179687, 9},
    {"Sex shop", 3, -103.559165,-24.225606,1000.718750, 10},
    {"Meat factory", 1, 963.418762,2108.292480,1011.030273, 11},
    {"Zeros RC shop", 6, -2240.468505,137.060440,1035.414062, 12},
    {"Club", 17, 493.390991,-22.722799,1000.679687, 13},
    {"Bar", 11, 501.980987,-69.150199,998.757812, 14},
    {"Lil probe inn", 18, -227.027999,1401.229980,27.765625, 15},
    {"Denise room", 1, 244.411987,305.032989,999.148437, 16},
    {"Katie room", 2, 271.884979,306.631988,999.148437, 17},
    {"Helena room", 3, 291.282989,310.031982,999.148437, 18},
    {"Michelle room", 4, 302.180999,300.722991,999.148437, 19},
    {"Barbara room", 5, 322.197998,302.497985,999.148437, 20},
    {"Millie room", 6, 346.870025,309.259033,999.155700, 21},
    {"Cjs house", 3, 2496.049804,-1695.238159,1014.742187, 22},
    {"Madd Doggs mansion", 5, 1267.663208,-781.323242,1091.906250, 23},
    {"Crack factory", 2, 2543.462646,-1308.379882,1026.728393, 24},
    {"Strip club", 3, 1212.019897,-28.663099,1000.953125, 25},
    {"Tiger skin brothel", 3, 964.106994,-53.205497,1001.124572},
    {"Pleasure domes", 3, -2640.762939,1406.682006,906.460937},
    {"Liberty city inside", 1, -794.806396,497.738037,1376.195312},
    {"Gang house", 5, 2350.339843,-1181.649902,1027.976562},
    {"Colonel Furhbergers", 8, 2807.619873,-1171.899902,1025.570312},
    {"Crack den", 5, 318.564971,1118.209960,1083.882812},
    {"Warehouse 1", 1, 1412.639892,-1.787510,1000.924377},
    {"Warehouse 2", 18, 1302.519897,-1.787510,1001.028259},
    {"Unused safe house", 12, 2324.419921,-1145.568359,1050.710083},
    {"RC Battlefield", 10, -975.975708,1060.983032,1345.671875}

};

//Vehicle names.
new VehicleNames[212][] = {	// Vehicle Names - Betamaster
	{"Landstalker"},
	{"Bravura"},
	{"Buffalo"},
	{"Linerunner"},
	{"Perrenial"},
	{"Sentinel"},
	{"Dumper"},
	{"Firetruck"},
	{"Trashmaster"},
	{"Stretch"},
	{"Manana"},
	{"Infernus"},
	{"Voodoo"},
	{"Pony"},
	{"Mule"},
	{"Cheetah"},
	{"Ambulance"},
	{"Leviathan"},
	{"Moonbeam"},
	{"Esperanto"},
	{"Taxi"},
	{"Washington"},
	{"Bobcat"},
	{"Mr Whoopee"},
	{"BF Injection"},
	{"Hunter"},
	{"Premier"},
	{"Enforcer"},
	{"Securicar"},
	{"Banshee"},
	{"Predator"},
	{"Bus"},
	{"Rhino"},
	{"Barracks"},
	{"Hotknife"},
	{"Trailer 1"}, //artict1
	{"Previon"},
	{"Coach"},
	{"Cabbie"},
	{"Stallion"},
	{"Rumpo"},
	{"RC Bandit"},
	{"Romero"},
	{"Packer"},
	{"Monster"},
	{"Admiral"},
	{"Squalo"},
	{"Seasparrow"},
	{"Pizzaboy"},
	{"Tram"},
	{"Trailer 2"}, //artict2
	{"Turismo"},
	{"Speeder"},
	{"Reefer"},
	{"Tropic"},
	{"Flatbed"},
	{"Yankee"},
	{"Caddy"},
	{"Solair"},
	{"Berkley's RC Van"},
	{"Skimmer"},
	{"PCJ-600"},
	{"Faggio"},
	{"Freeway"},
	{"RC Baron"},
	{"RC Raider"},
	{"Glendale"},
	{"Oceanic"},
	{"Sanchez"},
	{"Sparrow"},
	{"Patriot"},
	{"Quad"},
	{"Coastguard"},
	{"Dinghy"},
	{"Hermes"},
	{"Sabre"},
	{"Rustler"},
	{"ZR-350"},
	{"Walton"},
	{"Regina"},
	{"Comet"},
	{"BMX"},
	{"Burrito"},
	{"Camper"},
	{"Marquis"},
	{"Baggage"},
	{"Dozer"},
	{"Maverick"},
	{"News Chopper"},
	{"Rancher"},
	{"FBI Rancher"},
	{"Virgo"},
	{"Greenwood"},
	{"Jetmax"},
	{"Hotring"},
	{"Sandking"},
	{"Blista Compact"},
	{"Police Maverick"},
	{"Boxville"},
	{"Benson"},
	{"Mesa"},
	{"RC Goblin"},
	{"Hotring Racer A"}, //hotrina
	{"Hotring Racer B"}, //hotrinb
	{"Bloodring Banger"},
	{"Rancher"},
	{"Super GT"},
	{"Elegant"},
	{"Journey"},
	{"Bike"},
	{"Mountain Bike"},
	{"Beagle"},
	{"Cropdust"},
	{"Stunt"},
	{"Tanker"}, //petro
	{"Roadtrain"},
	{"Nebula"},
	{"Majestic"},
	{"Buccaneer"},
	{"Shamal"},
	{"Hydra"},
	{"FCR-900"},
	{"NRG-500"},
	{"HPV1000"},
	{"Cement Truck"},
	{"Tow Truck"},
	{"Fortune"},
	{"Cadrona"},
	{"FBI Truck"},
	{"Willard"},
	{"Forklift"},
	{"Tractor"},
	{"Combine"},
	{"Feltzer"},
	{"Remington"},
	{"Slamvan"},
	{"Blade"},
	{"Freight"},
	{"Streak"},
	{"Vortex"},
	{"Vincent"},
	{"Bullet"},
	{"Clover"},
	{"Sadler"},
	{"Firetruck LA"}, //firela
	{"Hustler"},
	{"Intruder"},
	{"Primo"},
	{"Cargobob"},
	{"Tampa"},
	{"Sunrise"},
	{"Merit"},
	{"Utility"},
	{"Nevada"},
	{"Yosemite"},
	{"Windsor"},
	{"Monster A"}, //monstera
	{"Monster B"}, //monsterb
	{"Uranus"},
	{"Jester"},
	{"Sultan"},
	{"Stratum"},
	{"Elegy"},
	{"Raindance"},
	{"RC Tiger"},
	{"Flash"},
	{"Tahoma"},
	{"Savanna"},
	{"Bandito"},
	{"Freight Flat"}, //freiflat
	{"Streak Carriage"}, //streakc
	{"Kart"},
	{"Mower"},
	{"Duneride"},
	{"Sweeper"},
	{"Broadway"},
	{"Tornado"},
	{"AT-400"},
	{"DFT-30"},
	{"Huntley"},
	{"Stafford"},
	{"BF-400"},
	{"Newsvan"},
	{"Tug"},
	{"Trailer 3"}, //petrotr
	{"Emperor"},
	{"Wayfarer"},
	{"Euros"},
	{"Hotdog"},
	{"Club"},
	{"Freight Carriage"}, //freibox
	{"Trailer 3"}, //artict3
	{"Andromada"},
	{"Dodo"},
	{"RC Cam"},
	{"Launch"},
	{"Police Car (LSPD)"},
	{"Police Car (SFPD)"},
	{"Police Car (LVPD)"},
	{"Police Ranger"},
	{"Picador"},
	{"S.W.A.T. Van"},
	{"Alpha"},
	{"Phoenix"},
	{"Glendale"},
	{"Sadler"},
	{"Luggage Trailer A"}, //bagboxa
	{"Luggage Trailer B"}, //bagboxb
	{"Stair Trailer"}, //tugstair
	{"Boxville"},
	{"Farm Plow"}, //farmtr1
	{"Utility Trailer"} //utiltr1
};

//Weapon names.
new WeaponNames[][32] = {
	{"Unarmed (Fist)"}, // 0
	{"Brass Knuckles"}, // 1
	{"Golf Club"}, // 2
	{"Night Stick"}, // 3
	{"Knife"}, // 4
	{"Baseball Bat"}, // 5
	{"Shovel"}, // 6
	{"Pool Cue"}, // 7
	{"Katana"}, // 8
	{"Chainsaw"}, // 9
	{"Purple Dildo"}, // 10
	{"Big White Vibrator"}, // 11
	{"Medium White Vibrator"}, // 12
	{"Small White Vibrator"}, // 13
	{"Flowers"}, // 14
	{"Cane"}, // 15
	{"Grenade"}, // 16
	{"Teargas"}, // 17
	{"Molotov"}, // 18
	{" "}, // 19
	{" "}, // 20
	{" "}, // 21
	{"Colt 45"}, // 22
	{"Colt 45 (Silenced)"}, // 23
	{"Desert Eagle"}, // 24
	{"Normal Shotgun"}, // 25
	{"Sawnoff Shotgun"}, // 26
	{"Combat Shotgun"}, // 27
	{"Micro Uzi (Mac 10)"}, // 28
	{"MP5"}, // 29
	{"AK47"}, // 30
	{"M4"}, // 31
	{"Tec9"}, // 32
	{"Country Rifle"}, // 33
	{"Sniper Rifle"}, // 34
	{"Rocket Launcher"}, // 35
	{"Heat-Seeking Rocket Launcher"}, // 36
	{"Flamethrower"}, // 37
	{"Minigun"}, // 38
	{"Satchel Charge"}, // 39
	{"Detonator"}, // 40
	{"Spray Can"}, // 41
	{"Fire Extinguisher"}, // 42
	{"Camera"}, // 43
	{"Night Vision Goggles"}, // 44
	{"Infrared Vision Goggles"}, // 45
	{"Parachute"}, // 46
	{"Fake Pistol"} // 47
};

new RobberyPlaces[][RobberyInfo] =
{
	{-2243.441162, -87.855560, 35.320312, "Bar", "Garcia", 0},
	{-2336.500732, -166.524215, 35.554687, "Burger Shot", "Garcia", 1},
	{-2492.693359, -39.729656, 25.765625, "Tatoo Parlour", "Hashbury", 2},
	{-2492.724121, -29.981319, 25.765625, "Suburban", "Hashbury", 3},
	{-2551.970703, 192.993316, 6.133697, "Club", "Queens", 4},
	{-2570.814697, 245.580566, 10.031362, "Barber", "Queens", 5},
	{-2671.472900, 259.039459, 4.632812, "Cluckin bell", "Ocean Flats", 6},
	{-2376.434082, 910.253967, 45.445312, "Binco", "Juniper Hill", 7},
	{-2357.515136, 1007.331298, 50.898437, "Burger Shot", "Juniper Hollow", 8},
	{-1722.123413, 1359.441406, 7.187500, "Well stacked pizza", "Esplanade North", 9},
	{-1815.215820, 617.756958, 35.171875, "Cluckin bell", "Downtown", 10},
	{-1911.334594, 829.051391, 35.171875, "Burger shot", "Downtown", 11},
	{-1884.788696, 863.695068, 35.171875, "Zip", "Downtown", 12},
	{-1807.786376, 945.479064, 24.890625, "Well stacked pizza", "Financial", 13},
	{-1695.664184, 952.249877, 24.890625, "Victim", "Downtown", 14},
	{453.450897, -1477.923461, 30.805128, "Didier sachs", "Rodeo", 15},
	{460.776763, -1500.236572, 31.063129, "Victim", "Rodeo", 16},
	{499.142761, -1358.869750, 16.368772, "Prolaps", "Rodeo", 17},
	{927.508972, -1352.553710, 13.343750, "Cluckin bell", "Market", 18},
	{812.524780, -1616.044799, 13.546875, "Burger shot", "Marina", 19},
	{1200.162109, -919.456481, 43.107227, "Burger shot", "Temple", 20},
	{1836.271972, -1681.903076, 13.354892, "Club", "Idlewood", 21},
	{2069.432128, -1779.512573, 13.559209, "Tatoo parlour", "Idlewood", 22},
	{2071.052246, -1793.247802, 13.553277, "Barber", "Idlewood", 23},
	{2104.762207, -1806.413574, 13.554687, "Well stacked pizza", "Idlewood", 24},
	{2309.944091, -1644.365478, 14.827047, "Bar", "Gangton", 25},
	{2397.644042, -1898.979980, 13.546875, "Cluckin bell", "Willowfield", 26},
	{2636.535156, 1849.739013, 11.023437, "Well stacked pizza", "Starfish Casino", 27},
	{2572.141357, 1904.490234, 11.023437, "Zip", "Starfish Casino", 28},
	{2636.221191, 1671.494995, 11.023437, "Cluckin bell", "Pilgrim", 29},
	{2393.320312, 2042.018066, 10.820312, "Cluckin bell", "Old Venturas Strip", 30},
	{2365.962646, 2071.232666, 10.820312, "Burger shot", "Old Venturas Strip", 31},
	{2441.323730, 2064.939453, 10.820312, "Bar", "Old Venturas Strip", 31},
	{2472.334472, 2033.855712, 11.062500, "24/7", "Old Venturas Strip", 32},
	{2169.562255, 2794.784667, 10.820312, "Burger shot", "Spinybed", 33},
	{2103.188964, 2257.679443, 11.023437, "Binco", "The Emerald Isle", 34},
	{2103.185058, 2229.213623, 11.023437, "Cluckin bell", "The Emerald Isle", 35},
	{2091.227050, 2223.587402, 11.023437, "Zip", "The Emerald Isle", 36},
	{2082.933593, 2223.645507, 11.023437, "Well stacked pizza", "The Emerald Isle", 37},
	{2094.881103, 2121.600585, 10.820312, "Sex shop", "Redsands East", 38},
	{1158.944824, 2072.181152, 11.062500, "Burger shot", "Whitewood Estates", 39},
	{2825.268798, 2406.491943, 11.062500, "Pro laps", "Creek", 40},
	{2802.411132, 2429.613037, 11.062500, "Well stacked pizza", "Creek", 41},
	{2779.427001, 2452.311767, 11.062500, "Suburban", "Creek", 42},
	{2756.015625, 2475.869628, 11.062500, "Victim", "Creek", 43},
	{2839.374511, 2406.833984, 11.068956, "Cluckin bell", "Creek", 44},
	{2244.276367, -1664.630371, 15.476562, "Binco", "Gangton", 45}

};

//functions

IsPlayerInRobberyCheckpoint(playerid) {

	for(new i = 0; i <= 13; i++) {
	    if(IsPlayerInDynamicCP(playerid, checkpoints[i])) return true;
	}

	return false;
}

GetInteriorName(intname[])
{
    new name[128];
    for(new i = 0;i < 47;i++)
    {
        if(strfind(Interiors[i][InteriorName], intname, true) != -1) {
            format(name,128,"%s", Interiors[i][InteriorName]);
            break;
        }
    }
    return name;
}

HouseGetFreeSlot()
{
    for(new i = 0; i < MAX_HOUSES; i++)
    {
        if(!HCreated[i]) return i;
    }

    return -1;
}


GetInteriorNameRow(intname[])
{
    for(new i = 0;i < 47;i++)
    {
        if(strfind(Interiors[i][InteriorName], intname, true) != -1) {
            return i;
        }
    }
    return -1;
}

IsPointInRangeOfPoint(Float:xp, Float:yp, Float:zp, Float:x2, Float:y2, Float:z2, Float:range)
{
    x2 -= xp;
    y2 -= yp;
    z2 -= zp;
    return ((x2 * x2) + (y2 * y2) + (z2 * z2)) < (range * range);
}

GetInteriorID(Float:Xp, Float:Yp, Float:Zp)
{
	for(new i = 0; i < sizeof(RobberyPlaces); i++) {
	    if(IsPointInRangeOfPoint(Xp, Yp, Zp, RobberyPlaces[i][Xpos], RobberyPlaces[i][Ypos], RobberyPlaces[i][Zpos], 2.0)) {
	        return RobberyPlaces[i][RobberyID];
	    }
	}
	return -1;
}

PlayerName(playerid)
{
	new name[24];
	GetPlayerName(playerid, name, 24);
	return name;
}

GetWeaponModelIDFromName(wname[])
{
	for(new i = 0;i < 47;i++)
	{
	    if(strfind(WeaponNames[i], wname, true) != -1)
	        return i;
	}
	return -1;
}

SetClassTextDraw(playerid, text[])
{
	PlayerTextDrawSetString(playerid, ClassSelection[playerid], text);
	PlayerTextDrawShow(playerid, ClassSelection[playerid]);
}

GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if (strfind(VehicleNames[i], vname, true) != -1)
			return i + 400;
	}
	return -1;
}

IsPlayerCivilian(playerid)
{
	if(gTeam[playerid] == CIVILIAN || gTeam[playerid] == HITMAN)
		return true;
	return false;
}

//Connect to the database
Mysql_init() {
	Gconnection = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DATABASE, MYSQL_PASSWORD);
	mysql_debug(1);
	if(mysql_ping(Gconnection) == 1) { //There was a successful connection! Lets report this.
	    printf("Connection to %s is alive and connected.", MYSQL_HOST);
	} else { //There wasnt a connection! something went wrong, better report this.
	    printf("WHOOPS! There seems to be no connection between you and the MySQL database!\n \
		Host: %s User: %s Database: %s Pass: %s", MYSQL_HOST, MYSQL_USER, MYSQL_DATABASE, MYSQL_PASSWORD);
		SendRconCommand("hostname Mysql error!"); // Set the hostname so everyone knows.
		SendRconCommand("password sfcnrrcon"); //Lets lock up the server as there are errors.
		SendRconCommand("mapname Fixing"); //Just come back leter please.
	}

	return 1;
}

IsPlayerSpamming(playerid)
{
    if((gettime() - Time[playerid])  > 2) {
		Time[playerid] = gettime();
		return 1;
	} else return 0;
}

HouseCreate(owner[], interiorname[], Float:X, Float:Y, Float:Z)
{
    new HouseID = HouseGetFreeSlot();
    new row = GetInteriorNameRow(interiorname);
	new doortext[200];
    HouseInfo[HouseID][Xpos] = X;
    HouseInfo[HouseID][Ypos] = Y;
    HouseInfo[HouseID][Zpos] = Z;
    format(HouseInfo[HouseID][Howner], 24, "%s", owner);
    HouseInfo[HouseID][Howned] = true;
    HCreated[HouseID] = true;
    HouseInfo[HouseID][HID] = CreateDynamicPickup(1273, 1, X, Y, Z, -1, -1, -1, 100.0);
    format(HouseInfo[HouseID][Interiorname], 100, "%s", GetInteriorName(interiorname));
	HouseInfo[HouseID][IntXpos] = Interiors[row][InteriorX];
	HouseInfo[HouseID][IntYpos] = Interiors[row][InteriorY];
	HouseInfo[HouseID][IntZpos] = Interiors[row][InteriorZ];
	HouseInfo[HouseID][interiorid] = Interiors[row][InteriorID];
	format(doortext, 200, "Owner:{FF0000} %s\n{FFFFFF}For rent:{FF0000} No\n{FFFFFF}For sale: {FF0000}No", HouseInfo[HouseID][Howner]);
	HouseInfo[HouseID][Doortext] = CreateDynamic3DTextLabel(doortext, -1, X, Y, Z, 30.0);
    return HouseID;
}

IsNumeric(str[])
{
	for(new i = 0; i < strlen(str); i++) {
	    if(str[i] > '9' || str[i] < '0') return 0;
	}

	return 1;
}

RandomString(strDest[], strLen = 10) {
	while(strLen--)
		strDest[strLen] = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');
}

GetXYInFrontOfPlayer(playerid, &Float:XP, &Float:YP, Float:distance)
{	// Created by Y_Less

	new Float:a;

	GetPlayerPos(playerid, XP, YP, a);
	GetPlayerFacingAngle(playerid, a);

	if (GetPlayerVehicleID(playerid)) {
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}

	XP += (distance * floatsin(-a, degrees));
	YP += (distance * floatcos(-a, degrees));
}

CommenceRobbery(playerid, storeid)
{
	if(storeid == -1) return -1;//the player isn't in a store
	if(StoreRobbed[storeid] == true) return -2;//store robbed

	foreach(Player, i) {
	    if(StoreRobbing[i] == storeid) return -3;//being robbed
	}

	StoreRobbing[playerid] = storeid;

	SendClientMessage(playerid, COLOR_ORANGE, "You are now robbing a store. Watch out for any criminals or cops!");
	return 1;
}

//Custom callbacks

public CoolDownShops(shopid)
{
	StoreRobbed[shopid] = false;
	return 1;
}

public OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
    if(StoreRobbing[playerid] != -1) {
		for(new i = 0; i <= 13;i++) {
		    if(checkpointid == checkpoints[i]) {
				StoreRobbing[playerid] = -1;
				PlayerTextDrawHide(playerid, RobberyText[playerid]);//go away textdraw
            	RobberyTime[playerid] = 16;
            	GameTextForPlayer(playerid, "~r~Robbery Failed!~n~You failed to stay in the checkpoint!", 4000, 4);
		    }
		}
	}
	return 1;
}

public OneSecTimer(playerid)
{
    if(StoreRobbing[playerid] != -1) { //currently robbing a store
        if(RobberyTime[playerid] > 0) {//still robbing
            RobberyTime[playerid]--;
            format(G_String, 128, "Attempting robbery stay in the ~r~checkpoint!~n~~w~Time Left: %d", RobberyTime[playerid]);
            PlayerTextDrawSetString(playerid, RobberyText[playerid], G_String);
            PlayerTextDrawShow(playerid, RobberyText[playerid]);

        } else {//finished robbery


			//lets see if they failed or succeeded

			Rand = random(3);

			if(Rand == 1) {//they robbed

				PlayerTextDrawHide(playerid, RobberyText[playerid]);//go away textdraw
				RobberyTime[playerid] = 16;
				StoreRobbed[PlayerRobberyID[playerid]] = true;
				SetTimerEx("CoolDownShops", 1000 * 60 * 3, false, "i", StoreRobbing[playerid]);
				StoreRobbing[playerid] = -1;
				Rand = random(50000);
				format(G_String, 128, "~g~Robbery completed!~n~$%d robbed", Rand);
				GivePlayerMoney(playerid, Rand);
				SetPlayerScore(playerid, GetPlayerScore(playerid)+1);
        		GameTextForPlayer(playerid, G_String, 3000, 4);
        		WantedLevel[playerid]+=4;
        		CallLocalFunction("OnPlayerCommitCrime", "iis", playerid, WantedLevel[playerid], "Robbed a store");
			} else if(Rand != 1) {//they failed
				WantedLevel[playerid]+=4;
				RobberyTime[playerid] = 16;
				PlayerTextDrawHide(playerid, RobberyText[playerid]);//go away textdraw
				StoreRobbing[playerid] = -1;
				StoreRobbed[PlayerRobberyID[playerid]] = true;
				SetTimerEx("CoolDownShops", 1000 * 60 * 3, false, "i", StoreRobbing[playerid]);
				CallLocalFunction("OnPlayerCommitCrime", "iis", playerid, WantedLevel[playerid], "Attempted robbery");
				GameTextForPlayer(playerid, "~r~Robbery failed!", 3000, 4);
				SendClientMessage(playerid, COLOR_ORANGE, "You have failed this robbery!");
			}
        }
    }
    
	return 1;
}

public OnPlayerRequestLoginRegister(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, Gconnection);

	if(rows != 0) { // query returned no rows = player is not registered
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FF0000}[Epanetrics Universe]{FFFFFF} You are registered!", "{FFFFFF}Please enter a password to login to your account", "Ok", "Quit");

	} else { // query returned 1 row = player is registered.
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "{FF0000}[Epanetrics Universe]{FFFFFF} You are not registered!", "{FFFFFF}Please enter a password to register an account with us", "Ok", "Quit");

	}

	return 1;
}

public Mysql_Register(playerid, password[])
{
	format(PlayerInfo[playerid][Ppassword], 24, password);
	mysql_real_escape_string(PlayerName(playerid), PlayerName(playerid), Gconnection);

	new hashedpass[429], salt[100];
	new Year, Month, Day;
	getdate(Year, Month, Day);
	RandomString(salt, 100);
	mysql_real_escape_string(password, password, Gconnection);
	format(hashedpass, 429, "%s%s", salt, password);

	for(new i = 0; i < 50; i++)
		WP_Hash(hashedpass, 429, hashedpass);



	new Query[600];
	format(Query, 600, "INSERT INTO `users` (username, password, regdate, salt) VALUES ('%s', '%s', '%02d/%02d/%d', '%s')", PlayerName(playerid), hashedpass, Day, Month, Year, salt);

	mysql_function_query(Gconnection, Query, true, "OnPlayerRegister", "d", playerid);


	return 1;
}

public Mysql_Login(playerid, password[])
{
	new rows, fields;
	cache_get_data(rows, fields, Gconnection);
	if(rows) {
		new HashedPass[429], temp[100], Query[600];
		mysql_real_escape_string(PlayerName(playerid), PlayerName(playerid), Gconnection);
		cache_get_field_content(0, "salt", temp);

		format(HashedPass, 429, "%s%s", temp, password);

        for(new i = 0; i < 50; i++)
			WP_Hash(HashedPass, 429, HashedPass);

		format(Query, 600, "SELECT `score` FROM `users` WHERE `username`='%s' AND `password`='%s'", PlayerName(playerid), HashedPass);
		mysql_function_query(Gconnection, Query, true, "OnPlayerRequestLogin", "d", playerid);
	}
	return 1;
}

public OnPlayerRequestLogin(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, Gconnection);

	if(rows) {
	    new Query[500];
		format(Query, 500, "SELECT * FROM `users` WHERE `username`='%s'", PlayerName(playerid));
		mysql_function_query(Gconnection, Query, true, "OnPlayerLogin", "d", playerid);
		SendClientMessage(playerid, COLOR_GREEN, "Logged in!");
		LoggedIn[playerid] = true;
		Registed[playerid] = 1;
	} else {
	    MaxPassAttempts[playerid]++;
	    SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Wrong password!");
	    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FF0000}[SFCNR]{FFFFFF} You are registered!", "{FFFFFF}Please enter a password to register an account with us", "Ok", "Quit");
	    if(MaxPassAttempts[playerid] == 4) {
			format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF}%s has been kicked for max password attempts.", PlayerName(playerid));
			SendClientMessageToAll(COLOR_RED2, G_String);
			Kick(playerid);
	    }
	}
	return 1;
}

public OnPlayerLogin(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, Gconnection);
	if(rows) {

	    new temp[12];
	    cache_get_row(0, 4, temp); PlayerInfo[playerid][Pscore] = strval(temp);
	    cache_get_row(0, 3, temp); GivePlayerMoney(playerid, strval(temp));

		SetPlayerScore(playerid, PlayerInfo[playerid][Pscore]);

	} else {
	    printf("Oops something went wrong! callback: OnPlayerLogin Player: %s Rows: %d", PlayerName(playerid), rows);
	}
	return 1;
}

public OnPlayerRegister(playerid)
{
	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Thanks for registering at our server! Please use /commands and /help for any help you need");
	LoggedIn[playerid] = true;
	Registed[playerid] = 1;
	SendClientMessage(playerid, COLOR_GREEN, "This server is currently in BETA stages and some features may not be finished / done.");
	SendClientMessage(playerid, COLOR_GREEN, "As this server is in BETA it is subject to bugs. If you find any bugs you can report them on the forum!");
	return 1;
}


main()
{
	print("\n----------------------------------");
	print(" 	Epanetrics Gamemode Loaded!		");
	print("----------------------------------\n");
	
	printf("==========================================================");
	printf("    Gamemode created by Brennan 'thefatshizms' Butler     ");
	printf("      Please use this email if you find any problem       ");
	printf("	            with the script                     ");
	printf("       	          brennan9723@hotmail.com                  \n\n");
}


public OnGameModeInit()
{

	// mysql connect
	
	Mysql_init();
	
	//checkpoints
	checkpoints[0] = CreateDynamicCP(501.1848,-78.2146,998.7578, 2, 0, -1, -1, 100.0);//Bar rob
	checkpoints[1] = CreateDynamicCP(378.7888,-64.8880,1001.5078, 2, 0, -1, -1, 100.0);//Burger rob
	checkpoints[2] = CreateDynamicCP(-201.2298,-5.2262,1002.2734, 2, 0, -1, -1, 100.0);//Tat rob
	checkpoints[3] = CreateDynamicCP(203.5807,-40.4363,1001.8047, 2, 0, -1, -1, 100.0);//Suburban rob
	checkpoints[4] = CreateDynamicCP(502.8620,-23.7864,1000.6797, 2, 0, -1, -1, 100.0);//rob club
	checkpoints[5] = CreateDynamicCP(418.5417,-75.1641,1001.8047, 2, 0, -1, -1, 100.0);//Barber rob
	checkpoints[6] = CreateDynamicCP(371.8004,-4.3236,1001.8589, 2, 0, -1, -1, 100.0);//Clucking bell rob
	checkpoints[7] = CreateDynamicCP(207.6289,-98.3428,1005.2578, 2, 0, -1, -1, 100.0);//Binco rob
	checkpoints[8] = CreateDynamicCP(161.3155,-80.2635,1001.8047, 2, 0, -1, -1, 100.0);//Zip rob
	checkpoints[9] = CreateDynamicCP(379.1379,-116.3564,1001.4922, 2, 0, -1, -1, 100.0);//Pizza rob
	checkpoints[10] = CreateDynamicCP(204.8533,-8.0930,1001.2109, 2, 0, -1, -1, 100.0);//Victim rob
	checkpoints[11] = CreateDynamicCP(204.1348,-157.5937,1000.5234, 2, 0, -1, -1, 100.0);//Didier rob
	checkpoints[12] = CreateDynamicCP(207.0713,-127.3425,1003.5078, 2, 0, -1, -1, 100.0);//Pro laps rob
	checkpoints[13] = CreateDynamicCP(414.3527,-10.8976,1001.8120, 2, 0, -1, -1, 100.0);//Barber2 rob
	checkpoints[14] = CreateDynamicCP(252.6888,68.8171,1003.6406, 2, 0, -1, -1, 100.0);//Police checkpoint
	checkpoints[15] = CreateDynamicCP(328.1127,-1512.3765,36.0325, 2, 0, -1, -1, 100.0);//enter fbi
	checkpoints[16] = CreateDynamicCP(1122.7065,-2037.0029,69.8942, 2, 0, -1, -1, 100.0);//enter whitehouse
	
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 501.1848,-78.2146,998.7578, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 378.7888,-64.8880,1001.5078, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, -201.2298,-5.2262,1002.2734, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 203.5807,-40.4363,1001.8047, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 502.8620,-23.7864,1000.6797, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 418.5417,-75.1641,1001.8047, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 371.8004,-4.3236,1001.8589, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 207.6289,-98.3428,1005.2578, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 161.3155,-80.2635,1001.8047, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 379.1379,-116.3564,1001.4922, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 204.8533,-8.0930,1001.2109, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 204.1348,-157.5937,1000.5234, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 207.0713,-127.3425,1003.5078, 30.0);
	CreateDynamic3DTextLabel("/robstore to rob this store", COLOR_WHITE, 414.3527,-10.8976,1001.8120, 30.0);

	SetGameModeText(SERVER_NAME);
	SendRconCommand("hostname Epanetrics Universe");
	SendRconCommand("mapname Los Santos");
	AddPlayerClass(0,2499.6289,-1668.4694,13.3504,85.9861,0,0,0,0,0,0);
    AddPlayerClass(220,-1985.3322,137.4805,27.6875,88.6009,0,0,0,0,0,0);//Civilian
	AddPlayerClass(147,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//Civilian
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
    AddPlayerClass(202,-1547.2676,126.4054,3.5547,137.0018,0,0,0,0,0,0);//civilian
    AddPlayerClass(223,-1712.3699,7.4375,3.5547,316.8104,0,0,0,0,0,0);//civilian
    AddPlayerClass(158,-1712.3699,7.4375,3.5547,316.8104,0,0,0,0,0,0);//civilian
	UsePlayerPedAnims();
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1946.5139,-1377.5527,18.5781);
	SetPlayerCameraPos(playerid, 1942.1672,-1380.6217,18.4928);
	SetPlayerCameraLookAt(playerid, 1946.5139,-1377.5527,18.5781);
	SetPlayerFacingAngle(playerid, -230);
	
	//mysql
	if(!LoggedIn[playerid]) {
	    new Query[500];
		format(Query, 500, "SELECT `username` FROM `users` WHERE `username`='%s'", PlayerName(playerid));
		mysql_function_query(Gconnection, Query, true, "OnPlayerRequestLoginRegister", "d", playerid);

	}
	
	switch(classid)
	{
	    case 0..112:
	    {
	        SetClassTextDraw(playerid, "Civilian");
	    }
	    case 113:
	    {
	        SetClassTextDraw(playerid, "Mechanic");
		}
		case 114:
		{
		    SetClassTextDraw(playerid, "Medic");
		}
		case 115..116:
		{
		    SetClassTextDraw(playerid, "ARMY");
		}
		case 117:
		{
		    SetClassTextDraw(playerid, "SWAT");
		}
		case 118:
		{
		    SetClassTextDraw(playerid, "Pizza Boy");
		}
		case 119..128:
		{
		    SetClassTextDraw(playerid, "Police Officer");
		}
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
  
  	// Player textdraws are created here
  	
	ClassSelection[playerid] = CreatePlayerTextDraw(playerid, 322.000000, 289.000000, "Civilian");
	PlayerTextDrawAlignment(playerid, ClassSelection[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, ClassSelection[playerid], 255);
	PlayerTextDrawFont(playerid, ClassSelection[playerid], 1);
	PlayerTextDrawLetterSize(playerid, ClassSelection[playerid], 0.609999, 1.600000);
	PlayerTextDrawColor(playerid, ClassSelection[playerid], -1);
	PlayerTextDrawSetOutline(playerid, ClassSelection[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ClassSelection[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, ClassSelection[playerid], 0);

    RobberyText[playerid] = CreatePlayerTextDraw(playerid, 322.000000, 143.000000, "Attempting robbery stay in the checkpoint!~n~Time Left: 10");
	PlayerTextDrawAlignment(playerid, RobberyText[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, RobberyText[playerid], 255);
	PlayerTextDrawFont(playerid, RobberyText[playerid], 3);
	PlayerTextDrawLetterSize(playerid, RobberyText[playerid], 0.649999, 3.299998);
	PlayerTextDrawColor(playerid, RobberyText[playerid], -1);
	PlayerTextDrawSetOutline(playerid, RobberyText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RobberyText[playerid], 1);
	
	format(G_String, 128, "%s has joined %s", PlayerName(playerid), SERVER_NAME);
	SendClientMessageToAll(COLOR_GREY, G_String);
	
	OneSec[playerid] = SetTimerEx("OneSecTimer", 1000, true, "i", playerid);
	StoreRobbing[playerid] = -1;
	PlayerRobberyID[playerid] = -1;
	SetPlayerColor(playerid, COLOR_WHITE);
	//Map icons.
	for(new i = 0;i <sizeof(MapIcons);i++) SetPlayerMapIcon(playerid, MapIcons[i][iconid], MapIcons[i][x], MapIcons[i][y], MapIcons[i][z], MapIcons[i][type], MapIcons[i][colour], MAPICON_LOCAL);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    switch(reason)
    {
        case 0: format(G_String, 128, "%s left the server. (Timed out)", PlayerName(playerid));
        case 1: format(G_String, 128, "%s left the server. (Leaving)", PlayerName(playerid));
        case 2: format(G_String, 128, "%s left the server. (Kicked/Banned)", PlayerName(playerid));
    }
    SendClientMessageToAll(COLOR_GREY, G_String);
    LoggedIn[playerid] = false;
    KillTimer(OneSec[playerid]);
    
    if(Registed[playerid] == 1) {

	    new Query[300];
	    format(Query, 300, "UPDATE `users` SET `score`='%d', `admin`='%d', `money`='%d' WHERE `username`='%s'", GetPlayerScore(playerid), PlayerInfo[playerid][Padmin], GetPlayerMoney(playerid), PlayerName(playerid));
	    mysql_function_query(Gconnection, Query, false, "", "");
	}
	
	return 1;
}

public OnPlayerSpawn(playerid)
{
	//So the player doesn't see the class selection textdraw
	PlayerTextDrawHide(playerid, ClassSelection[playerid]);
	
	gTeam[playerid] = CIVILIAN;
	Spawned[playerid] = 1;
	
	SetPlayerPos(playerid, 2499.6289,-1668.4694,13.3504);
	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(checkpointid == 15) {
	    SetPlayerPos(playerid, 384.808624,173.804992,1008.382812);
	    SetPlayerInterior(playerid, 3);
	}
	if(checkpointid == 14) {
	    ShowPlayerDialog(playerid, DIALOG_COPDIALOG, DIALOG_STYLE_LIST, "Police CP", "Join the police\nInformation", "Select", "Cancel");
	}
	if(checkpointid == 16) {
	    SetPlayerPos(playerid, 2324.419921,-1145.568359,1050.710083);
	    SetPlayerInterior(playerid, 12);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
    new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	new id = GetInteriorID(pos[0], pos[1], pos[2]);
	if(PlayerRobberyID[playerid] == -1) {
		PlayerRobberyID[playerid] = id;
	} else {
	    PlayerRobberyID[playerid] = -1;
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_LOGIN:
	    {
	        if(!response) return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FF0000}[SFCNR]{FFFFFF} You are registered!", "{FFFFFF}Please enter a password to login to your account", "Ok", "Quit");
			new Query[200];
			mysql_real_escape_string(inputtext, inputtext, Gconnection);
			format(Query, 200, "SELECT `salt` FROM `users` WHERE `username`='%s'", PlayerName(playerid));
			mysql_function_query(Gconnection, Query, true, "Mysql_Login", "ds", playerid, inputtext);
	    }
	    case DIALOG_REGISTER:
	    {
	        if(!response) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "{FF0000}[SFCNR]{FFFFFF} You are not registered!", "{FFFFFF}Please enter a password to register an account with us", "Ok", "Quit");
			Mysql_Register(playerid, inputtext);
	    }
	    case DIALOG_COPDIALOG:
	    {
			if(!response) return 0;
			switch(listitem)
			{
			    case 0:
			    {
			        SetPlayerSkin(playerid, 280);
			        gTeam[playerid] = POLICE;
			    }
			    case 1:
			    {
			    
			    }
			}
		}
	}
	return 1;
}

CMD:die(playerid, params[])
{
	SetPlayerHealth(playerid, 0.0);
	return 1;
}

//robbery command
CMD:robstore(playerid, params[])
{
	if(!IsPlayerCivilian(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Law enforcements are not allowed to rob stores.");
	if(!IsPlayerInRobberyCheckpoint(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the store and in the checkpoint to use this command.");
	new rob = CommenceRobbery(playerid, PlayerRobberyID[playerid]);
	if(rob == -2) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This store has already been robbed.");
	if(rob == -3) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot rob this store while it's being robbed.");
	return 1;
}

//------------------------------------------------
//Admin Commands

// Set admins level
CMD:setlvl(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return 0;
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
	new id, lvl;
	if(sscanf(params,"ui",id,lvl)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} Usage: /setlvl <id> <level>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(lvl < 0 || lvl > 4) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} Available levels: 1-4");
	if(PlayerInfo[id][Padmin] == lvl) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is already that admin level.");
	if(lvl < PlayerInfo[id][Padmin]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} Use /demote to lower someones admin level");
	PlayerInfo[id][Padmin] = lvl;
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin Has promoted %s to admin level: %i", PlayerName(id), lvl);
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

// demote admin command
CMD:demote(playerid, params[])
{
    if(!IsPlayerAdmin(playerid)) return 0;
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
	new id, lvl;
	if(sscanf(params,"ui",id,lvl)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} Usage: /demote <id> <level>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(lvl > PlayerInfo[id][Padmin]) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot set this players admin level higher with this command. Use /setlvl for that.");
	PlayerInfo[id][Padmin] = lvl;
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin Has demoted %s to admin level: %i", PlayerName(id), lvl);
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

// Admin Pm
CMD:apm(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, message[128];
	if(sscanf(params,"us[128]", id, message)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /apm <id> <message>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot admin private message yourself.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "Admin PM : %s", message);
	SendClientMessage(id, COLOR_BLUE1, G_String);
	SendClientMessage(playerid, COLOR_BLUE1, G_String);

	return 1;
}

// slap command
CMD:slap(playerid, params[])
{
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any command.");
	new id, Float:pos[3], reason[128];
	if(sscanf(params,"us[128]",id,reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /slap <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	GetPlayerPos(id, pos[0], pos[1], pos[2]);
	SetPlayerPos(id, pos[0], pos[1], pos[2]+10);
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has slaped %s for reason: %s",PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

// explode command
CMD:explode(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, Float:pos[3], reason[128];
	if(sscanf(params,"us[128]",id,reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /explode <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	GetPlayerPos(id, pos[0], pos[1], pos[2]);
	CreateExplosion(pos[0], pos[1], pos[2], 0, 2.0);
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has exploded %s for reason: %s", PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

// mute command
CMD:mute(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, reason[128];
	if(sscanf(params,"us[128]", id, reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /mute <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(Muted[id] == 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is already muted.");
	Muted[id] = 1;
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has muted %s for reason: %s", PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

// unmute command
CMD:unmute(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!IsNumeric(params[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /unmute <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	new id = strval(params[0]);
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(Muted[id] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is already unmuted.");
	Muted[id] = 0;
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has unmuted %s", PlayerName(id));
	SendClientMessageToAll(COLOR_RED2, G_String);

	return 1;
}

//announce command
CMD:ann(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new message[128];
	if(sscanf(params,"s[128]",message)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /ann <message>");
	GameTextForAll(message, 3000, 6);

	return 1;
}

//kick command
CMD:kick(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, reason[128];
	if(sscanf(params,"us[128]", id, reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /kick <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	//if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has kicked %s for reason: %s", PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);
	Kicked[id] = true;//Safe kick (so player sees the message)

	return 1;
}

//disarm command
CMD:disarm(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!IsNumeric(params[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /disarm <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	new id = strval(params[0]);
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has disarmed %s", PlayerName(id));
	SendClientMessageToAll(COLOR_RED2, G_String);
	ResetPlayerWeapons(id);

	return 1;
}

//freeze command
CMD:freeze(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, reason[128];
	if(sscanf(params,"us[128]", id, reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /freeze <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(Frozen[id] == 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is already frozen.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has frozen %s for reason: %s", PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);
	Frozen[id] = 1;
	TogglePlayerControllable(id, false);

	return 1;
}

//unfreeze command
CMD:unfreeze(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!IsNumeric(params[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /unfreeze <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	new id = strval(params[0]);
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(Frozen[id] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is already unfrozen.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has unfrozen %s", PlayerName(id));
	SendClientMessageToAll(COLOR_RED2, G_String);
	Frozen[id] = 0;
	TogglePlayerControllable(id, true);

	return 1;
}

// bring command
CMD:bring(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!IsNumeric(params[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /bring <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	new id = strval(params[0]), Float:pos[3];
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SetPlayerPos(id, pos[0], pos[1], pos[2]);
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} You have been teleported to %s", PlayerName(playerid));
	SendClientMessage(id, COLOR_LIGHTGREEN, G_String);

	return 1;
}

//goto command
CMD:goto(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, Float:pos[3];
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /goto <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	GetPlayerPos(id, pos[0], pos[1], pos[2]);
	SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} You have been teleported to %s", PlayerName(id));
	SendClientMessage(playerid, COLOR_LIGHTGREEN, G_String);

	return 1;
}

//skin command
CMD:skin(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id;
	if(sscanf(params,"i",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /skin <id>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(299 > id < 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Skin id's range from 0 to 299");
	SetPlayerSkin(playerid, id);
	format(G_String, 128, "[SKIN] :{FFFFFF} You have changed your skin to id %d", id);
	SendClientMessage(playerid, COLOR_RED2, G_String);

	return 1;
}

//set skin command
CMD:setskin(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, skin;
	if(sscanf(params,"ui",id, skin)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /setskin <id> <skin>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(299 > skin < 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Skin id's range from 0 to 299");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Use /skin to set your own skin.");
	SetPlayerSkin(id, skin);
	format(G_String, 128, "[SKIN] :{FFFFFF} You have changed %s skin to id %d", PlayerName(id), skin);
	SendClientMessage(playerid, COLOR_RED2, G_String);
    format(G_String, 128, "[SKIN] :{FFFFFF} Admin has set your skin to id %d", skin);
	SendClientMessage(id, COLOR_RED2, G_String);

	return 1;
}


//give cash command
CMD:givecash(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, ammount, string[2][128];
	if(sscanf(params,"ui",id,ammount)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /givecash <id> <ammount>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(ammount < 0 || ammount > 1000000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Min: 0 Max: 1 million");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Use /cash to give yourself money.");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have given %s $%i cash", PlayerName(id), ammount);
	format(string[1], 128,  "[SERVER MESSAGE] :{FFFFFF} You have been given $%i cash by Admin", ammount);
	SendClientMessage(playerid, COLOR_RED2,  string[0]);
	SendClientMessage(id, COLOR_RED2, string[1]);
	GivePlayerMoney(id, ammount);

	return 1;
}

CMD:cash(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new money;
	if(sscanf(params,"i",money)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /cash <ammount>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(5000000 > money < 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} The minimum you can give yourself is 1. The maximum you can give yourself is 5000000.");
	GivePlayerMoney(playerid, money);
	format(G_String, 128, "[CASH] :{FFFFFF} You have given youself $%d", money);
	SendClientMessage(playerid, COLOR_RED2, G_String);

	return 1;
}

// dveh command
CMD:dveh(playerid, params[])
{
 	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
 	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new vehicle = GetPlayerVehicleID(playerid);
		format(G_String, 128, "Vehicle id %i deleted", vehicle);
		SendClientMessage(playerid, COLOR_LIGHTGREEN, G_String);
	    DestroyVehicle(vehicle);
	}
	else
	{
	    for(new i = 0; i < MAX_VEHICLES;i++)
	    {
			new Float:pos[3];
			GetVehiclePos(i, pos[0], pos[1], pos[2]);
			if(IsPlayerInRangeOfPoint(playerid, 20, pos[0], pos[1], pos[2]))
			{
			    DestroyVehicle(i);
			}
		}
	}

	return 1;
}

//Get all command
CMD:getall(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	foreach(Player, i)
	{
	    SetPlayerPos(i, pos[0], pos[1], pos[2]);
 	}

	return 1;
}

// respawn all vehicles command
CMD:respawnv(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	for(new i = 0; i < MAX_VEHICLES;i++) {
		SetVehicleToRespawn(i);
	}
	SendClientMessageToAll(COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Admin has respawned all vehicles");

	return 1;
}

//warn command
CMD:warn(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, reason[128];
	if(sscanf(params, "us[128]", id, reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /warn <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	Warns[id]++;
	if(Warns[id] >= MAX_WARNS) {
	    format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF}%s has been kicked for reaching maximum ammount of warnings", PlayerName(id));
	    SendClientMessageToAll(COLOR_RED2, G_String);
	    Kick(id);
	} else {
	    format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin has warned %s for reason: %s [%i/3]", PlayerName(id), reason, Warns[id]);
	    SendClientMessageToAll(COLOR_RED2, G_String);
  	}

	return 1;
}

// reset warnings command
CMD:resetwarnings(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!IsNumeric(params[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /resetwarnings <id>");
	new id = strval(params[0]);
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(Warns[id] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has not had any warnings");
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin has reset %s warnings from %i to 0", PlayerName(id), Warns[id]);
	SendClientMessageToAll(COLOR_RED2, G_String);
	Warns[id] = 0;

	return 1;
}

//admins command
CMD:admins(playerid, params[])
{
	new count;
	SendClientMessage(playerid, COLOR_GREEN, "••  San Fierro Cops And Robbers Staff ••");
	foreach(Player, i) {
		switch(PlayerInfo[i][Padmin]) {
			case MOD: {
			    format(G_String, 128, "•  %s {FF0000} Moderator  {FFFFFF}•", PlayerName(i));
			    SendClientMessage(playerid, COLOR_WHITE, G_String);
			    count++;
			}
			case ADMIN: {
			    format(G_String, 128, "•  %s {FF0000} Admin  {FFFFFF}•", PlayerName(i));
			    SendClientMessage(playerid, COLOR_WHITE, G_String);
			    count++;
			}
			case SENIOR_ADMIN: {
			    format(G_String, 128, "•  %s {FF0000} Senior Admin  {FFFFFF}•", PlayerName(i));
			    SendClientMessage(playerid, COLOR_WHITE, G_String);
			    count++;
			}
		}
	}
	if(count == 0) return SendClientMessage(playerid, COLOR_WHITE, "[SERVER MESSAGE] {FFFFFF} There are no admins online");

	return 1;
}

//Rich list command
//Usefull to see if a player is money hacking
CMD:richlist(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	SendClientMessage(playerid, COLOR_YELLOW, "[RICH LIST] Players who have over one million cash");
	new count;
	foreach(Player, i) {
	    if(GetPlayerMoney(i) >= 1000000) {
	        format(G_String, 128, "%s || Money: %i || Score %i", PlayerName(i), GetPlayerMoney(i), GetPlayerScore(i));
	        SendClientMessage(playerid, COLOR_WHITE, G_String);
	        count++;
		}
	}
	if(count == 0) return SendClientMessage(playerid, COLOR_WHITE, "[SERVER MESSAGE] {FFFFFF} There are no players online with 1 million or more");

	return 1;
}

//Kill player command
CMD:akill(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, reason[128];
	if(sscanf(params,"us[128]",id,reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /akill <id> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has killed %s for reason: %s", PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);
	SetPlayerHealth(id, 0.0);

	return 1;
}

//warned people
CMD:warnlist(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	SendClientMessage(playerid, COLOR_YELLOW, "[WARNED LIST] Players who have been warned");
	new count;
	foreach(Player, i) {
	    if(Warns[i] >= 1) {
	        format(G_String, 128, "%s || Warns %i", PlayerName(i), Warns[i]);
	        SendClientMessage(playerid, COLOR_WHITE, G_String);
	        count++;
		}
	}
	if(count == 0) return SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF} There are no players online with warnings");

	return 1;
}

//clear chat command
CMD:clearchat(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	for(new i = 0;i < 15;i++)
	{
	    SendClientMessageToAll(COLOR_WHITE, "");
	}
	SendClientMessageToAll(COLOR_RED2, "[SERVER MESSAGE] {FFFFFF} Admin has cleared the chat");

	return 1;
}

//fine command
CMD:fine(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, money, reason[128];
	if(sscanf(params,"uis[128]",id,money,reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /fine <id> <money> <reason>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has fined %s $%i for reason: %s", PlayerName(id), money, reason);
	SendClientMessageToAll(COLOR_RED2, G_String);
	GivePlayerMoney(id, -money);

	return 1;
}

//wanted level command
CMD:setwanted(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, level;
	if(sscanf(params,"ui",id,level)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /setwanted <id> <level>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has set %s wanted level to %i", PlayerName(id), level);
	SendClientMessageToAll(COLOR_RED2, G_String);
	WantedLevel[id] = level;
	CallLocalFunction("OnPlayerCommitCrime", "iis", id, WantedLevel[id], "Admin set wanted.");

	return 1;
}

//set health command
CMD:sethealth(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, health;
	if(sscanf(params,"ui",id,health)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /sethealth <id> <health>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has set %s health to %i", PlayerName(id), health);
	SendClientMessageToAll(COLOR_RED2, G_String);
	SetPlayerHealth(id, health);

	return 1;
}

//set armour command
CMD:setarmour(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, armour;
	if(sscanf(params,"ui",id,armour)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /setarmour <id> <armour>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has set %s armour to %i", PlayerName(id), armour);
	SendClientMessageToAll(COLOR_RED2, G_String);
	SetPlayerArmour(id, armour);

	return 1;
}

//restart command
CMD:restart(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	if(PlayerInfo[playerid][Padmin] < SENIOR_ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	SendClientMessageToAll(COLOR_RED2, "[SERVER MESSAGE] {FFFFFF} Admin is restarting the server");
	GameTextForAll("~r~Restarting..", 6000, 6);
	SendRconCommand("gmx");

	return 1;
}

//v command
CMD:v(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new name[212], idx, Float:pos[4];
	if(sscanf(params,"s[212]",name)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /v <name>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    idx = GetVehicleModelIDFromName(name);
    if( idx == -1 ) {
		idx = strval(name);

		if ( idx < 400 || idx > 611 )
			return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid MODELID/NAME");
	}
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetXYInFrontOfPlayer(playerid, pos[0], pos[1], 5);
	GetPlayerFacingAngle(playerid, pos[3]);
	idx = CreateVehicle(idx, pos[0], pos[1], pos[2]+2, pos[3]-90, random(255), random(255), -1);
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} You have spawned a %s | Model %i | Vehicleid %i", VehicleNames[GetVehicleModel(idx) - 400], GetVehicleModel(idx), idx);
	SendClientMessage(playerid, COLOR_RED2, G_String);
	LinkVehicleToInterior(idx, GetPlayerInterior(playerid));
	CreatedVehicle[idx] = true;
	return 1;
}

//weapon command
CMD:weapon(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new name[17], idx;
	if(sscanf(params,"s[212]",name)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /weapon <name>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	idx = GetWeaponModelIDFromName(name);
	if(idx == -1) {
	    idx = strval(name);
	    if(idx < 0 || idx > 47 )
	        return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid MODELID/NAME");
	}
	GivePlayerWeapon(playerid, idx, 500);
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} You have spawned a %s with 500 amo", WeaponNames[idx]);
	SendClientMessage(playerid, COLOR_RED2, G_String);

	return 1;
}

//ban command
CMD:ban(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, reason[50], unban[100];
	if(sscanf(params, "us[50]s[100]", id, reason, unban)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /ban <id> <reason> <unban date>\nUnban date format: day/month/year");

	return 1;
}

//giveweapon command
CMD:giveweapon(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new name[17], idx, id, string[2][128];
	if(sscanf(params,"is[212]",id, name)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /giveweapon <id> <name>");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	idx = GetWeaponModelIDFromName(name);
	if(idx == -1) {
	    idx = strval(name);
	    if(idx < 0 || idx > 47 )
	        return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid MODELID/NAME");
	}
	GivePlayerWeapon(id, idx, 500);
	format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have given %s a %s with 500 amo", PlayerName(id), WeaponNames[idx]);
	format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} You have been given a %s with 500 amo by admin", WeaponNames[idx], PlayerName(playerid));
	SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(id, COLOR_RED2, string[1]);

	return 1;
}

CMD:setvw(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the staff team to use this command.");
	new id, vw;
	if(sscanf(params,"ui",id,vw)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /setvw <id> <virtual world>");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin has set %s virtual world to %d", PlayerName(id), vw);
	SendClientMessageToAll(COLOR_RED2, G_String);
	SetPlayerVirtualWorld(playerid, vw);

	return 1;
}

CMD:setinterior(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the staff team to use this command.");
	new id, interior;
	if(sscanf(params,"ui",id,interior)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /setinterior <id> <interiorid>");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} Admin has set %s interior id to %d", PlayerName(id), interior);
	SendClientMessageToAll(COLOR_RED2, G_String);
	SetPlayerInterior(playerid, interior);
	return 1;
}

CMD:chouse(playerid, params[])
{
    if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	//if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
    new owner[24], interiorName[100], Float:pos[3], Query[400], create;
    if(sscanf(params,"s[24]s[100]",owner, interiorName)) return SendClientMessage(playerid, -1, "Usage: /chouse <owner> <interior name>");
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	create = HouseCreate(owner, interiorName, pos[0], pos[1], pos[2]);
    if(create) {

	 	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} House created.");
	 	format(Query, 500, "INSERT INTO `house`(`id`, `owner`, `owned`, `interiorname`, `pass`, `Xpos`, `Ypos`, `Zpos`, `price`) VALUES (null,'%s','1','%s','','%f','%f','%f', '%d')", owner, HouseInfo[create][Interiorname], HouseInfo[create][Xpos], HouseInfo[create][Ypos], HouseInfo[create][Zpos], HouseInfo[create][Hsaleprice]);
    	mysql_function_query(Gconnection, Query, false, "OnHouseCreated", "d", create);
	}
    else SendClientMessage(playerid, COLOR_RED2, "[ERROR] Something went wrong. Make sure you enter the correct interior name, or input the whole interior name");
    return 1;
 }
