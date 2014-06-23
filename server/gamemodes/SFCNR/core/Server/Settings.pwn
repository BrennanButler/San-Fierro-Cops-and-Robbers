#include <YSI\y_hooks>
new Text:Textdraw0;
new Text:Textdraw1;
new Text:Textdraw2;
hook OnGameModeInit()
{
	SetGameModeText("SFCNR");

	UsePlayerPedAnims();

	SetWeather(10);

	EnableStuntBonusForAll(0);

	AllowInteriorWeapons(true);
	return 1;
}

new Float:org = 205.0000;
hook OnPlayerUpdate(playerid)
{
	org+= 2.32;
	TextDrawUseBox(Textdraw1, 1);
	TextDrawTextSize(Textdraw1, org, 300.0);
	TextDrawShowForAll(Textdraw1);
	new string[100];
	format(string, 100, "%d%%", floatround(((org-205.0000)/2.32)));
	TextDrawSetString(Textdraw2, string);
	TextDrawShowForAll(Textdraw2);

	if(org >= 437.0000)
		org = 205.0000;

	return 1;
}