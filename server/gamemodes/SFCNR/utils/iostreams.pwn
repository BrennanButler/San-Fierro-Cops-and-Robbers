#define SendFormattedMessageP MsgP 
#define SendFormattedMessageA MsgA 
#define SendFormattedMessageAP MsgAP

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

/*ConvertIntoArray()
{
	new File:toConvert = fopen("sfcnr/vehicles.txt", io_read);
	new File:Converted = fopen("sfcnr/vehiclearray.txt", io_write);
	new string[100];
	new pos;
	if(toConvert)
	{
		printf("opened file");
		while(fread(toConvert, string))
		{
			printf("reading");
			strdel(string, 0, 19);
			strins(string, "{", 0);
			if( (pos = strfind(string, ";")) != -1)
			{
				strdel(string, pos-1, pos);
				strins(string, "},", pos);
			}
			strins(string, "float:", 5);
			if( (pos = strfind(string, ",", true, 6)) != -1)
			{
				strins(string, "float:", pos+1);
			}
			if( ( pos = strfind(string, ",", true, pos+1)) != -1)
			{
				strins(string, "float:", pos+1);
			}
			if( ( pos = strfind(string, ",", true, pos+1)) != -1)
			{
				strins(string, "float:", pos+1);
			}
			fwrite(Converted, string);
			printf(string);
		}
	}
	fclose(toConvert);
	fclose(Converted);
}*/