/*
	Counter strike created by Brennan `thefatshizms` Butler

	© thefatshizms Software.

	© Copyright :

		By using this gamemode you are accepting the following:

			• You're not to resell or gain any profit from the gamemode (Excluding donations)
			• You're not to give this gamemode to any other person. (If you need help, see the bottom)
			• You're not to remove or change the copyrights and credits from this gamemode's source. 

	Help:

		If you need help with this gamemode, the contact information is displayed below:

			• EMAIL: 	brennan9723@hotmail.com
			• WEBSITE: 	www.sf-cnr.co.uk
			• SKYPE:	thefatshizms
			• SA-MP:	www.forum.sa-mp.com/member.php?u=148466
*/

/*
	CHECKLIST

	• 6 Different skins, 3 for each class
	• Two teams, counter terrorist and terrorist
	• When killing a player, if you have killed him with a crap gun (9mm etc) then he gains more money then he would with a good gun (m4 etc)
	• Team balancer
	• Textdraws indicating kills, deaths, team, and time till next round
	• Map changing system - Every 15 minutes
	• On each level up (score) they get a reward



*/
//includes
#include <a_samp>
#include <YSI\y_ini>


//defines

#define				USER_INI_PATH					("CS/users/%s.ini")
#define 			DEBUG
//dialogs

#define 			DIALOG_LOGIN					(0)
#define 			DIALOG_REGISTER					(1)

//teams

#define 			COUNTER 						(0)
#define 			TERRORIST 						(1)

//forwards
forward LoadAccount_user(playerid, name[], value[]);

//whirlpool

native WP_Hash(buffer[], len, const str[]);

//variables

new LoginAttempts[MAX_PLAYERS];
new Text:CounterTerrorist;
new Text:Terrorist;
new gTeam[MAX_PLAYERS];

//enums

enum PInfo 
{
	Ppassword[229],
	Psalt[100],
	Pscore,
	Pmoney,
	Padmin,
	Pdeaths,
	Pkills,
	Float:KD
}

new PlayerInfo[MAX_PLAYERS][PInfo];

//functions

PlayerName(playerid) {

	new name[24];
	GetPlayerName(playerid, name, 24);
	return name;
}

GetUserPath(playerid) {

	new path[37];
	format(path, 37, USER_INI_PATH, PlayerName(playerid));
	return path;
}

main()
{
	//Do not remove!
	printf("\n---------------------------------------------------------\n");
	printf("		Couter Strike has been loaded");
	printf("	   Created by Brennan `thefatshizms` Butler");
	printf("\n---------------------------------------------------------\n");
	//Do not remove!
}

public OnGameModeInit()
{	
	SetGameModeText("CounterStrike");
	SendRconCommand("hostname CounterStrike");
	SendRconCommand("mapname Map #1");

	//textdraws

	CounterTerrorist = TextDrawCreate(394.000000,159.000000,"~g~Class Name: ~w~~b~Counter Terrorist~N~~g~Class Information:~w~~N~>Able to features, lol");
	TextDrawUseBox(CounterTerrorist,1);
	TextDrawBoxColor(CounterTerrorist,0x00000065);
	TextDrawTextSize(CounterTerrorist,620.000000,0.000000);
	TextDrawAlignment(CounterTerrorist,0);
	TextDrawBackgroundColor(CounterTerrorist,0x000000FF);
	TextDrawFont(CounterTerrorist,2);
	TextDrawLetterSize(CounterTerrorist,0.25,1.0);
	TextDrawColor(CounterTerrorist,0xFFFFFFFF);
	TextDrawSetOutline(CounterTerrorist,1);
	TextDrawSetProportional(CounterTerrorist,1);
	TextDrawSetShadow(CounterTerrorist,1);


	Terrorist = TextDrawCreate(394.000000,159.000000,"~g~Class Name: ~w~~r~Terrorist~N~~g~Class Information:~w~~N~>These people tend to spawn");
	TextDrawUseBox(Terrorist,1);
	TextDrawBoxColor(Terrorist,0x00000065);
	TextDrawTextSize(Terrorist,620.000000,0.000000);
	TextDrawAlignment(Terrorist,0);
	TextDrawBackgroundColor(Terrorist,0x000000FF);
	TextDrawFont(Terrorist,2);
	TextDrawLetterSize(Terrorist,0.25,1.0);
	TextDrawColor(Terrorist,0xFFFFFFFF);
	TextDrawSetOutline(Terrorist,1);
	TextDrawSetProportional(Terrorist,1);
	TextDrawSetShadow(Terrorist,1);


	AddPlayerClass(11, -2384.5786, 1581.8998, 13.8062, 206.4518, 0, 0, 0, 0, 0, 0); //Counter Terrorist
	AddPlayerClass(179, -2384.5786, 1581.8998, 13.8062, 206.4518, 0, 0, 0, 0, 0, 0); //Counter Terrorist
	AddPlayerClass(285, -2384.5786, 1581.8998, 13.8062, 206.4518, 0, 0, 0, 0, 0, 0); //Counter Terrorist
	AddPlayerClass(112, -2473.8445, 1548.7585, 33.2273, 172.9482, 0, 0, 0, 0, 0, 0); //Terrorist
	AddPlayerClass(122, -2473.8445, 1548.7585, 33.2273, 172.9482, 0, 0, 0, 0, 0, 0); //Terrorist
	AddPlayerClass(124, -2473.8445, 1548.7585, 33.2273, 172.9482, 0, 0, 0, 0, 0, 0); //Terrorist
	return 1;
}

