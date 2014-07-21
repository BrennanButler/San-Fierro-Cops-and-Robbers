
IsPlayerInRangeOfPlayer(playerid, id, range)
{
	new
		Float:pos[3];
	GetPlayerPos(id, pos[0], pos[1], pos[2]);

	return IsPlayerInRangeOfPoint(playerid, range, pos[0], pos[1], pos[2]);
}

IsPointInRangeOfPoint(Float:xp, Float:yp, Float:zp, Float:x2, Float:y2, Float:z2, Float:range)
{
    x2 -= xp;
    y2 -= yp;
    z2 -= zp;
    return ((x2 * x2) + (y2 * y2) + (z2 * z2)) < (range * range);
}