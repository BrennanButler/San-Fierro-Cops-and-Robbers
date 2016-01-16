/*
	This include was made by thefatshizms and none other than him
	Please do not remove my credits
*/


#if defined biz_included
#endinput
#endif
#define biz_included

#tryinclude <streamer>

//general defines

#define		MAX_BIZ				(500)
#define     MAX_BIZPERPLAYER    (20)

//dialogs


/*
native CreateBiz(owner[] = '', Float:X, Float:Y, Float:Z, level, interior, income, incometime = 12:00)
native SetBizUpForSale(bizid, price)
native SetBizInterior(bizid, interior)
native SetBizLevel(bizid, level)
native SetBizOwner(bizid, owner[])
native DestroyBiz(bizid)
native LoadBizes()
*/


/* Enum */

enum BData
{
	pickupid,
	Float:Enter_X,
	Float:Enter_Y,
	Float:Enter_Z,
	Text3D:DoorText,
	BizName[100],
	bool:Owned,
	Owner[24],
	price
}

new BizData[MAX_BIZ][BData];

enum BizInt
{
	InterioName[50],
	InteriorID,
	Float:IntX,
	Float:IntY,
	Float:IntZ,
	BizLevel,
	Income
}

new InteriorInfo[][BizInt] =
{
	{"24/7 1", 17, -25.884498,-185.868988,1003.546875, 1, 500},
	{"24/7 2", 10, 6.091179,-29.271898,1003.549438, 1, 500},
	{""}
	
	
