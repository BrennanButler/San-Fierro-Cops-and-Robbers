#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
	GetPlayerName(playerid, PlayerName[playerid], 24);

	format(G_String, 128, "%s has joined San Fierro Cops And Robbers %s", PlayerName[playerid], SERVER_VERSION);
	SendClientMessageToAll(COLOR_GREY, G_String);

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	switch(reason)//How did they leave?
	{
	    case 0: format(G_String, 128, "%s Has left the server. (Timeout)", PlayerName[playerid]);
	    case 1: format(G_String, 128, "%s Has left the server. (Leaving)", PlayerName[playerid]);
	    case 2: format(G_String, 128, "%s Has left the server. (Kicked/Banned)", PlayerName[playerid]);
	}

	SendClientMessageToAll(COLOR_GREY, G_String);//Lets inform everyone
	return 1;
}