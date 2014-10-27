#include <YSI\y_hooks>

// Keep MAX_RUBBISH a low number
// The sweeper vehicle is really slow and setting a large amount of work
// would bore the player
#define MAX_RUBBISH 100

new tSweep[MAX_PLAYERS] = 0;
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

new SweeperInfo[MAX_SWEEPS][Sweeper];

GenerateRubbishID()
{
	for(new i = 0; i <= MAX_RUBBISH; i++)
		if ( !IsValidDynamicObject(SweeperInfo[i][Obj]) ) return i;
	return -1;
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
				if((gettime() - tSweep[playerid]) < 360) return MsgP(playerid, COLOR_WARNING, "Sorry, you've recently used the sweeper. You have "EMBED_WHITE"%d"EMBED_WARNING" seconds till you can sweep again.", (tSweep[playerid] / 60));
				PlayerVariables[playerid] |= PLAYER_IN_JOB;
				HideJobTextdraw(playerid);
				SendClientMessage(playerid, COLOR_DARKGREY, "[J] "EMBED_WHITE"Pickup all trash from the street to earn "EMBED_SKYBLUE"money "EMBED_WHITE"and "EMBED_SKYBLUE"score"EMBED_WHITE".");
				SendClientMessage(playerid, COLOR_DARKGREY, "[J] "EMBED_YELLOW"Rubish "EMBED_WHITE"is representated as "EMBED_YELLOW"yellow "EMBED_WHITE"squares on your minimap.");
				SendClientMessage(playerid, COLOR_DARKGREY, "[J] "EMBED_WHITE"You many "EMBED_SKYBLUE"/quitjob"EMBED_WHITE" at any time.");

				printf("Loading rubbish piles for sweeper job from mysql database.");
				//TODO : Make a cache system for rubbish piles
				mysql_tquery(Gconnection, "SELECT * FROM `sweeper`", "OnPlayerStartSweeperJob", "d", playerid);
			}
		}
	}
	return 1;
}

public OnPlayerStartSweeperJob(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, Gconnection);

	if(rows)
	{
		for(new i = 0; i < rows; i++)
		{
			new rubbishID = GenerateRubbishID();

			SweeperInfo[rubbishID][Weight] = cache_get_row_int(i, 0);
			SweeperInfo[rubbishID][Xpos] = cache_get_row_float(i, 1);
			SweeperInfo[rubbishID][Ypos] = cache_get_row_float(i, 2);
			SweeperInfo[rubbishID][Zpos] = cache_get_row_float(i, 3);
			printf("%f %f %f", SweeperInfo[rubbishID][Xpos], SweeperInfo[rubbishID][Ypos], SweeperInfo[rubbishID][Zpos]);
			SweeperInfo[rubbishID][Obj] = CreateDynamicObject(854, SweeperInfo[rubbishID][Xpos], SweeperInfo[rubbishID][Ypos], SweeperInfo[rubbishID][Zpos], 0.0, 0.0, 0.0, -1, -1, playerid);

			totalRubbish++;

			SweeperInfo[rubbishID][MapIcon] = CreateDynamicMapIcon(SweeperInfo[rubbishID][Xpos], SweeperInfo[rubbishID][Ypos], SweeperInfo[rubbishID][Zpos], 0, COLOR_YELLOW, -1, -1, playerid);
		}
	}
}

ptask SweeperTimer[1000](playerid)
{
	// TODO: Make this on a loading bar, not very "realistic" picking up the rubbish instantly
	for(new i = 0; i <= MAX_RUBBISH; i++)
	{
		// got them all?
		if(Sweeped[playerid] == totalRubbish && PlayerVariables[playerid] & PLAYER_IN_JOB)
		{
			ShowJobTextdraw(playerid, "Press ~g~CAPSLOCK ~w~to start the sweeper job");
			MsgP(playerid, COLOR_DARKGREY, "[J] "EMBED_WHITE"You have "EMBED_GREEN"finished"EMBED_WHITE" your job and earned "EMBED_GREEN"$%d!", jobPayment[playerid]);
			GivePlayerMoney(playerid, jobPayment[playerid]);
			SetPlayerScore(playerid, GetPlayerScore(i)+totalRubbish);
			GametextFormatted(playerid, "~g~$%d Earned!", 3000, 4, jobPayment[playerid]);
			Sweeped[playerid] = 0;
			tSweep[playerid] = gettime();
			PlayerVariables[playerid] &= ~PLAYER_IN_JOB;
		}

		// is the player in range of a rubbish pile?
		new Float:pos[3];
		GetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);
		if(IsPointInRangeOfPoint(SweeperInfo[i][Xpos], SweeperInfo[i][Ypos], SweeperInfo[i][Zpos], pos[0], pos[1], pos[2]-0.75, 3.0) && IsValidDynamicObject(SweeperInfo[i][Obj]))
		{
			// calculate the payment per weight.
			new payment = (SweeperInfo[i][Weight] > 9 && SweeperInfo[i][Weight] <= 50) ? 100 : ((SweeperInfo[i][Weight] > 50 && SweeperInfo[i][Weight] <= 100) ? 150 : ((SweeperInfo[i][Weight] > 100 && SweeperInfo[i][Weight] <= 150) ? 200 : ((SweeperInfo[i][Weight] > 150 && SweeperInfo[i][Weight] <= 200) ? 250 : 0)));
			Sweeped[playerid]++;
			DestroyDynamicMapIcon(SweeperInfo[i][MapIcon]);
			DestroyDynamicObject(SweeperInfo[i][Obj]);

			jobPayment[playerid]+= payment;

			MsgP(playerid, COLOR_DARKGREY, "[J] "EMBED_WHITE"You have picked up "EMBED_SKYBLUE"%d KG "EMBED_WHITE"worth a total of "EMBED_GREEN"$%d!", floatround(SweeperInfo[playerid][SweeperInfo[i][Weight]]), payment);
		}
	}
}