#include <YSI\y_hooks>

new
	checkpoints[30];

hook OnGameModeInit()
{
	checkpoints[0] = CreateDynamicCP(-2110.3142,-445.6071,38.7344, 2, -1, -1, -1, 100.0); // leisure center
	checkpoints[1] = CreateDynamicCP(-1615.9908,686.2200,7.1875, 2, -1, -1, -1, 100.0); // cop gun point
	checkpoints[2] = CreateDynamicCP(-1676.2111,432.1548,7.1797, 2, -1, -1, -1, 100.0); //  24/7
 	checkpoints[3] = CreateDynamicCP(-2588.1697,59.9089,4.3422, 2, -1, -1, -1, 100.0); // hippy shopper 1
	checkpoints[4] = CreateDynamicCP(-2442.5732,754.9309,35.1719, 2, -1, -1, -1, 100.0); // super save
	//checkpoints[5] = CreateDynamicCP(-26.0607,-187.2907,1003.5469, 2, -1, 17, -1, 100.0); // shop exit
	checkpoints[6] = CreateDynamicCP(-2511.1479,-49.9410,25.6833, 2, -1, -1, -1, 100.0);//hippy shopper 2
	checkpoints[7] = CreateDynamicCP(-1955.1440,255.8476,41.0471, 3, -1, -1, -1, 100.0);//car buy checkpoint
	checkpoints[8] = CreateDynamicCP(-2766.1589,375.5858,6.3347, 2, -1, -1, -1, 100.0);//mayor building
	checkpoints[9] = CreateDynamicCP(-2053.5571,454.2387,35.1719, 3, -1, -1, -1, 100.0);//bank entrance
	checkpoints[10] = CreateDynamicCP(2305.3916,-16.0711,26.7496, 2, -1, -1, -1, 50.0);//bank exit
	checkpoints[11] = CreateDynamicCP(2316.4424,-7.5928,26.7422, 2, -1, -1, -1, 50.0);//bank menu
	checkpoints[12] = CreateDynamicCP(501.1848,-78.2146,998.7578, 2, 0, -1, -1, 100.0);//Bar rob
	checkpoints[13] = CreateDynamicCP(378.7888,-64.8880,1001.5078, 2, 0, -1, -1, 100.0);//Burger rob
	checkpoints[14] = CreateDynamicCP(-201.2298,-5.2262,1002.2734, 2, 0, -1, -1, 100.0);//Tat rob
	checkpoints[15] = CreateDynamicCP(203.5807,-40.4363,1001.8047, 2, 0, -1, -1, 100.0);//Suburban rob
	checkpoints[16] = CreateDynamicCP(502.8620,-23.7864,1000.6797, 2, 0, -1, -1, 100.0);//rob club
	checkpoints[17] = CreateDynamicCP(418.5417,-75.1641,1001.8047, 2, 0, -1, -1, 100.0);//Barber rob
	checkpoints[18] = CreateDynamicCP(371.8004,-4.3236,1001.8589, 2, 0, -1, -1, 100.0);//Clucking bell rob
	checkpoints[19] = CreateDynamicCP(207.6289,-98.3428,1005.2578, 2, 0, -1, -1, 100.0);//Binco rob
	checkpoints[20] = CreateDynamicCP(161.3155,-80.2635,1001.8047, 2, 0, -1, -1, 100.0);//Zip rob
	checkpoints[21] = CreateDynamicCP(379.1379,-116.3564,1001.4922, 2, 0, -1, -1, 100.0);//Pizza rob
	checkpoints[22] = CreateDynamicCP(204.8533,-8.0930,1001.2109, 2, 0, -1, -1, 100.0);//Victim rob
	checkpoints[23] = CreateDynamicCP(204.1348,-157.5937,1000.5234, 2, 0, -1, -1, 100.0);//Didier rob
	checkpoints[24] = CreateDynamicCP(207.0713,-127.3425,1003.5078, 2, 0, -1, -1, 100.0);//Pro laps rob
	checkpoints[25] = CreateDynamicCP(414.3527,-10.8976,1001.8120, 2, 0, -1, -1, 100.0);//Barber2 rob
	checkpoints[26] = CreateDynamicCP(-2655.0178,639.8524,14.4545, 2, -1, -1, -1, 100.0);//hospital cp
	checkpoints[27] = CreateDynamicCP(-2081.7068,71.6446,35.2503, 2, -1, -1, -1, 100.0);//crim base cp
	checkpoints[28] = CreateDynamicCP(-1754.1857,964.1262,24.8906, 3, -1, -1, -1, 100.0);//hotel cp
	return 1;
}

hook OnPlayerPickUpPickup(playerid, pickupid)
{
	SendClientMessage(playerid, -1, "Picked up a pickup.");
	return 1;
}