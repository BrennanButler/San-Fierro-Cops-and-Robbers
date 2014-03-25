#include <a_samp>
#include <YSI\y_ini>
#include <fly>
#include <zcmd>
#include <sscanf2>
#include <streamer>

#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
#define DIALOG_SUCCESS_1 3
#define DIALOG_SUCCESS_2 4
#define DIALOG_LOBBY 5

#define PATH "/Users/%s.ini"

#define LIGHTBLUE "{00CED1}"
#define ALB "{ffffff}"
#define RED "{F81414}"
#define GREEN "{00FF22}"
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GRAD1 0xFFFFFFFF
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_BLUE 0x2641FEAA
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_YELLOW3 0xFFFF00FF
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_CHAT1 0xF9B7FFAA
#define COLOR_CHAT2 0xE6A9ECAA
#define COLOR_CHAT3 0xC38EC7AA
#define COLOR_CHAT4 0xD2B9D3AA
#define COLOR_CHAT5 0xC6AEC7AA
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_YELLOW2 0xF5DEB3AA
#define COLOR_GOLD 	0xF6C861AA
#define COLOR_DBLUE 0x2641FEAA
#define COLOR_OOC 0xE0FFFFAA
#define PURPLE "{7A378B}"
#define COLOR_GREEN 			0x008000FF
#define COLOR_LIGHTBLUE 		0xADD8E6FF
#define COLOR_RED 				0xFF0000FF
#define COLOR_LIGHTGREEN 		0x9ACD32AA
#define CYELLOW "{9DBD1E}"
#define CORANGE "{E68C0E}"
#define CBLUE   "{39AACC}"
#define CDGREEN "{6FA828}"
#define CWHITE  "{FFFFFF}"
#define CRED    "{FF0000}"
#define COBJS1	"{D0A5D1}"
#define COBJS2  "{8FC95F}"
#define CSALMON "{FA8072}"
#define COL_WHITE "{FFFFFF}"
#define COL_RED "{F81414}"
#define COL_GREEN "{00FF22}"
#define COL_LIGHTBLUE "{00CED1}"

enum pInfo
{
    pPass,
    pCash,
    pAdmin,
    pKills,
    pDeaths
}
new PlayerInfo[MAX_PLAYERS][pInfo];
new IsFlying[MAX_PLAYERS];

new Text:Textdraw0;
new Text:Textdraw1;

new lobby1slots = 0;
new lobby2slots = 0;
new lobby3slots = 0;
new lobby4slots = 0;
new lobby5slots = 0;

forward LoadUser_data(playerid,name[],value[]);
public LoadUser_data(playerid,name[],value[])
{
    INI_Int("Password",PlayerInfo[playerid][pPass]);
    INI_Int("Cash",PlayerInfo[playerid][pCash]);
    INI_Int("Admin",PlayerInfo[playerid][pAdmin]);
    INI_Int("Kills",PlayerInfo[playerid][pKills]);
    INI_Int("Deaths",PlayerInfo[playerid][pDeaths]);
    return 1;
}

stock UserPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string),PATH,playername);
    return string;
}

/*Credits to Dracoblue*/
stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

main()
{
	print("\n----------------------------------");
	print(" Mission script | Connor Howell");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
    Textdraw0 = TextDrawCreate(650.000000, 1.000000, "       ");
	TextDrawBackgroundColor(Textdraw0, 255);
	TextDrawFont(Textdraw0, 1);
	TextDrawLetterSize(Textdraw0, 0.500000, 1.000000);
	TextDrawColor(Textdraw0, -1);
	TextDrawSetOutline(Textdraw0, 0);
	TextDrawSetProportional(Textdraw0, 1);
	TextDrawSetShadow(Textdraw0, 1);
	TextDrawUseBox(Textdraw0, 1);
	TextDrawBoxColor(Textdraw0, 255);
	TextDrawTextSize(Textdraw0, -63.000000, 0.000000);

	Textdraw1 = TextDrawCreate(650.000000, 391.000000, "       ");
	TextDrawBackgroundColor(Textdraw1, 255);
	TextDrawFont(Textdraw1, 1);
	TextDrawLetterSize(Textdraw1, 0.500000, 1.000000);
	TextDrawColor(Textdraw1, -1);
	TextDrawSetOutline(Textdraw1, 0);
	TextDrawSetProportional(Textdraw1, 1);
	TextDrawSetShadow(Textdraw1, 1);
	TextDrawUseBox(Textdraw1, 1);
	TextDrawBoxColor(Textdraw1, 255);

	TextDrawTextSize(Textdraw1, -63.000000, 0.000000);
	SetGameModeText("Missions");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
    InitFly(playerid);
    if(fexist(UserPath(playerid)))
    {
        INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,""COL_WHITE"Login",""COL_WHITE"Type your password below to login.","Login","Quit");
    }
    else
    {
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD,""COL_WHITE"Registering...",""COL_WHITE"Type your password below to register a new account.","Register","Quit");
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new INI:File = INI_Open(UserPath(playerid));
    INI_SetTag(File,"data");
    INI_WriteInt(File,"Cash",GetPlayerMoney(playerid));
    INI_WriteInt(File,"Admin",PlayerInfo[playerid][pAdmin]);
    INI_WriteInt(File,"Kills",PlayerInfo[playerid][pKills]);
    INI_WriteInt(File,"Deaths",PlayerInfo[playerid][pDeaths]);
    INI_Close(File);
    return 1;
}

