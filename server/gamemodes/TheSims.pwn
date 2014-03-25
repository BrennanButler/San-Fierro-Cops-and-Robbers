/*

	TheSims™ is a registered trademark of Electronic Arts, Inc.
	© Electronic Arts, Inc 2013

	Programmed by Brennan `thefatshizms` Butler.

	Features:


	Changelog:

*/

//includes
#include <a_samp>

//defines

//misc
#define 			SERVER_VERSION 					("0.1 ALPHA")

main() 
{
	printf("TheSims Has been loaded.");
	printf("\n\nThis Gamemode was created for sa-mp servers by Brennan `thefatshizms` Butler.");
	printf("Current gamemode version :  %s\n", SERVER_VERSION);
}

public OnGameModeInit()
{
	SetGameModeText("TheSims");
	SendRconCommand("mapname San Andreas");
	SendRconCommand("hostname TheSims");
	SendRconCommand("weburl www.sa-mp.com");
	AddPlayerClass(1, 0.0, 0.0, 0.0, 0.0, 31, 500, 10, 100, 17, 500);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}