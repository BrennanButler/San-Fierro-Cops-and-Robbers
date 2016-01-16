#include <YSI\y_hooks>
new pLastUpdate[MAX_PLAYERS]; // Last update from player

IsPlayerAFK(playerid)
{
	new updateTime = (gettime() - pLastUpdate[playerid]);
	if( updateTime > 5.0 )
	{
	    // TODO: Check if player has moved.
	    return updateTime;
	}
	return 0;
}

hook OnPlayerConnect(playerid)
{
	pLastUpdate[playerid] = 0;
}

hook OnPlayerUpdate(playerid)
{
	pLastUpdate[playerid] = gettime();

	return 1;
}

ptask CheckAFK[1000](playerid)
{
	printf("Is player AFK? %s (%d)", (IsPlayerAFK(playerid) == 0)  ? "No" : "Yes", IsPlayerAFK(playerid));

	// Is the player AFK longer than 4 minutes?
	if(IsPlayerAFK(playerid) > 240)
	{
		// TODO: Alert the player about being kicked for being afk. Alert box?
		Kick(playerid);
	}
}

/* ============ EXAMPLE ============

	Timer(playerid)
	{
	    new afk = IsPlayerAFK(playerid);
	    if(afk > 0)
	    {
	        printf("Player %d is afk for %d seconds", playerid, afk);
	    }
	}

*/
