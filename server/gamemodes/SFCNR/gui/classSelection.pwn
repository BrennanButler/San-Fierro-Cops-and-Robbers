#include <YSI\y_hooks>

new Text:selectionBox[5];
new Text:selectionNav[10];
new Text:selectionText[3];
new PlayerText:selectionDesc[MAX_PLAYERS];
new PlayerText:selectionSkinWeps[MAX_PLAYERS][5];

new bool:Showing = false;

hook OnGameModeInit()
{
	selectionBox[0] = TextDrawCreate(589.000000, 85.000000, "                               ");
	TextDrawBackgroundColor(selectionBox[0], 255);
	TextDrawFont(selectionBox[0], 1);
	TextDrawLetterSize(selectionBox[0], 0.500000, 1.000000);
	TextDrawColor(selectionBox[0], -1);
	TextDrawSetOutline(selectionBox[0], 0);
	TextDrawSetProportional(selectionBox[0], 1);
	TextDrawSetShadow(selectionBox[0], 1);
	TextDrawUseBox(selectionBox[0], 1);
	TextDrawBoxColor(selectionBox[0], 1096134911);
	TextDrawTextSize(selectionBox[0], 55.000000, 0.000000);

	selectionText[2] = TextDrawCreate(73.000000, 88.000000, "Class Selection");
	TextDrawBackgroundColor(selectionText[2], 255);
	TextDrawFont(selectionText[2], 2);
	TextDrawLetterSize(selectionText[2], 0.370000, 1.700000);
	TextDrawColor(selectionText[2], -1);
	TextDrawSetOutline(selectionText[2], 1);
	TextDrawSetProportional(selectionText[2], 1);

	selectionBox[1] = TextDrawCreate(589.000000, 85.000000, "    ");
	TextDrawBackgroundColor(selectionBox[1], 255);
	TextDrawFont(selectionBox[1], 1);
	TextDrawLetterSize(selectionBox[1], 0.500000, 1.000000);
	TextDrawColor(selectionBox[1], -1);
	TextDrawSetOutline(selectionBox[1], 0);
	TextDrawSetProportional(selectionBox[1], 1);
	TextDrawSetShadow(selectionBox[1], 1);
	TextDrawUseBox(selectionBox[1], 1);
	TextDrawBoxColor(selectionBox[1], 319951615);
	TextDrawTextSize(selectionBox[1], 55.000000, 0.000000);

	selectionBox[2] = TextDrawCreate(183.000000, 123.000000, "                        ");
	TextDrawBackgroundColor(selectionBox[2], 255);
	TextDrawFont(selectionBox[2], 1);
	TextDrawLetterSize(selectionBox[2], 0.500000, 1.000000);
	TextDrawColor(selectionBox[2], -1);
	TextDrawSetOutline(selectionBox[2], 0);
	TextDrawSetProportional(selectionBox[2], 1);
	TextDrawSetShadow(selectionBox[2], 1);
	TextDrawUseBox(selectionBox[2], 1);
	TextDrawBoxColor(selectionBox[2], 910926591);
	TextDrawTextSize(selectionBox[2], 55.000000, 0.000000);

	selectionNav[0] = TextDrawCreate(69.000000, 127.000000, "Drug Dealer");
	TextDrawBackgroundColor(selectionNav[0], 255);
	TextDrawFont(selectionNav[0], 2);
	TextDrawLetterSize(selectionNav[0], 0.340000, 1.200000);
	TextDrawColor(selectionNav[0], -1);
	TextDrawSetOutline(selectionNav[0], 1);
	TextDrawSetProportional(selectionNav[0], 1);
	TextDrawSetProportional(selectionNav[0], 1);
	TextDrawSetSelectable(selectionNav[0], 1);

	selectionNav[1] = TextDrawCreate(69.000000, 149.000000, "Pedo");
	TextDrawBackgroundColor(selectionNav[1], 255);
	TextDrawFont(selectionNav[1], 2);
	TextDrawLetterSize(selectionNav[1], 0.340000, 1.200000);
	TextDrawColor(selectionNav[1], -1);
	TextDrawSetOutline(selectionNav[1], 1);
	TextDrawSetProportional(selectionNav[1], 1);
	TextDrawSetProportional(selectionNav[1], 1);
	TextDrawSetSelectable(selectionNav[1], 1);

	selectionNav[2] = TextDrawCreate(69.000000, 170.000000, "Wep Dealer");
	TextDrawBackgroundColor(selectionNav[2], 255);
	TextDrawFont(selectionNav[2], 2);
	TextDrawLetterSize(selectionNav[2], 0.340000, 1.200000);
	TextDrawColor(selectionNav[2], -1);
	TextDrawSetOutline(selectionNav[2], 1);
	TextDrawSetProportional(selectionNav[2], 1);
	TextDrawSetProportional(selectionNav[2], 1);
	TextDrawSetSelectable(selectionNav[2], 1);

	selectionNav[3] = TextDrawCreate(69.000000, 191.000000, "Thief");
	TextDrawBackgroundColor(selectionNav[3], 255);
	TextDrawFont(selectionNav[3], 2);
	TextDrawLetterSize(selectionNav[3], 0.340000, 1.200000);
	TextDrawColor(selectionNav[3], -1);
	TextDrawSetOutline(selectionNav[3], 1);
	TextDrawSetProportional(selectionNav[3], 1);
	TextDrawSetProportional(selectionNav[3], 1);
	TextDrawSetSelectable(selectionNav[3], 1);

	selectionNav[4] = TextDrawCreate(69.000000, 211.000000, "Items Dealer");
	TextDrawBackgroundColor(selectionNav[4], 255);
	TextDrawFont(selectionNav[4], 2);
	TextDrawLetterSize(selectionNav[4], 0.340000, 1.200000);
	TextDrawColor(selectionNav[4], -1);
	TextDrawSetOutline(selectionNav[4], 1);
	TextDrawSetProportional(selectionNav[4], 1);
	TextDrawSetProportional(selectionNav[4], 1);
	TextDrawSetSelectable(selectionNav[4], 1);

	selectionNav[5] = TextDrawCreate(69.000000, 231.000000, "Rapist");
	TextDrawBackgroundColor(selectionNav[5], 255);
	TextDrawFont(selectionNav[5], 2);
	TextDrawLetterSize(selectionNav[5], 0.340000, 1.200000);
	TextDrawColor(selectionNav[5], -1);
	TextDrawSetOutline(selectionNav[5], 1);
	TextDrawSetProportional(selectionNav[5], 1);
	TextDrawSetProportional(selectionNav[5], 1);
	TextDrawSetSelectable(selectionNav[5], 1);

	selectionNav[6] = TextDrawCreate(69.000000, 251.000000, "Kidnapper");
	TextDrawBackgroundColor(selectionNav[6], 255);
	TextDrawFont(selectionNav[6], 2);
	TextDrawLetterSize(selectionNav[6], 0.340000, 1.200000);
	TextDrawColor(selectionNav[6], -1);
	TextDrawSetOutline(selectionNav[6], 1);
	TextDrawSetProportional(selectionNav[6], 1);
	TextDrawSetProportional(selectionNav[6], 1);
	TextDrawSetSelectable(selectionNav[6], 1);

	selectionNav[7] = TextDrawCreate(69.000000, 272.000000, "Terrorist");
	TextDrawBackgroundColor(selectionNav[7], 255);
	TextDrawFont(selectionNav[7], 2);
	TextDrawLetterSize(selectionNav[7], 0.340000, 1.200000);
	TextDrawColor(selectionNav[7], -1);
	TextDrawSetOutline(selectionNav[7], 1);
	TextDrawSetProportional(selectionNav[7], 1);
	TextDrawSetProportional(selectionNav[7], 1);
	TextDrawSetSelectable(selectionNav[7], 1);

	selectionNav[8] = TextDrawCreate(69.000000, 294.000000, "Car Jacker");
	TextDrawBackgroundColor(selectionNav[8], 255);
	TextDrawFont(selectionNav[8], 2);
	TextDrawLetterSize(selectionNav[8], 0.340000, 1.200000);
	TextDrawColor(selectionNav[8], -1);
	TextDrawSetOutline(selectionNav[8], 1);
	TextDrawSetProportional(selectionNav[8], 1);
	TextDrawSetProportional(selectionNav[8], 1);
	TextDrawSetSelectable(selectionNav[8], 1);

	selectionNav[9] = TextDrawCreate(69.000000, 316.000000, "Whore");
	TextDrawBackgroundColor(selectionNav[9], 255);
	TextDrawFont(selectionNav[9], 2);
	TextDrawLetterSize(selectionNav[9], 0.340000, 1.200000);
	TextDrawColor(selectionNav[9], -1);
	TextDrawSetOutline(selectionNav[9], 1);
	TextDrawSetProportional(selectionNav[9], 1);
	TextDrawSetSelectable(selectionNav[9], 1);

	selectionBox[3] = TextDrawCreate(579.000000, 123.000000, "       ");
	TextDrawBackgroundColor(selectionBox[3], 255);
	TextDrawFont(selectionBox[3], 1);
	TextDrawLetterSize(selectionBox[3], 0.500000, 1.000000);
	TextDrawColor(selectionBox[3], -1);
	TextDrawSetOutline(selectionBox[3], 0);
	TextDrawSetProportional(selectionBox[3], 1);
	TextDrawSetShadow(selectionBox[3], 1);
	TextDrawUseBox(selectionBox[3], 1);
	TextDrawBoxColor(selectionBox[3], 572662527);
	TextDrawTextSize(selectionBox[3], 302.000000, 0.000000);

	selectionText[0] = TextDrawCreate(418.000000, 123.000000, "Info");
	TextDrawBackgroundColor(selectionText[0], 255);
	TextDrawFont(selectionText[0], 2);
	TextDrawLetterSize(selectionText[0], 0.409999, 1.100000);
	TextDrawColor(selectionText[0], -1);
	TextDrawSetOutline(selectionText[0], 1);
	TextDrawSetProportional(selectionText[0], 1);

	selectionBox[4] = TextDrawCreate(580.000000, 324.000000, "   ");
	TextDrawBackgroundColor(selectionBox[4], 255);
	TextDrawFont(selectionBox[4], 1);
	TextDrawLetterSize(selectionBox[4], 0.500000, 1.000000);
	TextDrawColor(selectionBox[4], -1);
	TextDrawSetOutline(selectionBox[4], 0);
	TextDrawSetProportional(selectionBox[4], 1);
	TextDrawSetShadow(selectionBox[4], 1);
	TextDrawUseBox(selectionBox[4], 1);
	TextDrawBoxColor(selectionBox[4], 572662527);
	TextDrawTextSize(selectionBox[4], 470.000000, 0.000000);

	selectionText[1] = TextDrawCreate(497.000000, 326.000000, "Spawn");
	TextDrawBackgroundColor(selectionText[1], 255);
	TextDrawFont(selectionText[1], 2);
	TextDrawLetterSize(selectionText[1], 0.389999, 1.299999);
	TextDrawColor(selectionText[1], -1);
	TextDrawSetOutline(selectionText[1], 1);
	TextDrawSetProportional(selectionText[1], 1);
	TextDrawSetSelectable(selectionText[1], 1);

	return 1;
}

