/*
This Include is made by Frede(Frederik Svend Vester). By using this you agree with following
	*Keep my credits
	*Of cause you most edit this and the PHP code if you just Keep my Credits
	*If you want to rerelease it then you most keep my credits. And ask me first
This was the agreements, however if you create a new design in this please do it public. This is not requiet, however, most people like to have some design, so why not make others happy.
					///////////////////////////////////////////////////////
	  				//    ********  ******    *******   *****     ****** //
	  				//    *         *     *   *         *    *    *      //
	  				//    *         *     *   *         *     *   *      //
	  				//    *****     ******    ****      *     *   ****   //
	  				//    *         *     *   *         *     *   *      //
	  				//    *         *     *   *         *    *    *      //
	  				//    *         *     *   *******   *****     ****** //
					///////////////////////////////////////////////////////

--------------------------------------------------------------------------------
						[CREDITS]
					Me(Frede) - Creating the include
			Slice - Giving me the idea. And i have used some of the functions from slice's include
*/

#if(!defined ServerLink)
	#error Please define the serverlink - IP:PORT

#endif

#if(!defined forumlink)
	#error Please define the forumlink - without HTTP://

#endif

#if(!defined ServerLogoLink)
    #error Please define the serverLogolink

#endif

#if(!defined ServerName)
	#error Please define the ServerName

#endif

#if(!defined PHPLink)
	#error Please define the PHPLink (If you did then you possible did it before you included the include. So please define it before you include)

#endif

#if(!defined MAX_MAIL_Length)
	#define MAX_MAIL_Length 1024

#endif

#if(!defined MAX_MAIL_TYPES)
	#define MAX_MAIL_TYPES 2

#endif
//forward mailback(playerid);

forward OnNiceMailResponse(playerid, response_code, data[]);
public OnNiceMailResponse(playerid, response_code, data[])
{
	print(data);
	if(response_code != 200)
	{	
		print("***A ERROR OCCURED WHEN SOMEBODY TRIED TO RUN NICEMAIL***");
		printf("ERROR: response was=%d - BAD PHPLINK", response_code);
		SendClientMessage(playerid, 0xFFFFFF, "***A ERROR OCCURED WHEN SOMEBODY TRIED TO RUN NICEMAIL***");
		SendClientMessage(playerid, 0xFFFFFF, "***Check server_log.txt to see the error***");
		return -1;
	}
	else return 1;
}
#define GREAT_MAIL 0
#define SIMPLE_MAIL 1
#define EASY_MAIL 2

#include <a_samp>
#include <a_http>

stock nicemail(type, reciveremail[], recivername[], senderemail[], sendername[], subject[], message[], playerid = -1)
{
	if(type > MAX_MAIL_TYPES || type < 0)
	{
		print("***A ERROR OCCURED WHEN SOMEBODY TRIED TO RUN NICEMAIL***");
		printf("ERROR: type=%d - Your type most be between 0-2", type);
		SendClientMessage(playerid, 0xFFFFFF, "***A ERROR OCCURED WHEN SOMEBODY TRIED TO RUN NICEMAIL***");
		SendClientMessage(playerid, 0xFFFFFF, "***Check server_log.txt to see the error***");
		return -1;
	}
	//mailback(playerid);
	new mail[MAX_MAIL_Length+250];
	format(mail, sizeof(mail), "t=%i&r=%s&rn=%s&se=%s&sn=%s&sb=%s&m=%s&lo=%s&sen=%s&link=%s&fl=%s",type, reciveremail, recivername, senderemail, sendername, subject, message, ServerLogoLink, ServerName, ServerLink, forumlink);
	HTTP(playerid, HTTP_POST, PHPLink, mail, "OnNiceMailResponse");
	print(mail);
	printf("[Mail Send]------------------\nTo=%s - %s\nFrom=%s -%s\nSubject= %s\ntype=%d\n----------------------------", reciveremail, recivername, senderemail, sendername, subject, type);
	return 1;
}