public OnPlayerSpawn(playerid)
{
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

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch( dialogid )
    {
        case DIALOG_LOBBY:
        {
            if (!response)
            {
                //SOLO CODE HERE
            }
            if (response)
            {
                //ADD TO LOBBY
            }
        }
        case DIALOG_REGISTER:
        {
            if (!response) return Kick(playerid);
            if(response)
            {
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, ""COL_WHITE"Registering...",""COL_RED"You have entered an invalid password.\n"COL_WHITE"Type your password below to register a new account.","Register","Quit");
                new INI:File = INI_Open(UserPath(playerid));
                INI_SetTag(File,"data");
                INI_WriteInt(File,"Password",udb_hash(inputtext));
                INI_WriteInt(File,"Cash",0);
                INI_WriteInt(File,"Admin",0);
                INI_WriteInt(File,"Kills",0);
                INI_WriteInt(File,"Deaths",0);
                INI_Close(File);

                SpawnPlayer(playerid);
            }
        }

        case DIALOG_LOGIN:
        {
            if ( !response ) return Kick ( playerid );
            if( response )
            {
                if(udb_hash(inputtext) == PlayerInfo[playerid][pPass])
                {
                    INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
                    GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
                    new string[256];
                    format(string, sizeof(string), "Lobby 1 - %i/5 Free\nLobby 2 - %i/5 Slots Free\nLobby 3 - %i/5 Slots Free\nLobby 4 - %i/5 Slots Free\nLobby 5 - %i/5 Slots Free", lobby1slots, lobby2slots, lobby3slots, lobby4slots, lobby5slots);
                    ShowPlayerDialog(playerid, DIALOG_LOBBY, DIALOG_STYLE_LIST, "Choose a Lobby", string, "Join", "Solo");
                }
                else
                {
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,""COL_WHITE"Login",""COL_RED"You have entered an incorrect password.\n"COL_WHITE"Type your password below to login.","Login","Quit");
                }
                return 1;
            }
        }
    }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
stock SetPlayerCutscene(playerid)
{
    TogglePlayerSpectating(playerid, 1);
    TogglePlayerControllable(playerid,0);
    TextDrawShowForPlayer(playerid,Textdraw1);
    TextDrawShowForPlayer(playerid,Textdraw0);
	return 1;
}
CMD:fly(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 3)
	{
	SendClientMessage(playerid, COLOR_LIGHTRED, "You are not a level 4 admin");
	return 1;
	}
	if(IsFlying[playerid] == 1)
    {
        StopFly(playerid);
        SendClientMessage(playerid, COLOR_LIGHTGREEN, "You've stopped flying!");
        IsFlying[playerid] = 0;
        SetPlayerHealth(playerid, 100);
        return 1;
    }
    else
    {
        StartFly(playerid);
        SendClientMessage(playerid, COLOR_LIGHTGREEN, "You're now flying!");
        IsFlying[playerid] = 1;
        SetPlayerHealth(playerid, 999999);
        return 1;
    }
}
CMD:veh(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		new veh,color1,color2;
		if (!sscanf(params, "iii", veh, color1,color2))
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x,y,z);
			AddStaticVehicle(veh, x,y,z,0,color1, color2);
		}
		else SendClientMessage(playerid, 0xFFFFFFFF, "Usage: /veh [carid] [Color 1] [Color 2]");
	}
	else SendClientMessage(playerid, 0xFFFFFFFF, "You do not have the rights to use that command!");
	return 1;
 }
CMD:makeadmin(playerid, params[])
{
    new pID, value;
	if(PlayerInfo[playerid][pAdmin] < 1338 && !IsPlayerAdmin(playerid)) return SendClientMessage(playerid, 0xFF0000AA, " you are not authorized to use this command!");
	else if (sscanf(params, "ui", pID, value)) return SendClientMessage(playerid, 0xFF0000AA, "Usage: /makeadmin [playerid/partofname] [level 1-1338]");
	else if (value < 0 || value > 1338) return SendClientMessage(playerid, 0xFF0000AA, "Unknown level! Only 0 to 1338");
	else if(pID == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_GREY,"Invalid player id");
	else
	{
	   	new pName[MAX_PLAYER_NAME], tName[MAX_PLAYER_NAME], string[128];
	   	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	    GetPlayerName(pID, tName, MAX_PLAYER_NAME);
	    format(string, sizeof(string), "You have promoted %s to Admin level %i", tName, value);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	    format(string, sizeof(string), "You have been promoted to Admin level %i by %s", value, pName);
	    SendClientMessage(pID, COLOR_LIGHTBLUE, string);
	    PlayerInfo[pID][pAdmin] = value;
    }
    return 1;
}
CMD:cutscene(playerid, params[])
{
	SetPlayerCutscene(playerid);
	InterpolateCameraPos(playerid, 2044.8234, 1342.7731, 10.6719, 2044.8234, 1342.7731, 10.6719, 10000, CAMERA_CUT);
	InterpolateCameraLookAt(playerid, 2016.3668, 1343.1252, 12.4475, 2016.3668, 1343.1252, 12.4475, 10000, CAMERA_CUT);
	return 1;
}
CMD:endccutscene(playerid, params[])
{
	TogglePlayerControllable(playerid,1);
	TogglePlayerSpectating(playerid, 0);
	TextDrawHideForPlayer(playerid,Textdraw1);
	TextDrawHideForPlayer(playerid,Textdraw0);
	return 1;
}
