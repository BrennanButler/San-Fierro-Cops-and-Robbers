CMD:hits(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(!IsPlayerSpamming(playerid)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Please stop spamming.");
    if(gTeam[playerid] != HITMAN) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to be a hitman to use this command.");
    new count;
    foreach(Player, i)
    {
        if(Hit[i] == 1)
        {
            format(G_String, 128, "[SERVER MESSAGE] :{FFFFFF} %s | Price: $%i | Location: %s", PlayerName[i], HitPrice[i], PlayerZone(i));
            SendClientMessage(playerid, COLOR_RED2, G_String);
            count++;
		}
	}
	if(count == 0) return SendClientMessage(playerid, COLOR_RED2, "[SERVER MESSAGE] :{FFFFFF} There are no online players with hits");

	return 1;
}
