#include <YSI\y_hooks>


hook OnGameModeInit()
{
	Gconnection = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DATABASE, MYSQL_PASS);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	

	return 1;
}
