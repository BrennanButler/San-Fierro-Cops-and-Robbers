#include <YSI\y_hooks>

// Keep MAX_RUBBISH a low number
// The sweeper vehicle is really slow and setting a large amount of work
// would bore the player
#define MAX_RUBBISH 100

new tSweep[MAX_PLAYERS] = 0;

// This needs to be per-player due to the dynamic nature of the creation and deletion of rubbish piles
// ERROR/Bug:
// Once this variable is per-player it enables the player to pickup 2 rubbish piles per 1 he moves over
new totalRubbish = 0;

new Sweeped[MAX_PLAYERS];
new jobPayment[MAX_PLAYERS];

enum Sweeper 
{
	Float:Weight,
	Float:Xpos,
	Float:Ypos,
	Float:Zpos,
	Obj,
	MapIcon
}

new SweeperInfo[MAX_PLAYERS][MAX_SWEEPS][Sweeper];

GenerateRubbishID(playerid)
{
	for(new i = 0; i <= MAX_RUBBISH; i++)
		if ( !IsValidDynamicObject(SweeperInfo[playerid][i][Obj]) ) return i;
	return -1;
}

hook OnGameModeInit()
{
	printf("Tom is a cunt");
	return 1;
}

hook OnPlayerConnect(playerid)
{
	tSweep[playerid] = 0;

}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
	if(GetVehicleModel(vehicleid) == 574)
		HideJobTextdraw(playerid);
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	// Player is now a driver of a vehicle
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
	{
		new vModel = GetVehicleModel(GetPlayerVehicleID(playerid));

		if(vModel == 574) // Sweeper vehicle vModel
		{
			if(!(PlayerVariables[playerid] & PLAYER_IN_JOB)) 
			{
 		    	ShowJobTextdraw(playerid, "Press ~g~CAPSLOCK~w~ to start the sweeper job");
 		    }
		}
	}
	else if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT && PlayerVariables[playerid] & PLAYER_IN_JOB)
	{
		// Get back in the damn car
		// @TODO: Alert the player to get back into the vehicle. 
	}	
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	// Player pressed caps lock 
	if(PRESSED(KEY_CROUCH) && !(PlayerVariables[playerid] & PLAYER_IN_JOB))
	{
		// Player is in vehicle
		if(IsPlayerInAnyVehicle(playerid))
		{
			// is he in a sweeper?
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 574)
			{
				// has the player recently used the sweeper and still has time left on cooldown?
				if((gettime() - tSweep[playerid]) < 360) return MsgP(playerid, COLOR_RED2, "* "EMBED_WHITE"Sorry, you've recently used the sweeper. You have "EMBED_WARNING"%d"EMBED_WHITE" seconds till you can sweep again.", 360 - (gettime() - tSweep[playerid]));
				for(new i = 0; i < 100; i++)
				{
					printf("Testing... %f %f %f", SweeperInfo[playerid][i][Xpos], SweeperInfo[playerid][i][Ypos], SweeperInfo[playerid][i][Zpos]);
				}
				PlayerVariables[playerid] |= PLAYER_IN_JOB;
				HideJobTextdraw(playerid);
				SendClientMessage(playerid, COLOR_DARKGREY, "* "EMBED_WHITE"Pickup all trash from the street to earn "EMBED_SKYBLUE"money "EMBED_WHITE"and "EMBED_SKYBLUE"score"EMBED_WHITE".");
				SendClientMessage(playerid, COLOR_DARKGREY, "* "EMBED_YELLOW"Rubish "EMBED_WHITE"is representated as "EMBED_YELLOW"yellow "EMBED_WHITE"squares on your minimap.");
				SendClientMessage(playerid, COLOR_DARKGREY, "* "EMBED_WHITE"You many "EMBED_SKYBLUE"/quitjob"EMBED_WHITE" at any time.");

				printf("Loading rubbish piles for sweeper job from mysql database.");
				//TODO : Make a cache system for rubbish piles
				mysql_tquery(gConnection, "SELECT * FROM `sweeper`", "OnPlayerStartSweeperJob", "d", playerid);
			}
		}
	}
	return 1;
}

