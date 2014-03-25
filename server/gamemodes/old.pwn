/*  ® San Fierro Cops And Robbers (SFCNR ™) - A SA-MP Server.
	© Brennan 'Thefatshizms' Butler ©

	Contact Email: Brennan9723@hotmail.com
	Website: http://sf-cnr.co.uk/

	Features Of San Fierro Cops And Robbers:

	Special Faction STAT:
	• Base With Slidable Gates +
	• Satalight To Spectate All Wanted Players %
	• Plant C4 (Animation and explosion) *
	• Place Road blocks *
	• Drag Command (Drags a wanted player to your vehicle) +
	• Laser Sight +
	• Road Spikes *
	• Taze Command *
	• Cuff Commmand +
	• Arrest Command *

	Special Faction S.W.A.T:
	• Base With Slidable Gates +
	• Place Road blocks *
	• Drag Command (Drags a wanted player to your vehicle) +
	• Laser Sight +
	• Taze Command *
	• Cuff Commmand +
	• Arrest Command *

	Special Faction Army:
	• Base With Slidable Gates +
	• Plant C4 (Animation and explosion) *
	• Laser Sight +
	• Taze Command *
	• Cuff Commmand +
	• Arrest Command *

	Mechanic Job:
	• Discount On Buyable Cars *
	• Can Place Bullet Proof Armour On Cars *
	• Fix Command +
	• Add Nitro Command +
	• Fix Me Command +

	Pilot Job:
	• Pilot shit around places ( including people )
	
	Taxi Job:
	• Can Change Min rate *
	• Can Change To A Privite Driver *

	Trucker Job:
	• Delivers Crap Around San Andreas *
	• Can Do A Convoy (Deliver with other people) *

	Terroist Job:
	• Can Blow Up Places *
	• Can Buy Suicide Bomb Jackets *
	• Discount On Weapons From Weapon Dealers *

	Rapist Job:
	• Can Rape People And Give Them STD's *
	• Can Choose Main STD To Infect With People %
	• When Raped By others It Gives Them An STD *

	Kidnapper Job:
	• Can Kidnapp People And Charge Them Or Others For Thier Release *
	• Spawns With 1 Piece Of Rope, Has To Buy More To Kidnapp More People *

	Pedo Job:
	• Rapist And Kidnapper Combined *

	Items Dealer Job:
	• Can Sell Many Items *
	• Can Run Out Of Items (Has to restore at a shop) *
	• Can Change What They Sell *

	Weapons Dealer Job:
	• Sells Weapons To People *
	• Can Change What They Sell *
	• Can Run Out Of Items (Has to restore at a amunation) *

	Robber Job:
	• Increased Chances In Robbing *
	• Can Rob More Than Normal People *

	Drug Dealer Job:
	• Can Sell Upto 4 Types Of Drugs +
	• Can Take Drugs And Not Get Caught  ( random )+

	Hitman Job:
	• Takes Out People On The Hit List *
	• Money Goes To Him Auto From Guy Who Placed Hit *

	ParaMedic Job:
	• Can Heal People +
	• Can Sell Medical Supplys +

	Police Job:
	• Taze Command *
	• Cuff Commmand +
	• Arrest Command *

	Mayor Job:
	• Admin Assign +
	• Can Change Tax *
	• Can Tax Everyone *

	Car System:
	• Buy A Car ( Assigned to your name ) *
	• Sell The Car Back *
	• Save Any Mods The Car Has *
	• Load Any Mods The Car Has *

	House System:
	• Can Make A House In-Game *
	• Can Be Rented To The Public *
	• Buy House Insurance *
	• Store Money And Items In The House *
	• Buy Furniture From A Sale Place *

	Business System:
	• Gaing Income *
	• Add/Remove Items To Be Sold *
	• Can Be Sold *

	24/7 System Items:
	• Condom *
	• Wallet *
	• Taze Gun *
	• Flowers *
	• ChainSaw *
	• Pistol *
	• Pizza *
	• Burger *
	• Infected Food *
	• Sprunk *

	Other:
	• Offical Groups Can Be Made And Managed In-Game *
	• Lesure Center +
	• A Prison +
	• Robbery System *
	• Pm Groups *
	• Pm System +

	88 In Total
	Done 21

	Key: + Added
		 - Taken Away
		 * Need to be done
		 % Adding in the future (AKA Not important OR Maybe)
*/


/** INCLUDES **/

#include <a_samp>

#include <sscanf2>
#include <zcmd>
#include <zones>
#include <streamer>
#include <fire>
#include <cuffs>
#include <foreach>
#include <a_mysql>
#include <../../include/gl_common>

/** DEFINES **/

#define 		SERVER_VERSION 				"SFCNR 0.1 BETA"
#define 		SERVER_PERCENTAGE 			"24%"
#define 		SERVER_NAME                 "[ALPHA]San Fierro Cops And Robbers[ALPHA]"

#define         MYSQL_HOST                  "localhost"
#define         MYSQL_USER                  "root"
#define         MYSQL_DB                    "sfcnr"
#define         MYSQL_PASS                  ""

#define			COLOR_ORANGE			0xFF8000FF
#define 		COLOR_GREY 				0xAFAFAFAA
#define 		COLOR_GREEN 			0x33AA33AA
#define 		COLOR_BLUE1 			0x0066FFFF
#define 		COLOR_LIGHTBLUE 		0x33CCFFAA
#define 		COLOR_LIGHTGREEN 		0x9ACD32AA
#define 		COLOR_YELLOW 			0xFFFF00AA
#define 		COLOR_VIP 				0xC93CCE00
#define 		COLOR_WHITE 			0xFFFFFFAA
#define 		COLOR_PURPLE 			0xC2A2DAAA
#define 		COLOR_PINK 				0xFF66FFAA
#define 		COLOR_DBLUE 			0x2641FEAA
#define 		COLOR_RED2				0xFF0000FF
#define         COLOR_FIRE              0xC11B17FF
#define         COLOR_BLACK             0x000000FF
#define         COLOR_COOLBLUE          0x00cacaFF

#undef 			MAX_PLAYERS
#define 		MAX_PLAYERS 			(50)
#define 		MAX_WARNS 				(3)
#define         MAX_PING                (800)
#define         MAX_PINGWARNING         (3)
#define         MAX_SPAMS               (3)
#define         MAX_VEHS                (1000)
#define         MAX_SPIKES              (200)

//Dialogs

#define         DIALOG_REGISTER         (0)
#define         DIALOG_LOGIN            (1)
#define         DIALOG_CLASS            (2)
#define         DIALOG_ACMDS            (3)
#define         DIALOG_CMDS             (4)
#define         DIALOG_GCMDS            (5)
#define         DIALOG_JCMDS            (6)
#define         DIALOG_VCMDS            (7)
#define         DIALOG_HELPERCMDS       (8)
#define         DIALOG_MODCMDS          (9)
#define         DIALOG_ADMINCMDS        (10)
#define         DIALOG_SENIORCMDS       (11)
#define         DIALOG_LESURE           (12)
#define         DIALOG_COPGUN           (13)
#define 		DIALOG_BUYCAR			(14)
#define			DIALOG_NUMPLATE			(15)
#define         DIALOG_DRUG             (16)
#define         DIALOG_BUYSTUFF         (17)

//Team defines

#define 		HITMAN      			(0)
#define 		CIVILIAN    			(1)
#define 		TEROIST    				(2)
#define 		STAT        			(4)
#define 		ARMY        			(3)
#define 		POLICE      			(5)
#define 		RAPIST      			(6)
#define 		MECHANIC    			(7)
#define 		MEDIC   				(8)
#define 		DRUG        			(9)
#define 		ROB        	 			(10)
#define 		WEP         			(11)
#define 		ITEMS       			(12)
#define 		KIDNAPPER   			(13)
#define 		PEDO        			(14)
#define 		TRUCKER     			(15)
#define 		TAXI        			(16)
#define 		SWAT        			(17)


//Admin Ranks

#define         HELPER                  (1)
#define         MOD                     (2)
#define         ADMIN                   (3)
#define         SENIOR_ADMIN            (4)

//Whirlpool

native WP_Hash(buffer[], len, const str[]);

/** FORWARDS **/

forward Mysql_Login(playerid, password[]);
forward Mysql_Register(playerid, password[]);
forward Mysql_Save(playerid);
forward Random_Messages();
forward UpdateSnow(playerid);
forward OneSecTimer(playerid);
forward timeupdate();
forward OnPlayerEnterKoth(playerid);
forward OnPlayerExitKoth(playerid);
forward OnPlayerEnterBusiness(playerid, bizid, isowner);
forward OnPlayerExitBusiness(playerid, bizid);

/** VARIABLES **/

// Login / register variables
new LoggedIn[MAX_PLAYERS];
new Registed[MAX_PLAYERS];
// spawned
new Spawned[MAX_PLAYERS];
// Snow Variables
new SnowTimer[MAX_PLAYERS];
new SnowObject;
// Class Variable
new gTeam[MAX_PLAYERS];
//Global random variable
new Rand;
//Global String
new G_String[128];
// Colors in chat
new pChat_Color[MAX_PLAYERS];
//Variable if they are muted
new Muted[MAX_PLAYERS];
//last pm
new LastPM[MAX_PLAYERS];
//player is frozen
new Frozen[MAX_PLAYERS];
//Warnings for a player
new Warns[MAX_PLAYERS];
//players wanted level
new WantedLevel[MAX_PLAYERS];
//Max ping
new PingWarnings[MAX_PLAYERS];
// for the clock
new Text:timetext;
new Minute = 00;
new Hour = 12;
new timestring[6];
// textdraws
new Text:Textdraw0;
new Text:Textdraw1;
new Text:Textdraw2;
new Text:Textdraw3;
new Text:Textdraw4;
new Text:Textdraw5;
new Text:Zone;
new PlayerText:Casual[MAX_PLAYERS];
// laser variable
new Laser[MAX_PLAYERS];
new TLaser[MAX_PLAYERS];
//spams variables
new PlayerSpams[MAX_PLAYERS];
new SpamTime[MAX_PLAYERS];
//for login
new MaxPassAttempts[MAX_PLAYERS];
//checkpoints and pickups
new checkpoints[100];
new pickups[100];
// leisure var
new bool:InLeisure[MAX_PLAYERS];
// car
new CurrentVeh[MAX_PLAYERS];
new lastveh[MAX_PLAYERS];
//injections
new Injections[MAX_PLAYERS];
//hits
new Hit[MAX_PLAYERS];
new HitPrice[MAX_PLAYERS];
//vehicle
new carcp;
new vehicle_creating;
new vehiclez;
//tax
new G_TAX;
//drugs
new Weed[MAX_PLAYERS];
new Heroin[MAX_PLAYERS];
new Cocaine[MAX_PLAYERS];
new WeedSeeds[MAX_PLAYERS];
//vehicles loading
new total_vehicles =0;
//Spod
new bool:HasSpod[MAX_PLAYERS];
new bool:Krose[MAX_PLAYERS];
new bool:Kdst[MAX_PLAYERS];
new bool:Rap[MAX_PLAYERS];
new bool:Rock[MAX_PLAYERS];
/** ENUM'S **/

enum PInfo
{
	Ppassword[24],
	Pusername[24],
	Padmin,
	Pmoney,
	Pscore,
	Pcop,
	Pvip,
	Pbank
}

new PlayerInfo[MAX_PLAYERS][PInfo];

enum IconsInfo
{
	iconid,
	Float:x,
	Float:y,
	Float:z,
	type,
	colour
}

enum PPosition
{
	Float:E_Old_X,
	Float:E_Old_Y,
	Float:E_Old_Z
}
new PlayerPos[MAX_PLAYERS][PPosition];

enum Veh
{
	owner[24],
	model,
	numberplate[24],
	Float:x_pos,
	Float:y_pos,
	Float:z_pos,
	value,
	pannel_damage,
	door_damage,
	light_damage,
	tire_damage,
	bool:owned,
	vehid,
}
new VehicleInfo[MAX_VEHS][Veh];

enum RoadSpikes
{
	Float:X_pos,
	Float:Y_pos,
	Float:Z_pos,
	model
}
new RoadSpike[MAX_SPIKES][RoadSpikes];
/** STOCKS **/



stock IsPlayerInRangeOfPlayer(playerid, otherplayer, Float:newrange)
{
	new Float:PP[3];
	GetPlayerPos(otherplayer, PP[0], PP[1], PP[2]);
	if(IsPlayerInRangeOfPoint(playerid, newrange, PP[0], PP[1], PP[2]))	return 1;
	return 0;
}

stock LawMSG(playerid, reason[])
{
	format(G_String, 128, "[LAW] %s has %s please go out and catch him", PlayerName(playerid), reason);
	return G_String;
}

stock IsVehiclePrivate(vehicleid)
{
	for(new i = 0;i < (MAX_VEHS); i++)
	{
	    if(VehicleInfo[i][vehid] == vehicleid)
	    {
	        return 1;
	    }
	}
	return 0;
}

stock ConvertVID(vehicleid)
{
	for(new i = 0;i < (MAX_VEHS); i++)
	{
	    if(VehicleInfo[i][vehid] == vehicleid)
	    {
	        return i;
	    }
	}
	return -1;
}

stock GetXYInFrontOfPlayer(playerid, &Float:XP, &Float:YP, Float:distance)
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

stock ShowCasualTextdraw(playerid, NewText[])
{
	PlayerTextDrawSetString(playerid, Casual[playerid], NewText);
    PlayerTextDrawShow(playerid, Casual[playerid]);
    return 1;
}

stock IsPlayerCivilianClass(playerid)
{
	if(gTeam[playerid] == CIVILIAN || gTeam[playerid] == HITMAN || gTeam[playerid] == TEROIST || gTeam[playerid] == RAPIST || gTeam[playerid] == DRUG || gTeam[playerid] == ROB || gTeam[playerid] == WEP || gTeam[playerid] == ITEMS || gTeam[playerid] == KIDNAPPER || gTeam[playerid] == PEDO) return 1;
	return 0;
}

stock IsPlayerAiming(playerid)
{
	new anim = GetPlayerAnimationIndex(playerid);
	if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) || (anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
	return 0;
}

stock ShowRules(playerid)
{
	TextDrawShowForPlayer(playerid, Text:Textdraw0);
	TextDrawShowForPlayer(playerid, Text:Textdraw1);
	TextDrawShowForPlayer(playerid, Text:Textdraw2);
	TextDrawShowForPlayer(playerid, Text:Textdraw3);
	return 1;
}

stock ShowRulesToAll()
{
    TextDrawShowForAll(Textdraw0);
	TextDrawShowForAll(Textdraw1);
	TextDrawShowForAll(Textdraw2);
	TextDrawShowForAll(Textdraw3);
	return 1;
}

stock PlayerZone(playerid)
{
    new zone[28];
    GetPlayer2DZone(playerid, zone, 28);
    return zone;
}

stock SendMessageToLaw(color, message[])
{
	foreach(Player, i)
	{
	    if(gTeam[i] == STAT || gTeam[i] == ARMY || gTeam[i] == SWAT || gTeam[i] == POLICE) return SendClientMessage(i, color, message);
	}
	return 0;
}
	    
stock ProxDetector(Float:radi, playerid, string[],color)
{
    new Float:position[3];
    GetPlayerPos(playerid,position[0],position[1],position[2]);
    foreach(Player, i)
	{
        if(IsPlayerInRangeOfPoint(i,radi,position[0],position[1],position[2]))
		{
            SendClientMessage(i,color,string);
        }
    }
}

stock ShowMainTextDraws(playerid, bool:show)
{
	if(show == true) return TextDrawShowForPlayer(playerid, Text:Textdraw5), TextDrawShowForPlayer(playerid, Text:timetext);
	else return TextDrawHideForPlayer(playerid, Text:timetext), TextDrawHideForPlayer(playerid, Text:Textdraw5);
}

stock SendMessageToAdmins(color, message[])
{
	foreach(Player, i)
	{
	    if(PlayerInfo[i][Padmin] >=1) return SendClientMessage(i, color, message);
	}
	return 0;
}

stock KickLog(playerid, kickedid, reason[])
{
	new File:file=fopen("sfcnr/kicks.txt", io_append), kick[128], year, month, day;
	getdate(year, month, day);
	format(kick, 128, "[%02d/%02d/%d] %s kicked %s for reason: %s\r\n", day, month, year, PlayerName(playerid), PlayerName(kickedid), reason);
	fwrite(file, kick);
	return fclose(file);
}

stock SendMysqlErrorLog(error[])
{
	new File:file=fopen("sfcnr/mysql_errors.txt", io_append), errorstring[128], year, month, day;
	getdate(year, month, day);
	format(errorstring, 128, "[%02d/%02d/%d] %s\r\n", day, month, year, error);
	fwrite(file, errorstring);
	return fclose(file);
}

stock PlayerName(playerid)
{
	new name[24];
	GetPlayerName(playerid, name, 24);
	return name;
}

stock BugPath(playerid)
{
	new path[100];
	format(path, 100, "sfcnr/BugReport_%s.ini", PlayerName(playerid));
	return path;
}

stock ShowLoginDialog(playerid)
{
    new string[2][128];
    format(string[0], 128, "{FF0000}[SFCNR]{FFFFFF} Your Account {FF0000}Is {FFFFFF} %s !", PlayerName(playerid));
    format(string[1], 128, "{FFFFFF}Hello %s your account {FF0000}was found in our database {FFFFFF}please input your account password", PlayerName(playerid));
    return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, string[0], string[1], "Ok", "Quit");
}

stock ShowRegisterDialog(playerid)
{
    new string[2][128];
    format(string[0], 128, "{FF0000}[SFCNR]{FFFFFF} Your Account {FF0000}Is Not {FFFFFF}Registered %s !", PlayerName(playerid));
    format(string[1], 128, "Hello %s it seems that your name was {FF0000}not{FFFFFF} found in our database, please input a password to register", PlayerName(playerid));
    return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, string[0], string[1], "Ok", "Quit");
}

stock CreateSnow(playerid)
{
	new Float:pPos[3];
 	GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
  	for(new i = 0; i < 15; i++) SnowObject = CreateDynamicObject(18864, pPos[0] + random(25), pPos[1] + random (25), pPos[2] - 5 + random(10), random(280), random(280), 0, -1, -1, playerid);
    SnowTimer[playerid] = SetTimerEx("UpdateSnow", 1000, true, "i", playerid);
    return 1;
}

// Load players stats
stock Load_Stats(playerid)
{
	new Query[300], row[400];
	format(Query, 300, "SELECT * FROM `users` WHERE `username`='%s'", PlayerName(playerid));
	mysql_query(Query);
	mysql_store_result();
	while(mysql_fetch_row_format(Query, "|"))
	{
	    mysql_fetch_field_row(row, "money");
	    PlayerInfo[playerid][Pmoney] = strval(row);
	    mysql_fetch_field_row(row, "admin");
	    PlayerInfo[playerid][Padmin] = strval(row);
	    mysql_fetch_field_row(row, "score");
	    PlayerInfo[playerid][Pscore] = strval(row);
	    mysql_fetch_field_row(row, "bank");
	    PlayerInfo[playerid][Pbank] = strval(row);
	}
	mysql_free_result();
	SetPlayerScore(playerid, PlayerInfo[playerid][Pscore]);
	GivePlayerMoney(playerid, PlayerInfo[playerid][Pmoney]);
	return 1;
}

stock GetPlayersVehicles(playerid)
{
	for(new i = 0;i< (MAX_VEHS);i++)
	{
	    if(strcmp(VehicleInfo[i][owner], PlayerName(playerid), false) == 0)
	    {
	        return i;
		}
	}
	return -1;
}

stock SavePlayerVehicles(playerid)
{
	new veh = ConvertVID(GetPlayersVehicles(playerid));
	new Query[500];
	new Float:health, pannels, doors, tires, lights;
	GetVehicleDamageStatus(veh,pannels,doors,lights,tires);
	format(Query, 500, "UPDATE `vehicle` SET `x_pos`='%f', `y_pos`='%f', `z_pos`='%f', `vehicle_health`='%d', `pannel_damage`='%d', `door_damage`='%d', `light_damage`='%d', `tire_damage`='%d' WHERE `vehicleid`='%d'", VehicleInfo[veh][x_pos], VehicleInfo[veh][y_pos], VehicleInfo[veh][z_pos], GetVehicleHealth(veh, health), pannels, doors, lights, tires, veh);
	mysql_query(Query);
	return 1;
}

stock BuyCar(modelid, playerid, valuenum)
{
	if(vehiclez == 1) return SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] You already have a car");
    new ID = GenerateID();
	format(VehicleInfo[ID][owner], 24, "%s", PlayerName(playerid));
	VehicleInfo[ID][model] = modelid;
	VehicleInfo[ID][value] = valuenum;
	VehicleInfo[ID][pannel_damage] = 0;
	VehicleInfo[ID][door_damage] = 0;
	VehicleInfo[ID][light_damage] = 0;
	VehicleInfo[ID][tire_damage] = 0;
	VehicleInfo[ID][owned] = true;
	VehicleInfo[ID][x_pos] = -1983.9702;
	VehicleInfo[ID][y_pos] = 304.0019;
	VehicleInfo[ID][z_pos] = 34.8990;
	vehicle_creating =ID;
	VehicleInfo[ID][vehid] = ID;
	GivePlayerMoney(playerid, -valuenum);
	vehiclez = 1;
	return ID;
}
/** ARRAYS **/

//map icons
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
	{21, -2023.1322,79.7627,28.1035, 20, 0}
};

// random messages
new RandomMessages[][] =
{
	"Use /admins for an online list of adminstrators",
	"Need help from the admins? Use /atalk [text] and your text will be sent to any online admins!",
	"New to the game? Need some help performing a task? Use /helpme [text] and your text will be sent to any online helpers",
	"Follow all the /rules, ALWAYS. There are no Exceptions.",
	"Seen a cheater? /report them and write a report on our forum http://sf-cnr.co.uk/forum",
	"Provoking is agaisnt the rules; if someone provokes you, report them to the administrators.",
	"you can Become a Regular Player After Playing 5 Hours in the Server.",
	"Visit our forum http://sf-cnr.co.uk/forum you can chat to ingame mates and even make clans!",
	"Racism will not be tolerated! If you see someone being racist, report them asap",
	"Want to be in the army? In the s.w.a.t? Join our forum and see fi you have the chance!",
	"Type /commands for a list of ingame commands",
	"Never ask for admin position, doing so lowers your chances of actuly being one",
	"Never abuse a script or san andreas bug! doing so can get you banned for a short time",
	"Want to keep us alive? Want new features such as teamspeak servers? Join our forum and donate!",
	"As we are in beta versions, use /bug to report a bug",
	"Want to fight like a kung fu master? Visit your local gym and change your fighting style!",
	"Is a police officer cuff abusing or abusing /rp? then /report him",
	"When you report someone a admin can view it offline and we keep it forever, even if there are no admins online",
	"Want some cool ingame stuff? Such as fireworks and neon for your car? Donate a short ammount of money and you can have them!",
	"Geting raped to often? Visit a local 24/7 to pickup a condom!",
	"Never advertise in the server, this includes website AND servers. If we catch you, you can be banned",
	"Never cheat, doing so will get you ip banned"
};

// car names
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

stock GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if (strfind(VehicleNames[i], vname, true) != -1)
			return i + 400;
	}
	return -1;
}

stock GetWeaponModelIDFromName(wname[])
{
	for(new i = 0;i < 47;i++)
	{
	    if(strfind(WeaponNames[i], wname, true) != -1)
	        return i;
	}
	return -1;
}

stock GenerateID()
{
	new Query[100];
	format(Query, 100, "SELECT * FROM vehicle");
	mysql_query(Query);
	mysql_store_result();
	new rows = mysql_num_rows();
	mysql_free_result();
	return rows;
}

//civilian random spawns
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

// army random spawns
new Float:ArmySpawns[][] =
{
	{-1545.2535,320.0439,53.4609,275.3235},
	{-1345.1957,501.4555,18.2344,4.3111}
};

//stat random spawns
new Float:StatSpawns[][] =
{
	{-2185.2268,2416.2488,5.1836,179.4194},
	{-2237.9580,2353.4204,4.9802,139.6023}
};

//prison spawns
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

//Random messages
public Random_Messages()
{
    new Random = random(sizeof(RandomMessages));
	SendClientMessageToAll(COLOR_COOLBLUE, RandomMessages[Random]);
	return 1;
}

public UpdateSnow(playerid)
{
	new Float:pPos[3];
 	GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
  	for(new i = 0; i < 15; i++) SetDynamicObjectPos(SnowObject, pPos[0] + random(25), pPos[1] + random(25), pPos[2] - 5 + random(10));
  	return 1;
}

public OneSecTimer(playerid)
{
	// loop through everyone
	foreach(Player, i)
	{
	    //making sure they are connected
	    if(IsPlayerConnected(i))
	    {
	        // if there ping is the max ping or higher
	        if(GetPlayerPing(i) >= MAX_PING)
	        {
             	if(PingWarnings[i] >= MAX_PINGWARNING) return Kick(i);
	            else PingWarnings[i]++;
			}
		}
	}
	TextDrawSetString(Text:Zone, PlayerZone(playerid));
    TextDrawShowForPlayer(playerid, Text:Zone);
	return 1;
}

main()
{
	print("\n|*|=====================================|*|");
	print("    San Fierro Cops And Robbers Gamemode ");
	printf("    Gamemode Version: %s             ", SERVER_VERSION);
	printf("    Percentage Done: %s				 ", SERVER_PERCENTAGE);
	print("|*|=====================================|*|\n");
}


