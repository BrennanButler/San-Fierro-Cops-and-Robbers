//------------------------------------------------
//Animation commands

//dance command
CMD:dance(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    new dance;
    if(!IsNumeric(params)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /dance <1-4>");
    dance = strval(params);
    switch(dance)
    {
		case 1:	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
        case 2: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
		case 3: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
		case 4: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
		default: SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /dance <1-4>");
	}
    return 1;
}


//piss command
CMD:piss(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
   	if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    SetPlayerSpecialAction(playerid, 68);

    return 1;
}

//pee returns piss command
CMD:pee(playerid, params[])
{
	return cmd_piss(playerid, params);
}

//handsup command
CMD:handsup(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);

    return 1;
}

//putdown command
CMD:putdown(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    ApplyAnimation(playerid,"CARRY","putdwn",4.1,0,0,0,0,1000);

    return 1;
}

//liftup command
CMD:liftup(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    ApplyAnimation(playerid,"CARRY","liftup",4.1,0,0,0,0,1000);

    return 1;
}

//reload command
CMD:reload(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    new reload;
    if(!IsNumeric(params)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /reload <1-3>");
    reload = strval(params);
    if(reload == 1) {
		ApplyAnimation(playerid,"COLT45","colt45_reload",4.1,0,0,0,0,1000);
	}
    else if(reload == 2) {
		ApplyAnimation(playerid,"COLT45","sawnoff_reload",4.1,0,0,0,0,1000);
	}
    else if(reload == 3) {
		ApplyAnimation(playerid,"SILENCED","Silence_reload",4.1,0,0,0,0,1000);
	}
    else {
		SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /reload <1-3>"); return 1;
	}

    return 1;
}

//spray command
CMD:spray(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    ApplyAnimation(playerid,"SPRAYCAN","spraycan_fire",4.1,0,0,0,0,1000);

    return 1;
}

//strip command
CMD:strip(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    new reload;
    if(!IsNumeric(params)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /strip <1-3>");
    reload = strval(params);
    if(reload == 1) {
		ApplyAnimation(playerid,"STRIP","strip_A",4.1,0,0,0,0,1000);
	}
    else if(reload == 2) {
		ApplyAnimation(playerid,"STRIP","strip_B",4.1,0,0,0,0,1000);
	}
    else if(reload == 3) {
		ApplyAnimation(playerid,"STRIP","strip_C",4.1,0,0,0,0,1000);
	}
    else {
		SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /strip <1-3>"); return 1;
	}

    return 1;
}

//wank command
CMD:wank(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    ApplyAnimation(playerid,"PAULNMAC","wank_in",4.1,0,0,0,0,1000);

    return 1;
}

//masturbate returns wank command
CMD:masturbate(playerid, params[])
{
	return cmd_wank(playerid, params);
}

//stretch command
CMD:stretch(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    ApplyAnimation(playerid,"PLAYIDLES","stretch",4.1,0,0,0,0,1000);

    return 1;
}

CMD:rules(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "You can check out the full list of rules on our forums. /rules again to display/take away the rules textdraw.");
    ToggleRulesTextDraw(playerid);
    return 1;
}

//watchtime command
CMD:watchtime(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    ApplyAnimation(playerid,"PLAYIDLES","time",4.1,0,0,0,0,1000);

    return 1;
}

//fall command
CMD:fall(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    new fall;
    if(!IsNumeric(params)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /fall <1-4>");
    fall = strval(params);
    if(fall == 1) {
		ApplyAnimation(playerid,"ped","FALL_back",4.1,0,0,0,0,1000);
	}
    else if(fall == 2) {
		ApplyAnimation(playerid,"ped","FALL_front",4.1,0,0,0,0,1000);
	}
    else if(fall == 3) {
		ApplyAnimation(playerid,"ped","FALL_fall",4.1,0,0,0,0,1000);
	}
    else if(fall == 4) {
		ApplyAnimation(playerid,"ped","FALL_collapse",4.1,0,0,0,0,1000);
	}
    else {
		SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} Usage: /fall <1-4>"); return 1;
	}

    return 1;
}

//talkphone command
CMD:talkphone(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
    if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    ApplyAnimation(playerid,"ped","phone_out",4.1,1,1,0,0,1000);
	SendClientMessage(playerid, COLOR_BLUE1, "[NOTICE] :{2CD1AB} Type /stopanim to stop your animation.");
    return 1;
}

//stopanim command
CMD:stopanim(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
   	if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot do animations while cuffed.");
    ClearAnimations(playerid);
    return 1;
}

//animlist
CMD:animlist(playerid, params[])
{
    if(!(PlayerVariables[playerid] & PLAYER_SPAWNED)) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You need to spawn before you use any commands.");
   	if(PlayerVariables[playerid] & PLAYER_CUFFED) return SendClientMessage(playerid, COLOR_RED2, "[ERROR] :{FFFFFF} You cannot view animations while cuffed.");
    SendClientMessage(playerid, COLOR_DBLUE, "----> Animations");
	SendClientMessage(playerid, COLOR_BLUE1, "/dance, /piss, /handsup, /putdown, /liftup, /reload, /spray");
	SendClientMessage(playerid, COLOR_BLUE1, "/strip, /wank, /stretch, /watchtime, /fall, /talkphone");
	SendClientMessage(playerid, COLOR_DBLUE, "/stopanim to cancel animations.");
    return 1;
}