#if defined _zcmd_included
	#endinput
#endif	
#define _zcmd_included

#define FCMD:%1(%2) \ 
	forward cmd_%1(%2);
	public cmd_%1(%2)

forward OnCommandPerformed(playerid, cmdtext[], success);
forward OnCommandRecived(playerid, cmdtext[]);

static bool: HasOCP. HasOCR;

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	HasOCP = funcidx("OnCommandPerformed") != -1;
	HasOCR = funcidx("OnCommandRecived") != -1;
	return CallLocalFunction("Fatcmd_OnFilterScriptInit", "");
}

#if defined _ALS_OnFilterScriptInit
#undef _ALS_OnFilterScriptInit
#else
#define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit Fatcmd_OnFilterScriptInit
forward Fatcmd_OnFilterScriptInit();

#else

public OnGameModeInit()
{
	HasOCP = funcidx("OnCommandPerformed") != -1;
	HasOCR = funcidx("OnCommandRecived") != -1;
	if(funcidx("Fatcmd_OnGameModeInit") != -1)
	return CallLocalFunction("Fatcmd_OnGameModeInit", "");
}

#if defined _ALS_OnGameModeInit
#undef _ALS_OnGameModeInit
#else
#define _ALS_OnGameModeInit
#endif
#define Fatcmd_OnGameModeInit Fatcmd_OnGameModeInit
forward Fatcmd_OnGameModeInit();

#endif

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(HasOCP && !CallLocalFunction("OnCommandRecived", "is", playerid, cmdtext))
	{
		return 1; // do nothing
	}
	new pos, funcname[32];
	while(cmdtext[++pos] > ' ')//while there is content
	{
		funcname[pos-1] = tolower(cmdtext[pos]);//lower everything
	}
	format(funcname, 32, "cmd_%s", funcname);
	while(cmdtext[pos] == ' ') pos++;
	if(!cmdtext[pos])
	{
		if(HasOCP)
		{
			return CallLocalFunction("OnCommandPerformed", "isi", playerid, cmdtext, CallLocalFunction(funcname, "is", playerid, "\1"));
		}
		return CallLocalFunction(funcname, "is", playerid, "\1");
	}
	if(HasOCP)
	{
		return CallLocalFunction("OnCommandPerformed", "isi", playerid, cmdtext[pos], CallLocalFunction(funcname, "is", playerid, cmdtext[pos]);
	}
	return CallLocalFunction(funcname, "is", playerid, cmdtext[pos]);
}
#if defined _ALS_OnPlayerCommandText
    #undef OnPlayerCommandText
#else
    #define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText Fatcmd_OnPlayerCommandText
forward Fatcmd_OnPlayerCommandText(playerid, cmdtext[]);