public OnGameModeInit()
{
	//maps
	//stat map
	AddStaticVehicleEx(446,-2220.39941406,2408.69921875,0.00000000,45.00000000,215,142,50);
	AddStaticVehicleEx(446,-2245.39990234,2433.80004883,-0.30000001,225.00000000,215,142,50);
	AddStaticVehicleEx(446,-2200.80004883,2427.30004883,0.00000000,45.00000000,215,142,50);
	AddStaticVehicleEx(446,-2226.39990234,2453.50000000,-0.30000001,225.00000000,215,142,50);
	AddStaticVehicleEx(446,-2325.69995117,2304.19995117,-0.30000001,180.00000000,215,142,50);
	AddStaticVehicleEx(487,-2227.50000000,2326.89990234,7.80000019,0.00000000,215,142,50);
	AddStaticVehicleEx(541,-2270.60009766,2336.19995117,4.50000000,270.00000000,215,142,50);
	AddStaticVehicleEx(541,-2270.60009766,2333.39990234,4.50000000,270.00000000,215,142,50);
	AddStaticVehicleEx(541,-2270.60009766,2330.30004883,4.50000000,270.00000000,215,142,50);
	AddStaticVehicleEx(541,-2270.60009766,2327.39990234,4.50000000,270.00000000,215,142,50);
	AddStaticVehicleEx(541,-2270.60009766,2324.50000000,4.50000000,270.00000000,215,142,50);
	AddStaticVehicleEx(522,-2270.39990234,2321.30004883,4.50000000,270.00000000,215,142,50);
	AddStaticVehicleEx(522,-2270.39990234,2318.50000000,4.50000000,270.00000000,215,142,50);
	AddStaticVehicleEx(522,-2270.39990234,2315.60009766,4.50000000,270.00000000,215,142,50);
	AddStaticVehicleEx(522,-2270.39990234,2312.30004883,4.50000000,270.00000000,215,142,50);
	AddStaticVehicleEx(522,-2270.39990234,2309.50000000,4.50000000,270.00000000,215,142,50);
	AddStaticVehicleEx(522,-2270.39990234,2306.60009766,4.50000000,270.00000000,215,142,50);
	AddStaticVehicleEx(451,-2271.39990234,2300.50000000,4.59999990,270.00000000,215,142,50);
	AddStaticVehicleEx(451,-2271.39990234,2294.50000000,4.59999990,270.00000000,215,142,50);
	AddStaticVehicleEx(451,-2271.39990234,2288.39990234,4.59999990,270.00000000,215,142,50);
	AddStaticVehicleEx(451,-2271.39990234,2285.50000000,4.59999990,270.00000000,-1,-1,50);
	AddStaticVehicleEx(451,-2271.39990234,2291.50000000,4.59999990,270.00000000,-1,-1,50);
	AddStaticVehicleEx(451,-2271.39990234,2297.50000000,4.59999990,270.00000000,-1,-1,50);
	AddStaticVehicleEx(451,-2271.39990234,2303.30004883,4.59999990,270.00000000,-1,-1,50);
	AddStaticVehicleEx(447,-2290.60009766,2415.50000000,5.00000000,316.00000000,32,32,50);
	AddStaticVehicleEx(447,-2274.30004883,2398.30004883,5.00000000,314.00000000,32,32,50);
	CreateDynamicObject(3406,-2214.59960938,2414.00000000,-0.60000002,0.00000000,0.00000000,44.99450684);
	CreateDynamicObject(3406,-2225.29980469,2403.50000000,-0.60000002,0.00000000,0.00000000,44.99450684);
	CreateDynamicObject(3406,-2240.69995117,2440.39990234,-0.60000002,0.00000000,0.00000000,44.99450684);
	CreateDynamicObject(3406,-2251.00000000,2429.50000000,-0.60000002,0.00000000,0.00000000,44.99450684);
	CreateDynamicObject(16782,-2187.50000000,2411.10009766,5.30000019,0.00000000,0.00000000,315.00000000);
	CreateDynamicObject(3406,-2205.39990234,2423.19995117,-0.60000002,0.00000000,0.00000000,44.99450684);
	CreateDynamicObject(3406,-2231.09960938,2449.89941406,-0.60000002,0.00000000,0.00000000,44.98352051);
	CreateDynamicObject(3524,-2217.39990234,2422.30004883,4.19999981,0.00000000,0.00000000,44.99450684);
	CreateDynamicObject(3524,-2213.89990234,2425.69995117,3.90000010,0.00000000,0.00000000,44.98901367);
	CreateDynamicObject(3524,-2227.50000000,2439.39990234,4.59999990,0.00000000,0.00000000,219.99572754);
	CreateDynamicObject(3524,-2230.89990234,2435.89990234,4.69999981,0.00000000,0.00000000,219.99572754);
	CreateDynamicObject(1676,-2249.10009766,2292.30004883,5.40000010,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1676,-2249.10009766,2298.39990234,5.40000010,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1676,-2249.10009766,2304.69995117,5.40000010,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1676,-2249.10009766,2310.39990234,5.40000010,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1676,-2249.10009766,2316.30004883,5.40000010,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1676,-2249.10009766,2322.00000000,5.40000010,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1676,-2249.10009766,2328.19995117,5.40000010,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1676,-2249.10009766,2334.69995117,5.40000010,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1949,-2250.80004883,2337.80004883,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2250.80004883,2331.39990234,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2254.00000000,2331.39990234,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2253.89990234,2337.80004883,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2253.89990234,2325.39990234,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2250.80004883,2325.39990234,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2250.80004883,2319.39990234,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2254.00000000,2319.39990234,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2250.89990234,2313.39990234,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2254.10009766,2313.39990234,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2250.89990234,2307.50000000,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2254.00000000,2307.50000000,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2250.89990234,2301.60009766,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2254.00000000,2301.60009766,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2250.89990234,2295.60009766,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2254.00000000,2295.60009766,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2250.89990234,2289.69995117,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2254.00000000,2289.69995117,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1676,-2249.10009766,2286.30004883,5.40000010,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1949,-2254.00000000,2283.69995117,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1949,-2250.89990234,2283.69995117,3.79999995,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3934,-2290.60009766,2415.19995117,3.90000010,0.00000000,0.00000000,45.00000000);
	CreateDynamicObject(3934,-2274.60009766,2398.19995117,3.90000010,0.00000000,0.00000000,44.99450684);

	//Admin house
	AddStaticVehicleEx(471,1526.70019531,2787.28613281,10.39531231,88.00000000,-1,-1,50);
	AddStaticVehicleEx(448,1527.45837402,2790.66870117,10.49053192,96.00000000,-1,-1,50);
	AddStaticVehicleEx(461,1527.76110840,2795.98706055,10.49481392,88.75000000,6,6,50);
	AddStaticVehicleEx(462,1527.57116699,2800.30419922,10.49053192,88.00000000,3,3,50);
	AddStaticVehicleEx(463,1527.95556641,2804.79760742,10.43731213,90.00000000,2,2,50);
	AddStaticVehicleEx(468,1527.90637207,2809.17187500,10.58031273,94.00000000,44,44,50);
	AddStaticVehicleEx(522,1527.47509766,2813.79614258,10.48069000,90.00000000,-1,6,50);
	AddStaticVehicleEx(523,1527.68713379,2818.50537109,10.48069000,90.00000000,-1,-1,50);
	AddStaticVehicleEx(581,1528.34790039,2822.79492188,10.52007294,90.00000000,123,61,50);
	AddStaticVehicleEx(586,1527.84118652,2827.46508789,10.41731262,90.00000000,102,1,50);
	AddStaticVehicleEx(509,1528.02905273,2831.84252930,10.42010975,90.00000000,106,1,50);
	AddStaticVehicleEx(481,1528.48339844,2836.42822266,10.42908859,86.00000000,-1,-1,50);
	AddStaticVehicleEx(510,1528.29577637,2840.88989258,10.51615429,93.99902344,-1,-1,50);
	AddStaticVehicleEx(525,1530.14245605,2845.40209961,10.81031227,88.99499512,-1,-1,50);
	AddStaticVehicleEx(411,1530.42297363,2849.65136719,10.62031269,90.00000000,-1,-1,50);
	AddStaticVehicleEx(415,1530.65625000,2854.66235352,10.66983414,90.00000000,-1,-1,50);
	AddStaticVehicleEx(451,1530.57617188,2858.92700195,10.58468437,91.99951172,-1,-1,50);
	AddStaticVehicleEx(480,1530.56250000,2863.26464844,10.67031288,91.99951172,1,1,50);
	AddStaticVehicleEx(506,1530.75268555,2867.69726562,10.61242580,90.99951172,-1,-1,50);
	AddStaticVehicleEx(541,1531.04809570,2872.31298828,10.52031231,90.99951172,-1,-1,50);
	AddStaticVehicleEx(457,1537.62780762,2764.46899414,10.54966068,0.00000000,-1,-1,50);
	AddStaticVehicleEx(495,1522.68176270,2879.27563477,11.38038635,179.50000000,6,6,50);
	AddStaticVehicleEx(486,1518.26440430,2878.24169922,11.12031269,178.75000000,-1,-1,50);
	AddStaticVehicleEx(552,1513.47705078,2878.65673828,10.60155869,179.00000000,126,126,50);
	AddStaticVehicleEx(560,1509.12451172,2879.47412109,10.55584526,180.50000000,1,1,50);
	AddStaticVehicleEx(562,1504.59301758,2879.41210938,10.57386208,179.75006104,3,1,50);
	AddStaticVehicleEx(535,1500.29162598,2879.00000000,10.66031265,179.50000000,6,1,50);
	AddStaticVehicleEx(444,1496.05761719,2878.71777344,11.27029037,179.74731445,-1,-1,50);
	AddStaticVehicleEx(487,1441.83325195,2845.45605469,11.08531284,90.00000000,-1,-1,50);
	AddStaticVehicleEx(447,1441.89318848,2863.31469727,10.92031288,90.00000000,36,1,50);
	CreateDynamicObject(8042,1485.57812500,2808.56250000,15.68770599,0.00000000,358.99475098,287.99560547);
	CreateDynamicObject(9833,1486.26428223,2763.58984375,12.45469475,0.00000000,0.00000000,359.00000000);
	CreateDynamicObject(2627,1423.94921875,2804.06005859,13.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2628,1427.01562500,2804.06152344,13.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2629,1424.10852051,2797.08911133,13.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2630,1427.17163086,2799.03247070,13.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2631,1421.19311523,2768.40844727,13.86664104,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2632,1426.60351562,2791.68823242,13.86664104,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1985,1427.61779785,2770.30346680,17.34903336,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(14782,1429.81018066,2768.15283203,14.83635998,0.00000000,0.00000000,271.99951172);
	CreateDynamicObject(5837,1530.42773438,2765.76171875,11.53780746,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3072,1420.41003418,2789.12719727,14.05409336,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3071,1421.17285156,2789.15380859,14.02972603,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2916,1420.95361328,2790.11962891,13.93685055,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2915,1422.28747559,2789.93286133,13.94147491,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2614,1430.12451172,2774.01831055,14.59423256,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(968,1477.42907715,2808.41577148,11.18934536,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(968,1494.35095215,2808.70117188,11.43194199,0.00000000,276.00000000,9.99993896);
	CreateDynamicObject(2899,1514.15454102,2780.48803711,9.93730545,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2899,1514.07324219,2775.70996094,9.93730545,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2899,1513.99902344,2770.93261719,9.93730545,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2899,1513.95898438,2766.08984375,9.93730545,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1337,1278.37402344,3226.48828125,-23.48091888,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2964,1426.75976562,2775.65722656,13.82031250,0.00000000,0.00000000,90.50000000);
	CreateDynamicObject(3106,1426.78295898,2776.17236328,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3105,1426.40759277,2775.59521484,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3104,1427.01647949,2775.18408203,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3103,1426.39550781,2776.33300781,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3102,1427.05139160,2776.07690430,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3101,1427.06640625,2775.55664062,14.60605907,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3101,1426.36840820,2774.94848633,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3100,1426.98388672,2775.61572266,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1946,1426.55712891,2781.55126953,14.02611637,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3497,1429.97094727,2780.35302734,15.92083549,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(14651,1425.36718750,2773.76757812,20.05688477,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3106,1424.89135742,2773.86718750,18.96327209,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3105,1424.84057617,2773.82348633,18.96327209,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3104,1424.78344727,2773.73681641,18.96327209,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3103,1424.59008789,2773.96606445,18.96327209,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3102,1424.63464355,2774.65625000,18.96327209,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3101,1424.85998535,2774.93212891,18.96327209,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3100,1425.03076172,2774.55737305,18.96327209,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3002,1424.77600098,2774.69580078,18.96327209,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3001,1424.41271973,2774.41967773,18.96327019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3000,1424.42700195,2775.06445312,18.96327209,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2999,1425.03137207,2775.12939453,18.96327019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2998,1424.64941406,2775.20507812,18.96327209,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2997,1425.02111816,2773.99414062,18.96327019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2996,1424.25134277,2774.69165039,18.96327019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2995,1424.89257812,2775.19628906,18.96327209,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(6965,1521.21740723,2744.70166016,12.80778122,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,771.78686523,-1325.51782227,12.58906460,0.00000000,359.50000000,0.25000000);
	CreateDynamicObject(987,759.75653076,-1325.40637207,12.58906460,0.00000000,359.49462891,0.24719238);
	CreateDynamicObject(987,747.76885986,-1325.35949707,12.58906460,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,735.81829834,-1325.36608887,12.58906460,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,723.89135742,-1325.38024902,12.58906460,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,723.89172363,-1337.21118164,12.58906460,0.00000000,359.50000000,90.25000000);
	CreateDynamicObject(987,791.81097412,-1329.98339844,12.58906460,0.00000000,0.00000000,269.99725342);
	CreateDynamicObject(987,790.71191406,-1341.98107910,12.58906460,0.00000000,0.00000000,272.00000000);
	CreateDynamicObject(987,791.15954590,-1353.53088379,12.58906460,0.00000000,0.00000000,271.99951172);
	CreateDynamicObject(987,791.10498047,-1365.58361816,12.58906460,0.00000000,0.00000000,271.99951172);
	CreateDynamicObject(987,791.43157959,-1374.55932617,12.58906460,0.00000000,0.00000000,267.99951172);
	CreateDynamicObject(1337,1526.59399414,2781.17895508,10.46953773,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1339,1527.31250000,2781.21997070,10.48228550,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1499,1528.61267090,2766.95556641,10.10811996,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3003,1426.66247559,2775.39624023,14.75065899,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3002,1426.84863281,2774.99365234,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3001,1426.58496094,2776.14648438,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3000,1426.84753418,2775.59204102,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2999,1426.53564453,2774.81225586,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2998,1426.90527344,2776.18725586,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2997,1427.17016602,2775.29052734,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2996,1426.55859375,2775.69555664,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2995,1426.51867676,2775.23388672,14.75026226,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2517,1429.60815430,2751.72436523,13.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2517,1429.60742188,2750.42407227,13.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2517,1429.51525879,2749.15014648,13.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2517,1429.52734375,2747.72167969,13.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2517,1429.63696289,2752.96484375,13.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1491,1427.27465820,2755.46411133,13.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2514,1429.57946777,2740.61523438,13.82031250,0.00000000,0.00000000,272.00000000);
	CreateDynamicObject(2514,1429.54211426,2741.42114258,13.82031250,0.00000000,0.00000000,271.99951172);
	CreateDynamicObject(2514,1429.47814941,2742.10424805,13.82031250,0.00000000,0.00000000,271.99951172);
	CreateDynamicObject(2514,1429.50061035,2742.82397461,13.82031250,0.00000000,0.00000000,271.99951172);
	CreateDynamicObject(1491,1428.82128906,2744.43408203,13.82031250,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(2526,1425.24047852,2742.87573242,13.82031250,0.00000000,0.00000000,1.50000000);
	CreateDynamicObject(2526,1425.25390625,2740.94335938,13.82031250,0.00000000,0.00000000,1.99951172);
	CreateDynamicObject(2796,1429.75354004,2744.43408203,15.83620930,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2290,1427.40795898,2763.68896484,13.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2571,1422.64526367,2757.06640625,13.82031250,0.00000000,0.00000000,183.99902344);
	CreateDynamicObject(1703,1429.68103027,2759.95776367,13.82031250,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1702,1419.85485840,2759.51513672,13.82031250,0.00000000,359.49462891,89.24743652);
	CreateDynamicObject(2229,1429.82128906,2756.17578125,13.82031250,0.00000000,0.00000000,268.00000000);
	CreateDynamicObject(2229,1430.09191895,2761.26367188,13.82031250,0.00000000,0.00000000,267.99499512);
	CreateDynamicObject(2229,1419.51098633,2758.46020508,13.82031250,0.00000000,0.00000000,89.99450684);
	CreateDynamicObject(1622,1559.20996094,2751.36523438,13.57354832,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2780,1423.94165039,2757.17749023,10.18696404,0.00000000,87.74230957,93.23547363);
	CreateDynamicObject(1649,1422.93127441,2753.35644531,14.96921730,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1649,1422.93066406,2753.35644531,14.96921730,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1649,1422.93383789,2748.97851562,14.96921730,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1649,1422.93359375,2748.97851562,14.96921730,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1649,1443.18005371,2744.90234375,14.96921730,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1649,1422.92968750,2744.66503906,14.96921730,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1649,1422.94726562,2742.30444336,14.96921730,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1649,1422.92968750,2744.66503906,14.96921730,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1649,1422.94726562,2742.30371094,14.96921730,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1649,1425.15051270,2740.10693359,14.96921730,0.00000000,0.00000000,180.00000000);
	CreateDynamicObject(1649,1425.15039062,2740.10644531,14.96921730,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1649,1429.55419922,2740.11181641,14.96921730,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(1649,1429.55371094,2740.11132812,14.96921730,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1649,1427.30419922,2742.28198242,14.96921730,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1649,1427.30371094,2742.28125000,14.96921730,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1649,1431.01367188,2743.96777344,14.96921730,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1649,1431.00671387,2744.48852539,14.96921730,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(1649,1431.00585938,2744.48828125,14.96921730,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1649,1425.13049316,2755.55053711,14.96921730,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(1649,1425.12988281,2755.54980469,14.96921730,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1649,1430.88903809,2755.60205078,14.96921730,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(1649,1430.88867188,2755.60156250,14.96921730,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1649,1421.25756836,2755.56909180,14.96921730,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1649,1419.09960938,2757.72705078,14.96921730,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1649,1419.09960938,2757.72656250,14.96921730,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1649,1419.09326172,2762.13769531,14.96921730,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1649,1419.09277344,2762.13769531,14.96921730,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1649,1421.28955078,2764.31884766,14.96921730,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1649,1421.28906250,2764.31835938,14.96921730,0.00000000,0.00000000,180.00000000);
	CreateDynamicObject(1649,1428.65856934,2764.28173828,14.96921730,0.00000000,0.00000000,180.00000000);
	CreateDynamicObject(1491,1423.45935059,2764.26220703,13.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1491,1426.45727539,2764.22583008,13.82031250,0.00000000,0.00000000,178.25000000);
	CreateDynamicObject(1649,1428.65820312,2764.28125000,14.96921730,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1649,1421.31115723,2755.53588867,14.96921730,0.00000000,0.00000000,180.00000000);
	CreateDynamicObject(1753,1426.20117188,2756.07421875,13.82031250,0.00000000,0.00000000,180.00000000);
	CreateDynamicObject(1703,1419.81628418,2763.78149414,13.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3934,1441.50769043,2845.65283203,9.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3934,1441.61376953,2863.76953125,9.82031250,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3586,1406.71679688,2773.64160156,11.69719887,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(987,1524.71716309,2771.49096680,9.67187500,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(987,1524.70263672,2762.45654297,9.67187500,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(2780,1427.80529785,2761.06103516,8.47032547,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2780,1423.48779297,2758.63256836,8.47032547,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3586,1406.71679688,2773.64160156,11.69719887,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(3586,1420.19628906,2773.64013672,11.69719887,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(9833,1486.58740234,2783.08984375,12.45469475,0.00000000,0.00000000,358.99475098);



	//Stunt map
	AddStaticVehicleEx(481,-3033.19995117,4020.39990234,105.69999695,0.00000000,142,140,50);
	AddStaticVehicleEx(481,-3041.19995117,4020.39990234,105.69999695,0.00000000,142,140,50);
	AddStaticVehicleEx(481,-3040.89990234,4037.60009766,105.69999695,0.00000000,142,140,50);
	AddStaticVehicleEx(481,-3021.30004883,4037.60009766,105.69999695,0.00000000,142,140,50);
	AddStaticVehicleEx(481,-3019.60009766,4021.19995117,105.69999695,0.00000000,142,140,50);
	AddStaticVehicleEx(406,-3031.50000000,4032.50000000,106.80000305,0.00000000,245,245,50);
	AddStaticVehicleEx(573,-3044.19995117,4026.10009766,106.19999695,0.00000000,124,27,50);
	AddStaticVehicleEx(573,-3017.69995117,4026.10009766,106.19999695,0.00000000,124,27,50);
	CreateDynamicObject(8171,-2743.80004883,4019.50000000,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2707.50000000,4019.30004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2670.80004883,4019.50000000,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2634.00000000,4019.50000000,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2596.60009766,4019.50000000,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2558.60009766,4019.50000000,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2558.60009766,3881.30004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2596.60009766,3881.30004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2634.00000000,3881.30004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2670.80004883,3881.30004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2707.50000000,3881.30004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2743.80004883,3881.30004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2781.39990234,3881.30004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2781.39990234,4019.50000000,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2781.39941406,3881.29980469,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2819.50000000,3881.30004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2856.59960938,3881.29980469,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2819.50000000,4019.59960938,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2856.59960938,4019.59960938,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2558.60009766,4157.70019531,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2596.60009766,4157.70019531,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2634.00000000,4157.70019531,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2670.79980469,4157.70019531,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2707.50000000,4157.70019531,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2743.80004883,4157.70019531,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2781.39941406,4157.70019531,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2819.50000000,4157.70019531,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(16114,-2879.09960938,3855.39941406,25.39999962,0.00000000,0.00000000,17.99560547);
	CreateDynamicObject(16114,-2689.29980469,4228.89941406,25.39999962,0.00000000,0.00000000,279.98657227);
	CreateDynamicObject(16114,-2648.80004883,4228.89990234,25.39999962,0.00000000,0.00000000,279.99206543);
	CreateDynamicObject(16114,-2611.50000000,4228.89990234,25.39999962,0.00000000,0.00000000,279.99206543);
	CreateDynamicObject(16114,-2573.19995117,4228.89990234,25.39999962,0.00000000,0.00000000,279.99206543);
	CreateDynamicObject(16114,-2557.69995117,4216.89990234,25.39999962,0.00000000,0.00000000,253.99206543);
	CreateDynamicObject(16114,-2539.00000000,4180.20019531,25.39999962,0.00000000,0.00000000,203.98741150);
	CreateDynamicObject(16114,-2539.00000000,4144.29980469,25.39999962,0.00000000,0.00000000,195.98315430);
	CreateDynamicObject(16114,-2539.00000000,4114.10009766,25.39999962,0.00000000,0.00000000,195.97961426);
	CreateDynamicObject(16114,-2539.00000000,4085.89990234,25.39999962,0.00000000,0.00000000,195.97961426);
	CreateDynamicObject(16114,-2539.00000000,4054.50000000,25.39999962,0.00000000,0.00000000,195.97961426);
	CreateDynamicObject(16114,-2539.00000000,4018.19995117,25.39999962,0.00000000,0.00000000,195.97961426);
	CreateDynamicObject(16114,-2539.00000000,3987.30004883,25.39999962,0.00000000,0.00000000,195.97961426);
	CreateDynamicObject(16114,-2539.00000000,3961.39990234,25.39999962,0.00000000,0.00000000,195.97961426);
	CreateDynamicObject(16114,-2539.00000000,3927.50000000,25.39999962,0.00000000,0.00000000,195.97961426);
	CreateDynamicObject(16114,-2539.00000000,3898.50000000,25.39999962,0.00000000,0.00000000,195.97961426);
	CreateDynamicObject(16114,-2539.00000000,3863.19995117,25.39999962,0.00000000,0.00000000,195.97961426);
	CreateDynamicObject(16114,-2548.80004883,3829.10009766,25.39999962,0.00000000,0.00000000,161.97961426);
	CreateDynamicObject(8171,-2596.60009766,3743.80004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2558.60009766,3743.80004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2634.00000000,3743.80004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2670.80004883,3743.80004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2707.50000000,3743.80004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2743.69995117,3743.80004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2781.39990234,3743.80004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2819.50000000,3743.80004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2856.50000000,3743.80004883,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(16114,-2873.30004883,3820.00000000,25.39999962,0.00000000,0.00000000,17.99560547);
	CreateDynamicObject(16114,-2873.30004883,3788.89990234,25.39999962,0.00000000,0.00000000,17.99560547);
	CreateDynamicObject(16114,-2873.30004883,3759.50000000,25.39999962,0.00000000,0.00000000,17.99560547);
	CreateDynamicObject(16114,-2873.30004883,3723.69995117,25.39999962,0.00000000,0.00000000,17.99560547);
	CreateDynamicObject(16114,-2867.50000000,3699.10009766,25.39999962,0.00000000,0.00000000,47.99560547);
	CreateDynamicObject(16114,-2841.39990234,3680.50000000,25.39999962,0.00000000,0.00000000,91.99377441);
	CreateDynamicObject(16114,-2799.69995117,3680.50000000,25.39999962,0.00000000,0.00000000,91.98852539);
	CreateDynamicObject(16114,-2763.39990234,3675.80004883,25.39999962,0.00000000,0.00000000,91.98852539);
	CreateDynamicObject(16114,-2721.00000000,3675.80004883,25.39999962,0.00000000,0.00000000,91.98852539);
	CreateDynamicObject(16114,-2682.69995117,3675.80004883,25.39999962,0.00000000,0.00000000,91.98852539);
	CreateDynamicObject(16114,-2644.19995117,3671.50000000,25.39999962,0.00000000,0.00000000,91.98852539);
	CreateDynamicObject(16114,-2608.19995117,3671.50000000,25.39999962,0.00000000,0.00000000,91.98852539);
	CreateDynamicObject(16114,-2571.50000000,3676.30004883,25.39999962,0.00000000,0.00000000,127.98852539);
	CreateDynamicObject(16114,-2550.50000000,3708.89990234,25.39999962,0.00000000,0.00000000,181.98521423);
	CreateDynamicObject(16114,-2549.50000000,3746.89990234,25.39999962,0.00000000,0.00000000,181.98303223);
	CreateDynamicObject(16114,-2549.50000000,3784.19995117,25.39999962,0.00000000,0.00000000,181.98303223);
	CreateDynamicObject(16114,-2549.50000000,3802.00000000,25.39999962,0.00000000,0.00000000,181.98303223);
	CreateDynamicObject(3374,-2686.89990234,3782.00000000,27.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2691.00000000,3782.00000000,27.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2695.00000000,3782.00000000,27.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2695.00000000,3782.00000000,30.39999962,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2695.00000000,3782.00000000,33.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2691.10009766,3782.00000000,33.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2687.00000000,3782.00000000,33.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2687.00000000,3782.00000000,36.40000153,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2687.00000000,3782.00000000,39.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2691.00000000,3782.00000000,39.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2695.00000000,3782.00000000,39.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2701.30004883,3782.00000000,27.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2701.30004883,3782.00000000,30.39999962,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2701.30004883,3782.00000000,33.40000153,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2701.30004883,3782.00000000,36.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2701.30004883,3782.00000000,39.40000153,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2705.30004883,3782.00000000,39.40000153,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2709.30004883,3782.00000000,39.40000153,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2705.19995117,3782.00000000,33.40000153,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2717.60009766,3782.00000000,27.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2714.80004883,3782.00000000,30.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2714.80004883,3782.19995117,33.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2714.80004883,3782.19995117,36.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2717.30004883,3782.19995117,39.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2721.19995117,3782.19995117,39.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2725.30004883,3782.19995117,39.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2720.89990234,3782.00000000,27.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2724.80004883,3782.00000000,27.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2733.00000000,3782.19995117,27.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2733.00000000,3782.19995117,30.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2733.00000000,3782.19995117,33.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2733.00000000,3782.19995117,36.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2733.00000000,3782.19995117,39.40000153,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2737.00000000,3782.19995117,39.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2741.00000000,3782.19995117,39.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2741.00000000,3782.19995117,36.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2741.00000000,3782.19995117,33.40000153,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2741.00000000,3782.19995117,31.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2741.00000000,3782.19995117,28.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2741.00000000,3782.19995117,25.89999962,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2747.30004883,3782.19995117,27.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2747.30004883,3782.19995117,30.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2747.30004883,3782.19995117,33.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2747.30004883,3782.19995117,36.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2747.30004883,3782.19995117,39.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2751.19995117,3782.19995117,39.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3374,-2755.10009766,3782.19995117,39.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1632,-2692.80004883,3929.00000000,27.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1632,-2692.80004883,3936.80004883,31.60000038,13.25000000,0.00000000,0.00000000);
	CreateDynamicObject(1632,-2692.80004883,3945.10009766,33.70000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1632,-2692.80004883,3945.39990234,36.20000076,40.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1632,-2692.80004883,3944.60009766,40.70000076,63.99523926,0.00000000,0.00000000);
	CreateDynamicObject(1632,-2692.80004883,3944.39990234,45.70000076,75.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1632,-2692.80004883,3941.80004883,49.20000076,67.99542236,179.99890137,179.98999023);
	CreateDynamicObject(1632,-2692.80004883,3936.89990234,52.20000076,33.99282837,179.99597168,179.98687744);
	CreateDynamicObject(1632,-2692.80004883,3942.10009766,36.29999924,24.24575806,0.00000000,0.00000000);
	CreateDynamicObject(1631,-2659.39990234,4032.60009766,26.70000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1655,-2691.69995117,3819.30004883,27.29999924,0.00000000,0.00000000,180.00000000);
	CreateDynamicObject(1655,-2700.39990234,3819.30004883,27.29999924,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(1655,-2709.10009766,3819.30004883,27.29999924,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(1655,-2717.19995117,3819.30004883,27.29999924,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(1655,-2725.39990234,3819.30004883,27.29999924,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(1655,-2734.10009766,3819.30004883,27.29999924,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(1655,-2742.30004883,3819.30004883,27.29999924,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(1655,-2750.60009766,3819.30004883,27.29999924,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(1655,-2759.10009766,3819.30004883,27.29999924,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(1655,-2684.19995117,3819.30004883,27.29999924,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(12956,-2709.30004883,4052.60009766,29.39999962,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(13590,-2612.89990234,4109.70019531,27.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(13641,-2734.39990234,3965.69995117,25.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(13637,-2817.89990234,3858.80004883,27.70000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(13831,-2558.39990234,4008.10009766,37.50000000,0.00000000,0.00000000,275.99853516);
	CreateDynamicObject(16002,-2794.50000000,3762.69995117,28.60000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1655,-2793.60009766,3791.80004883,27.00000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3363,-2686.80004883,3733.80004883,25.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3664,-2758.00000000,4062.50000000,32.59999847,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(18449,-2728.50000000,4163.20019531,44.09999847,359.77929688,28.00024414,270.11737061);
	CreateDynamicObject(18449,-2728.50000000,4227.79980469,84.50000000,0.00000000,35.99670410,270.00000000);
	CreateDynamicObject(18449,-2728.50000000,4292.10009766,131.19999695,0.00000000,35.99670410,270.00000000);
	CreateDynamicObject(12814,-2725.39990234,4349.00000000,155.10000610,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(12814,-2698.39990234,4348.89990234,155.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(12814,-2674.19995117,4348.79980469,155.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(18449,-2678.30004883,4292.29980469,131.19999695,0.00000000,35.99670410,270.00000000);
	CreateDynamicObject(18449,-2678.29980469,4236.59960938,90.80000305,0.00000000,35.99670410,270.00000000);
	CreateDynamicObject(18449,-2678.30004883,4174.00000000,41.50000000,0.00000000,40.49560547,270.00000000);
	CreateDynamicObject(1225,-2671.80004883,4324.00000000,155.39999390,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2684.50000000,4324.00000000,155.39999390,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2674.80004883,4317.00000000,148.89999390,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2677.30004883,4317.00000000,148.89999390,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2681.00000000,4317.00000000,148.89999390,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2680.30004883,4317.00000000,148.89999390,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2679.30004883,4317.00000000,148.89999390,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2679.29980469,4317.00000000,148.89999390,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2679.30004883,4309.29980469,143.39999390,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2681.30004883,4309.29980469,143.39999390,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2684.00000000,4309.29980469,143.39999390,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2677.30004883,4309.29980469,143.39999390,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2674.00000000,4309.29980469,143.39999390,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2674.00000000,4288.89990234,128.69999695,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2675.50000000,4288.89990234,128.69999695,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2677.50000000,4288.89990234,128.69999695,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2680.00000000,4288.89990234,128.69999695,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2680.80004883,4288.89990234,128.69999695,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2681.80004883,4288.89990234,128.69999695,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2679.80004883,4269.60009766,114.80000305,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2681.80004883,4269.60009766,114.80000305,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2676.80004883,4269.60009766,114.80000305,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2673.80004883,4269.60009766,114.80000305,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2673.79980469,4269.59960938,114.80000305,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2672.50000000,4197.50000000,62.09999847,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2674.30004883,4197.50000000,62.09999847,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2677.00000000,4197.50000000,62.09999847,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2680.50000000,4197.50000000,62.09999847,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2682.80004883,4197.50000000,62.09999847,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,-2682.00000000,4197.50000000,65.59999847,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2856.60009766,4157.70019531,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2896.00000000,4157.10009766,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2896.00000000,4019.60009766,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2934.19921875,4019.59960938,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2879.50000000,4019.60009766,26.00000000,0.00000000,344.50000000,0.00000000);
	CreateDynamicObject(8171,-2862.19995117,4019.60009766,31.79999924,0.00000000,330.74340820,0.00000000);
	CreateDynamicObject(8171,-2851.69995117,4019.60009766,37.79999924,0.00000000,312.23913574,0.00000000);
	CreateDynamicObject(8171,-2836.00000000,4019.60009766,52.79999924,0.00000000,299.73919678,0.00000000);
	CreateDynamicObject(8171,-2843.29980469,4019.59960938,43.79999924,0.00000000,307.23266602,0.00000000);
	CreateDynamicObject(8171,-2829.39990234,4019.50000000,59.59999847,0.00000000,289.48449707,0.00000000);
	CreateDynamicObject(8171,-2824.59960938,4022.59960938,85.40000153,0.00000000,285.47424316,0.00000000);
	CreateDynamicObject(16114,-2879.09960938,3898.19921875,25.39999962,0.00000000,0.00000000,17.99560547);
	CreateDynamicObject(8171,-2843.29980469,4023.09960938,43.79999924,0.00000000,307.23266602,0.00000000);
	CreateDynamicObject(8171,-2840.10009766,4022.60009766,52.79999924,0.00000000,299.73449707,0.00000000);
	CreateDynamicObject(8171,-2828.30004883,4023.30004883,76.30000305,0.00000000,293.97973633,0.00000000);
	CreateDynamicObject(8171,-2879.50000000,4156.89941406,26.00000000,0.00000000,344.49829102,0.00000000);
	CreateDynamicObject(8171,-2862.19921875,4156.70019531,31.79999924,0.00000000,330.73791504,0.00000000);
	CreateDynamicObject(8171,-2851.69995117,4156.89990234,37.79999924,0.00000000,312.23144531,0.00000000);
	CreateDynamicObject(8171,-2840.09960938,4156.70019531,52.79999924,0.00000000,299.73449707,0.00000000);
	CreateDynamicObject(8171,-2828.29980469,4157.00000000,77.30000305,0.00000000,289.73144531,0.00000000);
	CreateDynamicObject(8171,-2824.59960938,4157.39941406,85.40000153,0.00000000,285.46875000,0.00000000);
	CreateDynamicObject(8171,-2934.19995117,4157.00000000,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2948.10009766,4019.60009766,26.00000000,0.00000000,18.00000000,0.00000000);
	CreateDynamicObject(8171,-2969.10009766,4019.60009766,34.00000000,0.00000000,30.74572754,0.00000000);
	CreateDynamicObject(8171,-2977.10009766,4019.60009766,37.50000000,0.00000000,37.99560547,0.00000000);
	CreateDynamicObject(8171,-2987.80004883,4019.60009766,44.79999924,0.00000000,46.99075317,0.00000000);
	CreateDynamicObject(8171,-2995.30004883,4019.60009766,49.79999924,0.00000000,59.23852539,0.00000000);
	CreateDynamicObject(8171,-2948.10009766,4157.10009766,26.00000000,0.00000000,17.99560547,0.00000000);
	CreateDynamicObject(8171,-2969.10009766,4157.10009766,34.00000000,0.00000000,30.74523926,0.00000000);
	CreateDynamicObject(8171,-2977.10009766,4157.10009766,37.50000000,0.00000000,37.99072266,0.00000000);
	CreateDynamicObject(8171,-2896.00000000,4294.00000000,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2934.19995117,4293.79980469,26.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2969.10009766,4293.39990234,34.00000000,0.00000000,30.74523926,0.00000000);
	CreateDynamicObject(8171,-2879.50000000,4293.29980469,26.00000000,0.00000000,344.49829102,0.00000000);
	CreateDynamicObject(8171,-2862.19995117,4294.60009766,31.79999924,0.00000000,330.73791504,0.00000000);
	CreateDynamicObject(8171,-2840.10009766,4293.79980469,52.79999924,0.00000000,299.73449707,0.00000000);
	CreateDynamicObject(8171,-2828.30004883,4294.20019531,77.30000305,0.00000000,289.73144531,0.00000000);
	CreateDynamicObject(8171,-2824.60009766,4294.70019531,85.40000153,0.00000000,285.47424316,0.00000000);
	CreateDynamicObject(8171,-2977.10009766,4293.29980469,37.50000000,0.00000000,37.99072266,0.00000000);
	CreateDynamicObject(8171,-2977.10009766,4158.79980469,37.50000000,0.00000000,37.99072266,0.00000000);
	CreateDynamicObject(8171,-2987.80004883,4153.29980469,44.79999924,0.00000000,46.98852539,0.00000000);
	CreateDynamicObject(8171,-3002.39990234,4154.89990234,61.70000076,0.00000000,61.48498535,0.00000000);
	CreateDynamicObject(8171,-3002.30004883,4019.19995117,61.70000076,0.00000000,61.48498535,0.00000000);
	CreateDynamicObject(8171,-3002.39990234,4292.20019531,61.70000076,0.00000000,61.48498535,0.00000000);
	CreateDynamicObject(8171,-2987.80004883,4291.89990234,45.29999924,0.00000000,46.98852539,0.00000000);
	CreateDynamicObject(8172,-2931.50000000,4360.60009766,20.50000000,0.00000000,270.00000000,90.00000000);
	CreateDynamicObject(8172,-2896.00000000,4360.60009766,57.29999924,0.00000000,270.00000000,90.00000000);
	CreateDynamicObject(8172,-2900.30004883,4360.60009766,85.30000305,0.00000000,270.00000000,90.00000000);
	CreateDynamicObject(8172,-2931.00000000,4360.60009766,85.59999847,0.00000000,270.00000000,90.00000000);
	CreateDynamicObject(8172,-2924.89990234,4360.60009766,57.29999924,0.00000000,270.00000000,90.00000000);
	CreateDynamicObject(8171,-3011.80004883,4294.60009766,85.09999847,0.00000000,90.22985840,0.00000000);
	CreateDynamicObject(8171,-3011.80004883,4019.19995117,85.09999847,0.00000000,90.22521973,0.00000000);
	CreateDynamicObject(8171,-3011.80004883,4157.00000000,85.09999847,0.00000000,90.22521973,0.00000000);
	CreateDynamicObject(8172,-2933.30004883,3953.10009766,84.50000000,0.00000000,270.00000000,270.00000000);
	CreateDynamicObject(8172,-2933.30004883,3953.10009766,45.00000000,0.00000000,270.00000000,270.00000000);
	CreateDynamicObject(8172,-2899.60009766,3953.10009766,45.00000000,0.00000000,270.00000000,270.00000000);
	CreateDynamicObject(8172,-2899.60009766,3953.10009766,84.50000000,0.00000000,270.00000000,270.00000000);
	CreateDynamicObject(8171,-2799.30004883,4294.79980469,104.40000153,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2799.30004883,4156.50000000,104.40000153,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2799.30004883,4022.30004883,104.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-3031.69995117,4022.39990234,105.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-3031.69995117,4160.20019531,105.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-3031.69995117,4294.60009766,105.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(974,-3015.10009766,3953.39990234,107.69999695,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(974,-3021.80004883,3953.39990234,107.69999695,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(974,-3028.50000000,3953.39990234,107.69999695,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(974,-3035.19995117,3953.39990234,107.69999695,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(974,-3041.89990234,3953.39990234,107.69999695,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(974,-3048.19995117,3953.39990234,107.69999695,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(974,-3011.80004883,3956.69995117,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3011.80004883,3963.30004883,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3011.80004883,3969.89990234,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3011.80004883,3976.60009766,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3011.80004883,3983.19995117,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3011.80004883,3989.89990234,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3011.80004883,3996.60009766,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3011.80004883,4003.30004883,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3011.80004883,4010.00000000,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3011.80004883,4016.69995117,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3011.80004883,4023.39990234,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3011.80004883,4030.10009766,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3011.80004883,4036.80004883,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3011.80004883,4043.50000000,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3015.19995117,4046.80004883,107.80000305,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(974,-3021.80004883,4046.80004883,107.80000305,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(974,-3041.60009766,4046.80004883,107.80000305,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(974,-3048.30004883,4046.80004883,107.80000305,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(974,-3051.39990234,4043.60009766,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3051.39990234,4037.00000000,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3051.39990234,4030.30004883,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3051.39990234,4023.60009766,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3051.39990234,4017.00000000,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3051.39990234,4010.30004883,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3051.39990234,4003.60009766,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3051.39990234,3996.89990234,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3051.39990234,3990.19995117,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3051.39990234,3983.50000000,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3051.39990234,3976.80004883,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3051.39990234,3970.10009766,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3051.39990234,3963.39990234,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3051.39990234,3956.69995117,107.80000305,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(974,-3028.50000000,4046.80004883,107.80000305,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(641,-3038.69995117,4048.60009766,102.19999695,0.00000000,0.00000000,62.00000000);
	CreateDynamicObject(641,-3031.50000000,4048.60009766,102.19999695,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(14497,-3017.00000000,3960.10009766,105.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2648,-3052.00000000,3961.60009766,107.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(2290,-3042.00000000,3962.30004883,105.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(2290,-3043.30004883,3957.80004883,105.00000000,0.00000000,0.00000000,227.99450684);
	CreateDynamicObject(2290,-3044.30004883,3966.30004883,105.00000000,0.00000000,0.00000000,317.99377441);
	CreateDynamicObject(14833,-3039.80004883,3964.10009766,106.59999847,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(9153,-3034.19995117,4029.10009766,109.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(9153,-3027.39990234,4029.10009766,109.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(9153,-3037.60009766,4029.10009766,109.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(9153,-3037.60009766,4020.80004883,109.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(9153,-3030.10009766,4020.80004883,109.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(9153,-3026.30004883,4020.80004883,109.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(9153,-3028.80004883,4032.60009766,109.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(9153,-3038.00000000,4032.60009766,109.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(9153,-3033.50000000,4025.60009766,109.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(9153,-3038.00000000,4024.30004883,109.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8171,-2987.80004883,4175.39990234,45.29999924,0.00000000,46.98852539,0.00000000);
	CreateDynamicObject(8171,-2987.80004883,3992.30004883,45.29999924,0.00000000,46.98852539,0.00000000);
	CreateDynamicObject(8171,-2784.30004883,4295.20019531,118.59999847,0.00000000,90.00000000,0.00000000);
	CreateDynamicObject(8171,-2784.30004883,4295.20019531,78.69999695,0.00000000,90.00000000,0.00000000);
	CreateDynamicObject(8171,-2784.30004883,4157.10009766,118.59999847,0.00000000,90.00000000,0.00000000);
	CreateDynamicObject(8171,-2784.30004883,4157.20019531,78.69999695,0.00000000,90.00000000,0.00000000);
	CreateDynamicObject(8171,-2784.30004883,4157.20019531,39.00000000,0.00000000,90.00000000,0.00000000);
	CreateDynamicObject(8171,-2784.30004883,4019.50000000,39.00000000,0.00000000,90.00000000,0.00000000);
	CreateDynamicObject(8171,-2784.30004883,4019.50000000,78.69999695,0.00000000,90.00000000,0.00000000);
	CreateDynamicObject(8171,-2784.30004883,4019.50000000,118.69999695,0.00000000,90.00000000,0.00000000);
	CreateDynamicObject(8171,-2784.30004883,4295.20019531,47.90000153,0.00000000,90.00000000,0.00000000);
	CreateDynamicObject(16114,-2879.10009766,3929.80004883,25.39999962,0.00000000,0.00000000,17.99560547);
	CreateDynamicObject(16114,-2736.19995117,4228.89990234,25.39999962,0.00000000,0.00000000,279.98657227);
	CreateDynamicObject(16114,-2752.30004883,4228.89990234,25.39999962,0.00000000,0.00000000,279.98657227);





	//Koth map
	AddStaticVehicleEx(572,121.09999847,3629.50000000,11.89999962,0.00000000,249,240,50);
	AddStaticVehicleEx(471,121.80000305,3613.60009766,11.89999962,0.00000000,225,-1,50);
	CreateDynamicObject(12814,127.00000000,3689.09960938,11.30000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(985,116.39941406,3611.39941406,13.00000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(985,124.19921875,3611.39941406,13.00000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(985,132.00000000,3611.39941406,13.00000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(985,139.89941406,3611.39941406,13.00000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(985,147.69921875,3611.39941406,13.00000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(985,155.59960938,3611.39941406,13.00000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(985,163.50000000,3611.39941406,13.00000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(985,171.39941406,3611.39941406,13.00000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(985,175.29980469,3615.29980469,13.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(985,175.29980469,3623.19921875,13.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(985,175.29980469,3631.09960938,13.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(985,175.29980469,3639.00000000,13.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(985,175.29980469,3646.89941406,13.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(985,175.29980469,3654.79980469,13.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(985,175.29980469,3662.69921875,13.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(985,175.29980469,3670.59960938,13.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(985,175.29980469,3678.50000000,13.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(985,175.29980469,3686.39941406,13.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(985,175.29980469,3694.29980469,13.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(985,175.29980469,3702.19921875,13.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(985,175.29980469,3710.09960938,13.00000000,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(985,171.39941406,3714.00000000,13.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(985,163.50000000,3714.00000000,13.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(985,155.59960938,3714.00000000,13.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(985,147.69921875,3714.00000000,13.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(985,139.79980469,3714.00000000,13.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(985,131.89941406,3714.00000000,13.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(985,124.00000000,3714.00000000,13.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(985,116.09960938,3714.00000000,13.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(12814,156.89941406,3689.09960938,11.30000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(12814,160.50000000,3689.09960938,11.30000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(12814,160.50000000,3639.19921875,11.30000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(12814,130.69921875,3639.19921875,11.30000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(12814,126.89941406,3639.19921875,11.30000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(12814,126.89941406,3636.09960938,11.30000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(12814,156.10000610,3636.10009766,11.30000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(12814,160.50000000,3634.00000000,11.10000038,0.50000000,0.00000000,0.00000000);
	CreateDynamicObject(14612,131.69999695,3657.60009766,14.00000000,0.00000000,0.00000000,359.74731445);
	CreateDynamicObject(3630,140.39999390,3672.50000000,12.80000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3630,140.39999390,3669.50000000,15.60000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3630,140.39941406,3666.39941406,18.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3630,140.39999390,3663.39990234,21.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3630,140.39999390,3660.30004883,24.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3630,140.39999390,3657.30004883,27.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3630,140.39999390,3654.30004883,27.50000000,0.00000000,0.00000000,179.99993896);
	CreateDynamicObject(3630,140.39999390,3652.80004883,27.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3651.30004883,27.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3649.80004883,27.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3646.80004883,24.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3643.80004883,21.60000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39941406,3640.79980469,18.60000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3637.80004883,15.69999981,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3634.89990234,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3524,138.50000000,3648.50000000,28.89999962,0.00000000,0.00000000,34.00000000);
	CreateDynamicObject(3524,140.60000610,3648.50000000,28.89999962,0.00000000,0.00000000,324.00000000);
	CreateDynamicObject(3524,140.00000000,3658.39990234,28.89999962,0.00000000,0.00000000,141.99993896);
	CreateDynamicObject(3524,142.39941406,3658.59960938,28.89999962,0.00000000,0.00000000,219.99572754);
	CreateDynamicObject(621,165.89999390,3646.39990234,7.09999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(623,171.09960938,3699.69921875,9.10000038,0.00000000,355.98999023,165.99792480);
	CreateDynamicObject(3630,140.39999390,3637.89990234,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3640.89990234,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3643.89990234,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3646.89990234,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3650.00000000,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3653.10009766,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3656.10009766,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3659.10009766,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3662.10009766,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3665.19995117,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3668.30004883,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3669.69995117,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3640.80004883,15.69999981,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3643.80004883,15.69999981,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3646.80004883,15.69999981,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3649.80004883,15.69999981,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3652.69995117,15.69999981,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3643.80004883,18.60000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3649.80004883,12.80000019,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3655.69995117,15.69999981,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3658.69995117,15.69999981,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3661.39990234,15.69999981,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39941406,3664.19921875,15.69999981,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3666.60009766,15.69999981,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3663.39990234,18.70000076,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3660.39990234,18.70000076,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3660.39990234,21.70000076,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3657.50000000,18.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3654.60009766,18.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3651.39990234,18.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3648.30004883,18.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3646.39990234,18.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3646.39990234,21.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3649.30004883,21.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3652.30004883,21.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3655.30004883,21.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3657.69995117,21.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3657.69995117,24.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3654.69995117,24.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3651.89990234,24.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3630,140.39999390,3649.89990234,24.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(1225,137.89999390,3647.19995117,26.39999962,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,141.19999695,3649.00000000,29.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,141.39999390,3644.19995117,23.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,138.10000610,3641.69995117,20.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,141.19999695,3637.50000000,17.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,138.10000610,3634.50000000,14.39999962,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,141.19999695,3632.39990234,11.30000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,139.29980469,3658.00000000,29.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,142.69999695,3661.39990234,26.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,139.39999390,3664.30004883,23.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,139.69999695,3667.50000000,20.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,142.80000305,3670.50000000,17.39999962,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1225,139.80000305,3673.00000000,14.89999962,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(985,112.19999695,3710.00000000,13.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(985,112.19921875,3702.09960938,13.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(985,112.19921875,3694.19921875,13.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(985,112.19999695,3686.30004883,13.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(985,112.19999695,3678.39990234,13.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(985,112.19999695,3670.50000000,13.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(985,112.19999695,3662.60009766,13.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(985,112.19999695,3654.69995117,13.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(985,112.19999695,3646.80004883,13.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(985,112.19999695,3638.89990234,13.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(985,112.19999695,3631.00000000,13.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(985,112.19999695,3623.10009766,13.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(985,112.19999695,3615.30004883,13.00000000,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(3062,139.80000305,3614.19995117,12.69999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3062,141.30000305,3614.19995117,12.69999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3062,142.80000305,3614.19995117,12.69999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3062,138.30000305,3614.19995117,12.69999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3062,138.30000305,3615.69995117,12.69999981,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(3062,138.30000305,3617.19995117,12.69999981,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(3062,138.30000305,3617.19995117,12.69999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3062,139.80000305,3617.19995117,12.69999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3062,141.30000305,3617.19995117,12.69999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3062,142.80000305,3617.19995117,12.69999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3722,132.30000305,3705.10009766,15.19999981,0.00000000,359.74731445,266.99523926);
	CreateDynamicObject(5262,119.09999847,3621.10009766,14.19999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8884,154.89999390,3680.39990234,14.60000038,0.00000000,0.00000000,297.74743652);
	CreateDynamicObject(10757,161.10000610,3627.30004883,13.89999962,56.04611206,21.85446167,323.59719849);
	CreateDynamicObject(3361,147.89999390,3704.50000000,14.69999981,0.00000000,0.00000000,357.75000000);
	CreateDynamicObject(3361,152.69999695,3704.30004883,11.50000000,0.00000000,0.00000000,357.74780273);
	CreateDynamicObject(623,122.19999695,3689.19995117,9.10000038,0.00000000,355.98999023,209.99792480);


    // Army map and vehicles
	AddStaticVehicleEx(444,-1399.30004883,442.10000610,30.29999924,228.00000000,215,142,50);
	AddStaticVehicleEx(444,-1347.30004883,339.79998779,30.39999962,43.99926758,25,56,50);
	AddStaticVehicleEx(494,-1399.59960938,340.29980469,30.10000038,319.99877930,25,56,50);
	AddStaticVehicleEx(494,-1347.59997559,441.39999390,30.10000038,139.99877930,215,142,50);
	AddStaticVehicleEx(432,-1422.40002441,494.70001221,18.50000000,0.00000000,95,10,50);
	AddStaticVehicleEx(476,-1447.80004883,354.79998779,8.39999962,270.00000000,25,56,50);
	AddStaticVehicleEx(476,-1442.90002441,390.89999390,8.30000019,270.00000000,25,56,50);
	AddStaticVehicleEx(476,-1446.80004883,426.39999390,8.30000019,270.00000000,25,56,50);
	AddStaticVehicleEx(430,-1641.89941406,253.69921875,0.00000000,269.24743652,-1,-1,50);
	AddStaticVehicleEx(430,-1656.59960938,253.69921875,0.00000000,269.24743652,-1,-1,50);
	AddStaticVehicleEx(430,-1627.69921875,253.50000000,0.00000000,269.24743652,-1,-1,50);
	AddStaticVehicleEx(425,-1597.69995117,346.10000610,22.39999962,89.00000000,95,10,50);
	AddStaticVehicleEx(425,-1597.59997559,330.10000610,22.39999962,89.25000000,95,10,50);
	AddStaticVehicleEx(447,-1576.50000000,345.00000000,21.70000076,88.75000000,32,32,50);
	AddStaticVehicleEx(447,-1576.50000000,330.39999390,21.70000076,88.74755859,32,32,50);
	AddStaticVehicleEx(432,-1428.90002441,494.70001221,18.50000000,0.00000000,95,10,50);
	AddStaticVehicleEx(432,-1435.09997559,494.70001221,18.50000000,0.00000000,95,10,50);
	AddStaticVehicleEx(432,-1416.00000000,494.70001221,18.50000000,0.00000000,95,10,50);
	AddStaticVehicleEx(425,-1608.90002441,288.50000000,8.10000038,0.00000000,95,10,50);
	AddStaticVehicleEx(446,-2325.69995117,2304.19995117,-0.30000001,180.00000000,215,142,50);
	AddStaticVehicleEx(468,-1341.40002441,454.79998779,6.90000010,6.00000000,25,56,50);
	AddStaticVehicleEx(468,-1339.80004883,454.79998779,6.90000010,5.99865723,25,56,50);
	AddStaticVehicleEx(468,-1342.80004883,454.79998779,6.90000010,5.99853516,25,56,50);
	AddStaticVehicleEx(468,-1344.40002441,454.79998779,6.90000010,5.99853516,25,56,50);
	AddStaticVehicleEx(470,-1353.19995117,456.89999390,7.30000019,0.00000000,95,10,50);
	AddStaticVehicleEx(470,-1358.19995117,456.89999390,7.30000019,0.00000000,95,10,50);
	AddStaticVehicleEx(470,-1362.90002441,456.89999390,7.30000019,0.00000000,95,10,50);
	AddStaticVehicleEx(470,-1367.69995117,456.89999390,7.30000019,0.00000000,95,10,50);
	AddStaticVehicleEx(433,-1378.30004883,458.29998779,7.80000019,0.00000000,95,10,50);
	AddStaticVehicleEx(433,-1383.80004883,458.29998779,7.80000019,0.00000000,95,10,50);
	AddStaticVehicleEx(433,-1389.00000000,458.29998779,7.80000019,0.00000000,95,10,50);
	AddStaticVehicleEx(436,-3366.00000000,182.60000610,-53.09999847,0.00000000,43,62,50);
	CreateDynamicObject(14410,-1526.59960938,454.09960938,9.39999962,0.00000000,0.00000000,180.74707031);
	CreateDynamicObject(14410,-1526.50000000,443.39941406,14.69999981,0.00000000,0.00000000,180.74157715);
	CreateDynamicObject(14410,-1526.39941406,432.59960938,19.00000000,0.00000000,0.00000000,180.74157715);
	CreateDynamicObject(14410,-1526.29980469,421.50000000,25.10000038,0.00000000,0.00000000,180.74157715);
	CreateDynamicObject(14410,-1526.09960938,407.69921875,31.60000038,0.00000000,0.00000000,180.74157715);
	CreateDynamicObject(14410,-1526.00000000,394.50000000,37.50000000,0.00000000,0.00000000,180.74157715);
	CreateDynamicObject(14410,-1526.09997559,380.60000610,43.00000000,0.00000000,0.00000000,180.74157715);
	CreateDynamicObject(14410,-1525.90002441,366.79998779,49.20000076,0.00000000,0.00000000,180.74707031);
	CreateDynamicObject(14410,-1525.80004883,359.60000610,50.70000076,356.48986816,0.00000000,180.74157715);
	CreateDynamicObject(17950,-1316.39941406,494.89941406,19.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3383,-1316.89941406,491.39941406,16.89999962,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3383,-1318.90002441,493.10000610,16.89999962,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(3383,-1318.90002441,496.00000000,16.89999962,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(3383,-1318.90002441,497.20001221,16.89999962,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(3383,-1314.89941406,491.39941406,16.89999962,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(16782,-1313.40002441,494.50000000,19.10000038,0.00000000,0.00000000,180.00000000);
	CreateDynamicObject(2921,-1313.40002441,499.29998779,21.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2921,-1319.69995117,499.10000610,21.20000076,0.00000000,0.00000000,240.00000000);
	CreateDynamicObject(3785,-1313.30004883,497.79998779,18.50000000,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(3785,-1319.30004883,492.60000610,18.50000000,0.00000000,0.00000000,7.99255371);
	CreateDynamicObject(3785,-1319.40002441,496.79998779,18.50000000,0.00000000,0.00000000,7.98706055);
	CreateDynamicObject(1649,-1317.40002441,499.20001221,19.00000000,0.00000000,0.00000000,177.25000000);
	CreateDynamicObject(3115,-1456.79980469,501.39941406,16.89999962,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(10631,-1556.29980469,319.79980469,57.09999847,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(14411,-1442.00000000,343.00000000,38.59999847,0.00000000,0.00000000,89.50000000);
	CreateDynamicObject(14411,-1455.90002441,343.20001221,44.70000076,0.00000000,0.00000000,89.49462891);
	CreateDynamicObject(14411,-1469.09997559,343.39999390,50.29999924,0.00000000,0.00000000,89.49462891);
	CreateDynamicObject(14411,-1428.09997559,342.89999390,32.50000000,0.00000000,0.00000000,89.49462891);
	CreateDynamicObject(14411,-1419.50000000,342.79998779,28.20000076,0.00000000,0.00000000,89.49462891);
	CreateDynamicObject(987,-1340.09997559,423.70001221,29.10000038,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(987,-1340.00000000,411.70001221,29.10000038,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(987,-1340.00000000,399.79998779,29.10000038,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1649,-1315.00000000,499.19921875,19.00000000,0.00000000,0.00000000,180.00000000);
	CreateDynamicObject(987,-1340.00000000,387.79998779,29.10000038,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(987,-1340.00000000,375.89999390,29.10000038,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(987,-1340.00000000,363.89999390,29.10000038,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(987,-1339.90002441,352.00000000,29.10000038,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(987,-1339.90002441,340.00000000,29.10000038,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(987,-1340.19995117,330.79998779,29.10000038,0.00000000,0.00000000,180.00000000);
	CreateDynamicObject(987,-1352.09997559,330.79998779,29.10000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(987,-1364.09997559,330.79998779,29.10000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(987,-1376.09997559,330.79998779,29.10000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(987,-1388.09997559,330.79998779,29.10000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(987,-1400.00000000,330.79998779,29.10000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(987,-1412.00000000,330.79998779,29.10000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(987,-1423.90002441,330.79998779,29.10000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(987,-1435.80004883,330.79998779,29.10000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(987,-1447.80004883,330.79998779,29.10000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(987,-1459.80004883,330.79998779,29.10000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(987,-1471.80004883,330.89999390,29.10000038,0.00000000,0.00000000,179.99450684);
	CreateDynamicObject(987,-1339.80004883,435.70001221,29.10000038,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(987,-1339.90002441,447.70001221,29.10000038,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(987,-1352.00000000,450.29998779,29.10000038,0.00000000,0.00000000,1.99951172);
	CreateDynamicObject(987,-1339.90002441,450.70001221,29.10000038,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(987,-1364.00000000,450.29998779,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1376.30004883,450.39999390,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1388.40002441,450.39999390,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1400.59997559,450.50000000,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1412.59997559,450.50000000,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1424.59997559,450.50000000,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1436.59997559,450.50000000,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1448.59997559,450.50000000,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1460.59997559,450.50000000,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1472.59997559,450.50000000,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1484.59997559,450.50000000,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1496.59997559,450.50000000,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3819,-1411.80004883,342.10000610,30.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3819,-1411.80004883,350.70001221,30.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3819,-1411.80004883,359.29998779,30.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3819,-1411.79980469,367.89941406,30.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3819,-1411.80004883,376.50000000,30.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3819,-1411.80004883,385.10000610,30.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3819,-1411.80004883,393.70001221,30.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3819,-1411.80004883,402.29998779,30.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3819,-1411.80004883,410.89999390,30.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3819,-1411.79980469,419.50000000,30.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3819,-1411.90002441,428.10000610,30.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3819,-1411.79980469,436.69921875,30.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3819,-1407.00000000,344.79998779,30.10000038,0.99426270,0.00000000,179.99450684);
	CreateDynamicObject(3819,-1407.00000000,350.69921875,30.10000038,0.99426270,0.00000000,179.99450684);
	CreateDynamicObject(3819,-1407.00000000,359.29998779,30.10000038,0.99975586,0.00000000,179.99450684);
	CreateDynamicObject(3819,-1407.00000000,367.89999390,30.10000038,0.99975586,0.00000000,179.99450684);
	CreateDynamicObject(3819,-1407.00000000,376.50000000,30.10000038,0.99975586,0.00000000,179.99450684);
	CreateDynamicObject(3819,-1407.00000000,385.20001221,30.10000038,0.99975586,0.00000000,179.99450684);
	CreateDynamicObject(3819,-1407.00000000,393.79998779,30.10000038,0.99975586,0.00000000,179.99450684);
	CreateDynamicObject(3819,-1407.00000000,402.39999390,30.10000038,0.99975586,0.00000000,179.99450684);
	CreateDynamicObject(3819,-1407.00000000,411.10000610,30.10000038,0.99975586,0.00000000,179.99450684);
	CreateDynamicObject(3819,-1407.00000000,419.70001221,30.10000038,0.99975586,0.00000000,179.99450684);
	CreateDynamicObject(3819,-1407.00000000,428.29980469,30.10000038,0.99426270,0.00000000,181.99401855);
	CreateDynamicObject(3819,-1407.00000000,436.89999390,30.10000038,0.99975586,0.00000000,179.99450684);
	CreateDynamicObject(8835,-1449.19995117,391.70001221,31.29999924,0.00000000,0.00000000,336.00000000);
	CreateDynamicObject(8319,-1448.90002441,415.79998779,29.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8835,-1449.19995117,393.39999390,30.29999924,0.00000000,0.00000000,200.00000000);
	CreateDynamicObject(9035,-1434.59997559,383.00000000,31.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(807,-1445.09997559,402.20001221,29.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1303,-1448.69995117,399.20001221,29.60000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(6204,-1452.00000000,392.19921875,31.10000038,0.00000000,14.00000000,0.00000000);
	CreateDynamicObject(839,-1465.69995117,409.00000000,31.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(622,-1446.90002441,368.89999390,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(838,-1459.59997559,438.00000000,32.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(622,-1443.40002441,433.29998779,29.10000038,0.00000000,0.00000000,92.00000000);
	CreateDynamicObject(688,-1426.90002441,435.00000000,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(835,-1458.00000000,381.39999390,32.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(833,-1427.50000000,385.29998779,30.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(645,-1476.90002441,361.70001221,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(669,-1435.80004883,423.89999390,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(672,-1461.30004883,410.29998779,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(683,-1461.00000000,402.89999390,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(688,-1482.89941406,380.19921875,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(651,-1435.59997559,391.29998779,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(17941,-1451.80004883,406.50000000,29.60000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(757,-1446.80004883,413.79998779,35.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(820,-1448.29980469,410.09960938,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(751,-1428.09997559,387.20001221,30.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(17958,-1443.09997559,369.00000000,30.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(13635,-1430.30004883,366.29998779,31.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2780,-1460.69995117,376.50000000,27.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(17958,-1461.19921875,413.89941406,30.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(707,-1459.69995117,359.20001221,27.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(726,-1424.80004883,400.29998779,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(780,-1454.19995117,431.50000000,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2780,-1427.90002441,378.29998779,28.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2780,-1427.09997559,425.89999390,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(688,-1450.90002441,421.89999390,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3072,-1515.30004883,449.70001221,41.50000000,0.00000000,89.00000000,0.00000000);
	CreateDynamicObject(3072,-1515.30004883,446.89999390,41.50000000,0.00000000,88.99475098,0.00000000);
	CreateDynamicObject(3072,-1512.50000000,446.89999390,41.50000000,0.00000000,88.99475098,0.00000000);
	CreateDynamicObject(3072,-1512.50000000,450.89941406,41.50000000,0.00000000,88.98925781,0.00000000);
	CreateDynamicObject(3072,-1512.50000000,450.89941406,41.50000000,0.00000000,88.99475098,0.00000000);
	CreateDynamicObject(3503,-1503.30004883,360.70001221,43.09999847,0.00000000,90.00000000,3.99981689);
	CreateDynamicObject(14449,-1513.40002441,417.79998779,42.59999847,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(14449,-1509.30004883,417.79998779,42.59999847,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(14449,-1505.19995117,417.79998779,42.59999847,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(14449,-1501.40002441,417.79998779,42.59999847,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(14449,-1497.40002441,417.79998779,42.59999847,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(14781,-1499.50000000,370.79998779,42.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(14782,-1510.90002441,360.39999390,42.29999924,0.00000000,0.00000000,180.74996948);
	CreateDynamicObject(14782,-1498.00000000,360.29998779,42.29999924,0.00000000,0.00000000,180.74707031);
	CreateDynamicObject(14399,-1505.80004883,452.60000610,41.29999924,0.00000000,0.00000000,180.49987793);
	CreateDynamicObject(2627,-1505.50000000,370.60000610,41.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2628,-1510.69995117,369.50000000,41.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2629,-1500.90002441,384.50000000,41.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2630,-1505.00000000,384.70001221,41.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2631,-1511.80004883,385.79998779,41.40000153,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2632,-1511.80004883,387.70001221,41.40000153,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2739,-1511.80004883,454.70001221,41.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(16135,-1497.00000000,236.10000610,53.50000000,0.00000000,0.00000000,265.99548340);
	CreateDynamicObject(3884,-1500.69995117,322.29998779,52.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2985,-1493.19995117,325.10000610,52.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1808,-1517.30004883,403.00000000,41.29999924,0.00000000,0.00000000,98.00000000);
	CreateDynamicObject(16135,-1474.50000000,236.09960938,53.50000000,0.00000000,0.00000000,265.99548340);
	CreateDynamicObject(1541,-1499.59997559,450.39999390,43.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1542,-1498.00000000,450.79998779,42.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1665,-1514.09997559,450.50000000,41.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1665,-1503.09997559,450.60000610,42.70000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1736,-1501.40002441,455.20001221,43.29999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(8357,-1396.09960938,390.79980469,6.09999990,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(8357,-1396.09960938,426.50000000,6.09999990,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(8357,-1396.19995117,354.89999390,6.09999990,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(3666,-1454.90002441,397.60000610,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1454.80004883,384.20001221,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1396.50000000,384.39999390,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1396.19995117,397.50000000,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1336.00000000,397.79980469,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1335.80004883,384.50000000,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(16662,-1475.19995117,356.89999390,7.30000019,0.00000000,0.00000000,59.97985840);
	CreateDynamicObject(3396,-1472.69995117,340.60000610,6.19999981,0.00000000,0.00000000,271.99453735);
	CreateDynamicObject(987,-1300.39941406,437.50000000,6.19999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(983,-1463.40002441,341.89999390,6.69999981,0.00000000,0.00000000,30.75003052);
	CreateDynamicObject(987,-1288.40002441,437.50000000,6.19999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1276.40002441,437.50000000,6.19999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1264.40002441,437.50000000,6.19999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1252.40002441,437.50000000,6.19999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(983,-1467.19995117,342.29998779,6.69999981,0.00000000,359.50000000,138.74877930);
	CreateDynamicObject(987,-1240.40002441,437.60000610,6.19999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(987,-1228.40002441,437.60000610,6.19999981,0.00000000,0.00000000,50.00000000);
	CreateDynamicObject(1575,-1463.90002441,338.39999390,6.19999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1310,-1465.59997559,337.39999390,6.80000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1550,-1466.90002441,338.29998779,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1636,-1465.40002441,339.50000000,6.30000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1650,-1466.90002441,339.60000610,6.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1654,-1464.30004883,339.79998779,6.40000010,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(16782,-1465.30004883,341.39999390,6.30000019,0.00000000,270.00000000,85.74945068);
	CreateDynamicObject(983,-1467.19995117,342.29998779,8.00000000,0.00000000,359.49462891,138.74633789);
	CreateDynamicObject(983,-1467.19995117,342.29998779,9.30000019,0.00000000,359.49462891,138.74633789);
	CreateDynamicObject(983,-1467.19921875,342.29980469,10.50000000,0.00000000,359.48913574,138.74633789);
	CreateDynamicObject(1671,167.69921875,134.39941406,511.60000610,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(983,-1463.39941406,341.89941406,8.00000000,0.00000000,0.00000000,30.74523926);
	CreateDynamicObject(983,-1463.39941406,341.89941406,9.30000019,0.00000000,0.00000000,30.74523926);
	CreateDynamicObject(983,-1463.39941406,341.89941406,10.50000000,0.00000000,0.00000000,30.74523926);
	CreateDynamicObject(1652,-1456.39941406,358.69921875,6.59999990,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1652,-1456.39941406,352.29980469,6.59999990,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1652,-1456.39941406,389.09960938,6.59999990,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1652,-1456.39941406,414.69921875,6.59999990,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1652,-1456.39941406,430.69921875,6.59999990,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(13646,-1556.59997559,320.89999390,60.90000153,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3934,-1598.09997559,346.00000000,20.70000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3934,-1598.09997559,330.29998779,20.70000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3934,-1576.50000000,330.29998779,20.70000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3934,-1576.40002441,344.79998779,20.70000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1602.00000000,333.60000610,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1594.40002441,333.60000610,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1594.40002441,326.79998779,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1602.00000000,326.79998779,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1602.00000000,342.50000000,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1594.40002441,342.50000000,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1594.40002441,349.29998779,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1602.00000000,349.29998779,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1580.40002441,333.70001221,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1580.40002441,326.89999390,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1572.90002441,326.89999390,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1572.90002441,333.70001221,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1572.80004883,341.29998779,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1580.50000000,341.29998779,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1580.30004883,348.10000610,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1572.59997559,348.10000610,21.20000076,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(14410,-1526.00000000,350.39999390,50.20000076,1.48986816,0.00000000,358.74157715);
	CreateDynamicObject(14410,-1586.30004883,388.89999390,6.30000019,0.00000000,0.00000000,180.74157715);
	CreateDynamicObject(14410,-1586.09997559,375.00000000,12.39999962,0.00000000,0.00000000,180.74157715);
	CreateDynamicObject(14410,-1586.00000000,361.10000610,18.50000000,0.00000000,0.00000000,180.74157715);
	CreateDynamicObject(1215,-1622.30004883,270.70001221,6.80000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1608.00000000,270.70001221,6.80000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1594.00000000,270.70001221,6.80000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1594.00000000,270.69921875,6.80000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1594.00000000,285.00000000,6.80000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1594.00000000,299.20001221,6.80000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1608.09997559,299.70001221,6.80000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1622.40002441,299.70001221,6.80000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1215,-1622.40002441,284.70001221,6.80000019,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2207,-1474.00000000,429.19921875,6.19999981,0.00000000,0.00000000,85.98999023);
	CreateDynamicObject(3243,-1473.39941406,402.09960938,6.19999981,0.00000000,0.00000000,229.99328613);
	CreateDynamicObject(1714,-1475.40002441,430.10000610,6.00000000,0.00000000,0.00000000,90.25000000);
	CreateDynamicObject(10757,-1462.50000000,380.79980469,18.50000000,48.86169434,6.08642578,181.36779785);
	CreateDynamicObject(3872,-1465.79980469,381.69921875,15.69999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2313,-1476.80004883,422.60000610,6.19999981,0.00000000,0.00000000,92.00000000);
	CreateDynamicObject(3872,-1463.50000000,405.89941406,15.39999962,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2700,-1477.00000000,423.29998779,7.09999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1703,-1472.40002441,425.79998779,6.09999990,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(2710,-1474.19995117,429.39999390,7.19999981,0.00000000,0.00000000,255.24536133);
	CreateDynamicObject(1670,-1474.30004883,430.89999390,7.00000000,0.00000000,0.00000000,292.00000000);
	CreateDynamicObject(1829,-1479.19995117,430.00000000,6.69999981,0.00000000,359.24993896,85.99996948);
	CreateDynamicObject(1828,-1467.09997559,429.50000000,6.19999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(16782,-2187.50000000,2411.10009766,5.30000019,0.00000000,0.00000000,315.00000000);
	CreateDynamicObject(9819,-1475.69995117,346.20001221,6.80000019,0.00000000,0.00000000,180.00000000);
	CreateDynamicObject(11289,-206.69999695,-97.50000000,5.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2893,-1477.40002441,287.60000610,53.40000153,2.00000000,0.00000000,181.00000000);
	CreateDynamicObject(2893,-1499.90002441,287.60000610,53.40000153,1.99951172,0.00000000,180.99975586);
	CreateDynamicObject(1671,-1474.80004883,356.39999390,6.59999990,0.00000000,0.00000000,316.00000000);
	CreateDynamicObject(1671,-1474.90002441,346.79998779,6.59999990,0.00000000,0.00000000,315.99975586);
	CreateDynamicObject(1671,-1474.90002441,344.10000610,6.59999990,0.00000000,0.00000000,315.99975586);
	CreateDynamicObject(1671,-1472.90002441,341.60000610,6.59999990,0.00000000,0.00000000,47.99975586);
	CreateDynamicObject(2114,-1463.69995117,437.50000000,6.50000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3497,-1463.59997559,441.29998779,9.30000019,0.00000000,0.00000000,180.00000000);
	CreateDynamicObject(2395,-1470.59997559,416.20001221,6.09999990,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(2395,-1471.09997559,418.79998779,6.09999990,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(1792,-1470.69995117,417.60000610,7.80000019,0.00000000,0.00000000,270.00000000);
	CreateDynamicObject(2231,-1471.00000000,418.50000000,7.80000019,0.00000000,0.00000000,271.24694824);
	CreateDynamicObject(2231,-1471.00000000,416.10000610,7.80000019,0.00000000,0.00000000,271.24694824);
	CreateDynamicObject(1742,-1477.00000000,420.29998779,6.19999981,0.00000000,0.00000000,89.75000000);
	CreateDynamicObject(2964,-1466.69921875,420.39941406,6.19999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3077,-1475.90002441,366.89999390,6.19999981,0.00000000,0.49987793,55.74462891);
	CreateDynamicObject(1790,-1471.00000000,417.50000000,7.40000010,0.00000000,0.00000000,271.00000000);
	CreateDynamicObject(2964,-1472.39941406,379.19921875,6.19999981,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2279,-1476.30004883,423.39999390,8.89999962,0.00000000,0.00000000,88.00000000);
	CreateDynamicObject(823,-1433.50000000,398.50000000,9.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1336.00000000,419.50000000,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1336.00000000,433.79998779,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1371.59997559,433.79998779,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1371.59997559,419.39999390,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1421.59997559,419.39999390,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1421.59997559,434.10000610,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1310.50000000,434.10000610,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1310.50000000,411.29998779,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1293.30004883,411.29998779,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1293.30004883,433.79998779,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1293.30004883,406.20001221,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1311.30004883,406.20001221,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1311.30004883,375.39999390,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1293.50000000,375.39999390,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1293.50000000,370.39999390,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1293.50000000,339.20001221,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1309.00000000,339.39999390,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1309.00000000,369.89999390,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1335.00000000,362.60000610,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1335.00000000,348.10000610,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1363.19995117,348.10000610,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1363.19995117,362.60000610,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1406.69995117,362.60000610,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(3666,-1406.69995117,347.60000610,6.59999990,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2967,-1474.09997559,430.29998779,7.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2612,-1470.19995117,370.00000000,8.10000038,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2611,-1472.59997559,370.00000000,8.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(1753,-1475.19995117,378.70001221,6.19999981,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(2886,-3316.89990234,41.79999924,9.00000000,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(2147,461.39999390,2446.30004883,8.39999962,0.00000000,0.00000000,4.99877930);
	CreateDynamicObject(1710,-1476.40002441,414.79998779,6.19999981,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(11489,-1477.19995117,391.20001221,6.19999981,0.00000000,0.00000000,92.00000000);
	CreateDynamicObject(1652,-1456.39941406,352.29980469,6.59999990,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1652,-1456.39941406,358.69921875,6.59999990,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1652,-1456.39941406,389.09960938,6.59999990,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1652,-1456.39941406,414.69921875,6.59999990,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(1652,-1456.39941406,430.69921875,6.59999990,0.00000000,0.00000000,90.00000000);
	CreateDynamicObject(982,-1404.00000000,348.20001221,29.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(982,-1404.00000000,372.20001221,29.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(982,-1404.00000000,397.79998779,29.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(982,-1404.00000000,423.39999390,29.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(982,-1404.00000000,434.60000610,29.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(982,-1414.09997559,348.20001221,29.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(982,-1414.09997559,373.79998779,29.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(982,-1414.09997559,399.39999390,29.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(982,-1414.09997559,425.00000000,29.79999924,0.00000000,0.00000000,0.00000000);
	CreateDynamicObject(982,-1414.09997559,434.60000610,29.79999924,0.00000000,0.00000000,0.00000000);


	//Swat map and vehicles
    CreateVehicle(487,-991.79980469,-626.59960938,32.29999924,90.00000000,-1,-1,50);
	CreateVehicle(487,-991.39941406,-661.79980469,32.29999924,90.00000000,-1,-1,50);
	CreateVehicle(563,-993.00000000,-644.50000000,32.90000153,90.00000000,-1,-1,50);
	CreateVehicle(426,-1004.39941406,-679.09960938,31.79999924,90.00000000,-1,-1,50);
	CreateVehicle(426,-1004.29980469,-673.89941406,31.79999924,90.00000000,-1,-1,50);
	CreateVehicle(522,-1030.00000000,-684.00000000,31.70000076,271.99951172,-1,-1,50);
	CreateVehicle(522,-1030.09960938,-681.50000000,31.50000000,271.99951172,-1,-1,50);
	CreateVehicle(522,-1029.89941406,-679.00000000,31.70000076,271.99951172,-1,-1,50);
	CreateVehicle(601,-1039.09997559,-679.59997559,31.89999962,359.99499512,245,245,50);
	CreateVehicle(427,-1045.09997559,-611.79998779,32.29999924,270.00000000,-1,-1,50);
	CreateVehicle(426,-1004.50000000,-684.20001221,31.79999924,90.00000000,-1,-1,50);
	CreateVehicle(427,-1044.90002441,-605.79998779,32.29999924,269.99951172,-1,-1,50);
	CreateObject(3268,-1048.50000000,-653.89941406,31.00000000,0.00000000,0.00000000,179.98352051);
	CreateObject(16782,-1058.19995117,-652.50000000,34.00000000,0.00000000,0.00000000,0.00000000);
	CreateObject(16662,-1053.19995117,-642.40002441,32.20000076,0.00000000,0.00000000,9.99255371);
	CreateObject(3394,-1040.80004883,-667.79998779,31.00000000,0.00000000,0.00000000,270.00000000);
	CreateObject(3395,-1047.40002441,-667.70001221,31.00000000,0.00000000,0.00000000,272.00000000);
	CreateObject(3397,-1053.80004883,-667.29998779,31.00000000,0.00000000,0.00000000,270.00000000);
	CreateObject(1671,-1040.50000000,-666.29980469,31.50000000,0.00000000,0.00000000,0.00000000);
	CreateObject(1671,-1047.29980469,-666.39941406,31.50000000,0.00000000,0.00000000,0.00000000);
	CreateObject(1671,-1053.59997559,-666.09997559,31.50000000,0.00000000,0.00000000,0.00000000);
	CreateObject(955,-1044.19995117,-639.40002441,31.39999962,0.00000000,0.00000000,0.00000000);
	CreateObject(16093,-1026.80004883,-595.40002441,35.29999924,0.00000000,0.00000000,179.99450684);
	CreateObject(16638,-1026.90002441,-594.29998779,33.70000076,0.00000000,0.00000000,179.99450684);
	CreateObject(970,-1030.90002441,-588.40002441,36.70000076,0.00000000,0.00000000,358.00000000);
	CreateObject(970,-1026.79980469,-588.50000000,36.70000076,0.00000000,0.00000000,357.99499512);
	CreateObject(970,-1022.59960938,-588.59960938,36.70000076,0.00000000,0.00000000,358.00000000);
	CreateObject(3279,-1007.79998779,-599.50000000,31.00000000,0.00000000,0.00000000,270.00000000);
	CreateObject(3279,-983.59997559,-680.79998779,31.00000000,0.00000000,0.00000000,180.00000000);
	CreateObject(2165,-1057.50000000,-663.09997559,31.00000000,0.00000000,0.00000000,90.00000000);
	CreateObject(2605,-1057.09997559,-658.70001221,31.39999962,0.00000000,0.00000000,92.00000000);
	CreateObject(987,-1496.59997559,450.50000000,29.10000038,0.00000000,0.00000000,0.00000000);
	CreateObject(967,-1038.80004883,-459.60000610,35.09999847,0.00000000,0.00000000,112.00000000);
	CreateObject(966,-1041.00000000,-460.10000610,34.90000153,0.00000000,0.00000000,24.00000000);
	CreateObject(3877,-1045.19995117,-587.90002441,37.79999924,0.00000000,0.00000000,0.00000000);
	CreateObject(3877,-1032.80004883,-588.41998291,37.75999832,0.00000000,0.00000000,0.00000000);
	CreateObject(3934,-991.90002441,-644.29998779,31.00000000,0.00000000,0.00000000,0.00000000);
	CreateObject(1963,-1056.90002441,-645.09997559,31.39999962,0.00000000,0.00000000,64.00000000);
	CreateObject(1963,-1053.90002441,-642.00000000,31.39999962,0.00000000,0.00000000,36.00000000);
	CreateObject(1963,-1050.00000000,-640.59997559,31.39999962,0.00000000,0.00000000,8.00000000);
	CreateObject(1671,-1055.79980469,-645.59960938,31.50000000,0.00000000,0.00000000,239.99633789);
	CreateObject(1671,-1053.29980469,-642.89941406,31.50000000,0.00000000,0.00000000,209.99816895);
	CreateObject(1671,-1049.79980469,-641.59960938,31.50000000,0.00000000,0.00000000,189.99755859);
	CreateObject(1671,167.69921875,134.39941406,511.60000610,0.00000000,0.00000000,0.00000000);
	CreateObject(17017,-1074.90002441,-718.59997559,85.00000000,0.00000000,0.00000000,0.00000000);
	CreateObject(2961,-1047.59997559,-639.09997559,32.59999847,0.00000000,0.00000000,0.00000000);
	CreateObject(3934,-992.00000000,-626.70001221,31.00000000,0.00000000,0.00000000,0.00000000);
	CreateObject(1297,-1037.30004883,-644.70001221,34.40000153,0.00000000,0.00000000,106.00000000);
	CreateObject(1297,-1037.59997559,-662.59997559,34.40000153,0.00000000,0.00000000,250.00000000);
	CreateObject(1294,-1053.90002441,-465.89999390,38.70000076,0.00000000,0.00000000,290.00000000);
	CreateObject(1294,-1075.00000000,-478.29998779,37.40000153,0.00000000,0.00000000,310.00000000);
	CreateObject(1294,-1094.19995117,-496.10000610,36.40000153,0.00000000,0.00000000,320.00000000);
	CreateObject(1294,-1108.19995117,-513.79998779,34.90000153,0.00000000,0.00000000,330.00000000);
	CreateObject(1294,-1123.69995117,-538.79998779,33.79999924,0.00000000,0.00000000,330.00000000);
	CreateObject(1294,-1137.59997559,-565.70001221,33.79999924,0.00000000,0.00000000,330.00000000);
	CreateObject(1294,-1146.59997559,-589.20001221,37.20000076,0.00000000,0.00000000,340.00000000);
	CreateObject(1294,-1154.30004883,-615.00000000,41.79999924,0.00000000,0.00000000,346.00000000);
	CreateObject(1294,-1160.19995117,-634.09997559,44.40000153,0.00000000,0.00000000,350.00000000);
	CreateObject(1294,-1167.00000000,-658.90002441,48.20000076,0.00000000,0.00000000,350.00000000);
	CreateObject(1294,-1175.80004883,-690.70001221,54.50000000,0.00000000,0.00000000,340.00000000);
	CreateObject(1294,-1012.70001221,-448.39999390,40.00000000,0.00000000,0.00000000,300.00000000);
	CreateObject(1294,-1000.79998779,-422.39999390,40.00000000,0.00000000,0.00000000,130.00000000);
	CreateObject(1294,-1181.40002441,-707.00000000,57.40000153,0.00000000,0.00000000,348.00000000);
	CreateObject(1294,-1190.90002441,-730.79998779,61.40000153,0.00000000,0.00000000,338.00000000);
	CreateObject(1294,-1206.50000000,-753.29998779,64.90000153,0.00000000,0.00000000,320.00000000);
	CreateObject(1294,-1227.59997559,-779.50000000,67.59999847,0.00000000,0.00000000,220.00000000);
	CreateObject(1290,-1045.40002441,-579.79998779,37.00000000,0.00000000,0.00000000,356.00000000);
	CreateObject(1290,-1045.30004883,-555.00000000,37.00000000,0.00000000,0.00000000,0.00000000);
	CreateObject(1290,-1045.90002441,-529.40002441,37.00000000,0.00000000,0.00000000,0.00000000);
	CreateObject(1290,-1046.30004883,-509.89999390,37.00000000,0.00000000,0.00000000,0.00000000);
	CreateObject(1290,-1045.19995117,-488.29998779,37.40000153,0.00000000,0.00000000,358.75000000);
	CreateObject(9125,-2263.89941406,2334.00000000,4.09999990,0.00000000,0.00000000,90.00000000);
	CreateObject(14838,-1117.00000000,219.39999390,87.90000153,0.00000000,0.00000000,0.00000000);
	CreateObject(2207,-1054.50000000,-653.50000000,31.00000000,0.00000000,0.00000000,89.98999023);
	CreateObject(1671,-1056.09997559,-652.59997559,31.50000000,0.00000000,0.00000000,89.99755859);
	CreateObject(1671,-1045.80004883,-647.59997559,31.50000000,0.00000000,0.00000000,285.99816895);
	CreateObject(1671,-1047.59997559,-651.90002441,31.50000000,0.00000000,0.00000000,209.99755859);
	CreateObject(1671,-1047.40002441,-645.50000000,31.50000000,0.00000000,0.00000000,329.99609375);
	CreateObject(3934,-991.90002441,-661.79998779,31.00000000,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-988.29998779,-630.29998779,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-988.20001221,-623.29998779,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-995.90002441,-623.40002441,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-995.89941406,-630.19921875,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-995.79998779,-641.00000000,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-995.79998779,-647.79998779,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-988.20001221,-640.90002441,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-988.20001221,-647.90002441,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-995.79998779,-658.50000000,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-988.09997559,-658.40002441,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-995.90002441,-665.40002441,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-995.90002441,-665.40002441,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-988.29998779,-665.29998779,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1044.80004883,-586.79998779,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1033.19995117,-586.79998779,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1033.19995117,-580.50000000,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1044.90002441,-580.50000000,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1044.90002441,-570.79998779,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1033.30004883,-570.79998779,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1033.30004883,-556.79998779,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1044.30004883,-556.79998779,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1044.30004883,-541.79998779,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1033.30004883,-541.79998779,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1033.30004883,-526.50000000,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1044.09997559,-526.50000000,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1043.80004883,-510.89999390,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1033.30004883,-510.89999390,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1033.29980469,-510.89941406,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1042.69995117,-490.10000610,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1033.19995117,-490.10000610,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1035.19995117,-477.00000000,33.70000076,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1044.00000000,-477.00000000,33.70000076,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1047.09997559,-466.50000000,34.50000000,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1038.00000000,-464.60000610,35.00000000,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1033.19995117,-500.60000610,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1215,-1043.09997559,-500.60000610,31.60000038,0.00000000,0.00000000,0.00000000);
	CreateObject(1499,-1058.50000000,-666.29998779,31.00000000,0.00000000,0.00000000,268.00000000);
	CreateObject(1499,-1058.40002441,-667.90002441,31.00000000,0.00000000,0.00000000,92.74496460);
	CreateObject(2147,461.39999390,2446.30004883,8.39999962,0.00000000,0.00000000,4.99877930);
	CreateObject(970,-1018.50000000,-588.70001221,36.70000076,0.00000000,0.00000000,0.00000000);
	CreateObject(970,-1014.29998779,-588.70001221,36.70000076,0.00000000,0.00000000,358.00000000);
	CreateObject(970,-1010.20001221,-588.82000732,36.70000076,0.00000000,0.00000000,357.99499512);
	CreateObject(970,-1006.09997559,-589.00000000,36.70000076,0.00000000,0.00000000,357.98950195);
	CreateObject(970,-1002.29998779,-590.29998779,36.70000076,0.00000000,0.00000000,319.98950195);
	CreateObject(970,-999.40002441,-593.00000000,36.70000076,0.00000000,0.00000000,313.98779297);
	CreateObject(970,-996.79998779,-595.70001221,36.70000076,0.00000000,0.00000000,313.98376465);
	CreateObject(970,-993.79998779,-598.84997559,36.70000076,0.00000000,0.00000000,313.98376465);
	CreateObject(970,-991.00000000,-601.70001221,36.70000076,0.00000000,0.00000000,313.98376465);
	CreateObject(970,-988.09997559,-604.70001221,36.70000076,0.00000000,0.00000000,313.98376465);
	CreateObject(970,-985.20001221,-607.70001221,36.70000076,0.00000000,0.00000000,313.98376465);
	CreateObject(970,-982.59997559,-610.40002441,36.70000076,0.00000000,0.00000000,313.98376465);
	CreateObject(970,-979.70001221,-613.40002441,36.70000076,0.00000000,0.00000000,313.98376465);
	CreateObject(970,-976.90002441,-616.29998779,36.70000076,0.00000000,0.00000000,313.98376465);
	CreateObject(970,-974.20001221,-619.09997559,36.70000076,0.00000000,0.00000000,313.98376465);
	CreateObject(970,-972.40002441,-622.79998779,36.70000076,0.00000000,0.00000000,273.98376465);
	CreateObject(970,-972.40002441,-626.90002441,36.70000076,0.00000000,0.00000000,267.98254395);
	CreateObject(970,-972.50000000,-631.00000000,36.70000076,0.00000000,0.00000000,269.97851562);
	CreateObject(970,-972.50000000,-635.20001221,36.70000076,0.00000000,0.00000000,269.97802734);
	CreateObject(970,-972.50000000,-639.29998779,36.70000076,0.00000000,0.00000000,269.97802734);
	CreateObject(970,-972.50000000,-643.40002441,36.70000076,0.00000000,0.00000000,269.97802734);
	CreateObject(970,-972.54998779,-647.59997559,36.70000076,0.00000000,0.00000000,269.97802734);
	CreateObject(970,-972.59997559,-651.70001221,36.70000076,0.00000000,0.00000000,269.97802734);
	CreateObject(970,-972.59997559,-655.90002441,36.70000076,0.00000000,0.00000000,267.97802734);
	CreateObject(970,-972.70001221,-660.20001221,36.70000076,0.00000000,0.00000000,269.00000000);

	//pirate
	CreateObject(10410,-2077.9677734,-7664.4560547,16.1549606,0.0000000,0.0000000,249.9938965); //object(hc_golfcrse10_sfs)(1)
	CreateObject(6295,-2167.5878906,-7731.4648438,75.9764557,0.0000000,0.0000000,313.9892578); //object(sanpedlithus_law2)(1)
	CreateObject(8493,-2069.8544922,-7560.6767578,17.7500000,0.0000000,0.0000000,285.9960938); //object(pirtshp01_lvs)(1)
	CreateObject(9159,-2069.8999023,-7560.6699219,17.6590233,0.0000000,0.0000000,286.0000000); //object(pirtshp02_lvs)(1)
	CreateObject(3886,-2045.3730469,-7603.0781250,1.1680000,0.0000000,0.0000000,111.9951172); //object(ws_jettynol_sfx)(1)
	CreateObject(3886,-2054.7636719,-7607.0166016,1.1686039,0.0000000,0.0000000,111.9951477); //object(ws_jettynol_sfx)(2)
	CreateObject(3886,-2063.8105469,-7611.2519531,1.1686000,0.0000000,0.0000000,113.9886780); //object(ws_jettynol_sfx)(3)
	CreateObject(3886,-2073.0722656,-7615.6533203,1.1686039,0.0000000,0.0000000,115.9936218); //object(ws_jettynol_sfx)(4)
	CreateObject(3886,-2082.3447266,-7619.9082031,1.1686039,0.0000000,0.0000000,115.9881592); //object(ws_jettynol_sfx)(5)
	CreateObject(3886,-2037.7194824,-7605.9311523,-24.5813961,180.0000000,0.0000000,19.9896240); //object(ws_jettynol_sfx)(11)
	CreateObject(3886,-2034.0009766,-7614.6621094,-24.5813961,179.9945068,0.0000000,23.9831543); //object(ws_jettynol_sfx)(12)
	CreateObject(3886,-2029.4118652,-7622.5537109,-24.5813961,179.9945068,0.0000000,35.9831543); //object(ws_jettynol_sfx)(13)
	CreateObject(3886,-2026.5224609,-7627.2402344,-24.5813961,179.9945068,0.0000000,37.9802246); //object(ws_jettynol_sfx)(14)
	CreateObject(3886,-2041.6943359,-7607.2539062,-25.0813961,179.9945068,0.0000000,21.9781494); //object(ws_jettynol_sfx)(15)
	CreateObject(3886,-2046.0563965,-7608.5751953,-25.0813961,179.9945068,0.0000000,21.9781494); //object(ws_jettynol_sfx)(16)
	CreateObject(3886,-2048.6154785,-7609.6176758,-25.0813961,179.9945068,0.0000000,35.9781494); //object(ws_jettynol_sfx)(17)
	CreateObject(3886,-2053.3430176,-7612.2158203,-24.8313961,179.9945068,0.0000000,23.9747315); //object(ws_jettynol_sfx)(18)
	CreateObject(3886,-2057.3605957,-7613.0869141,-24.8313961,179.9945068,0.0000000,15.9721680); //object(ws_jettynol_sfx)(19)
	CreateObject(3886,-2058.9147949,-7614.1650391,-24.8313961,179.9945068,0.0000000,43.9686279); //object(ws_jettynol_sfx)(20)
	CreateObject(3886,-2063.5793457,-7616.3540039,-24.8313961,179.9945068,0.0000000,19.9672852); //object(ws_jettynol_sfx)(21)
	CreateObject(3886,-2067.7216797,-7617.7314453,-24.8313961,179.9945068,0.0000000,19.9621582); //object(ws_jettynol_sfx)(22)
	CreateObject(3886,-2071.5498047,-7619.2646484,-24.8313961,179.9945068,0.0000000,23.9621582); //object(ws_jettynol_sfx)(23)
	CreateObject(3886,-2074.9052734,-7620.9653320,-24.8313961,179.9945068,0.0000000,27.9611816); //object(ws_jettynol_sfx)(24)
	CreateObject(3886,-2079.5195312,-7622.8984375,-24.8313961,179.9945068,0.0000000,21.9602051); //object(ws_jettynol_sfx)(25)
	CreateObject(3886,-2084.4606934,-7623.9692383,-24.8313961,179.9945068,0.0000000,11.9561768); //object(ws_jettynol_sfx)(26)
	CreateObject(3886,-2082.4208984,-7622.4750977,-37.5813980,179.9945068,0.0000000,33.9531250); //object(ws_jettynol_sfx)(27)
	CreateObject(3886,-2079.6940918,-7621.1953125,-37.5813980,179.9945068,0.0000000,17.9516602); //object(ws_jettynol_sfx)(28)
	CreateObject(3886,-2075.4853516,-7619.3173828,-37.5813980,179.9945068,0.0000000,25.9516602); //object(ws_jettynol_sfx)(29)
	CreateObject(3886,-2072.3579102,-7617.9799805,-37.5813980,179.9945068,0.0000000,21.9497070); //object(ws_jettynol_sfx)(30)
	CreateObject(3886,-2084.9443359,-7623.4160156,-37.5813980,179.9945068,0.0000000,31.9477539); //object(ws_jettynol_sfx)(31)
	CreateObject(11245,-2168.1171875,-7732.6367188,102.3216629,0.0000000,289.9896240,0.0000000); //object(sfsefirehseflag)(1)
	CreateObject(16410,-2104.7675781,-7654.6787109,16.9130173,0.0000000,0.0000000,8.0000000); //object(desn2_graves)(1)
	CreateObject(3249,-2067.4228516,-7629.3164062,1.8240147,0.0000000,0.0000000,205.9936523); //object(des_westsaloon_)(1)
	CreateObject(16690,-2041.8210449,-7650.4287109,5.2282715,0.0000000,0.0000000,25.9881592); //object(des_westsaloon_02)(1)
	CreateObject(16051,-2063.6123047,-7621.0205078,5.3241577,0.0000000,0.0000000,295.9991455); //object(des_westsaloon_01)(1)
	CreateObject(16105,-2054.0625000,-7619.6005859,3.7141542,0.0000000,0.0000000,293.9996338); //object(des_westrn11_04)(1)
	CreateObject(711,-2051.6850586,-7614.5937500,7.4207993,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(1)
	CreateObject(711,-2074.2119141,-7630.2626953,8.1707993,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(2)
	CreateObject(711,-2039.9179688,-7614.2939453,7.9207993,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(3)
	CreateObject(837,-2048.8925781,-7618.1914062,2.6956103,0.0000000,0.0000000,291.9946289); //object(dead_tree_1)(1)
	CreateObject(711,-2058.1171875,-7637.7607422,8.6707993,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(4)
	CreateObject(711,-2085.1240234,-7656.3964844,22.1707993,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateObject(711,-2079.0361328,-7670.5058594,17.7718258,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(9)
	CreateObject(746,-2042.0986328,-7608.6279297,2.0394743,0.0000000,0.0000000,17.9956055); //object(sm_scrub_rock2)(1)
	CreateObject(750,-2094.1042481,-7639.2153320,16.5030804,0.0000000,0.0000000,0.0000000); //object(sm_scrb_column2)(1)
	CreateObject(855,-2122.5229492,-7604.0375977,0.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(1)
	CreateObject(855,-2118.8051758,-7604.0429688,-0.8247299,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(2)
	CreateObject(855,-2114.6708984,-7606.5893555,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(3)
	CreateObject(855,-2110.8691406,-7606.3593750,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(4)
	CreateObject(855,-2113.2226562,-7605.5146484,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(5)
	CreateObject(855,-2116.5175781,-7604.3320312,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(6)
	CreateObject(855,-2121.7011719,-7606.1909180,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(7)
	CreateObject(855,-2121.0009766,-7610.1611328,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(8)
	CreateObject(855,-2107.1728516,-7609.7285156,1.4252701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(17)
	CreateObject(855,-2108.3144531,-7608.0117188,0.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(18)
	CreateObject(855,-2104.9877930,-7611.0439453,0.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(19)
	CreateObject(855,-2106.8403320,-7613.0742188,0.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(20)
	CreateObject(855,-2111.0791016,-7613.2675781,0.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(21)
	CreateObject(855,-2116.2260742,-7612.9716797,0.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(22)
	CreateObject(855,-2115.8886719,-7612.6025391,2.9252701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(23)
	CreateObject(855,-2113.0249023,-7609.4648438,2.9252701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(24)
	CreateObject(855,-2110.4533691,-7611.4702148,2.9252701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(25)
	CreateObject(855,-2104.0615234,-7615.4375000,2.9252701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateObject(855,-2105.8300781,-7618.5458984,0.9252701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(30)
	CreateObject(855,-2109.5654297,-7618.2236328,5.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(31)
	CreateObject(855,-2107.7009277,-7614.5048828,5.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(39)
	CreateObject(855,-2107.7001953,-7614.5048828,5.1752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(40)
	CreateObject(1610,-2050.0810547,-7609.0312500,1.7020721,0.0000000,0.0000000,0.0000000); //object(sandcastle1)(1)
	CreateObject(2782,-2094.1220703,-7639.8862305,21.4331112,0.0000000,0.0000000,338.0000000); //object(cj_oyster_2)(1)
	CreateObject(711,-2100.1972656,-7637.9248047,22.1707993,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(20)
	CreateObject(711,-2111.6184082,-7697.5205078,24.5930672,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(22)
	CreateObject(711,-2092.0126953,-7699.6083984,24.5930672,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateObject(711,-2118.5449219,-7644.1708984,18.5930672,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(24)
	CreateObject(3461,-2100.0214844,-7726.3544922,32.7479019,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(1)
	CreateObject(3461,-2093.2968750,-7728.3525391,33.0891571,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(2)
	CreateObject(3461,-2093.8515625,-7712.7236328,26.6715660,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(3)
	CreateObject(3461,-2088.6425781,-7714.6591797,26.8161583,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(4)
	CreateObject(3461,-2090.4062500,-7703.0322266,22.4768982,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(5)
	CreateObject(3461,-2077.8183594,-7686.2617188,16.6672363,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(6)
	CreateObject(3461,-2085.7324219,-7704.8720703,22.3755760,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(7)
	CreateObject(3461,-2082.0751953,-7684.8701172,16.5199318,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(8)
	CreateObject(3461,-2075.2568359,-7670.1025391,12.9233408,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(9)
	CreateObject(3461,-2069.6787109,-7671.3496094,13.1957521,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(10)
	CreateObject(3524,-2072.0839844,-7662.6376953,11.6257477,0.0000000,0.0000000,149.9963379); //object(skullpillar01_lvs)(1)
	CreateObject(3524,-2066.3886719,-7665.2128906,11.6257477,0.0000000,0.0000000,155.9908447); //object(skullpillar01_lvs)(2)
	CreateObject(711,-2111.6181641,-7697.5205078,24.5930672,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(25)
	CreateObject(711,-2128.1679688,-7723.9843750,37.8341942,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(33)
	CreateObject(2906,-2026.5169678,-7636.0288086,0.2279943,70.0000000,0.0000000,106.0000000); //object(kmb_deadarm)(1)
	CreateObject(855,-2100.1325684,-7616.8037109,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateObject(855,-2101.3825684,-7621.2827148,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateObject(855,-2099.8388672,-7623.2500000,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateObject(855,-2095.7133789,-7624.4619141,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateObject(855,-2096.3300781,-7623.6748047,1.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateObject(855,-2098.6442871,-7621.3374023,2.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateObject(855,-2101.3242188,-7624.9492188,2.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateObject(855,-2105.1650391,-7621.7016602,3.6752701,0.0000000,0.0000000,0.0000000); //object(genveg_tallgrass01)(26)
	CreateObject(10409,-2105.5390625,-7727.3583984,27.3339996,0.0000000,0.0000000,251.9989014); //object(hc_golfcrse09_sfs)(55)
	CreateObject(10409,-2104.5922852,-7725.8886719,19.6664009,0.0000000,0.0000000,251.9989014); //object(hc_golfcrse09_sfs)(57)
	CreateObject(10409,-2103.3664551,-7732.8613281,18.1664009,0.0000000,0.0000000,251.9989014); //object(hc_golfcrse09_sfs)(58)
	CreateObject(18228,-2042.4100342,-7764.8798828,0.0000000,0.0000000,0.0000000,36.0000000); //object(cunt_rockgp2_21)(3)
	CreateObject(18228,-2058.5739746,-7795.7514648,0.0000000,0.0000000,0.0000000,357.9967041); //object(cunt_rockgp2_21)(4)
	CreateObject(18228,-2127.4396973,-7627.2460938,-4.2500000,0.0000000,0.0000000,233.9949951); //object(cunt_rockgp2_21)(5)
	CreateObject(18228,-2023.9123535,-7709.1137695,-12.2500000,0.0000000,0.0000000,39.9902344); //object(cunt_rockgp2_21)(6)
	CreateObject(18228,-2022.9575195,-7686.8691406,-3.8886833,0.0000000,0.0000000,31.9949951); //object(cunt_rockgp2_21)(8)
	CreateObject(18228,-2128.0820312,-7653.0410156,-4.2500000,0.0000000,0.0000000,237.9913330); //object(cunt_rockgp2_21)(9)
	CreateObject(18228,-2127.6586914,-7667.8330078,-1.5000000,0.0000000,0.0000000,237.9913330); //object(cunt_rockgp2_21)(10)
	CreateObject(18228,-2130.2604981,-7694.2666016,-6.0000000,0.0000000,0.0000000,237.9913330); //object(cunt_rockgp2_21)(11)
	CreateObject(18228,-2130.2597656,-7694.2666016,0.7500000,0.0000000,0.0000000,237.9913330); //object(cunt_rockgp2_21)(12)
	CreateObject(18228,-2132.8496094,-7702.2597656,0.7500000,0.0000000,0.0000000,229.9877930); //object(cunt_rockgp2_21)(13)
	CreateObject(18228,-2153.6748047,-7713.7563477,14.2500000,0.0000000,0.0000000,179.9877930); //object(cunt_rockgp2_21)(14)
	CreateObject(18228,-2159.6213379,-7702.8701172,1.2500000,0.0000000,0.0000000,179.9835205); //object(cunt_rockgp2_21)(15)
	CreateObject(18228,-2159.6210938,-7702.8701172,1.2500000,0.0000000,0.0000000,179.9835205); //object(cunt_rockgp2_21)(16)
	CreateObject(18228,-2163.2722168,-7714.1958008,12.0000000,0.0000000,0.0000000,199.9835205); //object(cunt_rockgp2_21)(17)
	CreateObject(18228,-2166.0439453,-7706.1601562,1.5000000,0.0000000,0.0000000,199.9731445); //object(cunt_rockgp2_21)(18)
	CreateObject(18228,-2171.8359375,-7719.2661133,11.5000000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(19)
	CreateObject(18228,-2178.3566894,-7719.0332031,29.7500000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(20)
	CreateObject(18228,-2180.4304199,-7710.4267578,17.2500000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(21)
	CreateObject(18228,-2183.3876953,-7704.6376953,10.2500000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(22)
	CreateObject(18228,-2186.9145508,-7697.7353516,2.2500000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(23)
	CreateObject(18228,-2193.0917969,-7727.7421875,18.5000000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(24)
	CreateObject(18228,-2201.8417969,-7727.9643555,2.5000000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(25)
	CreateObject(18228,-2180.6689453,-7725.2216797,37.5000000,0.0000000,0.0000000,199.9731445); //object(cunt_rockgp2_21)(26)
	CreateObject(18228,-2173.7800293,-7748.9477539,37.5000000,0.0000000,0.0000000,259.9786377); //object(cunt_rockgp2_21)(27)
	CreateObject(18228,-2190.5173340,-7757.5468750,19.2500000,0.0000000,0.0000000,259.9749756); //object(cunt_rockgp2_21)(28)
	CreateObject(18228,-2202.4040527,-7762.4746094,1.0000000,0.0000000,0.0000000,259.9749756); //object(cunt_rockgp2_21)(29)
	CreateObject(18228,-2179.9916992,-7759.4296875,1.0000000,0.0000000,0.0000000,289.9749756); //object(cunt_rockgp2_21)(30)
	CreateObject(18228,-2177.2666016,-7707.1035156,11.5000000,0.0000000,0.0000000,199.9731445); //object(cunt_rockgp2_21)(31)
	CreateObject(18228,-2199.9726562,-7712.9916992,14.7500000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(33)
	CreateObject(18228,-2208.2011719,-7701.6806641,7.5000000,0.0000000,0.0000000,199.9731445); //object(cunt_rockgp2_21)(34)
	CreateObject(18228,-2209.3935547,-7742.4218750,5.5000000,0.0000000,0.0000000,259.9749756); //object(cunt_rockgp2_21)(35)
	CreateObject(18228,-2160.8081055,-7714.9501953,14.2500000,0.0000000,0.0000000,177.9835205); //object(cunt_rockgp2_21)(36)
	CreateObject(18228,-2062.8613281,-7794.7851562,10.2500000,0.0000000,0.0000000,329.9963379); //object(cunt_rockgp2_21)(37)
	CreateObject(18228,-2089.4753418,-7797.6562500,4.7500000,0.0000000,0.0000000,329.9963379); //object(cunt_rockgp2_21)(38)
	CreateObject(18228,-2088.3398438,-7787.8359375,18.7500000,0.0000000,0.0000000,309.9902344); //object(cunt_rockgp2_21)(39)
	CreateObject(18228,-2108.8525391,-7757.3886719,30.5000000,0.0000000,0.0000000,39.9902344); //object(cunt_rockgp2_21)(40)
	CreateObject(18228,-2130.2346191,-7777.9223633,24.5000000,0.0000000,0.0000000,289.9887695); //object(cunt_rockgp2_21)(42)
	CreateObject(18228,-2137.9902344,-7795.2519531,5.2500000,0.0000000,0.0000000,289.9841309); //object(cunt_rockgp2_21)(43)
	CreateObject(18228,-2153.7329102,-7772.8896484,5.2500000,0.0000000,0.0000000,293.9841309); //object(cunt_rockgp2_21)(44)
	CreateObject(18228,-2168.7634277,-7785.0517578,5.2500000,0.0000000,0.0000000,307.9831543); //object(cunt_rockgp2_21)(45)
	CreateObject(18228,-2058.4509277,-7805.5732422,-1.7500000,0.0000000,0.0000000,329.9963379); //object(cunt_rockgp2_21)(46)
	CreateObject(18228,-2162.1645508,-7766.6196289,20.0000000,0.0000000,0.0000000,305.9749756); //object(cunt_rockgp2_21)(47)
	CreateObject(18228,-2165.1953125,-7760.4140625,28.7500000,0.0000000,0.0000000,319.9713135); //object(cunt_rockgp2_21)(48)
	CreateObject(18228,-2170.5039062,-7753.7050781,36.2500000,0.0000000,0.0000000,319.9713135); //object(cunt_rockgp2_21)(49)
	CreateObject(18228,-2164.3654785,-7750.5161133,36.2500000,0.0000000,0.0000000,329.9713135); //object(cunt_rockgp2_21)(50)
	CreateObject(18228,-2175.9804688,-7763.4282227,28.0000000,0.0000000,0.0000000,305.9688721); //object(cunt_rockgp2_21)(51)
	CreateObject(18228,-2194.3469238,-7773.4877930,13.0000000,0.0000000,0.0000000,305.9637451); //object(cunt_rockgp2_21)(52)
	CreateObject(18228,-2204.5319824,-7782.0224609,3.7500000,0.0000000,0.0000000,293.9637451); //object(cunt_rockgp2_21)(53)
	CreateObject(18228,-2023.9121094,-7709.1132812,-12.2500000,0.0000000,0.0000000,39.9902344); //object(cunt_rockgp2_21)(54)
	CreateObject(18228,-2032.9013672,-7729.9648438,0.0000000,0.0000000,0.0000000,39.9902344); //object(cunt_rockgp2_21)(55)
	CreateObject(18228,-2014.3466797,-7657.4814453,-9.6386833,0.0000000,0.0000000,83.9849854); //object(cunt_rockgp2_21)(56)
	CreateObject(8483,-2141.6123047,-7748.5195312,38.9770126,0.0000000,0.0000000,73.9819336); //object(pirateland02_lvs)(3)
	CreateObject(18228,-2117.0849609,-7765.7192383,30.5000000,0.0000000,0.0000000,279.9887695); //object(cunt_rockgp2_21)(58)
	CreateObject(18228,-2131.9912109,-7768.1845703,35.2500000,0.0000000,0.0000000,279.9865723); //object(cunt_rockgp2_21)(59)
	CreateObject(18228,-2128.1982422,-7782.6699219,19.7500000,0.0000000,0.0000000,279.9865723); //object(cunt_rockgp2_21)(60)
	CreateObject(18228,-2112.2287598,-7612.6230469,-9.5000000,0.0000000,0.0000000,117.9923096); //object(cunt_rockgp2_21)(61)
	CreateObject(18228,-2121.4511719,-7608.6787109,-9.5000000,0.0000000,0.0000000,127.9852295); //object(cunt_rockgp2_21)(62)
	CreateObject(3434,-2140.0322266,-7741.9482422,44.8849983,0.0000000,0.0000000,161.9869385); //object(skllsgn01_lvs)(2)
	CreateObject(1431,-2049.5732422,-7615.0019531,2.7391636,0.0000000,0.0000000,0.0000000); //object(dyn_box_pile)(1)
	CreateObject(935,-2066.3583984,-7620.1826172,2.5155544,0.0000000,0.0000000,0.0000000); //object(cj_drum)(1)
	CreateObject(3243,-2105.4169922,-7647.0283203,17.8596230,0.0000000,0.0000000,221.9897461); //object(tepee_room_)(1)
	CreateObject(3243,-2086.4267578,-7651.6474609,17.3596230,0.0000000,0.0000000,107.9901123); //object(tepee_room_)(2)
	CreateObject(11427,-2066.4296875,-7724.3447266,23.6646576,0.0000000,0.0000000,273.9935303); //object(des_adobech)(1)
	CreateObject(5777,-2099.5976562,-7639.8193359,17.9263420,0.0000000,0.0000000,255.9979248); //object(tombston01_lawn)(1)
	CreateObject(2895,-2099.8232422,-7640.5947266,17.6321888,0.0000000,0.0000000,0.0000000); //object(fun_flower_law)(1)
	CreateObject(16689,-2071.9433594,-7762.6484375,36.0832710,0.0000000,0.0000000,11.9915771); //object(des_westrn7_02)(1)
	CreateObject(3461,-2094.7138672,-7740.5292969,34.8603020,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(6)
	CreateObject(3461,-2104.8818359,-7735.2851562,34.3212128,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(6)
	CreateObject(18228,-2109.4785156,-7765.7011719,30.5000000,0.0000000,0.0000000,271.9830322); //object(cunt_rockgp2_21)(63)
	CreateObject(16285,-2063.8000488,-7777.7001953,33.0999985,0.0000000,0.0000000,0.0000000); //object(des_westrn7_03)(1)
	CreateObject(2780,-2144.3366699,-7742.7075195,34.2502327,0.0000000,0.0000000,0.0000000); //object(cj_smoke_mach)(11)
	CreateObject(2780,-2130.4155273,-7744.8330078,34.2502327,0.0000000,0.0000000,0.0000000); //object(cj_smoke_mach)(12)
	CreateObject(2780,-2138.8811035,-7743.7475586,33.5002327,0.0000000,0.0000000,0.0000000); //object(cj_smoke_mach)(14)
	CreateObject(2780,-2140.3300781,-7746.9326172,47.7502327,0.0000000,0.0000000,0.0000000); //object(cj_smoke_mach)(15)
	CreateObject(3524,-2139.0537109,-7742.7500000,32.9286575,0.0000000,0.0000000,169.9969482); //object(skullpillar01_lvs)(3)
	CreateObject(3528,-2137.8278809,-7744.9760742,41.9174042,0.0000000,344.9926758,53.9979248); //object(vgsedragon)(1)
	CreateObject(3528,-2140.7412109,-7744.3662109,41.6674042,0.0000000,344.9871826,75.9979248); //object(vgsedragon)(2)
	CreateObject(14608,-2121.3964844,-7718.5488281,23.3348312,0.0000000,0.0000000,289.9946289); //object(triad_buddha01)(2)
	CreateObject(1313,-2077.8613281,-7753.5585938,35.8942223,0.0000000,0.0000000,0.0000000); //object(killfrenzy2plyr)(1)
	CreateObject(2045,-2137.1433106,-7734.1743164,33.1017571,0.0000000,0.0000000,0.0000000); //object(cj_bbat_nails)(1)
	CreateObject(3364,-2038.8000488,-7662.3999023,13.5000000,4.0000000,0.0000000,215.9966888); //object(des_ruin3_)(1)
	CreateObject(16502,-2015.9443359,-7661.8613281,11.3339825,0.0000000,0.0000000,23.9996338); //object(cn2_jetty1)(1)
	CreateObject(749,-2007.6063232,-7667.9345703,-3.0883808,0.0000000,0.0000000,0.0000000); //object(sm_scrb_column3)(2)
	CreateObject(749,-2010.8538818,-7667.8457031,-3.3383808,0.0000000,0.0000000,0.0000000); //object(sm_scrb_column3)(3)
	CreateObject(758,-2118.4687500,-7731.0546875,31.7370377,0.0000000,0.0000000,0.0000000); //object(sm_scrub_rock6)(1)
	CreateObject(711,-2121.7187500,-7736.2451172,39.1824265,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateObject(711,-2157.2338867,-7710.0473633,57.1569099,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateObject(711,-2154.9204102,-7721.2636719,57.2040138,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateObject(711,-2159.9663086,-7743.5605469,58.3275375,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateObject(711,-2169.9487305,-7723.7724609,58.1584206,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateObject(711,-2151.0046387,-7736.6367188,57.7669105,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateObject(711,-2146.4006348,-7740.4228516,49.3488884,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateObject(711,-2091.7871094,-7738.0761719,39.3907394,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateObject(711,-2070.8583984,-7772.6669922,38.8634186,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateObject(711,-2068.6015625,-7746.2695312,38.7343826,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(23)
	CreateObject(711,-2122.6694336,-7681.6025391,23.9806976,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateObject(711,-2026.0341797,-7655.1279297,17.9575558,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateObject(711,-2052.1289062,-7662.2695312,19.2276668,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateObject(711,-2047.2607422,-7722.5214844,21.5943260,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateObject(711,-2031.1933594,-7686.1445312,19.0006161,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateObject(711,-2044.9404297,-7680.7587891,19.8836155,0.0000000,0.0000000,0.0000000); //object(vgs_palm02)(8)
	CreateObject(803,-2086.7763672,-7660.2421875,18.9036121,0.0000000,0.0000000,0.0000000); //object(genveg_bush09)(1)
	CreateObject(808,-2076.2570801,-7643.5795898,4.4592061,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(1)
	CreateObject(808,-2047.8635254,-7722.4370117,16.9404411,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(2)
	CreateObject(808,-2038.7812500,-7626.1943359,3.5464511,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(3)
	CreateObject(808,-2027.2099609,-7654.2275391,14.0442267,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(4)
	CreateObject(808,-2135.1777344,-7721.7783203,35.1689987,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(5)
	CreateObject(808,-2089.7783203,-7762.7607422,34.8629494,0.0000000,0.0000000,0.0000000); //object(genveg_bush12)(6)
	CreateObject(648,-2207.2680664,-7694.1987305,14.4877014,0.0000000,41.0000000,128.0000000); //object(veg_palm01)(1)
	CreateObject(710,-2031.8701172,-7644.2636719,16.7120590,0.0000000,0.0000000,0.0000000); //object(vgs_palm01)(1)
	CreateObject(18228,-2180.6220703,-7742.3662109,37.5000000,0.0000000,0.0000000,243.9733887); //object(cunt_rockgp2_21)(64)
	CreateObject(3461,-2124.3251953,-7716.4150391,23.1778927,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(3)
	CreateObject(3461,-2117.5273438,-7719.1191406,22.9630699,0.0000000,0.0000000,0.0000000); //object(tikitorch01_lvs)(3)
	CreateObject(2631,-2120.3076172,-7716.6376953,21.6839886,0.0000000,0.0000000,335.9948731); //object(gym_mat1)(1)
	CreateObject(2869,-2120.2656250,-7717.0263672,21.7376594,0.0000000,0.0000000,301.9976807); //object(gb_ornament04)(1)
	CreateObject(14705,-2121.6999512,-7716.7998047,21.8999996,0.0000000,0.0000000,0.0000000); //object(int2vase)(1)
	CreateObject(2096,-2080.0976562,-7753.0214844,33.2954788,0.0000000,0.0000000,129.9957275); //object(cj_rockingchair)(1)
	CreateObject(838,-2048.9785156,-7743.1435547,18.5378342,0.0000000,0.0000000,0.0000000); //object(dead_tree_9)(1)
	CreateObject(18228,-2213.1970215,-7693.6918945,1.2500000,0.0000000,0.0000000,181.9786377); //object(cunt_rockgp2_21)(66)
	CreateObject(710,-2090.9824219,-7777.9228516,47.7165565,0.0000000,0.0000000,0.0000000); //object(vgs_palm01)(2)
	CreateObject(710,-2170.9919434,-7719.1513672,64.0459747,0.0000000,0.0000000,0.0000000); //object(vgs_palm01)(3)
	CreateObject(9831,-2122.8876953,-7721.5693359,23.3250923,0.0000000,0.0000000,331.9958496); //object(sfw_waterfall)(1)
	CreateObject(9831,-2120.6591797,-7721.3916016,23.3250923,0.0000000,0.0000000,331.9903564); //object(sfw_waterfall)(15)
	CreateObject(9831,-2123.5058594,-7719.7451172,22.8250923,0.0000000,0.0000000,31.9921875); //object(sfw_waterfall)(16)
	CreateObject(1517,-2079.7561035,-7753.2255859,32.7452316,0.0000000,0.0000000,0.0000000); //object(dyn_wine_break)(1)
	CreateObject(1520,-2066.3242188,-7620.0664062,3.0794585,0.0000000,0.0000000,0.0000000); //object(dyn_wine_bounce)(1)
	CreateObject(1667,-2066.4746094,-7620.1630859,3.1535432,0.0000000,0.0000000,0.0000000); //object(propwineglass1)(1)
	CreateObject(1736,-2079.1230469,-7753.8271484,34.8935966,0.0000000,0.0000000,208.0000000); //object(cj_stags_head)(1)
	CreateObject(1828,-2054.8654785,-7617.0483398,1.6118135,0.0000000,0.0000000,0.0000000); //object(man_sdr_rug)(1)
	CreateObject(18228,-2046.0732422,-7789.4160156,-5.0000000,0.0000000,0.0000000,329.9963379); //object(cunt_rockgp2_21)(37)
	CreateObject(18228,-2025.4140625,-7771.0830078,-15.2500000,0.0000000,0.0000000,27.9931641); //object(cunt_rockgp2_21)(37)
	CreateObject(18228,-2217.6384277,-7732.8471680,-7.5000000,0.0000000,0.0000000,271.9749756); //object(cunt_rockgp2_21)(35)
	CreateObject(18228,-2218.6240234,-7766.5830078,-7.5000000,0.0000000,0.0000000,285.9720459); //object(cunt_rockgp2_21)(35)
	CreateObject(18228,-2216.1665039,-7776.4511719,-7.5000000,0.0000000,0.0000000,319.9686279); //object(cunt_rockgp2_21)(35)
	CreateObject(18228,-2208.5344238,-7779.4404297,-7.5000000,0.0000000,0.0000000,7.9658203); //object(cunt_rockgp2_21)(35)
	CreateObject(18228,-2188.6933594,-7787.8525391,-7.5000000,0.0000000,0.0000000,27.9650879); //object(cunt_rockgp2_21)(35)
	CreateObject(18228,-2111.1958008,-7761.4521484,30.5000000,0.0000000,0.0000000,25.9902344); //object(cunt_rockgp2_21)(40)
	CreateObject(18228,-2110.3432617,-7770.3813477,30.5000000,0.0000000,0.0000000,269.9830322); //object(cunt_rockgp2_21)(63)
	CreateObject(18228,-2081.4482422,-7789.5756836,18.7500000,0.0000000,0.0000000,297.9902344); //object(cunt_rockgp2_21)(39)
	CreateObject(18228,-2187.1354981,-7745.0781250,28.5000000,0.0000000,0.0000000,243.9733887); //object(cunt_rockgp2_21)(64)
	CreateObject(18228,-2197.6411133,-7744.9267578,14.7500000,0.0000000,0.0000000,243.9733887); //object(cunt_rockgp2_21)(64)
	CreateObject(18228,-2211.1794434,-7693.7905273,-2.2500000,0.0000000,0.0000000,199.9731445); //object(cunt_rockgp2_21)(34)
	CreateObject(18228,-2187.5478516,-7718.1748047,25.2500000,0.0000000,0.0000000,199.9786377); //object(cunt_rockgp2_21)(26)
	CreateObject(18228,-2215.0410156,-7750.0004883,1.7500000,0.0000000,0.0000000,259.9749756); //object(cunt_rockgp2_21)(35)
	CreateObject(18228,-2231.0366211,-7754.5312500,-12.0000000,0.0000000,0.0000000,259.9749756); //object(cunt_rockgp2_21)(35)
	CreateObject(3872,-2171.2597656,-7726.1523438,94.3365097,0.0000000,0.0000000,299.9981689); //object(ws_floodbeams)(1)
	CreateObject(18228,-2166.8906250,-7702.4448242,1.7500000,0.0000000,0.0000000,221.9731445); //object(cunt_rockgp2_21)(31)
	CreateObject(18228,-2158.6037598,-7707.2460938,1.7500000,0.0000000,0.0000000,207.9677734); //object(cunt_rockgp2_21)(31)
	CreateObject(900,-2157.5981445,-7665.7988281,-6.0000000,0.0000000,0.0000000,0.0000000); //object(searock04)(1)
	CreateObject(900,-2151.0996094,-7648.9746094,-6.0000000,0.0000000,0.0000000,0.0000000); //object(searock04)(2)
	CreateObject(900,-2135.6938477,-7661.1860352,-6.0000000,0.0000000,0.0000000,344.0000000); //object(searock04)(3)
	CreateObject(900,-2140.1960449,-7671.9873047,-5.2500000,0.0000000,0.0000000,351.9984131); //object(searock04)(4)
	CreateObject(900,-2139.6005859,-7659.2587891,-5.0000000,0.0000000,0.0000000,0.0000000); //object(searock04)(9)
	CreateObject(18228,-2138.7749023,-7648.4213867,-9.5000000,0.0000000,0.0000000,231.9625244); //object(cunt_rockgp2_21)(18)
	CreateObject(18228,-2125.2451172,-7794.0112305,6.2500000,0.0000000,0.0000000,279.9865723); //object(cunt_rockgp2_21)(60)
	CreateObject(18228,-2181.0603027,-7732.5898438,36.0000000,0.0000000,0.0000000,213.9733887); //object(cunt_rockgp2_21)(64)
	CreateObject(18228,-2164.6660156,-7753.1206055,41.5000000,0.0000000,0.0000000,335.9713135); //object(cunt_rockgp2_21)(48)
	CreateObject(18228,-2170.4782715,-7762.6337891,29.5000000,0.0000000,0.0000000,335.9674072); //object(cunt_rockgp2_21)(48)
	CreateObject(18228,-2182.9541016,-7750.8593750,23.5000000,0.0000000,0.0000000,327.9638672); //object(cunt_rockgp2_21)(48)
	CreateObject(18228,-2173.0117188,-7769.7988281,18.7500000,0.0000000,0.0000000,335.9619141); //object(cunt_rockgp2_21)(48)
	CreateObject(18228,-2011.4984131,-7662.1625977,-9.6386833,0.0000000,0.0000000,83.9904785); //object(cunt_rockgp2_21)(56)
	CreateObject(622,-2156.6665039,-7797.4887695,13.5943832,0.0000000,0.0000000,248.0000000); //object(veg_palm03)(1)
	CreateObject(18228,-2081.4609375,-7807.1586914,0.2500000,0.0000000,0.0000000,309.9902344); //object(cunt_rockgp2_21)(39)
	CreateObject(18228,-2133.1745606,-7812.2416992,-13.2500000,0.0000000,0.0000000,279.9865723); //object(cunt_rockgp2_21)(60)
	CreateObject(18228,-2091.6181641,-7817.5532227,-13.2500000,0.0000000,0.0000000,331.9865723); //object(cunt_rockgp2_21)(60)
	CreateObject(18228,-2047.7703857,-7805.0346680,-13.2500000,0.0000000,0.0000000,5.9848633); //object(cunt_rockgp2_21)(60)
	CreateObject(18228,-2012.6967773,-7728.9047852,-16.2500000,0.0000000,0.0000000,61.9820557); //object(cunt_rockgp2_21)(60)
	CreateObject(1458,-2048.9843750,-7626.1025391,2.4700000,0.0000000,0.0000000,341.9989014); //object(dyn_cart)(1)
	CreateObject(16406,-2200.0524902,-7794.8593750,16.2338486,0.0000000,0.0000000,40.0000000); //object(desn2_weemineb)(1)
	CreateObject(18228,-2192.6025391,-7757.6489258,8.2500000,0.0000000,0.0000000,327.9638672); //object(cunt_rockgp2_21)(48)
	CreateObject(18228,-2173.4072266,-7771.4291992,16.5000000,0.0000000,0.0000000,335.9619141); //object(cunt_rockgp2_21)(48)
	CreateObject(16404,-2112.3005371,-7677.0405273,20.0237770,0.0000000,0.0000000,0.0000000); //object(desn2_hutskel2)(1)
	CreateObject(1451,-2060.2587891,-7766.2021484,33.6803551,0.0000000,0.0000000,0.0000000); //object(dyn_coup)(1)
	CreateObject(1454,-2086.5524902,-7770.0668945,33.5004845,0.0000000,0.0000000,0.0000000); //object(dyn_h_bale2)(1)
	CreateObject(6865,-2145.0986328,-7725.3212891,42.4707451,0.0000000,0.0000000,127.9962158); //object(steerskull)(1)
	CreateObject(1486,-2098.7487793,-7571.0405273,10.2123203,0.0000000,0.0000000,0.0000000); //object(dyn_beer_1)(1)
	CreateObject(1433,-2100.4768066,-7568.8222656,9.1228495,0.0000000,0.0000000,0.0000000); //object(dyn_table_1)(1)
	CreateObject(1609,-2013.2897949,-7648.1699219,0.0000000,0.0000000,0.0000000,0.0000000); //object(turtle)(1)
	CreateObject(18228,-2024.5277100,-7634.9394531,-15.6386833,0.0000000,0.0000000,77.9849854); //object(cunt_rockgp2_21)(56)
	CreateObject(18228,-2032.5144043,-7611.6518555,-18.1386833,0.0000000,0.0000000,77.9809570); //object(cunt_rockgp2_21)(56)
	CreateObject(18228,-2029.3835449,-7622.0610352,-15.6386833,0.0000000,0.0000000,77.9809570); //object(cunt_rockgp2_21)(56)
	CreateObject(18228,-2037.0043945,-7603.0527344,-18.6386833,0.0000000,0.0000000,85.9809570); //object(cunt_rockgp2_21)(56)
	CreateObject(18228,-2039.1359863,-7602.0156250,-18.6386833,0.0000000,0.0000000,93.9790039); //object(cunt_rockgp2_21)(56)
	CreateObject(18228,-2126.3449707,-7657.7314453,-4.2500000,0.0000000,0.0000000,237.9913330); //object(cunt_rockgp2_21)(9)
	CreateObject(18228,-2132.9533691,-7706.5097656,4.2500000,0.0000000,0.0000000,229.9877930); //object(cunt_rockgp2_21)(13)
	CreateObject(18228,-2132.9533691,-7716.7661133,6.2500000,0.0000000,0.0000000,229.9877930); //object(cunt_rockgp2_21)(13)
	CreateObject(18228,-2061.3874512,-7791.8793945,14.7500000,0.0000000,0.0000000,329.9963379); //object(cunt_rockgp2_21)(37)
	CreateObject(18228,-2070.9362793,-7791.3408203,17.5000000,0.0000000,0.0000000,313.9963379); //object(cunt_rockgp2_21)(37)
	CreateObject(18228,-2129.0754395,-7767.1704102,35.2500000,0.0000000,0.0000000,279.9865723); //object(cunt_rockgp2_21)(59)


	//civilian cars
	AddStaticVehicleEx(600,-932.5999756,-538.7000122,25.7999992,0.0000000,-1,-1,30); //Picador
	AddStaticVehicleEx(531,-946.7999878,-531.7000122,26.0000000,0.0000000,-1,-1,30); //Tractor
	AddStaticVehicleEx(600,-911.5000000,-514.0999756,25.7999992,0.0000000,-1,-1,30); //Picador
	AddStaticVehicleEx(478,-932.5000000,-496.3999939,26.0000000,163.9999390,-1,-1,30); //Walton
	AddStaticVehicleEx(593,-1375.5000000,-497.2000122,14.6999998,224.0000000,-1,-1,30); //Dodo
	AddStaticVehicleEx(593,-1353.9000244,-482.6000061,14.6999998,186.0000000,-1,-1,30); //Dodo
	AddStaticVehicleEx(592,-1243.8000488,-494.1000061,15.3999996,0.0000000,-1,-1,30); //Andromada
	AddStaticVehicleEx(511,-1451.3000488,-534.0000000,15.6999998,220.0000000,-1,-1,30); //Beagle
	AddStaticVehicleEx(512,-1429.8000488,-516.7000122,14.8000002,186.0000000,-1,-1,30); //Cropdust
	AddStaticVehicleEx(488,-1260.5999756,-621.5000000,14.3999996,0.0000000,-1,-1,30); //News Chopper
	AddStaticVehicleEx(487,-1276.8000488,-619.2999878,14.3999996,0.0000000,-1,-1,30); //Maverick
	AddStaticVehicleEx(487,-1323.8000488,-617.7999878,14.3999996,0.0000000,-1,-1,30); //Maverick
	AddStaticVehicleEx(487,-1346.5000000,-616.9000244,14.3999996,0.0000000,-1,-1,30); //Maverick
	AddStaticVehicleEx(577,-1643.6999512,-150.1999969,13.1000004,316.0000000,-1,-1,30); //AT-400
	AddStaticVehicleEx(519,-1336.0000000,-268.3999939,15.1000004,314.0000000,-1,-1,30); //Shamal
	AddStaticVehicleEx(519,-1379.0999756,-228.3000031,15.1000004,320.0000000,-1,-1,30); //Shamal
	AddStaticVehicleEx(553,-1124.3000488,-191.0000000,16.3999996,124.0000000,-1,-1,30); //Nevada
	AddStaticVehicleEx(515,-1723.9000244,-137.8000031,4.6999998,42.0000000,-1,-1,30); //Roadtrain
	AddStaticVehicleEx(515,-1732.5999756,-146.1999969,4.6999998,42.0000000,-1,-1,30); //Roadtrain
	AddStaticVehicleEx(515,-1740.9000244,-154.3000031,4.6999998,42.0000000,-1,-1,30); //Roadtrain
	AddStaticVehicleEx(606,-1277.8994141,30.7998047,14.1999998,133.9946289,-1,-1,30); //Luggage Trailer A
	AddStaticVehicleEx(607,-1274.7998047,27.5996094,14.1999998,135.9996338,-1,-1,30); //Luggage Trailer B
	AddStaticVehicleEx(511,-1207.9000244,45.4000015,15.6999998,0.0000000,-1,-1,30); //Beagle
	AddStaticVehicleEx(606,-1280.7998047,33.1992188,14.1999998,133.9946289,-1,-1,30); //Luggage Trailer A
	AddStaticVehicleEx(487,-1187.1999512,24.7000008,14.3999996,0.0000000,-1,-1,30); //Maverick
	AddStaticVehicleEx(552,-1260.5000000,9.6999998,13.8999996,134.0000000,-1,-1,30); //Utility
	AddStaticVehicleEx(563,-1223.5999756,-7.0999999,15.0000000,0.0000000,-1,-1,30); //Raindance
	AddStaticVehicleEx(460,-1196.0999756,236.5000000,2.0000000,314.0000000,-1,-1,30); //Skimmer
	AddStaticVehicleEx(552,-1214.1999512,-108.4000015,13.8999996,130.0000000,-1,-1,30); //Utility
	AddStaticVehicleEx(573,-1261.8000488,34.0000000,14.3999996,0.0000000,-1,-1,30); //Duneride
	AddStaticVehicleEx(485,-1262.8000488,14.3000002,13.8000002,134.0000000,-1,-1,30); //Baggage
	AddStaticVehicleEx(455,-1733.6999512,189.0000000,4.0999999,0.0000000,-1,-1,30); //Flatbed
	AddStaticVehicleEx(530,-1704.4000244,4.0999999,3.3000000,0.0000000,-1,-1,30); //Forklift
	AddStaticVehicleEx(530,-1714.0999756,13.6000004,3.4000001,298.0000000,-1,-1,30); //Forklift
	AddStaticVehicleEx(578,-557.7999878,-499.0000000,25.8999996,0.0000000,-1,-1,30); //DFT-30
	AddStaticVehicleEx(578,-529.7000122,-498.8999939,25.8999996,0.0000000,-1,-1,30); //DFT-30
	AddStaticVehicleEx(578,-520.2999878,-499.0000000,25.8999996,0.0000000,-1,-1,30); //DFT-30
	AddStaticVehicleEx(403,-589.7999878,-487.7999878,26.2000008,0.0000000,-1,-1,30); //Linerunner
	AddStaticVehicleEx(403,-585.0000000,-487.3999939,26.2000008,0.0000000,-1,-1,30); //Linerunner
	AddStaticVehicleEx(403,-580.2000122,-487.2000122,26.2000008,0.0000000,-1,-1,30); //Linerunner
	AddStaticVehicleEx(403,-575.0999756,-487.5000000,26.2000008,0.0000000,-1,-1,30); //Linerunner
	AddStaticVehicleEx(514,-589.7000122,-472.1000061,26.2000008,0.0000000,-1,-1,30); //Tanker
	AddStaticVehicleEx(514,-584.7999878,-472.8999939,26.2000008,0.0000000,-1,-1,30); //Tanker
	AddStaticVehicleEx(514,-579.7999878,-473.2999878,26.2000008,0.0000000,-1,-1,30); //Tanker
	AddStaticVehicleEx(584,-616.7999878,-495.2000122,26.7000008,0.0000000,-1,-1,30); //Trailer 3
	AddStaticVehicleEx(584,-611.7000122,-494.3999939,26.7000008,0.0000000,-1,-1,30); //Trailer 3
	AddStaticVehicleEx(435,-607.2000122,-493.3999939,26.2000008,0.0000000,-1,-1,30); //Trailer 1
	AddStaticVehicleEx(450,-602.5000000,-493.5000000,26.2000008,0.0000000,-1,-1,30); //Trailer 2
	AddStaticVehicleEx(591,-598.2000122,-493.3999939,26.2000008,0.0000000,-1,-1,30); //Trailer 3
	AddStaticVehicleEx(524,-524.2999878,-472.5000000,26.6000004,0.0000000,-1,-1,30); //Cement Truck
	AddStaticVehicleEx(524,-519.2000122,-472.7999878,26.6000004,0.0000000,-1,-1,30); //Cement Truck
	AddStaticVehicleEx(515,-529.0999756,-473.3999939,26.7000008,0.0000000,-1,-1,30); //Roadtrain
	AddStaticVehicleEx(515,-565.5000000,-486.7999878,26.7000008,0.0000000,-1,-1,30); //Roadtrain
	AddStaticVehicleEx(515,-544.0000000,-473.7000122,26.7000008,0.0000000,-1,-1,30); //Roadtrain
	AddStaticVehicleEx(420,-1986.6999512,127.6999969,27.5000000,0.0000000,-1,-1,30); //Taxi
	AddStaticVehicleEx(420,-1986.9000244,119.0999985,27.3999996,0.0000000,-1,-1,30); //Taxi
	AddStaticVehicleEx(438,-1987.5999756,151.1000061,27.7000008,0.0000000,-1,-1,30); //Cabbie
	AddStaticVehicleEx(438,-1987.3000488,160.5000000,27.7000008,0.0000000,-1,-1,30); //Cabbie
	AddStaticVehicleEx(538,-1943.5999756,153.1999969,27.2000008,357.9949951,-1,-1,30); //Streak
	AddStaticVehicleEx(525,-2034.4000244,170.0000000,28.7999992,268.0000000,-1,-1,30); //Tow Truck
	AddStaticVehicleEx(525,-2034.3000488,178.3999939,28.7999992,267.9949951,-1,-1,30); //Tow Truck
	AddStaticVehicleEx(445,-2052.3000488,145.8999939,28.7999992,0.0000000,-1,-1,30); //Admiral
	AddStaticVehicleEx(524,-2047.6999512,248.8999939,36.9000015,0.0000000,-1,-1,30); //Cement Truck
	AddStaticVehicleEx(574,-1968.8000488,171.5000000,27.5000000,0.0000000,-1,-1,30); //Sweeper
	AddStaticVehicleEx(411,-2059.6000977,-109.0999985,35.0999985,0.0000000,-1,-1,30); //Infernus
	AddStaticVehicleEx(415,-2062.6999512,-109.5000000,35.2000008,0.0000000,-1,-1,30); //Cheetah
	AddStaticVehicleEx(429,-2065.6000977,-109.4000015,35.0999985,0.0000000,-1,-1,30); //Banshee
	AddStaticVehicleEx(451,-2070.3000488,-108.9000015,35.0999985,0.0000000,-1,-1,30); //Turismo
	AddStaticVehicleEx(477,-2074.3999023,-108.6999969,35.2000008,0.0000000,-1,-1,30); //ZR-350
	AddStaticVehicleEx(506,-2081.0000000,-108.0000000,35.0999985,0.0000000,-1,-1,30); //Super GT
	AddStaticVehicleEx(541,-2084.8999023,-108.0999985,35.0000000,0.0000000,-1,-1,30); //Bullet
	AddStaticVehicleEx(559,-2088.6000977,-107.9000015,35.0999985,0.0000000,-1,-1,30); //Jester
	AddStaticVehicleEx(522,-2091.3000488,-107.5000000,35.0000000,0.0000000,-1,-1,30); //NRG-500
	AddStaticVehicleEx(521,-2093.1000977,-107.0999985,35.0000000,0.0000000,-1,-1,30); //FCR-900
	AddStaticVehicleEx(413,-2113.3000488,-272.6000061,35.5000000,0.0000000,-1,-1,30); //Pony
	AddStaticVehicleEx(482,-2100.3000488,-273.1000061,35.5999985,32.0000000,-1,-1,30); //Burrito
	AddStaticVehicleEx(498,-2135.8999023,-233.8000031,35.5000000,0.0000000,-1,-1,30); //Boxville
	AddStaticVehicleEx(499,-2099.1999512,-221.1999969,35.4000015,0.0000000,-1,-1,30); //Benson
	AddStaticVehicleEx(530,-2185.3000488,-209.3000031,36.2999992,0.0000000,-1,-1,30); //Forklift
	AddStaticVehicleEx(567,-2158.1999512,-197.3000031,35.2999992,0.0000000,-1,-1,30); //Savanna
	AddStaticVehicleEx(448,-1805.0000000,949.5000000,24.6000004,0.0000000,-1,-1,30); //Pizzaboy
	AddStaticVehicleEx(509,-2808.8000488,1118.6999512,27.7999992,0.0000000,-1,-1,30); //Bike
	AddStaticVehicleEx(481,-2807.6000977,1118.6999512,27.7999992,0.0000000,-1,-1,30); //BMX
	AddStaticVehicleEx(510,-2806.3999023,1118.8000488,27.7999992,359.9884033,-1,-1,30); //Mountain Bike
	AddStaticVehicleEx(409,-2754.5000000,367.0000000,4.0999999,0.0000000,-1,-1,30); //Stretch
	AddStaticVehicleEx(409,-2754.1999512,378.3999939,4.0999999,0.0000000,-1,-1,30); //Stretch
	AddStaticVehicleEx(439,-2691.3999023,268.7000122,4.3000002,0.0000000,-1,-1,30); //Stallion
	AddStaticVehicleEx(529,-2681.8999023,268.5000000,4.0999999,0.0000000,-1,-1,30); //Willard
	AddStaticVehicleEx(585,-2671.8000488,268.8999939,4.0000000,0.0000000,-1,-1,30); //Emperor
	AddStaticVehicleEx(404,-2661.3999023,268.2000122,4.1999998,0.0000000,-1,-1,30); //Perrenial
	AddStaticVehicleEx(581,-2656.8000488,75.4000015,3.8000000,0.0000000,-1,-1,30); //BF-400
	AddStaticVehicleEx(482,-2651.0000000,110.3000031,4.4000001,4.2500000,-1,-1,30); //Burrito
	AddStaticVehicleEx(413,-2710.5000000,136.5000000,4.3000002,0.0000000,-1,-1,30); //Pony
	AddStaticVehicleEx(477,-2710.6999512,110.6999969,4.0000000,0.0000000,-1,-1,30); //ZR-350
	AddStaticVehicleEx(477,-2738.6999512,120.0999985,4.4000001,0.0000000,-1,-1,30); //ZR-350
	AddStaticVehicleEx(602,-2729.3999023,77.5000000,4.1999998,0.0000000,-1,-1,30); //Alpha
	AddStaticVehicleEx(483,-2710.6000977,59.9000015,4.3000002,0.0000000,-1,-1,30); //Camper
	AddStaticVehicleEx(483,-2676.3000488,-22.7000008,4.4000001,0.0000000,-1,-1,30); //Camper
	AddStaticVehicleEx(600,-2764.8000488,16.5000000,6.8000002,0.0000000,-1,-1,30); //Picador
	AddStaticVehicleEx(565,-2761.6999512,-32.2000008,6.6999998,0.0000000,-1,-1,30); //Flash
	AddStaticVehicleEx(572,-2685.8000488,16.7000008,4.0000000,0.0000000,-1,-1,30); //Mower
	AddStaticVehicleEx(405,-2683.0000000,-22.2000008,4.3000002,0.0000000,-1,-1,30); //Sentinel
	AddStaticVehicleEx(405,-2617.5000000,-22.0000000,4.3000002,0.0000000,-1,-1,30); //Sentinel
	AddStaticVehicleEx(426,-2630.3000488,-35.0999985,4.1999998,0.0000000,-1,-1,30); //Premier
	AddStaticVehicleEx(426,-2649.5000000,-54.5999985,4.1999998,0.0000000,-1,-1,30); //Premier
	AddStaticVehicleEx(575,-2689.8999023,-54.7999992,4.0999999,0.0000000,-1,-1,30); //Broadway
	AddStaticVehicleEx(518,-2683.3999023,-55.2999992,4.0999999,0.0000000,-1,-1,30); //Buccaneer
	AddStaticVehicleEx(439,-2663.1999512,-55.5999985,4.3000002,0.0000000,-1,-1,30); //Stallion
	AddStaticVehicleEx(603,-2620.1000977,-55.2999992,4.3000002,0.0000000,-1,-1,30); //Phoenix
	AddStaticVehicleEx(410,-2658.0000000,-101.5999985,3.9000001,0.0000000,-1,-1,30); //Manana
	AddStaticVehicleEx(602,-2654.0000000,-158.1000061,4.0000000,0.0000000,-1,-1,30); //Alpha
	AddStaticVehicleEx(457,-2754.3000488,-280.2000122,6.8000002,0.0000000,-1,-1,30); //Caddy
	AddStaticVehicleEx(457,-2756.6999512,-280.3999939,6.8000002,0.0000000,-1,-1,30); //Caddy
	AddStaticVehicleEx(457,-2759.1999512,-280.7999878,6.8000002,0.0000000,-1,-1,30); //Caddy
	AddStaticVehicleEx(457,-2751.6000977,-280.2999878,6.8000002,0.0000000,-1,-1,30); //Caddy
	AddStaticVehicleEx(457,-2761.6000977,-280.7000122,6.8000002,0.0000000,-1,-1,30); //Caddy
	AddStaticVehicleEx(422,-2767.1000977,-294.7999878,7.0999999,0.0000000,-1,-1,30); //Bobcat
	AddStaticVehicleEx(422,-2765.6000977,-311.1000061,7.0999999,0.0000000,-1,-1,30); //Bobcat
	AddStaticVehicleEx(603,-2779.0000000,-282.1000061,7.0000000,0.0000000,-1,-1,30); //Phoenix
	AddStaticVehicleEx(603,-2750.1000977,-295.3999939,7.0000000,0.0000000,-1,-1,30); //Phoenix
	AddStaticVehicleEx(534,-2758.8000488,-182.3000031,6.8000002,0.0000000,-1,-1,30); //Remington
	AddStaticVehicleEx(518,-2758.1999512,-111.0999985,6.6999998,0.0000000,-1,-1,30); //Buccaneer
	AddStaticVehicleEx(412,-2496.0000000,154.6999969,8.0000000,108.0000000,-1,-1,30); //Voodoo
	AddStaticVehicleEx(587,-2530.3999023,314.6000061,34.9000015,70.0000000,-1,-1,30); //Euros
	AddStaticVehicleEx(559,-2509.0000000,332.7999878,34.9000015,246.0000000,-1,-1,30); //Jester
	AddStaticVehicleEx(429,-2497.8000488,357.1000061,35.0000000,240.0000000,-1,-1,30); //Banshee
	AddStaticVehicleEx(602,-2502.6000977,382.0000000,35.0000000,56.0000000,-1,-1,30); //Alpha
	AddStaticVehicleEx(475,-2517.3000488,351.3999939,35.0000000,246.0000000,-1,-1,30); //Sabre
	AddStaticVehicleEx(463,-2477.3000488,412.7000122,27.3999996,320.0000000,-1,-1,30); //Freeway
	AddStaticVehicleEx(463,-2496.1999512,430.2999878,27.3999996,310.0000000,-1,-1,30); //Freeway
	AddStaticVehicleEx(461,-2484.0000000,418.7000122,27.5000000,320.0000000,-1,-1,30); //PCJ-600
	AddStaticVehicleEx(462,-2480.5000000,393.3999939,27.3999996,140.0000000,-1,-1,30); //Faggio
	AddStaticVehicleEx(462,-2489.8000488,400.7000122,27.5000000,140.0000000,-1,-1,30); //Faggio
	AddStaticVehicleEx(429,-2689.6000977,233.5000000,4.1999998,268.0000000,-1,-1,30); //Banshee
	AddStaticVehicleEx(477,-2588.6999512,627.5000000,14.3000002,270.0000000,-1,-1,30); //ZR-350
	AddStaticVehicleEx(401,-2589.1999512,647.5999756,14.3000002,268.0000000,-1,-1,30); //Bravura
	AddStaticVehicleEx(542,-2570.8999023,632.5000000,14.3000002,270.0000000,-1,-1,30); //Clover
	AddStaticVehicleEx(416,-2662.3000488,625.7999878,14.8000002,268.0000000,-1,-1,30); //Ambulance
	AddStaticVehicleEx(421,-2543.3999023,598.5000000,14.5000000,90.0000000,-1,-1,30); //Washington
	AddStaticVehicleEx(546,-2557.8999023,626.0999756,27.6000004,0.0000000,-1,-1,30); //Intruder
	AddStaticVehicleEx(580,-2578.6999512,626.5999756,27.7000008,0.0000000,-1,-1,30); //Stafford
	AddStaticVehicleEx(416,-2638.8000488,624.2000122,14.8000002,267.9949951,-1,-1,30); //Ambulance
	AddStaticVehicleEx(474,-2651.8999023,703.5000000,27.7000008,92.0000000,-1,-1,30); //Hermes
	AddStaticVehicleEx(496,-2434.1000977,741.7000122,34.7999992,0.0000000,-1,-1,30); //Blista Compact
	AddStaticVehicleEx(533,-2425.3000488,741.2999878,34.7999992,0.0000000,-1,-1,30); //Feltzer
	AddStaticVehicleEx(542,-2429.6000977,741.2999878,34.9000015,0.0000000,-1,-1,30); //Clover
	AddStaticVehicleEx(428,-2429.6999512,515.2999878,30.2000008,38.0000000,-1,-1,30); //Securicar
	AddStaticVehicleEx(428,-2419.2998047,525.0996094,30.2000008,49.9998779,-1,-1,30); //Securicar
	AddStaticVehicleEx(428,-2413.8999023,539.9000244,30.2000008,88.0000000,-1,-1,30); //Securicar
	AddStaticVehicleEx(477,-2460.3999023,741.0999756,34.9000015,0.0000000,-1,-1,30); //ZR-350
	AddStaticVehicleEx(558,-2447.1000977,741.2999878,34.7000008,0.0000000,-1,-1,30); //Uranus
	AddStaticVehicleEx(401,-2481.8999023,740.0999756,34.9000015,0.0000000,-1,-1,30); //Bravura
	AddStaticVehicleEx(527,-2407.6000977,741.2000122,34.7999992,0.0000000,-1,-1,30); //Cadrona
	AddStaticVehicleEx(475,-2460.1000977,777.2000122,35.0999985,0.0000000,-1,-1,30); //Sabre
	AddStaticVehicleEx(449,-2257.3999023,534.4000244,36.5999985,0.0000000,-1,-1,30); //Tram
	AddStaticVehicleEx(419,-2354.6999512,983.4000244,50.5999985,4.0000000,-1,-1,30); //Esperanto
	AddStaticVehicleEx(576,-2349.5000000,984.2000122,50.4000015,3.9890137,-1,-1,30); //Tornado
	AddStaticVehicleEx(422,-2423.6000977,952.5999756,45.4000015,268.0000000,-1,-1,30); //Bobcat
	AddStaticVehicleEx(559,-2422.8999023,993.4000244,45.0999985,270.0000000,-1,-1,30); //Jester
	AddStaticVehicleEx(492,-2617.8000488,1375.9000244,7.0000000,0.0000000,-1,-1,30); //Greenwood
	AddStaticVehicleEx(551,-2622.5000000,1376.0000000,7.0000000,0.0000000,-1,-1,30); //Merit
	AddStaticVehicleEx(566,-2629.3000488,1375.8000488,7.0000000,0.0000000,-1,-1,30); //Tahoma
	AddStaticVehicleEx(546,-2646.5000000,1377.8000488,7.0000000,0.0000000,-1,-1,30); //Intruder
	AddStaticVehicleEx(549,-2511.5000000,1209.9000244,37.2999992,88.0000000,-1,-1,30); //Tampa
	AddStaticVehicleEx(405,-2494.6000977,1216.9000244,37.4000015,322.0000000,-1,-1,30); //Sentinel
	AddStaticVehicleEx(529,-2521.1000977,1228.9000244,37.2000008,30.0000000,-1,-1,30); //Willard
	AddStaticVehicleEx(585,-2534.3000488,1228.6999512,37.0999985,32.0000000,-1,-1,30); //Emperor
	AddStaticVehicleEx(581,-1836.9000244,1307.3000488,59.4000015,0.0000000,-1,-1,30); //BF-400
	AddStaticVehicleEx(581,-1831.0999756,1309.0999756,59.4000015,0.0000000,-1,-1,30); //BF-400
	AddStaticVehicleEx(466,-1652.0999756,1310.6999512,7.0000000,314.0000000,-1,-1,30); //Glendale
	AddStaticVehicleEx(421,-1641.6999512,1300.4000244,7.0000000,314.0000000,-1,-1,30); //Washington
	AddStaticVehicleEx(448,-1720.3000488,1365.0999756,6.9000001,0.0000000,-1,-1,30); //Pizzaboy
	AddStaticVehicleEx(445,-1631.1999512,1290.5000000,7.0000000,312.0000000,-1,-1,30); //Admiral
	AddStaticVehicleEx(402,-1658.5000000,1209.9000244,21.1000004,0.0000000,-1,-1,30); //Buffalo
	AddStaticVehicleEx(480,-1658.1999512,1213.8000488,13.5000000,0.0000000,-1,-1,30); //Comet
	AddStaticVehicleEx(462,-1585.5000000,809.4000244,6.5000000,0.0000000,-1,-1,30); //Faggio
	AddStaticVehicleEx(565,-1656.9000244,1213.6999512,6.9000001,338.0000000,-1,-1,30); //Flash
	AddStaticVehicleEx(597,-1574.5000000,726.5999756,-5.4000001,89.9956055,-1,-1,30); //Police Car (SFPD)
	AddStaticVehicleEx(597,-1612.4000244,748.4000244,-5.4000001,180.0000000,-1,-1,30); //Police Car (SFPD)
	AddStaticVehicleEx(597,-1574.4000244,730.5999756,-5.4000001,89.9945068,-1,-1,30); //Police Car (SFPD)
	AddStaticVehicleEx(597,-1574.0999756,722.5999756,-5.4000001,89.9945068,-1,-1,30); //Police Car (SFPD)
	AddStaticVehicleEx(597,-1574.4000244,735.0999756,-5.4000001,90.0000000,-1,-1,30); //Police Car (SFPD)
	AddStaticVehicleEx(597,-1600.1999512,748.5999756,-5.4000001,182.0000000,-1,-1,30); //Police Car (SFPD)
	AddStaticVehicleEx(597,-1596.0000000,748.7000122,-5.4000001,180.0000000,-1,-1,30); //Police Car (SFPD)
	AddStaticVehicleEx(597,-1574.3000488,738.5000000,-5.4000001,90.0000000,-1,-1,30); //Police Car (SFPD)
	AddStaticVehicleEx(597,-1574.5999756,742.7000122,-5.4000001,90.0000000,-1,-1,30); //Police Car (SFPD)
	AddStaticVehicleEx(597,-1587.8000488,748.7000122,-5.4000001,177.9949951,-1,-1,30); //Police Car (SFPD)
	AddStaticVehicleEx(523,-1573.9000244,717.9000244,-5.5999999,90.0000000,-1,-1,30); //HPV1000
	AddStaticVehicleEx(523,-1574.0999756,714.0000000,-5.5999999,90.0000000,-1,-1,30); //HPV1000
	AddStaticVehicleEx(523,-1574.0000000,710.0999756,-5.5999999,90.0000000,-1,-1,30); //HPV1000
	AddStaticVehicleEx(523,-1574.6999512,706.5000000,-5.5999999,90.0000000,-1,-1,30); //HPV1000
	AddStaticVehicleEx(565,-1621.0000000,660.9000244,-5.5999999,0.0000000,-1,-1,30); //Flash
	AddStaticVehicleEx(562,-1623.5999756,653.7000122,-5.5000000,88.0000000,-1,-1,30); //Elegy
	AddStaticVehicleEx(599,-1604.6999512,691.5999756,-4.9000001,0.0000000,-1,-1,30); //Police Ranger
	AddStaticVehicleEx(562,-1623.6999512,649.5999756,-5.5000000,87.9949951,-1,-1,30); //Elegy
	AddStaticVehicleEx(599,-1611.9000244,691.2000122,-4.9000001,0.0000000,-1,-1,30); //Police Ranger
	AddStaticVehicleEx(602,-1638.5999756,649.7999878,-5.3000002,270.0092773,-1,-1,30); //Alpha
	AddStaticVehicleEx(523,-1582.6999512,674.0999756,6.8000002,0.0000000,-1,-1,30); //HPV1000
	AddStaticVehicleEx(523,-1576.5000000,674.0000000,6.9000001,0.0000000,-1,-1,30); //HPV1000
	AddStaticVehicleEx(523,-1587.5999756,673.5999756,6.8000002,0.0000000,-1,-1,30); //HPV1000
	AddStaticVehicleEx(523,-1594.6999512,674.0000000,6.8000002,0.0000000,-1,-1,30); //HPV1000
	AddStaticVehicleEx(497,-1682.0000000,706.0000000,30.8999996,90.0000000,-1,-1,30); //Police Maverick
	AddStaticVehicleEx(528,-1599.4000244,673.0000000,7.4000001,0.0000000,-1,-1,30); //FBI Truck
	AddStaticVehicleEx(528,-1605.0000000,673.5000000,7.4000001,0.0000000,-1,-1,30); //FBI Truck
	AddStaticVehicleEx(581,-1594.0999756,859.0000000,7.1999998,86.0000000,-1,-1,30); //BF-400
	AddStaticVehicleEx(482,-1531.5999756,805.4000244,7.4000001,356.0000000,-1,-1,30); //Burrito
	AddStaticVehicleEx(483,-1525.4000244,860.2999878,7.3000002,0.0000000,-1,-1,30); //Camper
	AddStaticVehicleEx(422,-1674.3000488,438.2999878,7.3000002,0.0000000,-1,-1,30); //Bobcat
	AddStaticVehicleEx(533,-1700.1999512,412.1000061,7.0000000,222.0000000,-1,-1,30); //Feltzer
	AddStaticVehicleEx(517,-1704.8000488,408.0000000,7.0999999,222.0000000,-1,-1,30); //Majestic
	AddStaticVehicleEx(461,-1705.0000000,382.2999878,6.9000001,310.0000000,-1,-1,30); //PCJ-600
	AddStaticVehicleEx(408,-1840.0999756,-14.6999998,15.8999996,0.0000000,-1,-1,30); //Trashmaster
	AddStaticVehicleEx(574,-1835.5999756,-12.1999998,14.8999996,0.0000000,-1,-1,30); //Sweeper
	AddStaticVehicleEx(461,-1707.5000000,384.8999939,6.9000001,310.0000000,-1,-1,30); //PCJ-600
	AddStaticVehicleEx(586,-1710.0000000,387.6000061,6.8000002,310.0000000,-1,-1,30); //Wayfarer
	AddStaticVehicleEx(578,-1830.6999512,-13.5000000,15.8999996,0.0000000,-1,-1,30); //DFT-30
	AddStaticVehicleEx(521,-1713.1999512,390.2999878,6.8000002,310.0000000,-1,-1,30); //FCR-900
	AddStaticVehicleEx(463,-1716.0999756,393.2999878,6.8000002,310.0000000,-1,-1,30); //Freeway
	AddStaticVehicleEx(407,-2021.9000244,92.9000015,28.3999996,270.0000000,-1,-1,30); //Firetruck
	AddStaticVehicleEx(407,-2021.5000000,83.8000031,28.3999996,270.0000000,-1,-1,30); //Firetruck
	AddStaticVehicleEx(544,-2020.8000488,73.0000000,28.6000004,226.0000000,-1,-1,30); //Firetruck LA
	AddStaticVehicleEx(544,-2062.6999512,91.5999985,28.7999992,225.9997559,-1,-1,30); //Firetruck LA
	AddStaticVehicleEx(554,-2081.3000488,61.5000000,34.4000015,272.0000000,-1,-1,30); //Yosemite
	AddStaticVehicleEx(554,-2081.3999023,-83.6999969,35.4000015,0.0000000,-1,-1,30); //Yosemite
	AddStaticVehicleEx(436,-2093.8999023,-83.9000015,35.0000000,0.0000000,-1,-1,30); //Previon
	AddStaticVehicleEx(517,-2064.3999023,-84.4000015,35.0999985,0.0000000,-1,-1,30); //Majestic
	AddStaticVehicleEx(549,-2264.6999512,-161.6999969,35.0000000,0.0000000,-1,-1,30); //Tampa
	AddStaticVehicleEx(518,-2281.1999512,-131.6999969,35.0999985,90.0000000,-1,-1,30); //Buccaneer
	AddStaticVehicleEx(576,-2322.1999512,-123.9000015,35.0999985,0.0000000,-1,-1,30); //Tornado
	AddStaticVehicleEx(445,-2315.3999023,-124.8000031,35.2999992,0.0000000,-1,-1,30); //Admiral
	AddStaticVehicleEx(529,-2337.5000000,-124.0999985,35.0999985,0.0000000,-1,-1,30); //Willard
	AddStaticVehicleEx(566,-2329.8999023,-124.4000015,35.2000008,0.0000000,-1,-1,30); //Tahoma
	AddStaticVehicleEx(566,-2344.6000977,-124.4000015,35.2000008,0.0000000,-1,-1,30); //Tahoma
	AddStaticVehicleEx(547,-2355.6000977,-124.6999969,35.2000008,0.0000000,-1,-1,30); //Primo
	AddStaticVehicleEx(406,-2324.1000977,-101.3000031,36.0999985,0.0000000,-1,-1,30); //Dumper
	AddStaticVehicleEx(480,-2445.6000977,-164.1000061,35.2000008,90.0000000,-1,-1,30); //Comet
	AddStaticVehicleEx(582,-2520.3000488,-602.4000244,132.6999969,0.0000000,-1,-1,30); //Newsvan
	AddStaticVehicleEx(582,-2512.8000488,-602.4000244,132.6999969,0.0000000,-1,-1,30); //Newsvan
	AddStaticVehicleEx(582,-2502.1999512,-602.2999878,132.6999969,0.0000000,-1,-1,30); //Newsvan
	AddStaticVehicleEx(488,-2494.3999023,-685.7000122,139.6000061,0.0000000,-1,-1,30); //News Chopper
	AddStaticVehicleEx(410,-2489.3000488,-172.3000031,25.3999996,0.0000000,-1,-1,30); //Manana
	AddStaticVehicleEx(409,-1761.0999756,954.7999878,24.7000008,90.0000000,-1,-1,30); //Stretch
	AddStaticVehicleEx(526,-2466.3999023,-103.5999985,25.6000004,0.0000000,-1,-1,30); //Fortune
	AddStaticVehicleEx(409,-1747.0000000,955.0999756,24.7000008,90.0000000,-1,-1,30); //Stretch
	AddStaticVehicleEx(549,-2506.1999512,-99.0999985,25.2999992,0.0000000,-1,-1,30); //Tampa
	AddStaticVehicleEx(467,-2505.8999023,-22.2999992,25.5000000,0.0000000,-1,-1,30); //Oceanic
	AddStaticVehicleEx(529,-2550.3999023,22.1000004,16.2000008,0.0000000,-1,-1,30); //Willard
	AddStaticVehicleEx(533,-2550.1999512,-32.4000015,16.2000008,0.0000000,-1,-1,30); //Feltzer
	AddStaticVehicleEx(419,-2599.5000000,54.0000000,4.0999999,0.0000000,-1,-1,30); //Esperanto
	AddStaticVehicleEx(575,-2608.6000977,11.6000004,4.0999999,0.0000000,-1,-1,30); //Broadway
	AddStaticVehicleEx(463,-2590.0000000,73.4000015,4.0999999,110.0000000,-1,-1,30); //Freeway
	AddStaticVehicleEx(409,-2417.8000488,330.2000122,34.9000015,150.0000000,-1,-1,30); //Stretch
	AddStaticVehicleEx(517,-2760.0000000,133.8000031,6.9000001,0.0000000,-1,-1,30); //Majestic
	AddStaticVehicleEx(542,-2754.8000488,178.6000061,6.9000001,0.0000000,-1,-1,30); //Clover
	AddStaticVehicleEx(576,-2795.3000488,238.1000061,6.9000001,0.0000000,-1,-1,30); //Tornado
	AddStaticVehicleEx(507,-2803.8999023,260.3999939,7.0999999,0.0000000,-1,-1,30); //Elegant
	AddStaticVehicleEx(547,-2756.8000488,293.0000000,5.4000001,269.9580078,-1,-1,30); //Primo
	AddStaticVehicleEx(533,-2691.0000000,330.7000122,4.0000000,270.0000000,-1,-1,30); //Feltzer
	AddStaticVehicleEx(565,-2658.0000000,385.2000122,3.8000000,0.0000000,-1,-1,30); //Flash
	AddStaticVehicleEx(410,-2710.6999512,446.5000000,3.9000001,0.0000000,-1,-1,30); //Manana
	AddStaticVehicleEx(549,-2858.8000488,414.5000000,4.4000001,0.0000000,-1,-1,30); //Tampa
	AddStaticVehicleEx(452,-1477.3000488,689.7999878,0.0000000,0.0000000,-1,-1,30); //Speeder
	AddStaticVehicleEx(475,-2807.5000000,461.6000061,5.0999999,270.0000000,-1,-1,30); //Sabre
	AddStaticVehicleEx(454,-1401.9000244,697.7999878,0.0000000,0.0000000,-1,-1,30); //Tropic
	AddStaticVehicleEx(542,-2827.8999023,585.2999878,5.3000002,0.0000000,-1,-1,30); //Clover
	AddStaticVehicleEx(405,-2871.3000488,755.7000122,31.7000008,8.0000000,-1,-1,30); //Sentinel
	AddStaticVehicleEx(467,-2792.1999512,778.0000000,50.2999992,0.0000000,-1,-1,30); //Oceanic
	AddStaticVehicleEx(534,-2763.1000977,766.2000122,52.5999985,0.0000000,-1,-1,30); //Remington
	AddStaticVehicleEx(588,-2458.8000488,792.2000122,35.0000000,0.0000000,-1,-1,30); //Hotdog
	AddStaticVehicleEx(429,-2379.5000000,890.7999878,45.0000000,0.0000000,-1,-1,30); //Banshee
	AddStaticVehicleEx(560,-2197.3000488,1007.5000000,79.8000031,88.0000000,-1,-1,30); //Sultan
	AddStaticVehicleEx(474,-2394.0000000,930.0000000,45.2000008,0.0000000,-1,-1,30); //Hermes
	AddStaticVehicleEx(475,-2408.1000977,903.5999756,45.2999992,90.0000000,-1,-1,30); //Sabre
	AddStaticVehicleEx(549,-2197.1000977,996.7999878,79.9000015,92.0000000,-1,-1,30); //Tampa
	AddStaticVehicleEx(445,-2522.1999512,926.2999878,64.9000015,0.0000000,-1,-1,30); //Admiral
	AddStaticVehicleEx(516,-2196.5000000,989.7000122,79.9000015,88.0000000,-1,-1,30); //Nebula
	AddStaticVehicleEx(558,-2197.3000488,972.0000000,79.6999969,90.0000000,-1,-1,30); //Uranus
	AddStaticVehicleEx(529,-2569.8999023,903.4000244,64.5999985,92.0000000,-1,-1,30); //Willard
	AddStaticVehicleEx(496,-2611.5000000,831.9000244,49.5999985,0.0000000,-1,-1,30); //Blista Compact
	AddStaticVehicleEx(549,-1979.4000244,953.4000244,45.2999992,0.0000000,-1,-1,30); //Tampa
	AddStaticVehicleEx(412,-1905.4000244,954.4000244,35.0000000,352.0000000,-1,-1,30); //Voodoo
	AddStaticVehicleEx(507,-2570.6999512,999.7999878,78.0999985,92.0000000,-1,-1,30); //Elegant
	AddStaticVehicleEx(546,-2290.1999512,865.4000244,42.7000008,0.0000000,-1,-1,30); //Intruder
	AddStaticVehicleEx(517,-2273.8999023,923.5000000,66.4000015,0.0000000,-1,-1,30); //Majestic
	AddStaticVehicleEx(534,-2248.3000488,960.4000244,66.5999985,0.0000000,-1,-1,30); //Remington
	AddStaticVehicleEx(496,-2248.5000000,774.0999756,49.0999985,0.0000000,-1,-1,30); //Blista Compact
	AddStaticVehicleEx(474,-2287.6999512,813.5999756,49.4000015,270.0000000,-1,-1,30); //Hermes
	AddStaticVehicleEx(549,-2151.6000977,790.0000000,69.3000031,0.0000000,-1,-1,30); //Tampa
	AddStaticVehicleEx(405,-2134.8000488,837.4000244,69.4000015,0.0000000,-1,-1,30); //Sentinel
	AddStaticVehicleEx(445,-1973.4000244,724.0000000,45.2999992,272.0000000,-1,-1,30); //Admiral
	AddStaticVehicleEx(540,-1906.6999512,712.7999878,45.4000015,0.0000000,-1,-1,30); //Vincent
	AddStaticVehicleEx(526,-1891.8000488,885.5000000,34.9000015,0.0000000,-1,-1,30); //Fortune
	AddStaticVehicleEx(518,-1786.5999756,872.7999878,24.7000008,0.0000000,-1,-1,30); //Buccaneer
	AddStaticVehicleEx(527,-1800.9000244,883.2999878,24.5000000,0.0000000,-1,-1,30); //Cadrona
	AddStaticVehicleEx(549,-1786.8000488,798.7000122,24.7999992,0.0000000,-1,-1,30); //Tampa
	AddStaticVehicleEx(549,-1721.1999512,890.2000122,24.6000004,0.0000000,-1,-1,30); //Tampa
	AddStaticVehicleEx(419,-1767.0000000,833.5999756,24.7000008,92.0000000,-1,-1,30); //Esperanto
	AddStaticVehicleEx(419,-1948.8000488,1323.3000488,7.1999998,90.0000000,-1,-1,30); //Esperanto
	AddStaticVehicleEx(496,-1706.8000488,793.7999878,24.5000000,0.0000000,-1,-1,30); //Blista Compact
	AddStaticVehicleEx(533,-1975.5000000,1322.9000244,7.0999999,90.0000000,-1,-1,30); //Feltzer
	AddStaticVehicleEx(562,-1721.5999756,813.0000000,24.5000000,0.0000000,-1,-1,30); //Elegy
	AddStaticVehicleEx(526,-1591.3000488,939.4000244,7.5000000,92.0000000,-1,-1,30); //Fortune
	AddStaticVehicleEx(518,-1610.5999756,1024.1999512,7.0000000,0.0000000,-1,-1,30); //Buccaneer
	AddStaticVehicleEx(517,-1613.3000488,1166.4000244,7.0999999,0.0000000,-1,-1,30); //Majestic
	AddStaticVehicleEx(412,-1734.0000000,1195.6999512,24.8999996,90.0000000,-1,-1,30); //Voodoo
	AddStaticVehicleEx(410,-1831.6999512,1398.8000488,6.9000001,0.0000000,-1,-1,30); //Manana
	AddStaticVehicleEx(533,-1837.3000488,1398.5000000,7.0000000,0.0000000,-1,-1,30); //Feltzer
	AddStaticVehicleEx(405,-1876.5000000,1067.0999756,45.4000015,0.0000000,-1,-1,30); //Sentinel
	AddStaticVehicleEx(534,-1971.6999512,1095.5000000,55.4000015,0.0000000,-1,-1,30); //Remington
	AddStaticVehicleEx(567,-1786.8000488,1013.4000244,24.8999996,0.0000000,-1,-1,30); //Savanna
	AddStaticVehicleEx(496,-1958.5999756,1185.9000244,45.2000008,90.0000000,-1,-1,30); //Blista Compact
	AddStaticVehicleEx(492,-1688.9000244,910.5999756,24.7999992,270.0000000,-1,-1,30); //Greenwood
	AddStaticVehicleEx(527,-1997.4000244,805.7999878,45.0999985,0.0000000,-1,-1,30); //Cadrona
	AddStaticVehicleEx(436,-2093.3999023,716.7000122,69.3000031,0.0000000,-1,-1,30); //Previon
	AddStaticVehicleEx(551,-1723.0999756,639.0999756,24.7999992,180.0000000,-1,-1,30); //Merit
	AddStaticVehicleEx(527,-1929.3000488,585.0999756,34.9000015,0.0000000,-1,-1,30); //Cadrona
	AddStaticVehicleEx(576,-1938.6999512,585.7000122,34.9000015,0.0000000,-1,-1,30); //Tornado
	AddStaticVehicleEx(466,-1835.0000000,598.2000122,35.0999985,270.0000000,-1,-1,30); //Glendale
	AddStaticVehicleEx(467,-1950.4000244,585.7999878,35.0000000,0.0000000,-1,-1,30); //Oceanic
	AddStaticVehicleEx(540,-2011.5999756,540.0000000,35.0000000,0.0000000,-1,-1,30); //Vincent
	AddStaticVehicleEx(566,-2394.3999023,587.2999878,26.1000004,180.0000000,-1,-1,30); //Tahoma
	AddStaticVehicleEx(410,-2011.5000000,489.6000061,34.7999992,0.0000000,-1,-1,30); //Manana
	AddStaticVehicleEx(559,-1996.8000488,426.3999939,34.7999992,0.0000000,-1,-1,30); //Jester
	AddStaticVehicleEx(492,-2470.3999023,1123.3000488,55.5999985,90.0000000,-1,-1,30); //Greenwood
	AddStaticVehicleEx(587,-2163.1000977,306.6000061,34.9000015,0.0000000,-1,-1,30); //Euros
	AddStaticVehicleEx(576,-2572.6999512,1133.5999756,55.4000015,70.0000000,-1,-1,30); //Tornado
	AddStaticVehicleEx(496,-2171.6999512,306.2000122,34.9000015,0.0000000,-1,-1,30); //Blista Compact
	AddStaticVehicleEx(545,-2163.1000977,293.8999939,35.0999985,0.0000000,-1,-1,30); //Hustler
	AddStaticVehicleEx(603,-2180.0000000,293.7000122,35.0999985,0.0000000,-1,-1,30); //Phoenix
	AddStaticVehicleEx(549,-2033.4000244,1039.6999512,55.5999985,0.0000000,-1,-1,30); //Tampa
	AddStaticVehicleEx(527,-2193.1999512,293.2999878,34.9000015,0.0000000,-1,-1,30); //Cadrona
	AddStaticVehicleEx(436,-2234.5000000,306.7999878,35.0000000,0.0000000,-1,-1,30); //Previon
	AddStaticVehicleEx(517,-2266.6000977,185.1999969,35.0999985,88.0000000,-1,-1,30); //Majestic
	AddStaticVehicleEx(518,-2266.1999512,192.3000031,35.0000000,88.0000000,-1,-1,30); //Buccaneer
	AddStaticVehicleEx(536,-2266.3000488,204.3000031,35.0000000,90.0000000,-1,-1,30); //Blade
	AddStaticVehicleEx(439,-2386.1999512,408.8999939,35.2000008,42.0000000,-1,-1,30); //Stallion
	AddStaticVehicleEx(526,-2210.8000488,580.4000244,35.0000000,0.0000000,-1,-1,30); //Fortune
	AddStaticVehicleEx(436,-2248.5000000,650.2000122,49.2000008,0.0000000,-1,-1,30); //Previon
	AddStaticVehicleEx(549,-2228.1000977,735.7999878,49.0999985,270.0000000,-1,-1,30); //Tampa
	AddStaticVehicleEx(602,-2582.3000488,473.7000122,14.5000000,90.0000000,-1,-1,30); //Alpha
	AddStaticVehicleEx(602,-2612.0000000,438.6000061,14.5000000,0.0000000,-1,-1,30); //Alpha
	AddStaticVehicleEx(549,-2151.5000000,715.4000244,69.3000031,0.0000000,-1,-1,30); //Tampa
	AddStaticVehicleEx(527,-2065.3000488,558.4000244,35.0000000,88.0000000,-1,-1,30); //Cadrona
	AddStaticVehicleEx(518,-2745.3999023,777.7000122,54.2000008,0.0000000,-1,-1,30); //Buccaneer
	AddStaticVehicleEx(496,-2745.3999023,927.2000122,57.5999985,0.0000000,-1,-1,30); //Blista Compact
	AddStaticVehicleEx(558,-2745.3000488,990.5000000,54.2000008,0.0000000,-1,-1,30); //Uranus
	AddStaticVehicleEx(415,-2719.3999023,1083.9000244,46.2999992,316.0000000,-1,-1,30); //Cheetah
	AddStaticVehicleEx(415,-2448.5000000,1384.8000488,7.0000000,272.0000000,-1,-1,30); //Cheetah
	AddStaticVehicleEx(429,-2134.3000488,599.0000000,43.0999985,0.0000000,-1,-1,30); //Banshee
	AddStaticVehicleEx(419,-2162.1999512,-91.0000000,35.0999985,0.0000000,-1,-1,30); //Esperanto
	AddStaticVehicleEx(555,-2151.8999023,452.6000061,35.0000000,0.0000000,-1,-1,30); //Windsor
	AddStaticVehicleEx(474,-2141.6999512,293.2000122,35.0999985,0.0000000,-1,-1,30); //Hermes
	AddStaticVehicleEx(529,-2161.8999023,-33.2000008,35.0999985,0.0000000,-1,-1,30); //Willard
	AddStaticVehicleEx(551,-2171.8000488,21.0000000,35.0999985,0.0000000,-1,-1,30); //Merit
	AddStaticVehicleEx(527,-2144.5000000,131.1000061,35.0999985,0.0000000,-1,-1,30); //Cadrona
	AddStaticVehicleEx(506,-2171.1000977,63.9000015,35.0000000,0.0000000,-1,-1,30); //Super GT
	CreateObject(2991,-1706.5000000,29.2000008,3.2000000,0.0000000,0.0000000,0.0000000); //object(imy_bbox) (1)
	CreateObject(2991,-1689.1999512,12.1999998,3.2000000,0.0000000,0.0000000,46.0000000); //object(imy_bbox) (2)
	CreateObject(2991,-1691.9000244,9.3999996,3.2000000,0.0000000,0.0000000,46.0000000); //object(imy_bbox) (3)
	CreateObject(3761,-1695.5000000,5.5000000,4.5999999,0.0000000,0.0000000,316.0000000); //object(industshelves) (1)
	CreateObject(3761,-1700.6999512,0.4000000,4.5999999,0.0000000,0.0000000,315.9997559); //object(industshelves) (2)
	CreateObject(3761,-1723.0999756,14.8999996,4.5999999,0.0000000,0.0000000,315.9997559); //object(industshelves) (3)
	CreateObject(2975,-1706.5999756,-3.2000000,2.5000000,0.0000000,0.0000000,0.0000000); //object(k_cargo3) (1)
	CreateObject(2973,-1710.0999756,26.2999992,2.5999999,0.0000000,0.0000000,0.0000000); //object(k_cargo2) (1)
	CreateObject(9958,-1632.0999756,109.1999969,-1.8000000,0.0000000,0.0000000,134.0000000); //object(submarr_sfe) (1)
	CreateObject(3077,-1571.5000000,134.1000061,2.5999999,0.0000000,0.0000000,344.0000000); //object(nf_blackboard) (1)
	CreateObject(10230,-3157.5000000,358.5000000,1.0000000,340.0000000,340.0000000,90.0000000); //object(freighter_sfe) (1)
	
	
	//General
	UsePlayerPedAnims();
	SetTimer("Random_Messages", 100000, true);
	SetTimer("timeupdate", 5760, true);
	checkpoints[0] = CreateDynamicCP(-2110.3142,-445.6071,38.7344, 2, -1, -1, -1, 100.0); // leisure center
	checkpoints[1] = CreateDynamicCP(-1615.9908,686.2200,7.1875, 2, -1, -1, -1, 100.0); // cop gun point
	checkpoints[2] = CreateDynamicCP(-1676.2111,432.1548,7.1797, 2, -1, -1, -1, 100.0); //  24/7
 	checkpoints[3] = CreateDynamicCP(-2588.1697,59.9089,4.3422, 2, -1, -1, -1, 100.0); // hippy shopper 1
	checkpoints[4] = CreateDynamicCP(-2442.5732,754.9309,35.1719, 2, -1, -1, -1, 100.0); // super save
	checkpoints[5] = CreateDynamicCP(-26.0607,-187.2907,1003.5469, 2, -1, 17, -1, 100.0); // shop exit
	checkpoints[6] = CreateDynamicCP(-2511.1479,-49.9410,25.6833, 2, -1, -1, -1, 100.0);//hippy shopper 2
	checkpoints[7] = CreateDynamicCP(-17.3677,-175.1572,1003.5469, 2, -1, 17, -1, 100.0); // buy stuff from local shops
	carcp = CreateDynamicCP(-1955.1440,255.8476,41.0471, 3, -1, -1, -1, 100.0);
	G_TAX = 1000;
	pickups[0] = CreateDynamicPickup(1279, 1, -2184.2314,-262.8053,40.7195, -1, -1, -1, 100.0);//drug
	
	//load vehicles
	
	//LV
	total_vehicles += LoadStaticVehiclesFromFile("vehicles/lv_law.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/lv_airport.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/lv_gen.txt");
    
    //LS
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/ls_law.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/ls_airport.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/ls_gen_inner.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/ls_gen_outer.txt");
    
    //OTHER
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/whetstone.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/bone.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/flint.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/tierra.txt");
    total_vehicles += LoadStaticVehiclesFromFile("vehicles/red_county.txt");
    
    printf("Total vehicles loaded from file: %d", total_vehicles);
	
	//textdraws
	timetext = TextDrawCreate(547.000000, 23.000000, "");
  	TextDrawBackgroundColor(timetext, 255);
   	TextDrawFont(timetext, 3);
   	TextDrawLetterSize(timetext, 0.599999, 2.100000);
    TextDrawColor(timetext, -1);
    TextDrawSetOutline(timetext, 1);
    TextDrawSetProportional(timetext, 1);
    
    Textdraw0 = TextDrawCreate(647.000000, 193.000000, "          ");
	TextDrawBackgroundColor(Textdraw0, 255);
	TextDrawFont(Textdraw0, 1);
	TextDrawLetterSize(Textdraw0, 0.500000, 1.000000);
	TextDrawColor(Textdraw0, -1);
	TextDrawSetOutline(Textdraw0, 0);
	TextDrawSetProportional(Textdraw0, 1);
	TextDrawSetShadow(Textdraw0, 1);
	TextDrawUseBox(Textdraw0, 1);
	TextDrawBoxColor(Textdraw0, 572661572);
	TextDrawTextSize(Textdraw0, -20.000000, 0.000000);
	
	Zone = TextDrawCreate(9.000000, 433.000000, "Zone");
	TextDrawBackgroundColor(Zone, 255);
	TextDrawFont(Zone, 2);
	TextDrawLetterSize(Zone, 0.500000, 1.000000);
	TextDrawColor(Zone, -1);
	TextDrawSetOutline(Zone, 1);
	TextDrawSetProportional(Zone, 1);

	Textdraw1 = TextDrawCreate(153.000000, 191.000000, "San Fierro Cops And Robbers");
	TextDrawBackgroundColor(Textdraw1, 255);
	TextDrawFont(Textdraw1, 2);
	TextDrawLetterSize(Textdraw1, 0.500000, 1.000000);
	TextDrawColor(Textdraw1, -16776961);
	TextDrawSetOutline(Textdraw1, 0);
	TextDrawSetProportional(Textdraw1, 1);
	TextDrawSetShadow(Textdraw1, 1);

	Textdraw2 = TextDrawCreate(136.000000, 218.000000, "This is NOT a deathmath server");
	TextDrawBackgroundColor(Textdraw2, 255);
	TextDrawFont(Textdraw2, 2);
	TextDrawLetterSize(Textdraw2, 0.500000, 1.000000);
	TextDrawColor(Textdraw2, -1);
	TextDrawSetOutline(Textdraw2, 0);
	TextDrawSetProportional(Textdraw2, 1);
	TextDrawSetShadow(Textdraw2, 1);

	Textdraw3 = TextDrawCreate(70.000000, 244.000000, "Use /commands for a list of ingame commands");
	TextDrawBackgroundColor(Textdraw3, 255);
	TextDrawFont(Textdraw3, 2);
	TextDrawLetterSize(Textdraw3, 0.500000, 1.000000);
	TextDrawColor(Textdraw3, -1);
	TextDrawSetOutline(Textdraw3, 0);
	TextDrawSetProportional(Textdraw3, 1);
	TextDrawSetShadow(Textdraw3, 1);
	
	Textdraw4 = TextDrawCreate(525.000000, 415.000000, "San Fierro");
	TextDrawBackgroundColor(Textdraw4, 255);
	TextDrawFont(Textdraw4, 3);
	TextDrawLetterSize(Textdraw4, 0.599999, 2.000000);
	TextDrawColor(Textdraw4, -1);
	TextDrawSetOutline(Textdraw4, 0);
	TextDrawSetProportional(Textdraw4, 1);
	TextDrawSetShadow(Textdraw4, 1);

	Textdraw5 = TextDrawCreate(530.000000, 423.000000, "~b~Cops ~r~Robbers");
	TextDrawBackgroundColor(Textdraw5, 255);
	TextDrawFont(Textdraw5, 0);
	TextDrawLetterSize(Textdraw5, 0.579999, 2.100000);
	TextDrawColor(Textdraw5, -1);
	TextDrawSetOutline(Textdraw5, 0);
	TextDrawSetProportional(Textdraw5, 1);
	TextDrawSetShadow(Textdraw5, 1);
	
	//classes
	AddPlayerClass(165,-2185.2268,2416.2488,5.1836,179.4194,0,0,0,0,0,0); // statpos1
	AddPlayerClass(166,-2237.9580,2353.4204,4.9802,139.6023,0,0,0,0,0,0); // statpos2
	AddPlayerClass(287,-1545.2535,320.0439,53.4609,275.3235,0,0,0,0,0,0); // armypos1
	AddPlayerClass(179,-1345.1957,501.4555,18.2344,4.3111,0,0,0,0,0,0); // armypos2
	AddPlayerClass(285,-1040.0908,-642.3456,32.0078,116.2276,0,0,0,0,0,0); // swatpos
 	AddPlayerClass(265,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 1
  	AddPlayerClass(266,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 2
   	AddPlayerClass(267,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 3
   	AddPlayerClass(280,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 4
    AddPlayerClass(281,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 5
    AddPlayerClass(282,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 6
    AddPlayerClass(283,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 7
    AddPlayerClass(284,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 8
    AddPlayerClass(288,-1598.2743,731.5563,-4.9063,10.5301,0,0,0,0,0,0);//cop 13
    AddPlayerClass(142,-1397.8112,-313.0121,14.1484,124.1484,0,0,0,0,0,0);//Driver (taxi)
 	AddPlayerClass(0,-2060.8259,1161.4252,46.1480,1.9959,0,0,0,0,0,0); // civilainspawn1
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
	AddPlayerClass(61,-2706.1011,376.4223,4.9684,177.0331,0,0,0,0,0,0); // civilianspawn59
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
    SetWeather(10);
	SetGameModeText(SERVER_VERSION);
	mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DB, MYSQL_PASS);
	mysql_debug();
 	if(mysql_ping() == -1) print("could not connect to da mysql server");
	return 1;
}

public OnGameModeExit()
{
	mysql_close();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, -2666.4329,1595.0068,217.2739);
	SetPlayerFacingAngle(playerid, 91.03);
	SetPlayerCameraPos(playerid, -2671.9260,1595.0878,217.2739);
	SetPlayerCameraLookAt(playerid, -2671.9260,1595.0878,217.2739);
	TextDrawShowForPlayer(playerid, Text:timetext);
	TextDrawHideForPlayer(playerid, Text:Textdraw0);
	TextDrawHideForPlayer(playerid, Text:Textdraw1);
	TextDrawHideForPlayer(playerid, Text:Textdraw2);
	TextDrawHideForPlayer(playerid, Text:Textdraw3);
	
	//mysql
	if(LoggedIn[playerid] == 0)
	{
		new Query[300];
		format(Query, 300, "SELECT * FROM `users` WHERE `username`='%s'", PlayerName(playerid));
		mysql_query(Query);
		mysql_store_result();
		if(mysql_num_rows() != 0)
		{
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FF0000}[SFCNR]{FFFFFF} You are registered!", "{FFFFFF}Please enter a password to login to your account", "Ok", "Quit");
		}
		else
		{
		    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "{FF0000}[SFCNR]{FFFFFF} You are not registered!", "{FFFFFF}Please enter a password to register an account with us", "Ok", "Quit");
		}
		mysql_free_result();
		printf("logged in status for %s : %i", PlayerName(playerid), LoggedIn[playerid]);
	}
	switch(classid)
	{
	    case 0..1:
	    {
	        ShowCasualTextdraw(playerid, "S.T.A.T");
			gTeam[playerid] = STAT;
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
		case 5..13:
		{
			ShowCasualTextdraw(playerid, "POLICE OFFICER");
			gTeam[playerid] = POLICE;
		}
		case 14:
		{
		    ShowCasualTextdraw(playerid, "TAXI DRIVER");
		    gTeam[playerid] = TAXI;
		}
		case 15..122:
		{
		    ShowCasualTextdraw(playerid, "CIVILIAN~n~Choose a job on spawn");
		    gTeam[playerid] = CIVILIAN;
		}
		case 123:
		{
		    ShowCasualTextdraw(playerid, "MEDIC");
		    gTeam[playerid] = MEDIC;
		}
		case 124:
		{
		    ShowCasualTextdraw(playerid, "TRUCKER");
		    gTeam[playerid] = TRUCKER;
		}
		case 125:
		{
		    ShowCasualTextdraw(playerid, "MECHANIC");
		    gTeam[playerid] = MECHANIC;
		}
		case 126:
		{
		    ShowCasualTextdraw(playerid, "HITMAN");
		    gTeam[playerid] = HITMAN;
		}
	}
	return 1;
}



// Start Mysql public's

public Mysql_Save(playerid)
{
	new Query[300];
	format(Query, 300, "UPDATE `users` SET `score`='%d', `money`='%d', `admin`='%d' WHERE `username`='%s'", GetPlayerScore(playerid), GetPlayerMoney(playerid), PlayerInfo[playerid][Padmin], PlayerName(playerid));
	mysql_query(Query);
	return 1;
}

public Mysql_Login(playerid, password[])
{
	mysql_real_escape_string(PlayerName(playerid), PlayerName(playerid));
	mysql_real_escape_string(password, password);
	Registed[playerid] = 1;
	new Hash[129], Query[500];
	WP_Hash(Hash, 129, password);
	format(Query, 500, "SELECT * FROM `users` WHERE `username` = '%s' AND `password` = '%s'", PlayerName(playerid), Hash);
	mysql_query(Query);
	mysql_store_result();
	if(mysql_num_rows() == 1)
	{
		SendClientMessage(playerid, COLOR_WHITE, "You have been logged in and your {FF0000}stats are loaded");
		LoggedIn[playerid] = 1;
		Load_Stats(playerid);
	}
	else
	{
		SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have submited an incorrect password, please try again.");
		MaxPassAttempts[playerid]++;
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FF0000}[SFCNR]{FFFFFF} You are registered!", "{FFFFFF}Please enter a password to login to your account", "Ok", "Quit");
		if(MaxPassAttempts[playerid] == 4) return Kick(playerid);
	}
	mysql_free_result();
	return 1;
}

public Mysql_Register(playerid, password[])
{
	mysql_real_escape_string(PlayerName(playerid), PlayerName(playerid));
	mysql_real_escape_string(password, password);
	new Day, Month, Year, Query[300], Hash[129];
	WP_Hash(Hash, 129, password);
	getdate(Year, Month, Day);
	format(Query, 300, "INSERT INTO `users`(`password`, `username`, `admin`, `money`, `score`, `regdate`) VALUES ('%s', '%s', '0', '0', '0', '%02d/%02d/%d')", Hash, PlayerName(playerid), Day, Month, Year);
	mysql_query(Query);
	SendClientMessage(playerid, COLOR_WHITE, "You have sucessfully registered! use{FF0000} /commands{FFFFFF} For a list of commands");
	LoggedIn[playerid] = 1;
	Registed[playerid] = 1;
	return 1;
}

// End Mysql Public's

public timeupdate()
{
    Minute += 01;
    if(Minute == 60 && Hour < 24) Hour += 01, Minute = 00;
    if(Hour == 24 && Minute == 00) Hour = 00, Minute = 00;
    if(Hour < 10 && Minute < 10) format(timestring,sizeof(timestring),"0%i:0%i",Hour,Minute);
    if(Hour < 10 && Minute > 9) format(timestring,sizeof(timestring),"0%i:%i",Hour,Minute);
    if(Hour > 9 && Minute < 10) format(timestring,sizeof(timestring),"%i:0%i",Hour,Minute);
    else if(Hour > 9 && Minute > 9) format(timestring,sizeof(timestring),"%i:%i",Hour,Minute);
    TextDrawSetString(timetext,timestring);
    TextDrawShowForAll(timetext);
    for(new i = 0; i < MAX_PLAYERS; i++) {
        SetPlayerTime(i,Hour,Minute);
    }
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(checkpointid == checkpoints[0]) return ShowPlayerDialog(playerid, DIALOG_LESURE, DIALOG_STYLE_LIST, "Leisure Center", "Fight Club\nRace Track\nBlood Bowl", "Select", "Close");
	if(checkpointid == checkpoints[1])
	{
		if(!IsPlayerCivilianClass(playerid) && gTeam[playerid] == POLICE)
		{
			ShowPlayerDialog(playerid, DIALOG_COPGUN, DIALOG_STYLE_LIST, "Armoury", "Armour\n9mm\nSilenced 9mm\nDesert Eagle\nCombat Shotgun\nMP5\nTec 9\nAk47\nM4\nSniper Rifle", "Select", "Cancel");
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a law enforcement to use this.");
		}
  	}
  	if(checkpointid == carcp) return ShowPlayerDialog(playerid, DIALOG_BUYCAR, DIALOG_STYLE_LIST, "{FFFFFF}Purchase a vehicle", "Infernus      {00FFFF}$120000\nTurismo      {00FFFF}$100000\nBuffalo      {00FFFF}60000\nBullet      {00FFFF}$150000\nCheetah      {00FFFF}$100000\nPhoenix      {00FFFF}$80000\nSanchez      {00FFFF}$90000\nQuad      {00FFFF}$40000\nFCR-900      {00FFFF}$100000\nNRG-500      {00FFFF}$150000", "Purchase", "Close");
  	if(checkpointid == checkpoints[2])
  	{
  	    SetPlayerPos(playerid, -22.5169,-185.3721,1003.5469);
  	    SetPlayerInterior(playerid, 17);
  	    SetPlayerVirtualWorld(playerid, 1);
  	    SetPlayerFacingAngle(playerid, 356.1240);
	}
	if(checkpointid == checkpoints[3])
	{
	    SetPlayerPos(playerid, -22.5169,-185.3721,1003.5469);
	    SetPlayerInterior(playerid, 17);
	    SetPlayerVirtualWorld(playerid, 2);
	    SetPlayerFacingAngle(playerid, 356.1240);
	}
	if(checkpointid == checkpoints[4])
	{
	    SetPlayerPos(playerid, -22.5169,-185.3721,1003.5469);
	    SetPlayerVirtualWorld(playerid, 3);
	    SetPlayerInterior(playerid, 17);
	    SetPlayerFacingAngle(playerid, 356.1240);
 	}
 	if(checkpointid == checkpoints[6])
 	{
 	    SetPlayerPos(playerid, -22.5169,-185.3721,1003.5469);
	    SetPlayerVirtualWorld(playerid, 4);
	    SetPlayerInterior(playerid, 17);
	    SetPlayerFacingAngle(playerid, 356.1240);
	}
 	if(checkpointid == checkpoints[5])
 	{
 	    if(GetPlayerVirtualWorld(playerid) == 1)
 	    {
 	        SetPlayerPos(playerid, -1674.0250,429.9817,7.1797);
 	        SetPlayerInterior(playerid, 0);
 	        SetPlayerVirtualWorld(playerid, 0);
 	        SetCameraBehindPlayer(playerid);
		}
		if(GetPlayerVirtualWorld(playerid) == 2)
		{
		    SetPlayerPos(playerid, -2590.9658,60.0634,4.3359);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    SetCameraBehindPlayer(playerid);
		}
		if(GetPlayerVirtualWorld(playerid) == 3)
		{
		    SetPlayerPos(playerid, -2442.5439,750.7072,35.1786);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    SetCameraBehindPlayer(playerid);
		}
		if(GetPlayerVirtualWorld(playerid) == 4)
		{
		    SetPlayerPos(playerid, -2507.9702,-49.8341,25.6841);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    SetCameraBehindPlayer(playerid);
		}
	}
	if(checkpointid == checkpoints[7])
	{
	    if(GetPlayerVirtualWorld(playerid) == 4 || GetPlayerVirtualWorld(playerid) == 2)
	    {
	        ShowPlayerDialog(playerid, DIALOG_BUYSTUFF, DIALOG_STYLE_LIST, "{FFFFFF}Hippy Shopper", "Blunt      {00FFFF}$6\nCheese Burger      {00FFFF}$6\nBacon      {00FFFF}$10\nChips      {00FFFF}$1\nFlowers      {00FFFF}$20\nStun Gun      {00FFFF}$200\nK-rose Music      {00FFFF}$50\nK-dst Music      {00FFFF}$50\nBeer      {00FFFF}$10", "Purchase", "Close");
 		}
	}
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	if(pickupid == pickups[0] && gTeam[playerid] != DRUG) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] You have to be in the drug class to use this command.");
	else ShowPlayerDialog(playerid, DIALOG_DRUG, DIALOG_STYLE_LIST, "{FFFFFF} Drug Store", "Cocaine (500g)      {00FFFF}$50000\nHeroin (500g)      {00FFFF}$35000\nWeed (500g)      {00FFFF}$50000\nWeed Seeds (10 Seeds)      {00FFFF}$3000", "Purcahse", "Cancel");
	return 1;
}

public OnPlayerEnterKoth(playerid)
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	PlayerPos[playerid][E_Old_X] = pos[0];
	PlayerPos[playerid][E_Old_Y] = pos[1];
	PlayerPos[playerid][E_Old_Z] = pos[2];
	GivePlayerWeapon(playerid, 31, 500);
	return 1;
}

public OnPlayerExitKoth(playerid)
{
    SetPlayerPos(playerid, PlayerPos[playerid][E_Old_X], PlayerPos[playerid][E_Old_Y], PlayerPos[playerid][E_Old_Z]);
    return 1;
}

public OnPlayerCommandPerformed(playerid,cmdtext[],success)
{
	if(!success) return format(G_String, 128, "[ERROR] :{FFFFFF} %s is not a valid command, use /commands for a list of commands", cmdtext), SendClientMessage(playerid, COLOR_RED2, G_String);
	return 1;
}

public OnPlayerConnect(playerid)
{

	Casual[playerid] = CreatePlayerTextDraw(playerid, 11.000000, 334.000000, "Textdraw");
	PlayerTextDrawBackgroundColor(playerid, Casual[playerid], 255);
	PlayerTextDrawFont(playerid, Casual[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Casual[playerid], 0.599999, 1.700000);
	PlayerTextDrawColor(playerid, Casual[playerid], -1);
	PlayerTextDrawSetOutline(playerid, Casual[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Casual[playerid], 1);

	format(G_String, 128, "%s(%i) has Joined San Fierro Cops And Robbers", PlayerName(playerid), playerid);
	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Welcome to San Fierro Cops And Robbers");
	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} This server is still under deveolpment and will be ready soon");
	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} If you have any questions, ask thefatshizms.");
	SendClientMessageToAll(COLOR_GREY, G_String);
	SetPlayerColor(playerid, COLOR_GREY);
	TextDrawShowForPlayer(playerid, Text:Textdraw0);
	TextDrawShowForPlayer(playerid, Text:Textdraw1);
	TextDrawShowForPlayer(playerid, Text:Textdraw2);
	TextDrawShowForPlayer(playerid, Text:Textdraw3);
	TextDrawShowForPlayer(playerid, Text:Textdraw4);
	TextDrawShowForPlayer(playerid, Text:Textdraw5);
	//ping system
 	SetTimerEx("OneSecTimer", 1000, true, "i", playerid);
	//reset crap
	lastveh[playerid] = -1;
	Spawned[playerid] = 0;
	Warns[playerid] = 0;
	PlayAudioStreamForPlayer(playerid, "http://sf-cnr.co.uk/hateorlove.mp3", 0.0, 0.0, 0.0, 0, 0);
	InLeisure[playerid] = false;
	LoggedIn[playerid] = 0;
	LastPM[playerid] = -1;
	Frozen[playerid] = 0;
	Laser[playerid] = 0;
	Injections[playerid] = 0;
	CurrentVeh[playerid] = 0;
	vehiclez = 0;
	HasSpod[playerid] = false;
	Krose[playerid] = false;
	Kdst[playerid] = false;
	Rap[playerid] = false;
	Rock[playerid] = false;
	printf("logged in status for %s : %i", PlayerName(playerid), LoggedIn[playerid]);
	WantedLevel[playerid] = 0;
	//mapicons
	for(new i = 0;i <sizeof(MapIcons);i++) SetPlayerMapIcon(playerid, MapIcons[i][iconid], MapIcons[i][x], MapIcons[i][y], MapIcons[i][z], MapIcons[i][type], MapIcons[i][colour], MAPICON_LOCAL);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	//reset crap
    Spawned[playerid] = 0;
	LoggedIn[playerid] = 0;
	LastPM[playerid] = -1;
	Warns[playerid] = 0;
	Frozen[playerid] = 0;
	WantedLevel[playerid] = 0;
	InLeisure[playerid] = false;
	Laser[playerid] = 0;
	CurrentVeh[playerid] = 0;
	Injections[playerid] = 0;
	vehiclez = 0;
	RemovePlayerAttachedObject(playerid, 0);
	switch(reason)
	{
	    case 0: format(G_String, 128, "%s Has left the server. (Timeout)", PlayerName(playerid));
	    case 1: format(G_String, 128, "%s Has left the server. (Leaving)", PlayerName(playerid));
	    case 2: format(G_String, 128, "%s Has left the server. (Kicked/Banned)", PlayerName(playerid));
	}
	SendClientMessageToAll(COLOR_GREY, G_String);
	/** MYSQL Save **/
	if(Registed[playerid] == 1)
	{
		Mysql_Save(playerid);
	}
	return 1;
}

//done
public OnPlayerSpawn(playerid)
{
   	Spawned[playerid] = 1;
   	PlayerTextDrawHide(playerid, Casual[playerid]);
   	SetCameraBehindPlayer(playerid);
   	StopAudioStreamForPlayer(playerid);
	switch(gTeam[playerid])
	{
	    case HITMAN:
	    {
	        Rand = random(sizeof(RandomSpawns));
	    	SetPlayerPos(playerid, RandomSpawns[Rand][0], RandomSpawns[Rand][1], RandomSpawns[Rand][2]);
	    	SetPlayerFacingAngle(playerid, RandomSpawns[Rand][3]);
	    	SetPlayerColor(playerid, COLOR_WHITE);
	    	GivePlayerWeapon(playerid, 22, 500);
 			GivePlayerWeapon(playerid, 28, 500);
 			GivePlayerWeapon(playerid, 31, 500);
		}
		case CIVILIAN || TEROIST:
		{
		    Rand = random(sizeof(RandomSpawns));
	    	SetPlayerPos(playerid, RandomSpawns[Rand][0], RandomSpawns[Rand][1], RandomSpawns[Rand][2]);
	    	SetPlayerFacingAngle(playerid, RandomSpawns[Rand][3]);
	    	SetPlayerColor(playerid, COLOR_WHITE);
	    	ShowPlayerDialog(playerid, DIALOG_CLASS, DIALOG_STYLE_LIST, "Choose your class", "Drug Dealer\nPedo\nGun merchant\nRobber\nItems dealer\nRapist\nKidnapper", "select", "cancel");
		}
		case ARMY:
		{
		    Rand = random(sizeof(ArmySpawns));
			SetPlayerPos(playerid, ArmySpawns[Rand][0], ArmySpawns[Rand][1], ArmySpawns[Rand][2]);
			SetPlayerFacingAngle(playerid, ArmySpawns[Rand][3]);
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

public OnPlayerDeath(playerid, killerid, reason)
{
	if(IsPlayerCivilianClass(playerid))
	{
	    gTeam[playerid] = CIVILIAN;
 	}
    SendDeathMessage(killerid, playerid, reason);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
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
	if(pChat_Color[playerid] == 1)
	{
	    format(G_String, 128, "%s(%i): {00FF00}%s", PlayerName(playerid), playerid, text);
	    SendClientMessageToAll(GetPlayerColor(playerid), G_String);
	    return 0;
	}
	if(pChat_Color[playerid] == 2)
	{
	    format(G_String, 128, "%s(%i): {FF0000}%s", PlayerName(playerid), playerid, text);
	    SendClientMessageToAll(GetPlayerColor(playerid), G_String);
	    return 0;
	}
	if(strfind(text, "How to be admin", true) != -1)
	{
	    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Please don't ask to be an admin. We will choose who will be admin");
	    return 0;
	}
	format(G_String, 128, "%s(%i): {FFFFFF}%s", PlayerName(playerid), playerid, text);
	SendClientMessageToAll(GetPlayerColor(playerid), G_String);
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(IsVehiclePrivate(vehicleid))
	{
	    new Float:pos[3];
	    GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
	    VehicleInfo[ConvertVID(vehicleid)][x_pos] =pos[0];
	    VehicleInfo[ConvertVID(vehicleid)][y_pos] =pos[1];
	    VehicleInfo[ConvertVID(vehicleid)][z_pos] =pos[2];
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
	{
	    if(Laser[playerid] == 1)
	    {
	        RemovePlayerAttachedObject(playerid, 0);
	        TLaser[playerid] = 1;
	        Laser[playerid] = 0;
 		}
		new Vehicleid = GetPlayerVehicleID(playerid);
	    printf("owner : %s", VehicleInfo[Vehicleid][owner]);
	    if(IsVehiclePrivate(Vehicleid))
	    {
	    	if(strcmp(VehicleInfo[ConvertVID(Vehicleid)][owner], PlayerName(playerid), false) != 0)
	    	{
				SendClientMessage(playerid, -1, "This is not your vehicle");
	    	    RemovePlayerFromVehicle(playerid);
			}
		}
	}
	if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT)
	{
	    if(TLaser[playerid] == 1)
	    {
	        Laser[playerid] = 1;
		}
	}
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(LoggedIn[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_RED2, "You must be logged in to spawn!");
		ForceClassSelection(playerid);
    	TogglePlayerSpectating(playerid, true);
    	TogglePlayerSpectating(playerid, false);
    	if(Registed[playerid] == 1)
		{
	 		ShowLoginDialog(playerid);
		}
    	else if(Registed[playerid] == 0)
		{
	 		ShowRegisterDialog(playerid);
		}
	}
	else if(LoggedIn[playerid] == 1)
	{
 		SpawnPlayer(playerid);
   	}
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

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	// When player enters and is wanted if(cops not in range range = 100) then remove 2 star wanted level ?
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
	SetCameraBehindPlayer(playerid);
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
	if(Laser[playerid] == 1)
	{
	    switch(GetPlayerWeapon(playerid))
		{
			case 23:
			{
			    if(IsPlayerAiming(playerid))
			    {
			        if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
			        {
			            SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.108249, 0.030232, 0.118051, 1.468254, 350.512573, 364.284240);
					}
					else
					{
					    SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.108249, 0.030232, 0.118051, 1.468254, 349.862579, 364.784240);
					}
				}
				else
				{
				    if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
				    {
				        SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.078248, 0.027239, 0.113051, -11.131746, 350.602722, 362.384216);
					}
					else
					{
					    SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.078248, 0.027239, 0.113051, -11.131746, 350.602722, 362.384216);
					}
				}
			}
			case 27:
			{
			    if(IsPlayerAiming(playerid))
			    {
			        if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
			        {
			            SetPlayerAttachedObject(playerid, 0, 18643, 6,0.588246, -0.022766, 0.138052, -11.531745, 347.712585, 352.784271);
					}
					else
					{
					    SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.588246, -0.022766, 0.138052, 1.468254, 350.712585, 352.784271);
					}
				}
				else
				{
				    if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
				    {
       					SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.563249, -0.01976, 0.134051, -11.131746, 351.602722, 351.384216);
					}
					else
					{
					    SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.563249, -0.01976, 0.134051, -11.131746, 351.602722, 351.384216);
					}
				}
			}
			case 30:
			{
			    if(IsPlayerAiming(playerid))
			    {
			        if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
			        {
			            SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.628249, -0.027766, 0.078052, -6.621746, 352.552642, 355.084289);
					}
					else
					{
					    SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.628249, -0.027766, 0.078052, -1.621746, 356.202667, 355.084289);
					}
				}
				else
				{
				    if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
				    {
				        SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.663249, -0.02976, 0.080051, -11.131746, 358.302734, 353.384216);
					}
					else
					{
					    SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.663249, -0.02976, 0.080051, -11.131746, 358.302734, 353.384216);
					}
				}
			}
			case 31:
			{
			    if(IsPlayerAiming(playerid))
			    {
			        if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
			        {
			            SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.528249, -0.020266, 0.068052, -6.621746, 352.552642, 355.084289);
					}
					else
					{
					    SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.528249, -0.020266, 0.068052, -1.621746, 356.202667, 355.084289);
					}
				}
				else
				{
				    if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
				    {
				        SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
					}
					else
					{
					    SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
					}
				}
			}
			case 29:
			{
			    if(IsPlayerAiming(playerid))
			    {
			        if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
			        {
			            SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.298249, -0.02776, 0.158052, -11.631746, 359.302673, 357.584259);
					}
					else
					{
					    SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.298249, -0.02776, 0.158052, 8.368253, 358.302673, 352.584259);
					}
				}
				else
				{
				    if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
				    {
				         SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
					}
					else
					{
					    SetPlayerAttachedObject(playerid, 0, 18643, 6, 0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
					}
				}
			}
	 		default:
			{
			    RemovePlayerAttachedObject(playerid, 0);
			}
		}
	}
	new hour, minute;
	GetPlayerTime(playerid, hour, minute);
	if(hour == 13 && minute == 00)
	{
	    GivePlayerMoney(playerid, -G_TAX);
	    format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} It's tax day! You have been taxed $%i", G_TAX);
	    SendClientMessage(playerid, COLOR_RED2, G_String);
	}
	return 1;
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    //register dialog
	    case DIALOG_REGISTER:
		{
		    if(!response) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "{FF0000}[SFCNR]{FFFFFF} You are not registered!", "{FFFFFF}Please enter a password to register an account with us", "Ok", "Quit");
			Mysql_Register(playerid, inputtext);
		}
	    //login dialog
	    case DIALOG_LOGIN:
		{
		    if(!response) return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FF0000}[SFCNR]{FFFFFF} You are registered!", "{FFFFFF}Please enter a password to login to your account", "Ok", "Quit");
			Mysql_Login(playerid, inputtext);
		}
	    //all commands dialog
	    case DIALOG_CMDS:
	    {
			switch(listitem)
			{
			    case 0: ShowPlayerDialog(playerid, DIALOG_JCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Job Commands", "stuff here", "Ok", "Close");
			    case 1: ShowPlayerDialog(playerid, DIALOG_GCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}General Commands", "stuff here", "Ok", "Close");
			    case 2:
				{
				    if(PlayerInfo[playerid][Padmin] >= HELPER)
				    {
						ShowPlayerDialog(playerid, DIALOG_ACMDS, DIALOG_STYLE_LIST, "{FFFFFF}Admin Commands", "{FFFFFF}Helper Commands\n{FFFFFF}Moderator Commands\n{FFFFFF}Admin Commands", "Ok", "Close");
					}
					else
					{
                        SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This is for staff members only!");
					}
				}
			    case 3: ShowPlayerDialog(playerid, DIALOG_VCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Vehicle Commands", "stuff here", "Ok", "Close");
			}
		}
		case DIALOG_ACMDS:
		{
			new string[800];
			switch(listitem)
			{
			    case 0:
				{
				    
    				strcat(string, "{FF0000}[CMD]{FFFFFF} /slap -{FF0000} Slaps a player into the air and reduces some health\n{FF0000}[CMD]{FFFFFF} /apm -{FF0000} Send an admin privite message to a player \
			    	\n{FF0000}[CMD] {FFFFFF}/mute -{FF0000} Mutes a player\n{FF0000}[CMD]{FFFFFF} /unmute -{FF0000} UnMutes a player\n{FF0000}[CMD]{FFFFFF} /ann -{FF0000} Announces a message on the screen\n{FF0000}[CMD]{FFFFFF} /disarm -{FF0000} Disarms a player");
					strcat(string, "\n{FF0000}[CMD]{FFFFFF} /freeze -{FF0000} Freezes a player\n{FF0000}[CMD]{FFFFFF} /unfreeze -{FF0000} Unfreezes a player\
					\n{FF0000}[CMD]{FFFFFF} /goto -{FF0000} Teleports yourself to the given player\n{FF0000}[CMD]{FFFFFF} /bring -{FF0000} Bring a player to your position");
			 		ShowPlayerDialog(playerid, DIALOG_HELPERCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Helper Commands", string, "Ok", "Close");
				}
				case 1:
				{
				    new Bstring[1100];
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}Moderators have helper commands plus these:");
				    strcat(Bstring, "{00FF00}Moderators have helpers commands aswell as thier own!\n{FF0000}[CMD]{FFFFFF} /explode -{FF0000} Creates an explosion at a players position\n{FF0000}[CMD]{FFFFFF} /kick -{FF0000} Kicks a player from the server\n{FF0000}[CMD]{FFFFFF} /tempban -{FF0000} Temp ban a player from the server\n{FF0000}[CMD]{FFFFFF} /givecash -{FF0000} Gives a player an ammount of cash");
				    strcat(Bstring, "\n{FF0000}[CMD]{FFFFFF} /dveh -{FF0000} Destroys the vehicle your in or vehicles around you if you're not in a vehicle\n{FF0000}[CMD]{FFFFFF} /getall -{FF0000} gets every player to your position\n{FF0000}[CMD]{FFFFFF} /respawnv -{FF0000} Respawns all vehicles in the server\n{FF0000}[CMD]{FFFFFF} /warn -{FF0000} Warns a player ( 3/3 = kick )\n{FF0000}[CMD]{FFFFFF} /resetwarnings -{FF0000} Resets a players wanrings");
				    strcat(Bstring, "\n{FF0000}[CMD]{FFFFFF} /warnlist -{FF0000} Displays everyone that has been warned\n{FF0000}[CMD]{FFFFFF} /richlist -{FF0000} Displays a list of players with 1 million or more and smaller than 10 score\n{FF0000}[CMD]{FFFFFF} /akill -{FF0000} Kills a given player");
				    ShowPlayerDialog(playerid, DIALOG_MODCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Moderator Commands", Bstring, "Ok", "Close");
				}
				case 2:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}Admins have helper and moderator commands plus these:");
				    strcat(string, "{00FF00}Admins have helpers and moderator commands aswell as thier own!\n{FF0000}[CMD]{FFFFFF} /clearchat -{FF0000} Clears the chat\n{FF0000}[CMD]{FFFFFF} /fine -{FF0000} Fine a player a given ammount of money\n{FF0000}[CMD]{FFFFFF} /setwanted -{FF0000} Set a players wanted level\n{FF0000}[CMD]{FFFFFF} /sethealth -{FF0000} Set a players health\n{FF0000}[CMD]{FFFFFF} /setarmour -{FF0000} Set a players armour");
				    ShowPlayerDialog(playerid, DIALOG_ADMINCMDS, DIALOG_STYLE_MSGBOX, "{FFFFFF}Admin Commands", string, "Ok", "Close");
				}
			}
		}
		case DIALOG_CLASS:
		{
		    if(!response)
		    {
		        SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You did not select you have been assigned to: {00FF00}Drug Dealer{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
		        GivePlayerWeapon(playerid, 22, 500);
				GivePlayerWeapon(playerid, 25, 100);
				GivePlayerWeapon(playerid, 28, 300);
				GivePlayerWeapon(playerid, 30, 500);
				gTeam[playerid] = DRUG;
			}
		    switch(listitem)
		    {
		        case 0:
		        {
		            SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {00FF00}Drug Dealer{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 28, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = DRUG;
		        }
		        case 1:
		        {
		            SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {00FF00}Pedo{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 43, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = PEDO;
				}
				case 2:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {00FF00}Gun Merchant{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 26, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = WEP;
				}
				case 3:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {00FF00}Robber{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 28, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = ROB;
				}
				case 4:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {00FF00}Items Dealer{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 28, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = ITEMS;
				}
				case 5:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {00FF00}Rapist{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 28, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = RAPIST;
				}
				case 6:
				{
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}You have selected {00FF00}Kidnapper{FFFFFF} use /commands to see your commands and /howto to see what your aim is.");
					GivePlayerWeapon(playerid, 22, 500);
					GivePlayerWeapon(playerid, 25, 100);
					GivePlayerWeapon(playerid, 28, 300);
					GivePlayerWeapon(playerid, 30, 500);
					gTeam[playerid] = KIDNAPPER;
				}
			}
		}
		case DIALOG_LESURE:
		{
		    if(!response) {}
		    switch(listitem)
		    {
		        case 0:
		        {
		            SetPlayerPos(playerid, 1302.519897,-1.787510,1001.028259);
		            SetPlayerInterior(playerid, 18);
		            InLeisure[playerid] = true;
		            SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have entered the leisure center. Use /exitleisure to exit the leisure center.");
				}
				case 1:
				{
				    SetPlayerPos(playerid, -1444.645507,-664.526000,1053.572998);
				    SetPlayerInterior(playerid, 4);
				    InLeisure[playerid] = true;
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have entered the leisure center. Use /exitleisure to exit the leisure center.");
				}
				case 2:
				{
				    SetPlayerPos(playerid, -1398.103515,937.631164,1036.479125);
				    SetPlayerInterior(playerid, 15);
				    InLeisure[playerid] = true;
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have entered the leisure center. Use /exitleisure to exit the leisure center.");
				}
			}
		}
		case DIALOG_COPGUN:
		{
			if(!response) {}
			switch(listitem)
			{
			    case 0:
				{
				    SetPlayerArmour(playerid, 100.0);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given armour.");
				}
				case 1:
				{
				    GivePlayerWeapon(playerid, 22, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a 9mm.");
				}
				case 2:
				{
				    GivePlayerWeapon(playerid, 23, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Silenced 9mm.");
				}
				case 3:
				{
				    GivePlayerWeapon(playerid, 24, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Desert Eagle.");
				}
				case 4:
				{
				    GivePlayerWeapon(playerid, 27, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Combat Shotgun.");
				}
				case 5:
				{
                    GivePlayerWeapon(playerid, 29, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a MP5.");
				}
				case 6:
				{
				    GivePlayerWeapon(playerid, 32, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Tec 9.");
				}
				case 7:
				{
				    GivePlayerWeapon(playerid, 30, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a AK47.");
				}
				case 8:
				{
				    GivePlayerWeapon(playerid, 31, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a M4.");
				}
				case 9:
				{
				    GivePlayerWeapon(playerid, 34, 500);
				    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have been given a Sniper Rifle.");
				}
			}
		}
		case DIALOG_BUYCAR:
	    {
	        switch(listitem)
	        {
	            case 0:
	            {
	                if(GetPlayerMoney(playerid) < 120000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle");
				 	ShowPlayerDialog(playerid, DIALOG_NUMPLATE, DIALOG_STYLE_INPUT, "{FFFFFF}Number plate", "{FFFFFF}You now can choose a custom number plate alternativly you can leave it the default value (Sfcnr)\nPlease note there is a limit of 32 characters!", "Ok", "Default");
				 	BuyCar(411, playerid, 120000);
				}
				case 1:
				{
				    if(GetPlayerMoney(playerid) < 100000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle");
	                ShowPlayerDialog(playerid, DIALOG_NUMPLATE, DIALOG_STYLE_INPUT, "{FFFFFF}Number plate", "{FFFFFF}You now can choose a custom number plate alternativly you can leave it the default value (Sfcnr)\nPlease note there is a limit of 32 characters!", "Ok", "Default");
	                BuyCar(451, playerid, 100000);
				}
				case 2:
				{
				    if(GetPlayerMoney(playerid) < 60000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle");
	                ShowPlayerDialog(playerid, DIALOG_NUMPLATE, DIALOG_STYLE_INPUT, "{FFFFFF}Number plate", "{FFFFFF}You now can choose a custom number plate alternativly you can leave it the default value (Sfcnr)\nPlease note there is a limit of 32 characters!", "Ok", "Default");
	                BuyCar(402, playerid, 60000);
				}
				case 3:
				{
				    if(GetPlayerMoney(playerid) < 150000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle");
	                ShowPlayerDialog(playerid, DIALOG_NUMPLATE, DIALOG_STYLE_INPUT, "{FFFFFF}Number plate", "{FFFFFF}You now can choose a custom number plate alternativly you can leave it the default value (Sfcnr)\nPlease note there is a limit of 32 characters!", "Ok", "Default");
	                BuyCar(541, playerid, 150000);
				}
				case 4:
				{
                    if(GetPlayerMoney(playerid) < 100000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle");
	                ShowPlayerDialog(playerid, DIALOG_NUMPLATE, DIALOG_STYLE_INPUT, "{FFFFFF}Number plate", "{FFFFFF}You now can choose a custom number plate alternativly you can leave it the default value (Sfcnr)\nPlease note there is a limit of 32 characters!", "Ok", "Default");
	                BuyCar(415, playerid, 100000);
				}
				case 5:
				{
				    if(GetPlayerMoney(playerid) < 80000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle");
	                ShowPlayerDialog(playerid, DIALOG_NUMPLATE, DIALOG_STYLE_INPUT, "{FFFFFF}Number plate", "{FFFFFF}You now can choose a custom number plate alternativly you can leave it the default value (Sfcnr)\nPlease note there is a limit of 32 characters!", "Ok", "Default");
	                BuyCar(603, playerid, 80000);
				}
				case 6:
				{
				    if(GetPlayerMoney(playerid) < 90000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle");
	                ShowPlayerDialog(playerid, DIALOG_NUMPLATE, DIALOG_STYLE_INPUT, "{FFFFFF}Number plate", "{FFFFFF}You now can choose a custom number plate alternativly you can leave it the default value (Sfcnr)\nPlease note there is a limit of 32 characters!", "Ok", "Default");
	                BuyCar(468, playerid, 90000);
				}
				case 7:
				{
				    if(GetPlayerMoney(playerid) < 40000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle");
	                ShowPlayerDialog(playerid, DIALOG_NUMPLATE, DIALOG_STYLE_INPUT, "{FFFFFF}Number plate", "{FFFFFF}You now can choose a custom number plate alternativly you can leave it the default value (Sfcnr)\nPlease note there is a limit of 32 characters!", "Ok", "Default");
	                BuyCar(471, playerid, 40000);
				}
				case 8:
				{
				    if(GetPlayerMoney(playerid) < 100000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle");
	                ShowPlayerDialog(playerid, DIALOG_NUMPLATE, DIALOG_STYLE_INPUT, "{FFFFFF}Number plate", "{FFFFFF}You now can choose a custom number plate alternativly you can leave it the default value (Sfcnr)\nPlease note there is a limit of 32 characters!", "Ok", "Default");
	                BuyCar(521, playerid, 100000);
				}
				case 9:
				{
				    if(GetPlayerMoney(playerid) < 150000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this vehicle");
	                ShowPlayerDialog(playerid, DIALOG_NUMPLATE, DIALOG_STYLE_INPUT, "{FFFFFF}Number plate", "{FFFFFF}You now can choose a custom number plate alternativly you can leave it the default value (Sfcnr)\nPlease note there is a limit of 32 characters!", "Ok", "Default");
	                BuyCar(522, playerid, 150000);
				}
				
			}
		}
		case DIALOG_NUMPLATE:
		{
		    if(strlen(inputtext) > 31) return ShowPlayerDialog(playerid, DIALOG_NUMPLATE, DIALOG_STYLE_INPUT, "{FFFFFF}Number plate", "You now can choose a custom number plate alternativly you can leave it the default value (Sfcnr)\nPlease note there is a limit of 32 characters!", "Ok", "Default");
			if(strlen(inputtext) < 1 || !response)
			{
			    if(vehiclez == 1) return SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] You already have a car");
				VehicleInfo[vehicle_creating][vehid] = AddStaticVehicle(VehicleInfo[vehicle_creating][model],-1983.9702,304.0019,34.8990,268.0746,random(255),random(255));
				SetVehicleNumberPlate(VehicleInfo[vehicle_creating][vehid], "Sfcnr");
				SetVehicleToRespawn(VehicleInfo[vehicle_creating][vehid]);
				PutPlayerInVehicle(playerid, VehicleInfo[vehicle_creating][vehid], 0);
				new Query[500];
		 		format(Query, 500, "INSERT INTO `vehicle`(`owner`, `model`, `numberplate`, `vehicleid`) VALUES('%s', '%i', '%s', '%i')", VehicleInfo[vehicle_creating][owner], VehicleInfo[vehicle_creating][model], "sfcnr", vehicle_creating);
		 		mysql_query(Query);
		 		
			}
			else
			{
				if(vehiclez == 1) return SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] You already have a car");
			    VehicleInfo[vehicle_creating][vehid] = AddStaticVehicle(VehicleInfo[vehicle_creating][model],-1983.9702,304.0019,34.8990,268.0746,random(255),random(255));
				SetVehicleNumberPlate(VehicleInfo[vehicle_creating][vehid], inputtext);
				SetVehicleToRespawn(VehicleInfo[vehicle_creating][vehid]);
				PutPlayerInVehicle(playerid, VehicleInfo[vehicle_creating][vehid], 0);
				new Query[500];
		 		format(Query, 500, "INSERT INTO `vehicle`(`owner`, `model`, `numberplate`, `vehicleid`) VALUES('%s', '%i', '%s', '%i')", VehicleInfo[vehicle_creating][owner], VehicleInfo[vehicle_creating][model], "sfcnr", vehicle_creating);
		 		mysql_query(Query);
		 		
			}
		}
		case DIALOG_DRUG:
		{
		    if(!response) {}
		    switch(listitem)
		    {
		        case 0:
		        {
		            if(GetPlayerMoney(playerid) < 50000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money to purcahse this item.");
		            if(Cocaine[playerid] >= 500) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You already have the maximum ammount of cocaine (500 grams)");
		            new chance = random(2);
		            if(chance == 1)
		            {
		                SendMessageToLaw(COLOR_RED2, LawMSG(playerid, "Purchasing drugs"));
					}
					Cocaine[playerid] = 500;
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have purcahsed 500 grams of cocaine");
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You can now sell this cocaine or use it.");
					GivePlayerMoney(playerid, -50000);
				}
				case 1:
		        {
		            if(GetPlayerMoney(playerid) < 35000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money to purcahse this item.");
		            if(Heroin[playerid] >= 500) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You already have the maximum ammount of cocaine (500 grams)");
		            new chance = random(2);
		            if(chance == 1)
		            {
		                SendMessageToLaw(COLOR_RED2, LawMSG(playerid, "Purchasing drugs"));
					}
					Heroin[playerid] = 500;
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have purcahsed 500 grams of Heroin");
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You can now sell this heroin or use it");
					GivePlayerMoney(playerid, -35000);
				}
				case 2:
		        {
		            if(GetPlayerMoney(playerid) < 50000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money to purcahse this item.");
		            if(Weed[playerid] >= 500) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You already have the maximum ammount of cocaine (500 grams)");
		            new chance = random(2);
		            if(chance == 1)
		            {
		                SendMessageToLaw(COLOR_RED2, LawMSG(playerid, "Purchasing drugs"));
					}
					Weed[playerid] = 500;
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have purcahsed 500 grams of Weed");
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You can now sell this weed or use it.");
                    GivePlayerMoney(playerid, -50000);
				}
				case 3:
		        {
		            if(GetPlayerMoney(playerid) < 3000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money to purcahse this item.");
		            if(WeedSeeds[playerid] >= 500) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You already have the maximum ammount of cocaine (500 grams)");
		            new chance = random(2);
		            if(chance == 1)
		            {
		                SendMessageToLaw(COLOR_RED2, LawMSG(playerid, "Purchasing drugs"));
					}
					WeedSeeds[playerid] += 10;
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have purcahsed 500 grams of Weed");
					SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You can now plant some seeds and grow them or sell them on.");
					GivePlayerMoney(playerid, -3000);
				}

			}
		}
		case DIALOG_BUYSTUFF:
		{
			if(GetPlayerVirtualWorld(playerid) == 2 || GetPlayerVirtualWorld(playerid) == 4)
  			{
  				switch(listitem)
     			{
			 	
		            case 0:
		            {
		                if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
		                SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
		                GivePlayerMoney(playerid, -10);
		                SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your blunt.");
					}
					case 1:
					{
					    if(GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough moneu for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -6);
					    new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+25);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your burger.");
					}
					case 2:
					{
					    if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -10);
						new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+50);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your bacon.");
					}
					case 3:
					{
					    if(GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -1);
					    new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+10);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your chips.");
					}
					case 4:
					{
					    if(GetPlayerMoney(playerid) < 20) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -20);
					    GivePlayerWeapon(playerid, 14, 1);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your flowers.");
					}
					case 5:
					{
					    if(GetPlayerMoney(playerid) < 200) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -200);
					    // need variable to give the gun
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your stun gun.");
					}
					case 6:
					{
					    if(GetPlayerMoney(playerid) < 50) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -50);
					    // give k-rose music
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your K-rose music.");
					}
					case 7:
					{
					    if(GetPlayerMoney(playerid) < 50) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -50);
						//give k-dst music
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your K-dst music.");
					}
					case 8:
					{
					    if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -10);
					    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your beer.");
					}
				}
			}
			if(GetPlayerVirtualWorld(playerid) == 1)
			{
			    switch(listitem)
			    {
			        case 0:
					{
					    if(GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough moneu for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -6);
					    new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+25);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your burger.");
					}
					case 1:
					{
					    if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -10);
						new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+50);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your bacon.");
					}
					case 2:
					{
					    if(GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -1);
					    new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+10);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your chips.");
					}
					case 3:
					{
					    if(GetPlayerMoney(playerid) < 20) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -20);
					    GivePlayerWeapon(playerid, 14, 1);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your flowers.");
					}
					case 4:
					{
					    if(GetPlayerMoney(playerid) < 200) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -200);
					    // need variable to give the gun
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your stun gun.");
					}
					case 5:
					{
					    if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -10);
					    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your beer.");
					}
					case 6:
					{
					    if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -5);
					    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your sprunk.");
					}
					case 7:
					{
					    if(GetPlayerMoney(playerid) < 50) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -50);
					    // give k-rose music
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your K-rose music.");
					}
					case 8:
					{
					    if(GetPlayerMoney(playerid) < 30) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -30);
					    GivePlayerWeapon(playerid, 2, 1);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your golf club.");
					}
				}
			}
			if(GetPlayerVirtualWorld(playerid) == 3)
			{
			    switch(listitem)
			    {
			        case 0:
					{
					    if(GetPlayerMoney(playerid) < 6) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough moneu for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -6);
					    new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+25);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your burger.");
					}
					case 1:
					{
					    if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -10);
						new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+50);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your bacon.");
					}
					case 2:
					{
					    if(GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4, 0,1,1,1,1,1);
					    GivePlayerMoney(playerid, -1);
					    new Float:H;
					    SetPlayerHealth(playerid, GetPlayerHealth(playerid, H)+10);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your chips.");
					}
					case 3:
					{
					    if(GetPlayerMoney(playerid) < 20) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -20);
					    GivePlayerWeapon(playerid, 14, 1);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your flowers.");
					}
					case 4:
					{
					    if(GetPlayerMoney(playerid) < 200) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -200);
					    // need variable to give the gun
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your stun gun.");
					}
					case 5:
					{
					    if(GetPlayerMoney(playerid) < 10) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -10);
					    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your beer.");
					}
					case 6:
					{
					    if(GetPlayerMoney(playerid) < 5) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -5);
					    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your sprunk.");
					}
					case 7:
					{
					    if(GetPlayerMoney(playerid) < 50) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -50);
					    // give k-rose music
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your K-rose music.");
					}
					case 8:
					{
					    if(GetPlayerMoney(playerid) < 3000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have enough money for this.");
					    GivePlayerMoney(playerid, -3000);
					    //give spod
					    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your spod.");
					}
				}
			}
		}
	}
	return 1;
}

/** COMMANDS **/

// animation commands

//dance command
CMD:dance(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    new dance;
    if(sscanf(params, "d", dance))
    return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /dance <1-4>");
    if(dance == 1) { SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1); }
    else if(dance == 2) { SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2); }
    else if(dance == 3) { SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3); }
    else if(dance == 4) { SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4); }
    else { SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /dance <1-4>"); return 1; }
    return 1;
}

//piss command
CMD:piss(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    SetPlayerSpecialAction(playerid, 68);
    return 1;
}

//handsup command
CMD:handsup(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
    return 1;
}

//class commands

//hits
CMD:hits(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != HITMAN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a hitman to use this command.");
    new count;
    foreach(Player, i)
    {
        if(Hit[i] == 1)
        {
            format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} %s | Price: $%i | Location: %s", PlayerName(i), HitPrice[i], PlayerZone(i));
            SendClientMessage(playerid, COLOR_RED2, G_String);
            count++;
		}
	}
	if(count == 0) return SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} There are no online players with hits");
	return 1;
}
	
        
//fixme command
CMD:fixme(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != MECHANIC) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a mechanic to use this command.");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a vehicle to use this command.");
    SetVehicleHealth(GetPlayerVehicleID(playerid), 100.0);
    RepairVehicle(GetPlayerVehicleID(playerid));
    return 1;
}

//fix command
CMD:fix(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != MECHANIC) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a mechanic to use this command.");
    new id, string[2][128];
    if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /fix <id>");
    if(!IsPlayerInRangeOfPlayer(playerid, id, 5)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are not close enough to this player to fix his vehicle.");
    if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player needs to be in a vehicle to fix it.");
    if(GetPlayerMoney(id) < 1000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player does not have enough money to be fixed.");
    RepairVehicle(GetPlayerVehicleID(id));
    format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have fixed %s vehicle and recieved $1000 as a reward.", PlayerName(id));
    format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} Your car has been fixed by %s at the price of $1000", PlayerName(playerid));
	SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(playerid, COLOR_RED2, string[1]);
	GivePlayerMoney(playerid, 1000);
	GivePlayerMoney(id, -1000);
	return 1;
}

// add nitro
CMD:addnitro(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != MECHANIC) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a mechanic to use this command.");
    new id, string[2][128], component;
    if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /addnitro <id>");
    if(!IsPlayerInRangeOfPlayer(playerid, id, 5)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are not close enough to this player to add nitro to his vehicle.");
    if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player needs to be in a vehicle to add nitro to it.");
    if(GetPlayerMoney(id) < 1000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player does not have enough money to add nitro to his vehicle.");
    component = GetVehicleComponentInSlot(GetPlayerVehicleID(id), CARMODTYPE_NITRO);
    if(component == 1010) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has already got nitro installed on his vehicle.");
    format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have added ntiro to %s vehicle and recieved $1000 as a reward.", PlayerName(id));
    format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} Your car has been added nitro by %s at the price of $1000", PlayerName(playerid));
	SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(playerid, COLOR_RED2, string[1]);
	GivePlayerMoney(playerid, 1000);
	GivePlayerMoney(id, -1000);
	AddVehicleComponent(GetPlayerVehicleID(id), 1010);
	return 1;
}

//flip command
CMD:flip(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(gTeam[playerid] != MECHANIC) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a mechanic to use this command.");
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in a vehicle to use this command");
    new veh = GetPlayerVehicleID(playerid), Float:Angle;
    GetVehicleZAngle(veh, Angle);
    SetVehicleZAngle(veh, Angle);
    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have fliped your vehicle");
	return 1;
}


//use injections
CMD:useinjection(playerid, params[])
{
	new Float:health;
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(Injections[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have any injections left. Visit a hospital or call a medic to buy more injections.");
    if(GetPlayerHealth(playerid, health) == 100.0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You have full health, there is no need to refill it.");
	SetPlayerHealth(playerid, GetPlayerHealth(playerid, health)+50);
	Injections[playerid]--;
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} +50 health! You now have %i injections left.", Injections[playerid]);
	SendClientMessage(playerid, COLOR_RED2, G_String);
	return 1;
}

//sell injection
CMD:sellinjection(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] != MEDIC) return SendClientMessage(playerid, COLOR_RED2, "You need to be a medic to use this command");
    if(Injections[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have any injections left. Visit a hospital to buy more injections.");
	new id, string[2][128];
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /sellinjection <id>");
	if(GetPlayerMoney(id) < 1500) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player does not have enough money to give him injections.");
	format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have sold an injection to %s and recieved $1500 as a reward.", PlayerName(id));
    format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} You have been sold a injection by %s at the price of $1500", PlayerName(playerid));
    SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(playerid, COLOR_RED2, string[1]);
	GivePlayerMoney(playerid, 1500);
	GivePlayerMoney(id, -1500);
	Injections[playerid] --;
	Injections[id]++;
	return 1;
}

//heal
CMD:heal(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] != MEDIC) return SendClientMessage(playerid, COLOR_RED2, "You need to be a medic to use this command");
	new id, string[2][128], Float:health;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /heal <id>");
	if(GetPlayerMoney(id) < 1000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player does not have enough money for healing");
	if(GetPlayerHealth(id, health) == 100.0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player has already got full health.");
    format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have healed %s and have recieved $1000 as a reward", PlayerName(id));
    format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} You have been healed by %s at the price of $1000", PlayerName(playerid));
    SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(playerid, COLOR_RED2, string[1]);
	SetPlayerHealth(id, 100.0);
	return 1;
}

//give injection
CMD:giveinjection(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(Injections[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have any injections left. Visit a hospital or call a medic to buy more injections.");
	new id, string[2][128];
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /giveinjection <id>");
	format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have given an injection to %s", PlayerName(id));
    format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} You have been given a injection by %s ", PlayerName(playerid));
    SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(playerid, COLOR_RED2, string[1]);
	Injections[playerid] --;
	Injections[id]++;
	return 1;
}

// injections
CMD:injections(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} You have %i injections left.", Injections[playerid]);
    SendClientMessage(playerid, COLOR_RED2, G_String);
	return 1;
}

//laser command
CMD:laser(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] != STAT && gTeam[playerid] != ARMY && gTeam[playerid] != SWAT) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is only for special classes");
	Laser[playerid] =1;
	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] {FFFFFF}Laser enabled");
	return 1;
}


// general commands

CMD:chatc(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    new color;
    if(sscanf(params,"i",color)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /chatc <0-1>");
    switch(color)
	{
	    case 0:
	    {
	        pChat_Color[playerid] = 1;
	        SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your {00FF00}Green {FFFFFF}text");
		}
		case 1:
		{
		    pChat_Color[playerid] = 2;
		    SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} Enjoy your {FF0000}Red {FFFFFF}text");
		}
		default:
		{
		    SendClientMessage(playerid, COLOR_RED2, "[ERROR] Use numbers 0-1 for different colours");
		}
  	}
	return 1;
}

CMD:exitleisure(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(InLeisure[playerid] == false) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the leisure center before exiting it!");
	InLeisure[playerid] = false;
	SetPlayerPos(playerid, -2110.3142,-445.6071,38.7344);
	SetPlayerInterior(playerid, 0);
	SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} You have exited the leisure center");
	return 1;
}

//rob command
CMD:rob(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(gTeam[playerid] == STAT || gTeam[playerid] == ARMY || gTeam[playerid] == SWAT || gTeam[playerid] == POLICE) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Law enforcements are not allowed to use criminal commands.");
	new string[4][128], id;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /rob <id>");
 	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(GetPlayerMoney(id) < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player does not have enough money to be robbed");
	new Money = random(GetPlayerMoney(id));
	GivePlayerMoney(playerid, Money);
	GivePlayerMoney(id, -Money);
	WantedLevel[playerid] += 4;
	SetPlayerWantedLevel(playerid, WantedLevel[playerid]);
	format(string[0], 128, "[SERVER MESSAGE] {FFFFFF}You have robbed $%i from %s", Money, PlayerName(id));
	format(string[1], 128, "[SERVER MESSAGE] {FFFFFF}You have commited a crime and your wanted level now stands at: %i", WantedLevel[playerid]);
	format(string[2], 128, "[SERVER MESSAGE] {FFFFFF}You have been robed $%i from %s", Money, PlayerName(playerid));
	format(string[3], 128, "[CRIME COMMITED] %s has robbed a civilian. All law enforcers dispatch at his location: %s", PlayerName(playerid), PlayerZone(playerid));
	SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(playerid, COLOR_RED2, string[1]);
	SendClientMessage(id, COLOR_RED2, string[2]);
	SendMessageToLaw(COLOR_BLUE1, string[3]);
	SendMessageToLaw(COLOR_BLUE1, "[DISPATCH] ALL OFFICERS PLEASE RESPOND TO THIS CRIME");
	return 1;
}

//die command
CMD:die(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(WantedLevel[playerid] > 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot kill yourself while wanted.");
	if(GetPlayerMoney(playerid) < 1000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to have at least $1000 in your pocket to kill yourself.");
	if(Frozen[playerid] == 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command while frozen.");
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF}%s has killed himself ( /die )", PlayerName(playerid));
	SendClientMessageToAll(COLOR_RED2, G_String);
	SetPlayerHealth(playerid, 0.0);
	return 1;
}

//whisper command
CMD:whisper(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    new message[2][128];
    if(sscanf(params,"s[128]", message[0])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /whisper <message>");
    format(message[1], 128, "[WHISPER] %s :{FFFF00} %s", PlayerName(playerid), message[0]);
    ProxDetector(10, playerid, message[1], COLOR_ORANGE);
    SetPlayerChatBubble(playerid, message[0], COLOR_YELLOW, 10, 10000);
    return 1;
}

//give money command
CMD:gm(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    new id, ammount, string[2][128];
    if(sscanf(params,"ui",id,ammount)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /gm <ammount>");
    if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	if(GetPlayerMoney(playerid) < ammount) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You do not have this ammount of money");
	if(ammount < 0 || ammount > 200000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Min: $1 Max: $200000");
	GivePlayerMoney(playerid, -ammount);
	GivePlayerMoney(id, ammount);
	format(string[0], 128, "You have given %s $%i", PlayerName(id), ammount);
	format(string[1], 128, "You have been given $%i by %s", ammount, PlayerName(playerid));
	SendClientMessage(playerid, COLOR_LIGHTGREEN, string[0]);
	SendClientMessage(id, COLOR_LIGHTGREEN, string[1]);
	return 1;
}

// me command
CMD:me(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(Muted[playerid] == 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command while muted");
    new text[128];
    if(sscanf(params,"s[128]",text)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /me <text>");
    format(G_String, 128, "** %s %s", PlayerName(playerid), text);
    SendClientMessageToAll(COLOR_PINK, G_String);
	return 1;
}
//report command
CMD:report(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    new id, reason[128];
    if(sscanf(params,"us[128]", id, reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /report <id> <reason>");
    if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
    format(G_String, 128, "[Report] :{FFFFFF} %s  -  %s", reason, PlayerName(playerid));
    SendMessageToAdmins(COLOR_RED2, G_String);
    SendClientMessage(playerid, COLOR_LIGHTGREEN, "Report submitted to admins");
	return 1;
}

//ask command
CMD:ask(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    new message[128], string[2][128];
    if(sscanf(params,"s[128]", message)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /ask <question>");
    format(string[0], 128, "[Question] {FFFFFF} %s  -  %s", PlayerName(playerid), message);
    format(string[1], 128, "Use /apm %i <answer> to answer the players question", playerid);
    SendMessageToAdmins(COLOR_RED2, string[0]);
    SendMessageToAdmins(COLOR_LIGHTGREEN, string[1]);
    SendClientMessage(playerid, COLOR_LIGHTGREEN, "Question submitted to admins");
	return 1;
}

// Private message system
// PM command
CMD:pm(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any commands.");
	new id, message[128], string[2][128];
	if(sscanf(params,"us[128]",id,message)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /pm <id> <message>");
	format(string[0], 128, "** {FFFF00}PM From %s : %s {008000}**", PlayerName(playerid), message);
	format(string[1], 128, "** {FFFF00}PM To %s : %s {008000}**", PlayerName(id), message);
	SendClientMessage(playerid, COLOR_GREEN, string[1]);
	SendClientMessage(id, COLOR_GREEN, string[0]);
	LastPM[id] = playerid;
	return 1;
}

// Reply command
CMD:r(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any commands.");
    if(LastPM[playerid] == -1) return SendClientMessage(playerid, -1, "No one has pm'ed you since you joined the server");
    if(LastPM[playerid] == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "The player that last pm'ed you has left the server");
	new string[2][128], message[128];
    if(sscanf(params,"s[128]",message)) return SendClientMessage(playerid, -1, "Syntax: /r <message>");
    format(string[0], 128, "** {FFFF00}PM To %s : %s {008000}**", PlayerName(LastPM[playerid]), message);
    format(string[1], 128, "** {FFFF00}PM From %s : %s {008000}**", PlayerName(playerid), message);
    SendClientMessage(playerid, COLOR_GREEN, string[0]);
    SendClientMessage(LastPM[playerid], COLOR_GREEN, string[1]);
    LastPM[LastPM[playerid]] = playerid;
    return 1;
}

//Class commands

//law enforcement

CMD:grab(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
	if(gTeam[playerid] != SWAT && gTeam[playerid] != STAT) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be swat or stat to use this command");
	if(lastveh[playerid] == -1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to enter a car first.");
	new id, Float:pos[3], string[2][128];
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /grab <id>");
	if(WantedLevel[id] < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not wanted.");
	GetVehiclePos(lastveh[playerid], pos[0], pos[1], pos[2]);
	if(!IsPlayerInRangeOfPoint(playerid, 50, pos[0], pos[1], pos[2])) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You are not close enough to your vehicle.");
	if(!IsPlayerInRangeOfPlayer(playerid, id, 10)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be close enough to grab this player");
	PutPlayerInVehicle(id, lastveh[playerid], 1);
	format(string[0], 128, "[SERVER MESSAGE] :{FFFFFF} You have grabed %s into your vehicle.", PlayerName(id));
	format(string[1], 128, "[SERVER MESSAGE] :{FFFFFF} You have been grabed and placed into %s vehicle", PlayerName(playerid));
	SendClientMessage(playerid, COLOR_RED2, string[0]);
	SendClientMessage(playerid, COLOR_RED2, string[1]);
	return 1;
}

//beta commands

// Bug report command
CMD:bug(playerid, params[])
{
	new File:file=fopen(BugPath(playerid), io_append);
	new Bug[128], formatted[128];
	if(sscanf(params,"s[128]",Bug)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /rbug <Bug>");
	if(file)
	{
		format(formatted, 128, "%s\r\n", Bug);
	    fwrite(file, formatted);
	    fclose(file);
	    SendClientMessage(playerid, COLOR_GREEN, "Bug reported.");
	}
	return 1;
}

//admin commands

// Set admins level
CMD:setlvl(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return 0;
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
	new id, lvl;
	if(sscanf(params,"ui",id,lvl)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} Usage: /setlvl <id> <level>");
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
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, message[128];
	if(sscanf(params,"us[128]", id, message)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /apm <id> <message>");
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
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before using any command.");
	new id, Float:pos[3], reason[128];
	if(sscanf(params,"us[128]",id,reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /slap <id> <reason>");
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
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, reason[128];
	if(sscanf(params,"us[128]", id, reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /mute <id> <reason>");
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
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id;
	if(sscanf(params,"u", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /unmute <id>");
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
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
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
	if(sscanf(params,"us[128]", id, reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /ann <message>");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has kicked %s for reason: %s", PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);
	KickLog(playerid, id, reason);
	Kick(id);
	return 1;
}

//disarm command
CMD:disarm(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /disarm <id>");
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
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, reason[128];
	if(sscanf(params,"us[128]", id, reason)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /freeze <id> <reason>");
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
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id;
	if(sscanf(params,"u", id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /unfreeze <id>");
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
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, Float:pos[3];
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /bring <id>");
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
	if(PlayerInfo[playerid][Padmin] < HELPER) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, Float:pos[3];
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /goto <id>");
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	GetPlayerPos(id, pos[0], pos[1], pos[2]);
	SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} You have been teleported to %s", PlayerName(id));
	SendClientMessage(playerid, COLOR_LIGHTGREEN, G_String);
	return 1;
}

//give cash command
CMD:givecash(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, ammount, string[2][128];
	if(sscanf(params,"ui",id,ammount)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /givecash <id> <ammount>");
	if(ammount < 0 || ammount > 1000000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Min: 0 Max: 1 million");
	if(id == playerid && PlayerInfo[playerid][Padmin] != SENIOR_ADMIN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(string[0], 128, "You have given %s $%i cash", PlayerName(id), ammount);
	format(string[1], 128,  "You have been given $%i cash by Admin", ammount);
	SendClientMessage(playerid, COLOR_LIGHTGREEN,  string[0]);
	SendClientMessage(id, COLOR_LIGHTGREEN, string[1]);
	GivePlayerMoney(id, ammount);
	return 1;
}

// dveh command
CMD:dveh(playerid, params[])
{
 	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
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
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	for(new i = 0; i < MAX_VEHICLES;i++)
	{
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
	if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	Warns[id]++;
	if(Warns[id] >= MAX_WARNS)
	{
	    format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF}%s has been kicked for reaching maximum ammount of warnings", PlayerName(id));
	    SendClientMessageToAll(COLOR_RED2, G_String);
	    KickLog(playerid, id, "Maximum ammount of warnings");
	    Kick(id);
	}
	else
	{
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
	new id;
	if(sscanf(params,"u",id)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /resetwarnings <id>");
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
	SendClientMessage(playerid, COLOR_YELLOW, "••  San Fierro Cops And Robbers Staff ••");
	foreach(Player, i)
	{
		switch(PlayerInfo[i][Padmin])
		{
			case HELPER:
			{
			    format(G_String, 128, "•  %s {FF0000} Helper  {FFFFFF}•", PlayerName(i));
			    SendClientMessage(playerid, COLOR_WHITE, G_String);
				count++;
			}
			case MOD:
			{
			    format(G_String, 128, "•  %s {FF0000} Moderator  {FFFFFF}•", PlayerName(i));
			    SendClientMessage(playerid, COLOR_WHITE, G_String);
			    count++;
			}
			case ADMIN:
			{
			    format(G_String, 128, "•  %s {FF0000} Admin  {FFFFFF}•", PlayerName(i));
			    SendClientMessage(playerid, COLOR_WHITE, G_String);
			    count++;
			}
			case SENIOR_ADMIN:
			{
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
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	SendClientMessage(playerid, COLOR_YELLOW, "[RICH LIST] Players who have over one million cash");
	new count;
	foreach(Player, i)
	{
	    if(GetPlayerMoney(i) >= 1000000)
	    {
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
    if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has killed %s for reason: %s", PlayerName(id), reason);
	SendClientMessageToAll(COLOR_RED2, G_String);
	SetPlayerHealth(playerid, 0.0);
	return 1;
}

//warned people
CMD:warnlist(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	SendClientMessage(playerid, COLOR_YELLOW, "[WARNED LIST] Players who have been warned");
	new count;
	foreach(Player, i)
	{
	    if(Warns[i] >= 1)
	    {
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
	//if(id == playerid) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot use this command on yourself. ");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This player is not connected.");
	format(G_String, 128, "[SERVER MESSAGE] {FFFFFF} Admin has set %s wanted level to %i", PlayerName(id), level);
	SendClientMessageToAll(COLOR_RED2, G_String);
	WantedLevel[id] = level;
	return 1;
}

//set health command
CMD:sethealth(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new id, health;
	if(sscanf(params,"ui",id,health)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /sethealth <id> <health>");
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
    idx = GetVehicleModelIDFromName(name);
    if( idx == -1 )
	{
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
	return 1;
}

//weapon command
CMD:weapon(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new name[17], idx;
	if(sscanf(params,"s[212]",name)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /weapon <name>");
	idx = GetWeaponModelIDFromName(name);
	if(idx == -1)
	{
	    idx = strval(name);
	    if(idx < 0 || idx > 47 )
	        return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Invalid MODELID/NAME");
	}
	GivePlayerWeapon(playerid, idx, 500);
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} You have spawned a %s with 500 amo", WeaponNames[idx]);
	SendClientMessage(playerid, COLOR_RED2, G_String);
	return 1;
}

//giveweapon command
CMD:giveweapon(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < MOD) return SendClientMessage(playerid, COLOR_RED2,  "[ERROR] :{FFFFFF} This command is for staff members only!");
	new name[17], idx, id, string[2][128];
	if(sscanf(params,"is[212]",id, name)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /giveweapon <id> <name>");
	idx = GetWeaponModelIDFromName(name);
	if(idx == -1)
	{
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

// set tax command
CMD:settax(playerid, params[])
{
	if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be in the staff team to use this command.");
	new tax;
	if(sscanf(params,"i",tax)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /settax <ammount>");
	if(tax < 0 || tax > 200000) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Minimum: 1 Max: 200000");
	G_TAX = tax;
	format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} The tax of the server has been changed to $%i", tax);
	return 1;
}

//commands command
CMD:commands(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
	ShowPlayerDialog(playerid, DIALOG_CMDS, DIALOG_STYLE_LIST, "{FFFFFF}In-Game Commands", "{FFFFFF}Job Commands\n{FFFFFF}General Commands\n{FFFFFF}Admin Commands\n{FFFFFF}Vehicle Commands", "Select", "Close");
	return 1;
}

/* VIP COMMANDS */

CMD:koth(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerInfo[playerid][Pvip] < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a vip to use this command.");
    OnPlayerEnterKoth(playerid);
	SetPlayerPos(playerid, 121.09999847,3629.50000000,11.89999962+5);
	return 1;
}

CMD:exitkoth(playerid, params[])
{
    if(Spawned[playerid] == 0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerInfo[playerid][Pvip] < 1) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a vip to use this command.");
    OnPlayerExitKoth(playerid);
	return 1;
}

CMD:pirate(playerid, params[])
{
    SetPlayerPos (playerid,-2050.0810547,-7609.0312500,2.2020721);
	return 1;
}

CMD:vipme(playerid, params[])
{
	PlayerInfo[playerid][Pvip] = 1;
	return 1;
}
CMD:troll(playerid, params[])
{
	new id, message[128];
	if(sscanf(params,"us[128]",id,message)) return SendClientMessage(playerid, -1, "USAGE: /troll <id> <message>");
	if(id == playerid) return SendClientMessage(playerid, -1, "cant troll yourself!");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "this player is not connected");
	format(message, 128, "%s(%i): {FFFFFF}%s",PlayerName(id), id, message);
	SendClientMessageToAll(GetPlayerColor(id), message);
	return 1;
}CMD:test(playerid, params[])
{
	
	return 1;
}
