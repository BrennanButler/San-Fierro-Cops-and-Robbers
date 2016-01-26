#include <YSI\y_hooks>


// Random server messages

new randomMessages[][] =
{
	"Use /admins for an online list of adminstrators",
	"Need help from the admins? Use /ask [text] and your text will be sent to any online admins!",
	"Follow all the /rules, ALWAYS. There are no Exceptions.",
	"Seen a cheater? /report them and write a report on our forum http://sf-cnr.co.uk/forum",
	"Provoking is against the rules; if someone provokes you, report them to the administrators.",
	"you can Become a Regular Player After Playing 5 Hours in the Server.",
	"Visit our forum http://sf-cnr.co.uk/forum you can chat to ingame mates and even make clans!",
	"Racism will not be tolerated! If you see someone being racist, report them asap",
	"Want to be in the army? In the S.W.A.T Join our forum and see if you have the chance!",
	"Type /commands for a list of ingame commands",
	"Never ask for admin position, doing so lowers your chances of actually being one",
	"Never abuse a script or san andreas bug! doing so can get you banned for a short time",
	"Want to keep us alive? Want new features such as teamspeak servers? Join our forum and donate!",
	"As we are in beta versions, use /bug to report a bug",
	"Want to fight like a kung fu master? Visit your local gym and change your fighting style!",
	"Is a police officer cuff abusing or abusing /rp? then /report him",
	"When you report someone a admin can view it offline and we keep it forever, even if there are no admins online",
	"Want some cool ingame stuff? Such as fireworks and neon for your car? Donate a short amount of money and you can have them!",
	"Getting raped to often? Visit a local 24/7 to pick up a anti rape device!",
	"Never advertise in the server, this includes website AND servers. If we catch you, you can be banned",
	"Never cheat, doing so will get you banned"
};

new lastMessageUpdate = 0;
static messageIndex = 0;

/**
 * Sends a random server message every 3 minutes
 */
SendRandomServerMessage()
{
	// Send a server message every 3 minutes
	if((gettime() - lastMessageUpdate) >= 180)
	{
		SendClientMessageToAll(COLOR_COOLBLUE, randomMessages[messageIndex]);
		lastMessageUpdate = gettime();
		messageIndex++;

		// Reset counter
		if(messageIndex > 20)
		{
			messageIndex = 0;
		}
	}
	return 1;
}

hook OnGameModeInit()
{

	//Settings up browser view (name, url etc)
	//meaning you won't have to dibber dabber in the cfg to set everything up

	SendRconCommand("hostname San Fierro Cops and Robbers [0.8.2.13]");
	SendRconCommand("weburl www.sf-cnr.co.uk");
	SetGameModeText("Cops and Robbers");

	UsePlayerPedAnims();

	SetWeather(10);

	EnableStuntBonusForAll(0);

	AllowInteriorWeapons(true);

	Debug(DEBUG_CALLBACK, "OnGameModeInit()");

	return 1;
}

task ServerMessages[1000]()
{
	// if( PlayerCount() > 0 )
	SendRandomServerMessage();
}
