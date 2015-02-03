/*
		  ___           ___           ___           ___           ___     
	     /\  \         /\  \         /\  \         /\__\         /\  \    
	    /::\  \       /::\  \       /::\  \       /::|  |       /::\  \   
	   /:/\ \  \     /:/\:\  \     /:/\:\  \     /:|:|  |      /:/\:\  \  
	  _\:\~\ \  \   /::\~\:\  \   /:/  \:\  \   /:/|:|  |__   /::\~\:\  \ 
	 /\ \:\ \ \__\ /:/\:\ \:\__\ /:/__/ \:\__\ /:/ |:| /\__\ /:/\:\ \:\__\
	 \:\ \:\ \/__/ \/__\:\ \/__/ \:\  \  \/__/ \/__|:|/:/  / \/_|::\/:/  /
	  \:\ \:\__\        \:\__\    \:\  \           |:/:/  /     |:|::/  / 
	   \:\/:/  /         \/__/     \:\  \          |::/  /      |:|\/__/  
	    \::/  /                     \:\__\         /:/  /       |:|  |    
	     \/__/                       \/__/         \/__/         \|__|   


		Gamemode by Brennan `thefatshizms` Butler

	    @changelog SFCNR/changelog.txt
	    @features  SFCNR/features.txt

	    © Brennan Butler, San Fierro Cops and Robbers sf-cnr.co.uk 2012-2015

	    @Version: 
	    	MAJOR: 0.8 ( BETA )
	    	MINOR: 2
	    	BUILD: 24

	    	0.8.2.13 ( BETA )

	    The server was originally founded by Josip and thefatshizms on the basis
	    of creating a fun, unique and good place for friends and players to come
	    play.

	    @Contact:
	    	Email: brennan9723@hotmail.com
	    	Skype: thefatshizms
	    	Steam: thefatshizms

	    This gamemode was written by thefatshizms with help from librarys and some
	    maps. Credits are shown where needed though some may be forgotten.

	    Mechanic: transport vehicles that are owned and owners not online to a pickup place

	    297.46970, 123.13170, 998.09491,   91.00000, 0.00000, 90.00000 // bank vault door opened

*/

//===================================================================================//

#include <a_samp>

//===================================================================================//


/*===================================================================================
	
	Definitions

===================================================================================*/

#define 		__DEBUG 1
#define			SERVER_VERSION				("0.8.2.45") //MAJOR.MINOR.PATCH
#undef 			MAX_PLAYERS
#define			MAX_PLAYERS					(50) 
#define         MAX_HOUSES              	(1000)
#define         MAX_BUSINESSES            	(1000)
#define         MAX_SPIKES                  (500)
#define         MAX_STORES                  (28)
#define			DEFAULT_STD					("Aids")
#define         MAX_ROADBLOCKS              (500)
#define         BOT_REALNAME                ("Jeffrey")
#define         BOT_USERNAME                ("Jeffrey")
#define         MAX_BOTS                    (1)
#define         MAX_WEED                    (1000)
#define         MAX_COW_NODES               (100)
#define 		MAX_ITEMS					(15)
#define 		MAX_SWEEPS					(1000)
#define 		MAX_FIRES					(4000)
#define 		MAX_CENTERID				(2000)

//Colours

//main colour scheme 
#define 		COLOR_DARKGREY				0x34302DAA
#define 		COLOR_GREEN 				0x86C543AA
#define 		COLOR_YELLOW 				0xFCD920AA
#define 		COLOR_WHITE 				0xFFFEFFAA
#define 		COLOR_SKYBLUE 				0x00A9E0AA

//other
#define			COLOR_ORANGE				0xFF8000FF
#define 		COLOR_GREY 					0xAFAFAFAA
#define 		COLOR_BLUE1 				0x0066FFFF
#define 		COLOR_LIGHTBLUE 			0x33CCFFAA
#define 		COLOR_LIGHTGREEN 			0x9ACD32AA
#define 		COLOR_VIP 					0xC93CCE00
#define 		COLOR_PURPLE 				0xC2A2DAAA
#define 		COLOR_PINK 					0xFF66FFAA
#define 		COLOR_DBLUE 				0x2641FEAA
#define 		COLOR_RED2					0xFF0000FF
#define         COLOR_FIRE              	0xC11B17FF
#define         COLOR_BLACK             	0x000000FF
#define         COLOR_COOLBLUE          	0x00cacaFF //Only used for random messages.
#define 		COLOR_WARNING				0xF0AD4EFF