hook OnPlayerConnect(playerid)
{
	selectionSkinWeps[playerid][0] = CreatePlayerTextDraw(playerid, 198.000000, 121.000000, "CJ SKIN");
	PlayerTextDrawBackgroundColor(playerid,selectionSkinWeps[playerid][0], 0x364ba2AA);
	PlayerTextDrawFont(playerid,selectionSkinWeps[playerid][0], 5);
	PlayerTextDrawLetterSize(playerid,selectionSkinWeps[playerid][0], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,selectionSkinWeps[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid,selectionSkinWeps[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid,selectionSkinWeps[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid,selectionSkinWeps[playerid][0], 1);
	PlayerTextDrawUseBox(playerid,selectionSkinWeps[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid,selectionSkinWeps[playerid][0], 910926591);
	PlayerTextDrawTextSize(playerid,selectionSkinWeps[playerid][0], 97.000000, 96.000000);

	selectionSkinWeps[playerid][1] = CreatePlayerTextDraw(playerid, 198.000000, 223.000000, "Drug Dealer");
	PlayerTextDrawBackgroundColor(playerid,selectionSkinWeps[playerid][1], 0x364ba2AA);
	PlayerTextDrawFont(playerid,selectionSkinWeps[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid,selectionSkinWeps[playerid][1], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,selectionSkinWeps[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid,selectionSkinWeps[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid,selectionSkinWeps[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid,selectionSkinWeps[playerid][1], 1);
	PlayerTextDrawUseBox(playerid,selectionSkinWeps[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid,selectionSkinWeps[playerid][1], 255);
	PlayerTextDrawTextSize(playerid,selectionSkinWeps[playerid][1], 74.000000, 63.000000);

	selectionSkinWeps[playerid][2] = CreatePlayerTextDraw(playerid, 272.000000, 223.000000, "Drug Dealer");
	PlayerTextDrawBackgroundColor(playerid,selectionSkinWeps[playerid][2], 0x364ba2AA);
	PlayerTextDrawFont(playerid,selectionSkinWeps[playerid][2], 5);
	PlayerTextDrawLetterSize(playerid,selectionSkinWeps[playerid][2], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,selectionSkinWeps[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid,selectionSkinWeps[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid,selectionSkinWeps[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid,selectionSkinWeps[playerid][2], 1);
	PlayerTextDrawUseBox(playerid,selectionSkinWeps[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid,selectionSkinWeps[playerid][2], -1);
	PlayerTextDrawTextSize(playerid,selectionSkinWeps[playerid][2], 74.000000, 63.000000);

	selectionSkinWeps[playerid][3] = CreatePlayerTextDraw(playerid, 346.000000, 223.000000, "Drug Dealer");
	PlayerTextDrawBackgroundColor(playerid,selectionSkinWeps[playerid][3], 0x364ba2AA);
	PlayerTextDrawFont(playerid,selectionSkinWeps[playerid][3], 5);
	PlayerTextDrawLetterSize(playerid,selectionSkinWeps[playerid][3], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,selectionSkinWeps[playerid][3], -1);
	PlayerTextDrawSetOutline(playerid,selectionSkinWeps[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid,selectionSkinWeps[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid,selectionSkinWeps[playerid][3], 1);
	PlayerTextDrawUseBox(playerid,selectionSkinWeps[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid,selectionSkinWeps[playerid][3], -1);
	PlayerTextDrawTextSize(playerid,selectionSkinWeps[playerid][3], 74.000000, 63.000000);

	selectionSkinWeps[playerid][4] = CreatePlayerTextDraw(playerid, 420.000000, 223.000000, "Drug Dealer");
	PlayerTextDrawBackgroundColor(playerid, selectionSkinWeps[playerid][4], 0x364ba2AA);
	PlayerTextDrawFont(playerid, selectionSkinWeps[playerid][4], 5);
	PlayerTextDrawLetterSize(playerid, selectionSkinWeps[playerid][4], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, selectionSkinWeps[playerid][4], -1);
	PlayerTextDrawSetOutline(playerid, selectionSkinWeps[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, selectionSkinWeps[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, selectionSkinWeps[playerid][4], 1);
	PlayerTextDrawUseBox(playerid, selectionSkinWeps[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, selectionSkinWeps[playerid][4], -1);
	PlayerTextDrawTextSize(playerid, selectionSkinWeps[playerid][4], 74.000000, 63.000000);

	selectionDesc[playerid] = CreatePlayerTextDraw(playerid, 310.000000, 142.000000, "Drug Dealers spawn with a 9mm, uzi, ak47 and a shotgun.~n~They also spawn with 5 weed seeds and 100 grams of all ~n~drugs.");
	PlayerTextDrawBackgroundColor(playerid, selectionDesc[playerid], 255);
	PlayerTextDrawFont(playerid, selectionDesc[playerid], 2);
	PlayerTextDrawLetterSize(playerid, selectionDesc[playerid], 0.189999, 1.100000);
	PlayerTextDrawColor(playerid, selectionDesc[playerid], -1);
	PlayerTextDrawSetOutline(playerid, selectionDesc[playerid], 1);
	PlayerTextDrawSetProportional(playerid, selectionDesc[playerid], 1);
	return 1;
}

ToggleClassSelection(playerid)
{	
	if(!Showing)
	{
		for(new i = 0; i < 5; i++)
		{
			TextDrawShowForPlayer(playerid, selectionBox[i]);
		}
		for(new i = 0; i < 10; i++)
		{
			TextDrawShowForPlayer(playerid, selectionNav[i]);
		}
		for(new i = 0; i < 3; i++)
		{
			TextDrawShowForPlayer(playerid, selectionText[i]);
		}
		for(new i = 0; i < 5; i++)
		{
			PlayerTextDrawShow(playerid, selectionSkinWeps[playerid][i]);
		}
		PlayerTextDrawShow(playerid, selectionDesc[playerid]);
		Showing = true;
	}
	else
	{
		for(new i = 0; i < 5; i++)
		{
			TextDrawHideForPlayer(playerid, selectionBox[i]);
		}
		for(new i = 0; i < 10; i++)
		{
			TextDrawHideForPlayer(playerid, selectionNav[i]);
		}
		for(new i = 0; i < 3; i++)
		{
			TextDrawHideForPlayer(playerid, selectionText[i]);
		}
		for(new i = 0; i < 5; i++)
		{
			PlayerTextDrawHide(playerid, selectionSkinWeps[playerid][i]);
		}
		PlayerTextDrawHide(playerid, selectionDesc[playerid]);
		Showing = false;
	}
}

SetDescription(playerid, text[])
{
	PlayerTextDrawSetString(playerid, selectionDesc[playerid], text);
	PlayerTextDrawShow(playerid, selectionDesc[playerid]);
}

CMD:class(playerid, params[])
{
	ToggleClassSelection(playerid);
	return 1;
}

CMD:setdesc(playerid, params[])
{
	SetDescription(playerid, params);
	return 1;
}