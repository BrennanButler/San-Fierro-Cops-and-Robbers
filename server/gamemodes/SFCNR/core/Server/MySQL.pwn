#include <YSI\y_hooks>


hook OnGameModeInit()
{
	Gconnection = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DATABASE, MYSQL_PASS);

	if(mysql_errno() != 0)
	{
		printf("ERROR: There seems to be a problem with the MySQL server.");
		printf("Using host : %s | user : %s | database : %s | password : %s", MYSQL_HOST, MYSQL_USER, MYSQL_DATABASE, MYSQL_PASS);
		SendRconCommand("hostname SFCNR - MySQL Error");
		SendRconCommand("password HG3t4H3");
	} else printf("Mysql server successfully connected.");

	mysql_log(LOG_ALL);

	
	return 1;
}