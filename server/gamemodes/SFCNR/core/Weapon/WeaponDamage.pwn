#include <YSI\y_hooks>

hook OnPlayerGiveDamage(playerid, damagedid, amount, weaponid)
{
	new 
		Float:pHealth;

	GetPlayerHealth(damagedid, pHealth);

	if((pHealth - amount) < pHealth)
	{
		printf("[SUSPICIOUS] Player %d is suspected to be suspicious.", playerid);
		//MsgA(COLOR_YELLOW, "Potential suspicious player: " EMBED_WHITE "%d", playerid);
	}

	return 1;
}

hook OnPlayerTakeDamage(playerid, issuerid, amount, weaponid)
{
	if(issuerid == INVALID_PLAYER_ID)
	{
		//Hurt himself, doh!
		pLasthit[playerid] = playerid;
		return 1;
	}

	pLasthit[playerid] = issuerid;

	return 1;
}