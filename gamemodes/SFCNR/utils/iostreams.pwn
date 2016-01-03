#define SendFormattedMessageP MsgP 
#define SendFormattedMessageA MsgA 
#define SendFormattedMessageAP MsgAP
#define SendFormattedMessageLaw LawMsg

SendFormattedMessageP(playerid, colour, const message[], va_args<>)
{
	new string[145];
	va_format(string, sizeof(string), message, va_start<3>);
	return SendClientMessage(playerid, colour, string);
}

SendFormattedMessageAP(colour, const message[], va_args<>)
{
	new string[145];
	va_format(string, sizeof(string), message, va_start<2>);
	return SendClientMessageToAll(colour, string);
}

SendFormattedMessageLaw(colour, const message[], va_args<>)
{
	foreach(Player, i)
	{
		if(!IsPlayerCivilian(i))
		{
			new string[145];
			va_format(string, sizeof(string), message, va_start<2>);
			return SendClientMessageToAll(colour, string);
		}
	}
	return 0;
}

GametextFormatted(playerid, const message[], time, style, va_args<>)
{
	new gstring[145];
	va_format(gstring, sizeof(gstring), message, va_start<4>);
	return GameTextForPlayer(playerid, gstring,time,style);
}

stock SendFormattedMessageA(colour, const message[], va_args<>)
{
	new string[145];
	va_format(string, sizeof(string), message, va_start<2>);

	foreach(new i : Player)
	{
		if(PlayerInfo[i][Padmin] > 0)
		{	
			return SendClientMessage(i, colour, string);
		}
	}
	return 0;
}

randomEx(minnum = cellmin, maxnum = cellmax) return random(maxnum - minnum + 1) + minnum;