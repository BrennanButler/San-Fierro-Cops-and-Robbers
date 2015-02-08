#include <YSI\y_hooks>

hook OnPlayerDeath(playerid, killerid, reason)
{

	new pDeathString[100];
	if(killerid == INVALID_PLAYER_ID)
	{
		switch(reason)
		{
			case 16, 35..36, 39, 51: pDeathString = "was killed by a massive explosion.";
			case 18, 37: pDeathString = "was burnt alive.";
			case 41..42: pDeathString = "choked on lethal gases.";
			case 49: pDeathString = "was run over by a speeding vehicle.";
			case 50: pDeathString = "was sliced by the blades of a helicopter";
			case 53: pDeathString = "drowned, silly sod.";
			case 54: pDeathString = "fell from great heights, silly sod.";
			default: pDeathString = "died from unkown causes.";
		}
		MsgAP(COLOR_YELLOW, "%s " EMBED_WHITE "%s", PlayerName[playerid], pDeathString);
	}

	if(IsPlayerConnected(killerid))
	{
		switch(reason)
		{
			case 0..7, 10..15: pDeathString = "They were killed with a melee weapon.";
			case 8: pDeathString = "They were decapitated by a sword of some kind.";
			case 9: pDeathString = "They were cut in half by a chainsaw.";
			case 16, 35..36, 39, 51: pDeathString = "They were killed by a massive explosion.";
			case 18, 37: pDeathString = "They were burnt alive.";
			case 22..34, 38: pDeathString = "They were shot until dead.";
			case 41..42: pDeathString = "They choked on lethal gases.";
			case 49: pDeathString = "They were run over by a speeding vehicle.";
			case 50: pDeathString = "They were sliced by the blades of a helicopter";
			case 53: pDeathString = "They drowned, silly sod.";
			case 54: pDeathString = "They fell from great heights, silly sod.";
			default: pDeathString = "They died from unkown causes.";
		}

		MsgAP(COLOR_YELLOW, "%s " EMBED_WHITE "has died. %s (" EMBED_RED2 "%d" EMBED_WHITE ")", PlayerName[playerid], pDeathString, killerid);
	}


	SendDeathMessage(killerid, playerid, reason);

	return 1;
}