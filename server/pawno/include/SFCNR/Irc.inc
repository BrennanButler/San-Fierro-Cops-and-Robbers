public IRC_OnJoinChannel(botid, channel[])
{
	printf("Joined channel %s", channel);
	return 1;
}

public IRC_OnConnect(botid, ip[], port)
{
	printf("Bot id %d connected to %s on port %d", botid, ip, port);
	IRC_JoinChannel(botid, IRC_CHANNEL);
	IRC_AddToGroup(BGroupID, botid);
	return 1;
}

public IRC_OnConnectAttemptFail(botid, ip[], port, reason[])
{
	printf("Bot id %d failed to connect to server %s on port %d for reason: %s", botid, ip, port, reason);
	return 1;
}