public OnPlayerStartSweeperJob(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, gConnection);

	if(rows)
	{
		for(new i = 0; i < rows; i++)
		{
			new rubbishID = GenerateRubbishID(playerid);

			SweeperInfo[playerid][rubbishID][Weight] = cache_get_row_int(i, 0);
			SweeperInfo[playerid][rubbishID][Xpos] = cache_get_row_float(i, 1);
			SweeperInfo[playerid][rubbishID][Ypos] = cache_get_row_float(i, 2);
			SweeperInfo[playerid][rubbishID][Zpos] = cache_get_row_float(i, 3);
			printf("%f %f %f", SweeperInfo[playerid][rubbishID][Xpos], SweeperInfo[playerid][rubbishID][Ypos], SweeperInfo[playerid][rubbishID][Zpos]);
			SweeperInfo[playerid][rubbishID][Obj] = CreateDynamicObject(854, SweeperInfo[playerid][rubbishID][Xpos], SweeperInfo[playerid][rubbishID][Ypos], SweeperInfo[playerid][rubbishID][Zpos], 0.0, 0.0, 0.0, -1, -1, playerid);

			totalRubbish++;
			SweeperInfo[playerid][rubbishID][MapIcon] = CreateDynamicMapIcon(SweeperInfo[playerid][rubbishID][Xpos], SweeperInfo[playerid][rubbishID][Ypos], SweeperInfo[playerid][rubbishID][Zpos], 0, COLOR_YELLOW, -1, -1, playerid, 100.0, MAPICON_GLOBAL);
		}
	}
}

ptask SweeperTimer[1000](playerid)
{
	// TODO: Make this on a loading bar, not very "realistic" picking up the rubbish instantly
	if(PlayerVariables[playerid] & PLAYER_IN_JOB)
	{
		for(new i = 0; i <= MAX_RUBBISH; i++)
		{
			// got them all?
			if(Sweeped[playerid] == totalRubbish && PlayerVariables[playerid] & PLAYER_IN_JOB)
			{
				ShowJobTextdraw(playerid, "Press ~g~CAPSLOCK ~w~to start the sweeper job");
				MsgP(playerid, COLOR_GREEN, "* "EMBED_WHITE"You have "EMBED_GREEN"finished"EMBED_WHITE" your job and earned "EMBED_GREEN"$%d!", jobPayment[playerid]);
				GivePlayerMoney(playerid, jobPayment[playerid]);
				SetPlayerScore(playerid, GetPlayerScore(playerid)+totalRubbish);
				GametextFormatted(playerid, "~g~$%d Earned!", 3000, 4, jobPayment[playerid]);
				Sweeped[playerid] = 0;
				tSweep[playerid] = gettime();
				PlayerVariables[playerid] &= ~PLAYER_IN_JOB;
				jobPayment[playerid] = 0;

				// Quick fix:
				totalRubbish = 0;

				// A fix/optimization is needed in order to reduce the number of sql queries produced by this job, or at least, reduce the execution times of said queries
			}
	
			// is the player in range of a rubbish pile?
			new Float:pos[3];
			GetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);
			if(IsPointInRangeOfPoint(SweeperInfo[playerid][i][Xpos], SweeperInfo[playerid][i][Ypos], SweeperInfo[playerid][i][Zpos], pos[0], pos[1], pos[2]-0.75, 3.0) && IsValidDynamicObject(SweeperInfo[playerid][i][Obj]))
			{
				// calculate the payment per weight.
				new payment = (SweeperInfo[playerid][i][Weight] > 9 && SweeperInfo[playerid][i][Weight] <= 50) ? 100 : ((SweeperInfo[playerid][i][Weight] > 50 && SweeperInfo[playerid][i][Weight] <= 100) ? 150 : ((SweeperInfo[playerid][i][Weight] > 100 && SweeperInfo[playerid][i][Weight] <= 150) ? 200 : ((SweeperInfo[playerid][i][Weight] > 150 && SweeperInfo[playerid][i][Weight] <= 200) ? 250 : 0)));
				Sweeped[playerid]++;
				DestroyDynamicMapIcon(SweeperInfo[playerid][i][MapIcon]);
				DestroyDynamicObject(SweeperInfo[playerid][i][Obj]);
	
				jobPayment[playerid]+= payment;
	
				MsgP(playerid, COLOR_DARKGREY, "* "EMBED_WHITE"You have picked up "EMBED_SKYBLUE"%d KG "EMBED_WHITE"worth a total of "EMBED_GREEN"$%d!", floatround(SweeperInfo[playerid][i][Weight]), payment);
			}
		}
	}
}

CMD:csweeper(playerid, params[])
{
	new Float:weight, Float:pos[3], query[128];

	// Checks
	if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} You need to spawn before using any commands");
	if(PlayerInfo[playerid][Padmin] < ADMIN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} This command is for staff members only!");
	if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
	
	if(sscanf(params,"f",weight)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] : {FFFFFF} Usage: /csweeper <weight>");
	
	if(weight < 10.0 || weight > 200.0) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Minimum weight is 10 Maximum weight is 200");


	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	MsgP(playerid, COLOR_SKYBLUE, "* "EMBED_WHITE"You have successfully created a rubbish spawn for the sweeper job totalling at "EMBED_SKYBLUE"%f"EMBED_WHITE"kg !", weight);
	format(query, 500, "INSERT INTO `sweeper` (`weight`, `x`, `y`, `z`) VALUES ('%f', '%f', '%f', '%f')", weight, pos[0], pos[1], pos[2]-0.75);
	mysql_function_query (gConnection, query, false, "", "");

	return 1;
}