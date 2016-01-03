#include <YSI\y_hooks>

new 
	Text:ProgressBackBar,
	BitArray:ProgressID<500>;
	
enum PBar 
{
	ID,
	PlayerText:Bar[2],
	Value
}

new ProgressBar[MAX_PLAYERS][PBar];

hook OnGameModeInit()
{
	ProgressBackBar = TextDrawCreate(443.000000, 300.000000, "_ ");
	TextDrawBackgroundColor(ProgressBackBar, 255);
	TextDrawFont(ProgressBackBar, 1);
	TextDrawLetterSize(ProgressBackBar, 0.500000, 1.000000);
	TextDrawColor(ProgressBackBar, -1);
	TextDrawSetOutline(ProgressBackBar, 0);
	TextDrawSetProportional(ProgressBackBar, 1);
	TextDrawSetShadow(ProgressBackBar, 1);
	TextDrawUseBox(ProgressBackBar, 1);
	TextDrawBoxColor(ProgressBackBar, 96);
	TextDrawTextSize(ProgressBackBar, 201.000000, 0.000000);
}

stock GetProgressID()
{
	foreach(new ID : ProgressID)
	{
		if(!Bit_Get(ProgressID, ID)) return ID;
	}
	return -1;
}

stock CreateProgressBar()
{	
	new 
		ID = GetProgressID();

	if(ID != -1)
	{
		ProgressBar[playerid][Bar][ID][0] = CreatePlayerTextDraw(playerid, 205.000000, 300.000000, "_ ");
		PlayerTextDrawBackgroundColor(playerid, ProgressBar[playerid][Bar][ID][0], 255);
		PlayerTextDrawFont(playerid, ProgressBar[playerid][Bar][ID][0], 1);
		PlayerTextDrawLetterSize(playerid, ProgressBar[playerid][Bar][ID][0], 0.500000, 1.000000);
		PlayerTextDrawColor(playerid, ProgressBar[playerid][Bar][ID][0], -1);
		PlayerTextDrawSetOutline(playerid, ProgressBar[playerid][Bar][ID][0], 0);
		PlayerTextDrawSetProportional(playerid, ProgressBar[playerid][Bar][ID][0], 1);
		PlayerTextDrawSetShadow(playerid, ProgressBar[playerid][Bar][ID][0], 1);
		PlayerTextDrawUseBox(playerid, ProgressBar[playerid][Bar][ID][0], 1);
		PlayerTextDrawBoxColor(playerid, ProgressBar[playerid][Bar][ID][0], 897374378);
		PlayerTextDrawTextSize(playerid, ProgressBar[playerid][Bar][ID][0], 201.000000, 1.000000);

		ProgressBar[playerid][Bar][ID][1] = CreatePlayerTextDraw(playerid, 324.000000, 302.000000, "0%");
		PlayerTextDrawAlignment(playerid, ProgressBar[playerid][Bar][ID][1], 2);
		PlayerTextDrawBackgroundColor(playerid, ProgressBar[ID][playerid][1], 255);
		PlayerTextDrawFont(playerid, ProgressBar[ID][playerid][1], 2);
		PlayerTextDrawLetterSize(playerid, ProgressBar[ID][playerid][1], 0.310000, 1.399999);
		PlayerTextDrawColor(playerid, ProgressBar[ID][playerid][1], -1);
		PlayerTextDrawSetOutline(playerid, ProgressBar[ID][playerid][1], 1);
		PlayerTextDrawSetProportional(playerid, ProgressBar[ID][playerid][1], 1);
		return 1;
	} 
	else return 0;
}

stock ShowProgressBar(Bid, playerid)
{
	TextDrawShowForPlayer(playerid, ProgressBackBar);
	PlayerTextDrawShow(playerid, ProgressBar[Bid][playerid][0]);
	PlayerTextDrawShow(playerid, ProgressBar[Bid][playerid][1]);
}

stock SetProgressBarValue(Bid, value) 
{

}