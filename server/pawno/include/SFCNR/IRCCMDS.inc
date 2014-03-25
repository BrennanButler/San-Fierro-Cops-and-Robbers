//irc commands

IRCCMD:say(botid, channel[], user[], host[], params[])
{
	new message[128];
	if(sscanf(params, "s[128]", message)) return IRC_Notice(BGroupID, user, "Usage: !say <text>");
	format(G_String, 128, "** FROM IRC :{FFFFFF} %s: %s {008000}**", user, message);
	IRC_Notice(BGroupID, user, "Message sent!");
	SendClientMessageToAll(COLOR_GREEN, G_String);
	return 1;
}


IRCCMD:kickplayer(botid, channel[], user[], host[], params[])
{
	new id, string[100];
	IRC_GetUserChannelMode(BGroupID, IRC_CHANNEL, user, string);
	if(strcmp(string, "@") != 0 && strcmp(string, "~") != 0 && strcmp(string, "&") != 0) return IRC_Notice(BGroupID, user, "You're not allowed to use this command.");
	if(sscanf(params, "ds[100]", id)) return IRC_Notice(BGroupID, user, "Usage: !kick <id, reason>");
	format(G_String, 128, "%s has kicked %s for reason: %s", user, string);
	SendClientMessageToAll(COLOR_GREEN, G_String);
	IRC_Notice(BGroupID, user, "Successfully kicked.");
	IRC_GroupSay(BGroupID, IRC_CHANNEL, G_String);
	PlayerVariables[id] |= PLAYER_KICKED;
	
	return 1;
}
