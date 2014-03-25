//      Mailing inc
//      By brennan butler

#if defined _mailing_included
	#endinput
#endif
#define _mailing_included

#if ( !defined PHP_LOC )
	#error You need to define the location of send.php
#endif

#define MAX_MESSAGE         (1000)
#define	MAX_TEMPLATE_SIZE	(5000)

#include <a_samp>
#include <a_http>

forward OnNiceMailResponse(playerid, response_code, data[]);

public OnNiceMailResponse(playerid, response_code, data[])
{
	if(response_code != 200) {
	
		new File:Mail=fopen("Mailing_log.txt", io_append), string[50];
		format(string, 50, "Response code: %d\nData: %s", response_code, data);
	    printf("Mailing.inc was unable to send a mail..");
	    printf(string);
	    
	    fwrite(Mail, string);
	    fclose(Mail);
	
	}
	
	return 1;
}

stock SendMail(to[], to_email[], from[], from_email[], subject[], message[],  playerid = -1)
{
	if(strlen(message) > MAX_MESSAGE) {
	    printf("Your message is too long!");
	}
	
	new Mail[MAX_MESSAGE+100];
	format(Mail, MAX_MESSAGE+100, "?to_name=%s&to_email=%s&from_name=%s&from_email=%s&subject=%s&message=%s", to, to_email, from, from_email, subject, message);
	HTTP(playerid, HTTP_POST, PHP_LOC, Mail, "OnMailResponse");
	return 1;
}
