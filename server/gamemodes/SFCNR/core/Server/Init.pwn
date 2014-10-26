#include <YSI\y_hooks>

hook OnGameModeInit()
{

	//Settings up browser view (name, url etc)
	//meaning you won't have to dibber dabber in the cfg to set everything up

	SendRconCommand("hostname San Fierro Cops and Robbers [0.8.2.13]");
	SendRconCommand("weburl www.sf-cnr.co.uk");
	SetGameModeText("Cops and Robbers");

	UsePlayerPedAnims();

	SetWeather(10);

	EnableStuntBonusForAll(0);

	AllowInteriorWeapons(true);
	
	return 1;
}
