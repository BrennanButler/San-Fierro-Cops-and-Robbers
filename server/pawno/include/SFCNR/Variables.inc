
new cow;//variables.
new cow2;
new bool:IsACow[60];
new gCowLastMove[60];//last move in seconds
new Gconnection; //The connection to MySQL
new total_vehicles; //Loading of the maps vehicles
new gTeam[MAX_PLAYERS]; //The players teamID
new bool:VehicleLocked[MAX_VEHICLES];//if the vehicle is locked
new G_String[128]; //Global string
new PlayerText:Casual[MAX_PLAYERS];//For the class selection
new PlayerText:Zone[MAX_PLAYERS];//For the zone you are in
new PlayerText:JobTextdraw[MAX_PLAYERS];//the job textdraw
new PlayerText:Spedo[MAX_PLAYERS][3];//the spedo textdraw
new Rand; // global random variable
new Injections[MAX_PLAYERS]; // injections on a player
new Text:timetext;//Textdraw for the clock
new Minute = 00;//minutes for the clock
new Hour = 12;//hours for the clock
new AFK[MAX_PLAYERS];//is the player afk
new timestring[6];// string for the textdraw
new MaxPassAttempts[MAX_PLAYERS]; //speaks for itself
new lastveh[MAX_PLAYERS]; // Last vehicle entered
new WantedLevel[MAX_PLAYERS]; //the players wanted level
new g_PlayerFires[MAX_PLAYERS];//the amount of fires the player has put out
new Hit[MAX_PLAYERS]; //A players hit
new HitPrice[MAX_PLAYERS]; // A players hit price
new Laser[MAX_PLAYERS]; // A players laser
new pChat_Color[MAX_PLAYERS];//A players chat colour
new LastPM[MAX_PLAYERS];//The last pm you recieved
new Warns[MAX_PLAYERS]; //Warnings of a player
new JobWage[24];//the job wage for each job
new G_TAX;//Gloal tax
new timing[1];//used for timing callbacks etc
new Cocaine[MAX_PLAYERS]; //A players cocain
new Heroin[MAX_PLAYERS];//A players heroin
new Weed[MAX_PLAYERS];//A players weed
new WeedSeeds[MAX_PLAYERS];//Weed seeds
new Sweeped[MAX_PLAYERS];//total rubbish sweeped up
new TLaser[MAX_PLAYERS]; //temp laser
new bool:HasSpod[MAX_PLAYERS];//have an spod?
new Bar:ItemBatch[MAX_PLAYERS];//progress of loading/unloading the stuff
new bool:Krose[MAX_PLAYERS];//Have an krose cd?
new bool:Kdst[MAX_PLAYERS];//Have a kdst cd?
new bool:Rap[MAX_PLAYERS];//Have a rap cd?
new SweeperCash[MAX_PLAYERS];//the total cash earned
new LastCuffAttempt[MAX_PLAYERS];//the last time the player attempted to break cuffs
new bool:Rock[MAX_PLAYERS];//Have a rock cd?
new checkpoints[500]; //Checkpoint id's
new MessageIndex = 0;
new Text3D:HotelRooms[MAX_PLAYERS][8];//hotel room labels
new pickups[500]; //pickups ids
new bool:InCriminalBase[MAX_PLAYERS];//is the player in the crim base?
new CurrentJobID[MAX_PLAYERS];//their current job id
new JobStatus[MAX_PLAYERS];//the job status 1 = getting items 2 = delivering
new CTime[MAX_PLAYERS];//chat time!
new ArmyGate;//The actaul army gate
new Time[MAX_PLAYERS];//time spam
new JobTime[MAX_PLAYERS][25];//when they started the job
new BannedP[MAX_PLAYERS];//banned player
new bool:SweepCreated[MAX_SWEEPS];
new CheckingBan[MAX_PLAYERS];//checking the ban status
new TimeOnline[MAX_PLAYERS]; //time online the server
new Minutes[MAX_PLAYERS];//mins online
new House[MAX_PLAYERS];//the house the player is in
new TimeSinceSweep[MAX_PLAYERS]; //the time since their last sweeper job
new TimeMessages = 0;//the time since the last server message
new TotalSweeps;
new bool:HCreated[MAX_HOUSES];//if the house is created
new HouseStanding[MAX_PLAYERS]; //house the player is standing on.
new ResprayWanted[MAX_PLAYERS];//if they have used the pay 'n spray to decreas their wanted level
new JobIcon[MAX_PLAYERS];//the job mapicon
//new Text:Logo, Text:Logo2;//logo textdraws
new Text:URL;//url textdraw
new Text:DialogBoxes[2];//the main boxes (header and main) for the new dialog
new Text:DialogButtons[3];//the dialog buttons
new PlayerText:DialogTitle[MAX_PLAYERS];//the dialog title
new PlayerText:DialogContent[MAX_PLAYERS][4];//the dialog content
new PlayerText:DialogButtonText[MAX_PLAYERS][3];//the button text
new Text:JobSelection[18];//the job textdraw
new PlayerFoodSale[MAX_PLAYERS];//Checkpoint id for the food sale
new PlayerText:JobSelectionTextdraw[7];//the job textdraws for player
new bool:VehCreated[MAX_VEHICLES];//if the player vehicle is created
new bool:SellingFood[MAX_PLAYERS];//if the player is selling food
new JobCheckpoint[MAX_PLAYERS];//the job checkpoint id
new RobTime[MAX_PLAYERS];//recently been robbed
new ToyStock[MAX_PLAYERS];//the players stock on toys
new RapeTime[MAX_PLAYERS];//recently been raped
new PlayerText:PrisonTextdraw[MAX_PLAYERS];//Prison textdraw
new Hitter[MAX_PLAYERS];//Who hit this player? (hitman)
new bool:StunGun[MAX_PLAYERS];//If the player has a stun gun
new bool:Cuffs[MAX_PLAYERS];//if the player has cuffs
new bool:Spod[MAX_PLAYERS];//if the player has the spod
new bool:Wallet[MAX_PLAYERS];//if the player has a wallet
new bool:AntiRape[MAX_PLAYERS];//if the player has an anti rape device
new WepStock[MAX_PLAYERS];//how much weapon stock the player has
new ItemStock[MAX_PLAYERS];//Item stock
new RequestedDriver[MAX_PLAYERS];//trhe private driver
new RequestedDriverCoolDown[MAX_PLAYERS];//the cooldown
new StoreTimeRobbed[MAX_STORES];//when the shop was last robbed.
new RequestItemCooldown[MAX_PLAYERS];//items cool down
new bool:RBCreated[MAX_ROADBLOCKS]; // if the roadblock is created
new SweeperWeight[MAX_PLAYERS];//the weight they picked up
new RequestWepCooldown[MAX_PLAYERS];//wep cool down
new ArmyGangzone[6];//The gangzones
new SwatGangzone;//the swat gangzone
new bool:CreatedVehicle[MAX_VEHICLES];//the vehicle is created by command
new AFKSec[MAX_PLAYERS];//how long afk
new RoadSpikes[MAX_PLAYERS];//how many road spikes laid down
new bool:SpikeCreated[MAX_SPIKES];//spike created?
new ArmyGangZoneTimer[MAX_PLAYERS];//for the timer of army gangzone
new PizzaRequestTime[MAX_PLAYERS];//the time when the player requested pizza (gettime())
new StatGangzone;//the stat gangzone
new PlayerRobberyID[MAX_PLAYERS];//the robbery interior id
new PlayerText:RobberyText[MAX_PLAYERS];//The robbery textdraw
new RobberyTime[MAX_PLAYERS] =15;//the robbery time left
new StoreRobbing[MAX_PLAYERS];//what store is the player robbing
new bool:StoreRobbed[MAX_STORES];//is the store robbed?
new WeedPlanted[MAX_PLAYERS];//how many has the player planted
new building[4];//the mech
new Aindex[MAX_PLAYERS];
new ItemBarValue[MAX_PLAYERS];
//new bool:BCreated[MAX_BUSINESSES];//if the business is created
new bool:Ignore[MAX_PLAYERS][MAX_PLAYERS];//if the player is irnogring him
new WireID[MAX_PLAYERS];//the player this player is wiring money to
new Bomb[MAX_PLAYERS];//the id of the bomb object
new PlayerText:VehicleBuy[MAX_PLAYERS][3]; //the vehicle buy textdraw
new Text:VehButtons[2];
new stairs[3];//prison stairs
new FoodPrice[MAX_PLAYERS];//the price of the food
new RoadBlocks[MAX_PLAYERS]; // keep track of how many roadblocks are placed per user
new TaxiDriver[MAX_PLAYERS];//the taxi driver id
new VBulletArmourTime[MAX_PLAYERS];//how long the players have left of vehicle armour
new BulletArmourTime[MAX_PLAYERS];//how long the players have left of armour
#if defined __DEBUG
new debug_String[128];//debug string
#endif
new bool:Clamped[MAX_VEHICLES]; // is this vehicle clamped
new bool:VehicleDestroy[MAX_VEHICLES];//to destroy the vehicle slowly
new PlayerStolenVeh[MAX_PLAYERS][MAX_VEHICLES];//if they've stolen the vehicle.
new PVehicle[MAX_PLAYERS];//the vehicle the player selected
new FoodSelling[MAX_PLAYERS];//what type of food is the player selling
new City[MAX_PLAYERS];//what city the player is in
new Text:RulesTextDraw[14];//the rules textdraw
new BotID[MAX_BOTS];//irc bot
new BGroupID;//the bot group id
new bool:SeenWeedMessage[MAX_PLAYERS];//has the player seen the message?
new bool:CNodeTaken[MAX_COW_NODES];
new bool:CenterCreated[MAX_CENTERID] = false;
new g_Inventorytype[MAX_PLAYERS];
new doors[4];//prison doors
new bool:FireCreated[MAX_FIRES] = false;
new Menu:clothingtype;
new Menu:Hats;
new Menu:Misc;
new Cones[82]; //cones for driving test
new VehicleSprayColor[MAX_PLAYERS] =1;
new fence0, fence1, fence2,//prison fences->
	fence3, fence4, fence5,
    fence6, fence7, fence8,
    fence9, fence10, fence11,
    fence12, fence13, fence14,
    fence15, fence16, fence17,
    fence18, fence19, fence20,
    fence21, fence22, fence23,
    fence24, fence25, fence26,
    fence27, fence28, fence29,
    fence30, fence31, fence32,
    fence33, fence34, fence35;//<-prison fences