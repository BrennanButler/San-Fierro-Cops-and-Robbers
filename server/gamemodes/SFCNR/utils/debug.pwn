DEBUG(debuglvl, string[])
{
	if(__DEBUG <= debuglvl)
	{
		printf(string);
		SendClientMessageToAll(-1, string);
	}
}