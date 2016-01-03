#include <YSI\y_hooks>

hook OnGameModeInit()
{
	BotID[0] = IRC_Connect(IRC_SERVER, IRC_PORT, "Jeffrey", "Jeffrey", "Jeffrey");
	IRC_SetIntData(BotID[0], E_IRC_CONNECT_DELAY, 20);
    BGroupID = IRC_CreateGroup();
    return 1;
}

hook OnGameModeExit()
{
	IRC_DestroyGroup(BGroupID);
	IRC_Quit(BotID[0], "Server has shutdown! Goodbye folks!");
	return 1;
}

hook OnPlayerConnect(playerid)
{
	format(G_String, 128, "%s has joined San Fierro Cops And Robbers %s", PlayerName[playerid], SERVER_VERSION);
	IRC_GroupSay(BGroupID, IRC_CHANNEL, G_String);
	return 1;
}

public IRC_OnJoinChannel(botid, channel[])
{
	printf("Joined channel %s", channel);
	return 1;
}

public IRC_OnConnect(botid, ip[], port)
{
	printf("Bot id %d connected to %s on port %d", botid, ip, port);
	//IRC_JoinChannel(botid, IRC_CHANNEL);
	IRC_AddToGroup(BGroupID, botid);
	return 1;
}

public IRC_OnConnectAttemptFail(botid, ip[], port, reason[])
{
	printf("Bot id %d failed to connect to server %s on port %d for reason: %s", botid, ip, port, reason);
	return 1;
}
