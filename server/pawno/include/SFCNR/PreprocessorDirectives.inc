//defines.

//Misc defines.

#define 		__DEBUG
#define 		__DEBUG_MAJOR
#define			SERVER_VERSION				("BETA 4.0")
#undef 			MAX_PLAYERS
#define			MAX_PLAYERS					(50) //Let's redefine our max_players to our current slots.
#define         MAX_WARNS               	(3)
#define         MAX_PING                	(700)
#define         MAX_PINGWARNING        		(5)
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

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
#define isnull(%1) \
    ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))

//Lets define some colours.

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

//Mysql defines.

#define 		MYSQL_HOST					("localhost")
#define			MYSQL_USER					("root")
#define 		MYSQL_PASS					("HG3t4H3")
#define			MYSQL_DATABASE				("sfcnr")

//irc definesor 

#define         IRC_SERVER                  ("irc.tl")
#define         IRC_PORT                    (6667)
#define         IRC_CHANNEL                 ("#sfcnr.echo")

//Team definitions.

#define 		HITMAN      				(0)
#define 		CIVILIAN    				(1)
#define 		TERRORIST    				(2)
#define 		STAT        				(4)
#define 		ARMY        				(3)
#define 		POLICE      				(5)
#define 		RAPIST      				(6)
#define 		MECHANIC    				(7)
#define 		MEDIC   					(8)
#define 		DRUG        				(9)
#define 		ROB        	 				(10)
#define 		WEP         				(11)
#define 		ITEMS       				(12)
#define 		KIDNAPPER   				(13)
#define 		PEDO        				(14)
#define 		TRUCKER     				(15)
#define 		TAXI        				(16)
#define 		SWAT        				(17)
#define         PILOT                       (18)
#define         PIZZABOY                    (19)
#define         FARMER                      (20)
#define         MINER                       (21)
#define			CARJACKER					(22)
#define         WHORE                       (23)
#define         MAYOR                       (24)
#define 		FIREFIGHTER 				(25)

//Admin ranks.

#define         HELPER                  	(1)
#define         MOD                     	(2)
#define         ADMIN                   	(3)
#define         SENIOR_ADMIN            	(4)

//Dialogs.

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

//WhirlPool

native WP_Hash(buffer[], len, const str[]);
native IsValidVehicle(vehicleid);