//embed

#define 		EMBED_WARNING				"{f0ad4e}"
#define			EMBED_ORANGE				"{FF8000}"
#define 		EMBED_GREY 					"{AFAFAF}"
#define 		EMBED_GREEN 				"{86C543}"
#define 		EMBED_BLUE1 				"{0066FF}"
#define 		EMBED_LIGHTBLUE 			"{33CCFF}"
#define 		EMBED_LIGHTGREEN 			"{9ACD32}"
#define 		EMBED_YELLOW 				"{FCD920}"
#define 		EMBED_VIP 					"{C93CCE}"
#define 		EMBED_WHITE 				"{FFFEFF}"
#define 		EMBED_PURPLE 				"{C2A2DA}"
#define 		EMBED_PINK 					"{FF66FF}"
#define 		EMBED_DBLUE 				"{2641FE}"
#define 		EMBED_RED2					"{FF0000}"
#define         EMBED_FIRE              	"{C11B17}"
#define         EMBED_BLACK             	"{000000}"
#define         EMBED_COOLBLUE          	"{00caca}"
#define         EMBED_SKYBLUE           	"{00A9E0}"

//Mysql defines

#define 		MYSQL_HOST					("localhost")
#define			MYSQL_USER					("root")
#define 		MYSQL_PASS					("")
#define			MYSQL_DATABASE				("sfcnr")

//IRC defines

#define         IRC_SERVER                  ("irc.tl")
#define         IRC_PORT                    (6667)
#define         IRC_CHANNEL                 ("#sfcnr")

//Team definitions

#define 		HITMAN      				(0)
#define 		CIVILIAN    				(1)
#define 		TERRORIST    				(2)
#define 		STAT        				(3)
#define 		ARMY        				(4)
#define 		POLICE      				(5)
#define 		FIREFIGHTER 				(6)
#define 		SWAT        				(7)
#define         PILOT                       (8)
#define 		RAPIST      				(9)
#define 		MECHANIC    				(10)
#define 		MEDIC   					(11)
#define 		DRUG        				(12)
#define 		ROB        	 				(13)
#define 		WEP         				(14)
#define 		ITEMS       				(15)
#define 		KIDNAPPER   				(16)
#define 		PEDO        				(17)
#define 		TRUCKER     				(18)
#define 		TAXI        				(19)
#define         PIZZABOY                    (20)
#define         FARMER                      (21)
#define         MINER                       (22)
#define			CARJACKER					(23)
#define         WHORE                       (24)
#define         MAYOR                       (25)


//Admin ranks

#define         HELPER                  	(1)
#define         MOD                     	(2)
#define         ADMIN                   	(3)
#define         SENIOR_ADMIN            	(4)

//Dialogs

