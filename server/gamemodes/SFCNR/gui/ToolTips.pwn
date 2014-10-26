#include <YSI\y_hooks>

new PlayerText:Casual[MAX_PLAYERS], 
	PlayerText:JobTextdraw[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
	Casual[playerid] = CreatePlayerTextDraw(playerid, 320.000000, 82.000000, "Textdraw");
	PlayerTextDrawBackgroundColor(playerid, Casual[playerid], 255);
	PlayerTextDrawFont(playerid, Casual[playerid], 3);
	PlayerTextDrawAlignment(playerid, Casual[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Casual[playerid], 0.699998, 2.499999);
	PlayerTextDrawColor(playerid, Casual[playerid], -1);
	PlayerTextDrawSetOutline(playerid, Casual[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Casual[playerid], 1);

	JobTextdraw[playerid] = CreatePlayerTextDraw(playerid, 15.000000, 434.000000, "Press ~g~CAPSLOCK ~w~to start the sweeper job");
	PlayerTextDrawBackgroundColor(playerid, JobTextdraw[playerid], 255);
	PlayerTextDrawFont(playerid, JobTextdraw[playerid], 2);
	PlayerTextDrawLetterSize(playerid, JobTextdraw[playerid], 0.270000, 1.200000);
	PlayerTextDrawColor(playerid, JobTextdraw[playerid], -1);
	PlayerTextDrawSetOutline(playerid, JobTextdraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid, JobTextdraw[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, JobTextdraw[playerid], 0);

	return 1;
}


ShowCasualTextdraw(playerid, NewText[])
{
	PlayerTextDrawSetString(playerid, Casual[playerid], NewText);
    PlayerTextDrawShow(playerid, Casual[playerid]);
    return 1;
}

HideCasualTextdraw(playerid)
{
	PlayerTextDrawHide(playerid, Casual[playerid]);
	return 1;
}

ShowJobTextdraw(playerid, text[]) 
{
	PlayerTextDrawSetString(playerid, JobTextdraw[playerid], text);
	PlayerTextDrawShow(playerid, JobTextdraw[playerid]);
	return 1;
}

HideJobTextdraw(playerid)
{
	PlayerTextDrawHide(playerid, JobTextdraw[playerid]);
	return 1;
}