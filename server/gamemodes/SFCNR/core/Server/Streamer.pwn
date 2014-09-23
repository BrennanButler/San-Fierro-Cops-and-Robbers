#include <YSI\y_hooks>

hook OnPlayerPickUpPickup(playerid, pickupid)
{
	SendClientMessage(playerid, -1, "Picked up a pickup.");
	return 1;
}