//Custom Callbacks

public LoadAccount_user(playerid, name[], value[])
{
	INI_String("Password", PlayerInfo[playerid][Ppassword], 229);
	return 1;
}

public OnPlayerConnect(playerid)
{
	//reset
	LoginAttempts[playerid] = 0;

	//login / register
	if(!fexist(GetUserPath(playerid))) {
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "{FFFFFF} Your account doesn't exist!", "{FFFFFF}We didn't find your account in our files, please input a password in order to register.", "Continue", "");
		#if defined DEBUG
			printf("%s has entered the server. His account does not exist with us... Attempting registration.", PlayerName(playerid));
		#endif
	} else {
		INI_ParseFile(GetUserPath(playerid), "LoadAccount_%s", .bExtra = true, .extra = playerid);
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FFFFFF} Your account exists!", "{FFFFFF}We found your account in our files, please input the password you used to register with us.", "Continue", "");
		#if defined DEBUG
			printf("%s has entered the server. His account exists with us... Attempting login.", PlayerName(playerid));
		#endif
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, -2408.0334,1545.2686,31.8594);
	SetPlayerCameraPos(playerid, -2402.4036,1545.2621,31.8594);
	SetPlayerCameraLookAt(playerid, -2408.0334,1545.2686,31.8594);
	SetPlayerFacingAngle(playerid, 268.0105);
	switch(classid)
	{
		case 0..2:
		{
			TextDrawHideForPlayer(playerid, Terrorist);
	        TextDrawShowForPlayer(playerid, CounterTerrorist);
	        gTeam[playerid] = COUNTER;
		}
		case 3..5:
		{
			TextDrawHideForPlayer(playerid, CounterTerrorist);
	        TextDrawShowForPlayer(playerid, Terrorist);
	        gTeam[playerid] = TERRORIST;
		}
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerTeam(playerid, gTeam[playerid]);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_REGISTER:
		{
			if(strlen(inputtext) < 4) {
				SendClientMessage(playerid, -1, "You must enter at least 4 characters.");
				return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "{FFFFFF} Your account doesn't exist!", "{FFFFFF}We didn't find your account in our files, please input a password in order to register.", "Continue", "");
			}
			new hash[229];
			format(hash, 229, "%s",  inputtext);
			WP_Hash(hash, 229, hash);

			new INI:file = INI_Open(GetUserPath(playerid));
			INI_SetTag(file,"Player's Password Information");
			INI_WriteString(file, "Password", hash);
			INI_SetTag(file, "Player Statistics");
			INI_WriteInt(file, "Score", 0);
			INI_WriteInt(file, "Money", 0);
			INI_WriteInt(file, "Admin", 0);
			INI_WriteInt(file, "Deaths", 0);
			INI_WriteInt(file, "Kills", 0);
			INI_WriteInt(file, "KD", 0);
			INI_Close(file);

			#if defined DEBUG
				printf("%s has created an account.", PlayerName(playerid));
			#endif
		}
		case DIALOG_LOGIN:
		{	
			if(strlen(inputtext) < 4) {
				SendClientMessage(playerid, -1, "You must enter at least 4 characters.");
				return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FFFFFF} Your account exists!", "{FFFFFF}We found your account in our files, please input the password you used to register with us.", "Continue", "");
			}
			new password[229];
			format(password, 229, "%s", inputtext);
			WP_Hash(password, 229, password);
			if(!strcmp(PlayerInfo[playerid][Ppassword], password, true)) {
				SendClientMessage(playerid, -1, "You have logged in");
				#if defined DEBUG
					printf("%s has logged in successfully.", PlayerName(playerid));
				#endif
			} else {
				#if defined DEBUG
					printf("%s has attemped login with an incorrect password. Attempting another login. Chances left: %d", PlayerName(playerid), 3 - LoginAttempts[playerid]);
				#endif
				if(LoginAttempts[playerid] < 3) {
					SendClientMessage(playerid, -1, "You have attempted to login with an incorrect password, please try again.");
					++LoginAttempts[playerid];
					ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FFFFFF} Your account exists!", "{FFFFFF}We found your account in our files, please input the password you used to register with us.", "Continue", "");
				} else {
					#if defined DEBUG
						printf("%s has attemped login with an incorrect password too many times and has been kicked.", PlayerName(playerid));
					#endif
				}
			}
		}
	}

	return 1;
}