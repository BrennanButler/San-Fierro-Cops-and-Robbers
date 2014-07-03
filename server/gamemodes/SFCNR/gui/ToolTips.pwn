ShowCasualTextdraw(playerid, NewText[])
{
	PlayerTextDrawSetString(playerid, Casual[playerid], NewText);
    PlayerTextDrawShow(playerid, Casual[playerid]);
    return 1;
}