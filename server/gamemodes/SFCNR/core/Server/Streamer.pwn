#include <YSI\y_hooks>

hook OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == pickups[0])
	{
		SendClientMessage(playerid, -1, "bank");
	}
	return 1;
}