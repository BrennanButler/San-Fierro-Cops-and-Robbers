#include <YSI\y_hooks>

hook OnPlayerConnect(playerid)
{
	GetPlayerName(playerid, PlayerName[playerid], 24);
	return 1;
}