#define         DIALOG_REGISTER         	(0)
#define         DIALOG_LOGIN            	(1)
#define         DIALOG_CLASS            	(2)
#define         DIALOG_ACMDS            	(3)
#define         DIALOG_CMDS             	(4)
#define         DIALOG_GCMDS            	(5)
#define         DIALOG_JCMDS            	(6)
#define         DIALOG_VCMDS            	(7)
#define         DIALOG_HELPERCMDS      	 	(8)
#define         DIALOG_MODCMDS          	(9)
#define         DIALOG_ADMINCMDS        	(10)
#define         DIALOG_SENIORCMDS       	(11)
#define         DIALOG_LESURE           	(12)
#define         DIALOG_COPGUN           	(13)
#define 		DIALOG_BUYCAR				(14)
#define			DIALOG_NUMPLATE				(15)
#define         DIALOG_DRUG             	(16)
#define         DIALOG_BUYSTUFF         	(17)
#define         DIALOG_HOUSE            	(18)
#define         DIALOG_STATS            	(19)
#define         DIALOG_EDITHOUSE        	(20)
#define         DIALOG_RADIO            	(21)
#define         DIALOG_YOUTUBE          	(22)
#define         DIALOG_EDITHOUSEOWNER   	(23)
#define         DIALOG_EDITHOUSEPRICE   	(24)
#define         DIALOG_EDITHOUSESALEPRICE	(25)
#define			DIALOG_BANKMENU				(26)
#define			DIALOG_BANKWITH				(27)
#define			DIALOG_BANKDEP				(28)
#define			DIALOG_STATEMENT			(29)
#define			DIALOG_BANKWIREID			(30)
#define			DIALOG_BANKWIRE				(31)
#define			DIALOG_BANKWIREPEFORM		(32)
#define         DIALOG_TAXIPAY              (33)
#define         DIALOG_DESTINATION          (34)
#define         DIALOG_VEHMANAGE            (35)
#define         DIALOG_CHANGEPASS           (36)
#define         DIALOG_PASSSURE             (37)
#define         DIALOG_PURCHASEVEH          (38)
#define         DIALOG_VEHNUMPLATE          (39)
#define 		DIALOG_CRIM_WEP				(40)
#define 		DIALOG_CRIM_AMO				(41)
#define 		DIALOG_EOWARN				(42)
#define 		DIALOG_BUY_FOOD				(43)
#define			DIALOG_GANG_MAKE			(44)

//business types

#define         BUSINESS_AMU1           	(1)
#define         BUSINESS_AMU2           	(2)
#define         BUSINESS_AMU3           	(3)
#define         BUSINESS_AMU4           	(4)
#define         BUSINESS_AMU5           	(5)
#define         BUSINESS_HORSE          	(6)
#define         BUSINESS_SEX            	(7)
#define         BUSINESS_MEAT           	(8)
#define         BUSINESS_ZERO           	(9)
#define         BUSINESS_CLUB           	(10)
#define         BUSINESS_BAR            	(11)
#define         BUSINESS_PROB           	(12)
#define         BUSINESS_RANCH          	(13)
#define         BUSINESS_STRIP          	(14)
#define         BUSINESS_BROTHEL        	(15)
#define         BUSINESS_TIGERBROTHEL   	(16)
#define         BUSINESS_LIBERTY        	(17)


//trailers

#define			TRAILER_FLUID				(584)
#define			TRAILER_ORE					(450)
#define			TRAILER_CARGO				(435)

//macros

#define 		IsPlayerLoggedIn(%0)		(PlayerVariables[%0] & PLAYER_LOGGED_IN)
#define 		IsPlayerCivilian(%0) \
		(gTeam[%0] != 3 || gTeam[%0] != 4 || gTeam[%0] != 5 || gTeam[%0] != 6 || gTeam[%0] != 7 || gTeam[%0] != 8)

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
#define isnull(%1) \
    ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))

//WhirlPool

native WP_Hash(buffer[], len, const str[]);
native IsValidVehicle(vehicleid);
native gpci(playerid, serial[], len);


main()
{
	print("\n|*|=====================================|*|");
	print("    San Fierro Cops And Robbers Gamemode ");
	printf("    Gamemode Version: %s            ", SERVER_VERSION);
	print("|*|=====================================|*|\n");

	print("\n********************************************");
	print("             Gamemode credits                ");
	print("---------------------------------------------");
	print("     Brennan Butler - Maker of this gamemode  ");
	print("     Josip - Made this server with me         ");
	print("     BoSSpeed   - Always here, good friend    ");
	print("     Kalcor - Making all this possible       \n\n\n");
}

