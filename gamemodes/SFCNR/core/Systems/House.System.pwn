#include <YSI\y_hooks>
static const HOUSE_OWNED = 19522;
static const HOUSE_UNOWNED = 1273;
static const HOUSE_FORRENT = 19524;
const MAX_HOUSES = 100;

enum HOUSE_E
{
	owner[24],
	interiorName[100],
	housePass[250],
	Text3D:doorText,
	salePrice,
	rentPrice,
	Float:xPos,
	Float:yPos,
	Float:zPos,
	Float:interiorX,
	Float:interiorY,
	Float:interiorZ,
	interiorID,
	pickupID
}

new houseInfo[MAX_HOUSES][HOUSE_E];

enum INTERIORS_E
{
	interiorName[100],
	interiorID,
	Float:x,
	Float:y,
	Float:z
}

new gInteriors [][INTERIORS_E] =
{
	// Name Interior ID Interior X Interior Y Interior Z
    {"Ammunation 1", 1, 286.148986,-40.644397,1001.515625},
    {"Ammunation 2", 4, 286.800994,-82.547599,1001.515625},
    {"Ammunation 3", 6, 296.919982,-108.071998,1001.515625},
    {"Ammunation 4", 7, 314.820983,-141.431991,999.601562},
    {"Ammunation 5", 6, 316.524993,-167.706985,999.593750},
    {"Ammunation booths", 7, 302.292877,-143.139099,1004.062500},
    {"Ammunation range", 7, 298.507934,-141.647048,1004.054748},
    {"Budget inn motel room", 12, 444.646911,508.239044,1001.419494},
    {"Sex shop", 3, -103.559165,-24.225606,1000.718750},
    {"Zeros RC shop", 6, -2240.468505,137.060440,1035.414062},
    {"Bar", 11, 501.980987,-69.150199,998.757812},
    {"Lil probe inn", 18, -227.027999,1401.229980,27.765625},
    {"Denise room", 1, 244.411987,305.032989,999.148437},
    {"Katie room", 2, 271.884979,306.631988,999.148437},
    {"Helena room", 3, 291.282989,310.031982,999.148437},
    {"Michelle room", 4, 302.180999,300.722991,999.148437},
    {"Barbara room", 5, 322.197998,302.497985,999.148437},
    {"Millie room", 6, 346.870025,309.259033,999.155700},
    {"Cjs house", 3, 2496.049804,-1695.238159,1014.742187},
    {"Madd Doggs mansion", 5, 1267.663208,-781.323242,1091.906250},
    {"Crack factory", 2, 2543.462646,-1308.379882,1026.728393},
    {"Strip club", 3, 1212.019897,-28.663099,1000.953125},
    {"Tiger skin brothel", 3, 964.106994,-53.205497,1001.124572},
    {"Pleasure domes", 3, -2640.762939,1406.682006,906.460937},
    {"Liberty city inside", 1, -794.806396,497.738037,1376.195312},
    {"Gang house", 5, 2350.339843,-1181.649902,1027.976562},
    {"Colonel Furhbergers", 8, 2807.619873,-1171.899902,1025.570312},
    {"Crack den", 5, 318.564971,1118.209960,1083.882812},
    {"Unused safe house", 12, 2324.419921,-1145.568359,1050.710083}
};

GetHouseID()
{
	for(new i = 0; i <= MAX_HOUSES; i++)
	{
		if(!IsValidDynamicPickup(houseInfo[i][pickupID]))
			return i;
	}
	return -1;
}

GetInteriorName(intname[])
{
    for(new i = 0;i < 47;i++)
    {
        if(strfind(gInteriors[i][interiorName], intname, true) != -1)
        {
            return gInteriors[i][interiorName];
        }
    }
    return 0;
}

GetInteriorNameRow(intname[])
{
    for(new i = 0;i < 47;i++)
    {
        if(strfind(gInteriors[i][interiorName], intname, true) != -1)
        {
            return i;
        }
    }
    return -1;
}

HouseCreate(_owner[24], _interiorName[100], Float:_xPos, Float:_yPos, Float:_zPos)
{
	new houseID = GetHouseID(); // Get a new house ID
	new interiorRow = GetInteriorNameRow(_interiorName); // Get the array index num
	new tdoorText[101];
	Debug(DEBUG_CALLBACK, "houseID %d interiorRow %d", houseID, interiorRow);
	if(houseID != -1) // There is a space left for this house to be created
	{
		// Fill out the enum with the required information
		houseInfo[houseID][xPos] = _xPos;
		houseInfo[houseID][yPos] = _yPos;
		houseInfo[houseID][zPos] = _zPos;
		houseInfo[houseID][owner] = _owner;
		houseInfo[houseID][interiorName] = GetInteriorName(_interiorName);
		houseInfo[houseID][interiorID] = gInteriors[interiorRow][interiorID];
		houseInfo[houseID][interiorX] = gInteriors[interiorRow][x];
		houseInfo[houseID][interiorY] = gInteriors[interiorRow][y];
		houseInfo[houseID][interiorZ] = gInteriors[interiorRow][z];
		Debug(DEBUG_CALLBACK, "intID %d x %f y %f z %f", gInteriors[interiorRow][interiorID], gInteriors[interiorRow][x], gInteriors[interiorRow][y], gInteriors[interiorRow][z]);
		houseInfo[houseID][pickupID] = CreateDynamicPickup(19522, 1, _xPos, _yPos, _zPos);
		format(tdoorText, 101, "Owner:{FF0000} %s\n{FFFFFF}For rent:{FF0000} No\n{FFFFFF}For sale: {FF0000}No", houseInfo[houseID][owner]);
		houseInfo[houseID][doorText] = CreateDynamic3DTextLabel(tdoorText, -1, _xPos, _yPos, _zPos, 100);
	}

	// Will return the ID of the new house or -1 if it failed.
	return houseID;
}

public house_OnPlayerPickUpPickup(playerid, pickupid)
{
	for(new i = 0; i < 29; i++)
	{
		if(houseInfo[i][pickupID] == pickupid)
		{
			Debug(DEBUG_CALLBACK, "Picked up a house pickup");

		}
	}
	return 1;
}

CMD:createhouse(playerid, params[])
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	HouseCreate("thefatshizms", "Crack factory", pos[0], pos[1], pos[2]);
	return 1;
}
