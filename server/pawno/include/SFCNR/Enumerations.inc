//Enums.

enum PInfo
{
	Ppassword[24],
	Pusername[24],
	Padmin,
	Pmoney,
	Float:Health,
	Float:Armour,
	Pscore,
	Pcop,
	Pvip,
	Pbank,
	Pip[16],
	Parrest,
	BizID,
	Pstat,
	Parmy,
	Pswat,
	Pprison,
	Prob,
	Prape,
	Pheal,
	Phitman,
	Psales,
	Pwep,
	Pdrug,
	Ptaze,
	Ptruck,
	Psurender,
	STD[100],
	PrisonTime,
	bool:Mayor,
	GroupID,
	PTERRORIST,
	Pfix,
	Pkidnapper,
	Ppedo,
	Ptaxi,
	Ppilot,
	Ppizza,
	Pfarmer,
	Pminer,
	Ptaxirate,
	totalvehs,
	LangRoom,
	Pkills,
	Parrests
}

new PlayerInfo[MAX_PLAYERS][PInfo];

enum IconsInfo
{
	iconid,
	Float:x,
	Float:y,
	Float:z,
	type,
	colour
}

enum Banned
{
	BanReason[50],
	UnbanDate[50],
	BanAdmin[24],
	BanIP[24],
	issued[50]
}
new BanInfo[MAX_PLAYERS][Banned];

enum Hinfo
{
    HID,
    Float:Xpos,
    Float:Ypos,
    Float:Zpos,
    Howner[24],
    bool:Howned,
    Interiorname[100],
    Float:IntXpos,
    Float:IntYpos,
    Float:IntZpos,
    interiorid,
    pass[400],
    SqlID,
    Text3D:Doortext,
    Hsaleprice,
    Hrentprice,
    bool:Hrented,
    bool:Hsale

}
new HouseInfo[MAX_HOUSES][Hinfo];

enum BInfo
{
	BID,
 	Float:Xpos,
    Float:Ypos,
    Float:Zpos,
	InteriorName[100],
    Bowner[24],
    Float:IntXpos,
    Float:IntYpos,
    Float:IntZpos,
    interiorid,
    pass[400],
    income,
	items[11],
    employee,
    Itemstock[11],
    Btype,
	Text3D:DoorText
}
new BizInfo[MAX_BUSINESSES][BInfo];

enum InteriorInfo
{
    InteriorName[100],
    InteriorID,
    Float:InteriorX,
    Float:InteriorY,
    Float:InteriorZ,
	UID
}

enum Spike
{
	Spikeid,
	Float:SpikeX,
	Float:SpikeY,
	Float:SpikeZ
}
new SpikeInfo[MAX_SPIKES][Spike];


enum RB
{
	BlockID,
	Float:RBX,
	Float:RBY,
	Float:RBZ
}
new RoadBlock[MAX_ROADBLOCKS][RB];


enum RobberyInfo
{
	Float:Xpos,
	Float:Ypos,
	Float:Zpos,
	RobberyType[100],
	RobberyZone[100],
	RobberyID
}

enum VehicleP
{
	VehicleName[100],
	PurchasePrice
}

enum ShopM
{
	ItemName[100],
	PurchasePrice
}

enum VehI
{
	Owner[24],
	model,
	VehName[100],
	NumberPlate[32],
	Float:X_pos,
	Float:Y_pos,
	Float:Z_pos,
	Float:Rotation,
	value,
	PannelDamage,
	DoorDamage,
	LightDamage,
	TireDamage,
	Float:VehicleHealth,
	VID,
	SQLID,
	Vcolor1,
	Vcolor2,

}

new VehicleInfo[MAX_VEHICLES][VehI];

enum weedI
{
    WeedObject,
    Text3D:WeedLabel,
    bool:WeedWatered,
    Pickup,
	Float:Xpos,
	Float:Ypos,
	Float:Zpos,
	Owner[24],
	bool:Burnt,
	burnttime,
	HHour,
	HMin,
	bool:ForHarvest
}

new WeedInfo[MAX_WEED][weedI];

enum E_FIRES
{
	centerid,
	object,
	Float:pos1,
	Float:pos2, 
	Float:pos3,
	area,
	icon,
	total,
	bool:isout,
	Ftime,
	Ftype // 1 = Vehicle fire 
		 //  2 = Building fire (a big fire)
}

new FireInfo[MAX_FIRES][E_FIRES];

enum PlayerVars:(<<=1)
{
	PLAYER_SPAWNED = 1,
	PLAYER_LOGGED_IN,
	PLAYER_IN_LEISURE,
	PLAYER_FROZEN,
	PLAYER_MUTED,
	PLAYER_RAPED,
	PLAYER_EDITING_HOUSE,
	PLAYER_REQUESTED_TOYS,
	PLAYER_CUFFED,
	PLAYER_IN_JAIL,
	PLAYER_KICKED,
	PLAYER_TAZED,
	PLAYER_REQUESTED_WEAPONS,
	PLAYER_REQUESTED_ITEMS,
	PLAYER_IN_BUSINESS,
	PLAYER_IN_CLASS_SELECTION,
	PLAYER_PM_OFF,
	PLAYER_HAS_BOMB,
	PLAYER_HAS_VEHICLE_ARMOUR,
	PLAYER_HAS_ARMOUR,
	PLAYER_IN_MOVIE_MODE,
	PLAYER_ON_PICKUP,
	PLAYER_READING_RULES,
	PLAYER_FORCED_READ_RULES,
	PLAYER_IS_REGISTERED,
	PLAYER_IN_ARMY,
	PLAYER_IN_SWAT,
	PLAYER_IN_STAT,
	PLAYER_IN_JOB,
	PLAYER_BANNED,
	PLAYER_HAS_PRIVATE_DRIVER,
	PLAYER_REQUESTED_PIZZA,
	IN_HOTEL
}

new PlayerVars:PlayerVariables[MAX_PLAYERS];

enum TruckingJ
{
	JobText[128],
	Float:FromX,
	Float:FromY,
	Float:FromZ,
	Float:ToX,
	Float:ToY,
	Float:ToZ,
	Payment
}

enum PilotJ
{
	JobText[128],
	Float:FromX,
	Float:FromY,
	Float:FromZ,
	Float:ToX,
	Float:ToY,
	Float:ToZ,
	Payment,
}

enum CowNode
{
	NodeID,
	Float:Xpos,
	Float:Ypos,
	Float:Zpos,
	FarmID
}

enum Sweeper 
{
	Float:Weight,
	Float:Xpos,
	Float:Ypos,
	Float:Zpos,
	Obj,
	MapIcon,
	Player
}

new SweeperInfo[MAX_SWEEPS][Sweeper];

enum playerao 
{
	amodel,
	abone,
	Float:ax,
	Float:ay,
	Float:az,
	Float:arx,
	Float:ary,
	Float:arz,
	Float:asx,
	Float:asy,
	Float:asz
}

new ao[MAX_PLAYERS][MAX_PLAYER_ATTACHED_OBJECTS][playerao];
