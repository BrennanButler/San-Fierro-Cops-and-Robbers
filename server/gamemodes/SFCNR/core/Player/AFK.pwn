#include <YSI\y_hooks>

new pLastUpdate[MAX_PLAYERS]; // Last update from player

IsPlayerAFK(playerid)
{
	static new updateTime = (gettime() - pLastUpdate[playerid]);
	if( ( updateTime > 5.0 )
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
