#include <YSI\y_hooks>

forward BlaBla();

hook OnGameModeInit()
{
	Gconnection = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DATABASE, MYSQL_PASS);

	return 1;
}

hook OnPlayerConnect(playerid)
{
	mysql_format(Gconnection, G_String, 128, "SELECT * FROM `users` WHERE `username`='%e'", PlayerName[playerid]);
	mysql_tquery(Gconnection, G_String, "BlaBla", "");

	return 1;
}

public BlaBla()
{
	new rows, fields;
	cache_get_data(rows, fields);

	if(rows)
	{
		printf("there is data for this user");
	} else printf("there is no data for this user");

	return 1;
}