public OnGameModeInit() 
{ 
	#if defined gm_OnGameModeInit

	return gm_OnGameModeInit();

	#else

	return 1;

	#endif
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit gm_OnGameModeInit

#if defined gm_OnGameModeInit
	forward gm_OnGameModeInit();
#endif

/*===================================================================================

	Librarys

===================================================================================*/

#include <sscanf2>

#include <YSI\y_va>
#include <YSI\y_timers>
#include <YSI\y_hooks>
#include <YSI\y_iterate>
#include <YSI\y_ini>
#include <zcmd>

#include <streamer>

#include <zones>
#include <remove>

#include <cuffs>
#include <a_mysql>

#include <abreak>

#include <irc>


/*===================================================================================

	Variables
	TODO: Clean up

===================================================================================*/


forward timeupdate();
forward Mysql_Register(playerid, password[]);
forward Mysql_Login(playerid, password[]);
forward OnPlayerRegister(playerid);
forward OnPlayerLogin(playerid);
forward OnPlayerRequestLoginRegister(playerid);
forward OnPlayerRequestLogin(playerid);
forward OnPlayerEnterKoth(playerid);
forward OnPlayerExitKoth(playerid);
forward OnPlayerCommitCrime(playerid, wantedlevel, crime[], extraid);
forward OnPlayerBanned(playerid);
forward OnHousesLoaded();
forward OnHouseCreated(houseid);
forward GetHouseInfo(houseid);
forward SmallTimer(playerid);
forward OnPlayerPM(playerid, pmto, message[]);
forward OnForumRegister(index, response_code, data[]);
forward OnPlayerLeavePMGroup(playerid, groupid);
forward OnMysqlCheckPass(playerid, password[]);
forward OnPlayerEnterPrison(playerid, time, oldwanted);
forward OnServerLoadVehicles(playerid);
forward ServerCoreTimer();
forward Float:GetPointAngleToPoint(Float:x2, Float:y2, Float:X, Float:Y);
forward OnWeedBurnt(weedid, burner);
forward OnPlayerStartSweeperJob(playerid);
forward OnBanChecked(playerid);
forward OnPlayerRecieveJobWage(playerid, jobid, wage);
forward OnServerLoadClothing(playerid);
forward OnFirePutOut(fireid, playerid);
forward OnPlayerJoinServer(playerid);


enum PInfo
{
	Ppassword[250],
	Pusername[24],
	Padmin,
	Pmoney,
	Float:Health,
	Float:Armour,
	Pscore,
	Pcop,
	Pvip,
	Pbank,
	Pip[16],
	Parrest,
	BizID,
	Pstat,
	Parmy,
	Pswat,
	Pprison,
	Prob,
	Prape,
	Pheal,
	Phitman,
	Psales,
	Pwep,
	Pdrug,
	Ptaze,
	Ptruck,
	Psurender,
	STD[100],
	PrisonTime,
	bool:Mayor,
	GroupID,
	PTERRORIST,
	Pfix,
	Pkidnapper,
	Ppedo,
	Ptaxi,
	Ppilot,
	Ppizza,
	Pfarmer,
	Pminer,
	Ptaxirate,
	totalvehs,
	LangRoom,
	Pkills,
	Parrests
}

new PlayerInfo[MAX_PLAYERS][PInfo];

enum PlayerVars:(<<=1)
{
	PLAYER_SPAWNED = 1,
	PLAYER_LOGGED_IN,
	PLAYER_IN_LEISURE,
	PLAYER_FROZEN,
	PLAYER_MUTED,
	PLAYER_RAPED,
	PLAYER_EDITING_HOUSE,
	PLAYER_REQUESTED_TOYS,
	PLAYER_CUFFED,
	PLAYER_IN_JAIL,
	PLAYER_KICKED,
	PLAYER_TAZED,
	PLAYER_REQUESTED_WEAPONS,
	PLAYER_REQUESTED_ITEMS,
	PLAYER_IN_BUSINESS,
	PLAYER_IN_CLASS_SELECTION,
	PLAYER_PM_OFF,
	PLAYER_HAS_BOMB,
	PLAYER_HAS_VEHICLE_ARMOUR,
	PLAYER_HAS_ARMOUR,
	PLAYER_IN_MOVIE_MODE,
	PLAYER_ON_PICKUP,
	PLAYER_READING_RULES,
	PLAYER_FORCED_READ_RULES,
	PLAYER_IS_REGISTERED,
	PLAYER_IN_ARMY,
	PLAYER_IN_SWAT,
	PLAYER_IN_STAT,
	PLAYER_IN_JOB,
	PLAYER_BANNED,
	PLAYER_HAS_PRIVATE_DRIVER,
	PLAYER_REQUESTED_PIZZA,
	IN_HOTEL
}

new PlayerVars:PlayerVariables[MAX_PLAYERS];

new cow;//variables.
new cow2;
new PlayerName[MAX_PLAYERS][24];
new bool:IsACow[60];
new gCowLastMove[60];//last move in seconds
new Gconnection; //The connection to MySQL
new total_vehicles; //Loading of the maps vehicles
new gTeam[MAX_PLAYERS]; //The players teamID
new bool:VehicleLocked[MAX_VEHICLES];//if the vehicle is locked
new G_String[128 char]; //Global string
new PlayerText:Zone[MAX_PLAYERS];//For the zone you are in
new PlayerText:Spedo[MAX_PLAYERS][3];//the spedo textdraw
new Rand; // global random variable
new Injections[MAX_PLAYERS]; // injections on a player
new Text:timetext;//Textdraw for the clock
new Minute = 00;//minutes for the clock
new Hour = 12;//hours for the clock
new timestring[6];// string for the textdraw
new MaxPassAttempts[MAX_PLAYERS]; //speaks for itself
new lastveh[MAX_PLAYERS]; // Last vehicle entered
new WantedLevel[MAX_PLAYERS]; //the players wanted level
new g_PlayerFires[MAX_PLAYERS];//the amount of fires the player has put out
new Hit[MAX_PLAYERS]; //A players hit
new HitPrice[MAX_PLAYERS]; // A players hit price
new Laser[MAX_PLAYERS]; // A players laser
new pChat_Color[MAX_PLAYERS];//A players chat colour
new LastPM[MAX_PLAYERS];//The last pm you recieved
new Warns[MAX_PLAYERS]; //Warnings of a player
new JobWage[24];//the job wage for each job
new G_TAX;//Gloal tax
new VaultDoor;
new timing[1];//used for timing callbacks etc
new Cocaine[MAX_PLAYERS]; //A players cocain
new Heroin[MAX_PLAYERS];//A players heroin
new Weed[MAX_PLAYERS];//A players weed
new WeedSeeds[MAX_PLAYERS];//Weed seeds
new TLaser[MAX_PLAYERS]; //temp laser
new bool:HasSpod[MAX_PLAYERS];//have an spod?
new Bar:ItemBatch[MAX_PLAYERS];//progress of loading/unloading the stuff
new bool:Krose[MAX_PLAYERS];//Have an krose cd?
new bool:Kdst[MAX_PLAYERS];//Have a kdst cd?
new bool:Rap[MAX_PLAYERS];//Have a rap cd?
new SweeperCash[MAX_PLAYERS];//the total cash earned
new LastCuffAttempt[MAX_PLAYERS];//the last time the player attempted to break cuffs
new bool:Rock[MAX_PLAYERS];//Have a rock cd?
new checkpoints[500]; //Checkpoint id's
new MessageIndex = 0;
new Text3D:HotelRooms[MAX_PLAYERS][8];//hotel room labels
new pickups[500]; //pickups ids
new bool:InCriminalBase[MAX_PLAYERS];//is the player in the crim base?
new CurrentJobID[MAX_PLAYERS];//their current job id
new JobStatus[MAX_PLAYERS];//the job status 1 = getting items 2 = delivering
new CTime[MAX_PLAYERS];//chat time!
new ArmyGate;//The actaul army gate
new Time[MAX_PLAYERS];//time spam
new JobTime[MAX_PLAYERS][25];//when they started the job
new BannedP[MAX_PLAYERS];//banned player
new bool:SweepCreated[MAX_SWEEPS];
new CheckingBan[MAX_PLAYERS];//checking the ban status
new TimeOnline[MAX_PLAYERS]; //time online the server
new Minutes[MAX_PLAYERS];//mins online
new House[MAX_PLAYERS];//the house the player is in
new TimeMessages = 0;//the time since the last server message
new TotalSweeps;
new bool:HCreated[MAX_HOUSES];//if the house is created
new HouseStanding[MAX_PLAYERS]; //house the player is standing on.
new ResprayWanted[MAX_PLAYERS];//if they have used the pay 'n spray to decreas their wanted level
new JobIcon[MAX_PLAYERS];//the job mapicon
//new Text:Logo, Text:Logo2;//logo textdraws
new Text:URL;//url textdraw
new Text:DialogBoxes[2];//the main boxes (header and main) for the new dialog
new Text:DialogButtons[3];//the dialog buttons
new PlayerText:DialogTitle[MAX_PLAYERS];//the dialog title
new PlayerText:DialogContent[MAX_PLAYERS][4];//the dialog content
new PlayerText:DialogButtonText[MAX_PLAYERS][3];//the button text
new Text:JobSelection[18];//the job textdraw
new PlayerFoodSale[MAX_PLAYERS];//Checkpoint id for the food sale
new PlayerText:JobSelectionTextdraw[7];//the job textdraws for player
new bool:VehCreated[MAX_VEHICLES];//if the player vehicle is created
new bool:SellingFood[MAX_PLAYERS];//if the player is selling food
new JobCheckpoint[MAX_PLAYERS];//the job checkpoint id
new RobTime[MAX_PLAYERS];//recently been robbed
new ToyStock[MAX_PLAYERS];//the players stock on toys
new RapeTime[MAX_PLAYERS];//recently been raped
new PlayerText:PrisonTextdraw[MAX_PLAYERS];//Prison textdraw
new Hitter[MAX_PLAYERS];//Who hit this player? (hitman)
new bool:StunGun[MAX_PLAYERS];//If the player has a stun gun
new bool:Cuffs[MAX_PLAYERS];//if the player has cuffs
new bool:Spod[MAX_PLAYERS];//if the player has the spod
new bool:Wallet[MAX_PLAYERS];//if the player has a wallet
new bool:AntiRape[MAX_PLAYERS];//if the player has an anti rape device
new WepStock[MAX_PLAYERS];//how much weapon stock the player has
new ItemStock[MAX_PLAYERS];//Item stock
new RequestedDriver[MAX_PLAYERS];//trhe private driver
new RequestedDriverCoolDown[MAX_PLAYERS];//the cooldown
new StoreTimeRobbed[MAX_STORES];//when the shop was last robbed.
new RequestItemCooldown[MAX_PLAYERS];//items cool down
new bool:RBCreated[MAX_ROADBLOCKS]; // if the roadblock is created
new SweeperWeight[MAX_PLAYERS];//the weight they picked up
new RequestWepCooldown[MAX_PLAYERS];//wep cool down
new ArmyGangzone[6];//The gangzones
new SwatGangzone;//the swat gangzone
new bool:CreatedVehicle[MAX_VEHICLES];//the vehicle is created by command
new RoadSpikes[MAX_PLAYERS];//how many road spikes laid down
new bool:SpikeCreated[MAX_SPIKES];//spike created?
new ArmyGangZoneTimer[MAX_PLAYERS];//for the timer of army gangzone
new PizzaRequestTime[MAX_PLAYERS];//the time when the player requested pizza (gettime())
new StatGangzone;//the stat gangzone
new PlayerRobberyID[MAX_PLAYERS];//the robbery interior id
new PlayerText:RobberyText[MAX_PLAYERS];//The robbery textdraw
new RobberyTime[MAX_PLAYERS] =15;//the robbery time left
new StoreRobbing[MAX_PLAYERS];//what store is the player robbing
new bool:StoreRobbed[MAX_STORES];//is the store robbed?
new WeedPlanted[MAX_PLAYERS];//how many has the player planted
new building[4];//the mech
new Aindex[MAX_PLAYERS];
new ItemBarValue[MAX_PLAYERS];
//new bool:BCreated[MAX_BUSINESSES];//if the business is created
new bool:Ignore[MAX_PLAYERS][MAX_PLAYERS];//if the player is irnogring him
new WireID[MAX_PLAYERS];//the player this player is wiring money to
new Bomb[MAX_PLAYERS];//the id of the bomb object
new PlayerText:VehicleBuy[MAX_PLAYERS][3]; //the vehicle buy textdraw
new Text:VehButtons[2];
new stairs[3];//prison stairs
new FoodPrice[MAX_PLAYERS];//the price of the food
new RoadBlocks[MAX_PLAYERS]; // keep track of how many roadblocks are placed per user
new TaxiDriver[MAX_PLAYERS];//the taxi driver id
new VBulletArmourTime[MAX_PLAYERS];//how long the players have left of vehicle armour
new BulletArmourTime[MAX_PLAYERS];//how long the players have left of armour
#if defined __DEBUG
new debug_String[128];//debug string
#endif
new bool:Clamped[MAX_VEHICLES]; // is this vehicle clamped
new bool:VehicleDestroy[MAX_VEHICLES];//to destroy the vehicle slowly
new PlayerStolenVeh[MAX_PLAYERS][MAX_VEHICLES];//if they've stolen the vehicle.
new PVehicle[MAX_PLAYERS];//the vehicle the player selected
new FoodSelling[MAX_PLAYERS];//what type of food is the player selling
new City[MAX_PLAYERS];//what city the player is in
new Text:RulesTextDraw[14];//the rules textdraw
new BotID[MAX_BOTS];//irc bot
new BGroupID;//the bot group id
new bool:SeenWeedMessage[MAX_PLAYERS];//has the player seen the message?
new bool:CNodeTaken[MAX_COW_NODES];
new bool:CenterCreated[MAX_CENTERID] = false;
new g_Inventorytype[MAX_PLAYERS];
new doors[4];//prison doors
new bool:FireCreated[MAX_FIRES] = false;
new Menu:clothingtype;
new Menu:Hats;
new Menu:Misc;
new pLasthit[MAX_PLAYERS];
new Cones[82]; //cones for driving test
new VehicleSprayColor[MAX_PLAYERS] =1;
new fence[36];//<-prison fences

/*===================================================================================

	Gamemode files

===================================================================================*/

//Utils
#include "SFCNR/utils/debug.pwn"
#include "SFCNR/utils/iostreams.pwn"
#include "SFCNR/utils/Player.pwn"

//GUI
#include "SFCNR/gui/ToolTips.pwn"
#include "SFCNR/gui/classSelection.pwn"

//Data 
#include "SFCNR/data/Vehicle.pwn"
#include "SFCNR/data/Map.pwn"
#include "SFCNR/data/MPIcons.pwn"
//#include "SFCNR/data/Collectables.pwn"

//Core
#include "SFCNR/core/Server/Init.pwn"
#include "SFCNR/core/Server/Irc.pwn"
#include "SFCNR/core/Player/Connections.pwn"
#include "SFCNR/core/Player/Accounts.pwn"
#include "SFCNR/core/Player/Spawn.pwn"
#include "SFCNR/core/Player/Death.pwn"
#include "SFCNR/core/Player/PrivateMessaging.pwn"
#include "SFCNR/core/Server/MySQL.pwn"
#include "SFCNR/core/Server/Vehicle.pwn"
#include "SFCNR/core/Server/Streamer.pwn"
#include "SFCNR/core/Player/Bank.pwn"
#include "SFCNR/core/Player/AFK.pwn"

//Jobs 
#include "SFCNR/core/Player/Jobs/Sweeper.Job.pwn"
#include "SFCNR/core/Player/Jobs/DDealer.Job.pwn"

//Commands
//#include "SFCNR/core/Player/Commands/Law.Commands.pwn"
#include "SFCNR/core/Player/Commands/DDealer.Commands.pwn"
#include "SFCNR/core/Player/Commands/Hitman.Commands.pwn"
#include "SFCNR/core/Player/Commands/IDealer.Commands.pwn"
#include "SFCNR/core/Player/Commands/Mechanic.Commands.pwn"
#include "SFCNR/core/Player/Commands/Medic.Commands.pwn"
#include "SFCNR/core/Player/Commands/Pedo.Commands.pwn"
#include "SFCNR/core/Player/Commands/Pizza.Commands.pwn"
#include "SFCNR/core/Player/Commands/Taxi.Commands.pwn"
#include "SFCNR/core/Player/Commands/WDealer.Commands.pwn"
#include "SFCNR/core/Player/Commands/Whore.Commands.pwn"

//World 
#include "SFCNR/world/SpecialZones.pwn"
