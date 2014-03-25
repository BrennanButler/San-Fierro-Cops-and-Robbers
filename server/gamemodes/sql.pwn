	

    //First, of course we need to include these files first
    #include <a_samp> //Without this, we won't be able to use all samp functions/callbacks
    #include <a_mysql> //Without this, we won't be able to use all mysql functions
    #include <zcmd>
     
    #define         host                    "109.169.18.***"
    #define         user                    "avttdmpi_usersu"
    #define         pass                    "askmeifyouneedthepassword"
    #define         db                              "avttdmpi_users"
    //Global variables. We will use them later
    static
        mysql, //This variable will be used to manage our database
        NameSQL[MAX_PLAYERS][24], //We will use this variable to store player's name.
        IP[MAX_PLAYERS][16] //We will use this variable to store player's ip.
        ;
     
    native WP_Hash(buffer[], len, const str[]); //whirlpool, for hashing our password
     
     
    //Now let's create an enumerator that holds player's information
    enum PDATA //We name our enumerator as PDATA (which stands for PlayerDATA). You can name it however you want.
    {
        ID, //Will be used later to store player's ID from database so we can use it anywhere later
        pPass[129], //We will load player's password into this varible from database
        pAdmin, //We will load player's admin level from database into this variable so we can use it anywhere later.
        pVip, //We will load player's VIP level from database into this variable so we can use it anywhere later.
    //We will load player's money from database into this variable so we can use it anywhere later.
        pReg, // done
        pLog, // done
        pCash, //done
        pKills, // done
        pDeaths, // done
            pScore, // done
            pWarns, // done
            pIp[32],
            pMuted, // done
            pFreeze, // done
            pBan, // done
            pAirforce,
            pXp,
            pHitman,
            pAlpha,
            pLVSF,
            pHydrakill,
            pAXP,
            pCXP,
            pSXP,
            pEXP,
            pPXP,
            pBXP,
            pAlphaKill,
            pHitmanKill,
            pPlaytime
     
    }
    new pInfo[MAX_PLAYERS][PDATA]; //Variable that stores enumerator above
     
     
    public OnGameModeInit()
    {
        mysql_debug(1); //Let's enable debugging so we can detect a problem(if there is)
        mysql = mysql_connect(host, user, db, pass); //This function will connect your server to database. Remember we have defined our host, username, database and password. It's time to use it here.
        if(mysql_errno(mysql) != 0) print("Could not connect to database!"); //This will tell if your connection to database is successful or not. If it's not, check your host, username, database and password. Make sure they all right.
            new bigquery[4000];
            strcat(bigquery,"CREATE TABLE IF NOT EXISTS `players`(`ID` int(10) NOT NULL AUTO_INCREMENT, `Username` varchar(24) NOT NULL, `Password` varchar(129) NOT NULL, `IP` varchar(16) NOT NULL, `Admin` int(10) NOT NULL, `VIP` int(10) NOT NULL, `Money` int(10) NOT NULL,`Deaths` int(10) NOT NULL, `Kills` int(10) NOT NULL, `Score` int(10) NOT NULL, `Freeze` int(10) NOT NULL, `Warns` int(10) NOT NULL, `Muted` int(10) NOT NULL, `Reg` int(10) NOT NULL, `Log` int(10) NOT NULL, `Ban` int(10) NOT NULL,");
        strcat(bigquery,"`AirForce` int(10) NOT NULL,`Alpha` int(10) NOT NULL,`Hitman` int(10) NOT NULL, `AXP` int(10) NOT NULL, `CXP` int(10) NOT NULL, `SXP` int(10) NOT NULL, `EXP` int(10) NOT NULL, `PXP` int(10) NOT NULL, `BXP` int(10) NOT NULL, `AlphaKill` int(10) NOT NULL, `HitmanKill` int(10) NOT NULL, `Playtime` int(10) NOT NULL, `XP` int(10) NOT NULL,  PRIMARY KEY (`ID`))");
            //If we're cool, it's time to create a table for your database.
        mysql_tquery(mysql, bigquery, "", "");
        /*We will use mysql_tquery to execute a query
         We are creating a table called `players`.
        `ID` int(10) NOT NULL AUTO_INCREMENT, = We are creating a column inside of the table called ID and it must be int since ID is an integer. NOT NULL means the column must not be blank(e.g not inserting value into it). AUTO_INCREMENT, it automatically generates a new ID everytime player registers(1,2,3,4 ... and so on)
        `Username` varchar(24) NOT NULL, = We are creating a column inside of the table called Username. It will be used for storing player's name in it and since player's name is a string, we must use varchar
        `Password` varchar(129) NOT NULL, = Same as above
        `IP` varchar(16) NOT NULL, = Same as above
        `Admin` int(10) NOT NULL, = Same as above
        `VIP` int(10) NOT NULL, = Same as above
        `Money` int(10) NOT NULL, = Same as above
        `posX` float NOT NULL, = posX is player's X position. So it must be float
        `posY` float NOT NULL, = Same as above
        `posZ` float NOT NULL, = Same as above
        "", ""); = We leave this 2 parameters(callback[] and format[]) empty because we only gonna need it if we use SELECT
    */
        return 1;
    }
     
    //Checking player's account if they are registered or not.
    public OnPlayerConnect(playerid)
    {
        new query[128]; //We use this variable to format our query
        GetPlayerName(playerid, NameSQL[playerid], 24); //Getting player's name
        GetPlayerIp(playerid, IP[playerid], 16); //Getting layer's IP
        mysql_format(mysql, query, sizeof(query),"SELECT * FROM `players` WHERE `Username` = '%e' LIMIT 1", NameSQL[playerid]);
        // - We use mysql_format instead of format because we can use an %e specifier. %e specifier escapes a string so we can avoid sql injection which means we don't have to use mysql_real_escape_string
        // - Formatting our query; SELECT * FROM `players` WHERE `Username`='%e' means we are selecting all rows in the table called `players` that has your name in Username column
        // - LIMIT 1; we only need 1 result to be shown
        mysql_tquery(mysql, query, "OnAccountCheck", "i", playerid);
        //lets execute the formatted query and when the execution is done, a callback OnAccountCheck will be called
        //You can name the callback however you like
     
        return 1;
    }
     
    //OnAccountCheck is a custom callback which means it has to be forwarded.
    forward OnAccountCheck(playerid);
     
    //Now once the query has been processed;
    public OnAccountCheck(playerid)
    {
        new rows, fields; //a variable that will be used to retrieve rows and fields in the database.
        cache_get_data(rows, fields, mysql);//let's get the rows and fields from the database.
        if(rows) //if there is row
        {//then
            cache_get_row(0, 2, pInfo[playerid][pPass], mysql, 129);
            //we will load their password into pInfo[playerid][Password] to be used in logging in
            //0 is row, 2 is field. If you're wondering why row is 0; remember we used LIMIT 1 while checking player's account. LIMIT is a limitation of results to be shown. Since we used LIMIT 1, it'd be like;
            // ---> row>  ID | Username | Password | IP | Admin | .... and so on
            //             ^       ^           ^
            //      fields 0       1           2
            //So we're getting row 0, field 2 which is password
     
            pInfo[playerid][ID] = cache_get_row_int(0, 0); //now let's load player's ID into pInfo[playerid][ID] so we can use it later
            printf("%s", pInfo[playerid][pPass]); //OPTIONAL: Just for debugging. If it didn't show your password, then there must be something wrong while getting player's password
            ShowPlayerDialog(playerid, 1, DIALOG_STYLE_INPUT, "Login", "In order to play, you need to login", "Login", "Quit"); //And since we found a result from the database, which means, there is an account; we will show a login dialog
        }
        else //if we didn't find any rows from the database, that means, no accounts were found
        {
            ShowPlayerDialog(playerid, 2, DIALOG_STYLE_INPUT, "Register", "In order to play, you need to register.", "Register", "Quit");
            //So we show the a dialog register
        }
        return 1;
    }
     
    //Now let's response to the login and register dialog
    public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
    {
        new query[1024];
        switch(dialogid)
        {
            case 1: //login dialog
            {
                if(!response) Kick(playerid); //if they clicked Quit, we will kick them
                new hpass[129]; //for password hashing
                WP_Hash(hpass, 129, inputtext); //hashing inputtext
                if(!strcmp(hpass, pInfo[playerid][pPass])) //remember we have loaded player's password into this variable, pInfo[playerid][Password] earlier. Now let's use it to compare the hashed password with password that we load
                { //if the hashed password matches with the loaded password from database
                    mysql_format(mysql, query, sizeof(query), "SELECT * FROM `players` WHERE `Username` = '%e' LIMIT 1", NameSQL[playerid]);
                    //let's format our query
                    //once again, we select all rows in the table that has your name and limit the result
                    mysql_tquery(mysql, query, "OnAccountLoad", "i", playerid);
                    //lets execute the formatted query and when the execution is done, a callback OnAccountLoad will be called
                    //You can name the callback however you like
                }
                else //if the hashed password didn't match with the loaded password(pInfo[playerid][Password])
                {
                    //we tell them that they have inserted a wrong password
                    ShowPlayerDialog(playerid, 1, DIALOG_STYLE_INPUT, "Login", "In order to play, you need to login\nWrong password!", "Login", "Quit");
                }
            }
            case 2: //register dialog
            {
                if(!response) return Kick(playerid); //if they clicked Quit, we will kick them
                if(strlen(inputtext) < 6) return ShowPlayerDialog(playerid, 2, DIALOG_STYLE_INPUT, "Register", "In order to play, you need to register.\nYour password must be at least 6 characters long!", "Register", "Quit");
                //strlen checks a lenght of a string. so if player types their password that is lower than 6, we tell them; Your password must be at least 6 characters long!
                WP_Hash(pInfo[playerid][pPass], 129, inputtext); //hashing inputtext
                mysql_format(mysql, query, sizeof(query), "INSERT INTO `players` (`Username`, `Password`, `IP`, `Admin`, `VIP`, `Money`,`Deaths`,`Kills`,`Score`,`Freeze`,`Warns`,`Muted`,`Reg`,`Log`,`Ban`,`AirForce`,`Alpha`,`Hitman`,`AXP`,`CXP`,`SXP`,`EXP`,`PXP`,`BXP`,`AlphaKill`,`HitmanKill`,`Playtime`,`XP`) VALUES ('%e', '%s', '%s', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)", NameSQL[playerid], pInfo[playerid][pPass], IP[playerid]);
                //Now let's create a new row and insert player's information in it
                mysql_tquery(mysql, query, "", "");
                //let's execute the query
            }
        }
        return 1;
    }
    forward OnAccountLoad(playerid);
    //let's load player's information
    public OnAccountLoad(playerid)
    {
        // ---> row>  ID | Username | Password | IP | Admin | VIP | Money | posX | posY | posZ
        //             ^       ^           ^      ^     ^       ^     ^       ^     ^       ^
        //      fields 0       1           2      3     4       5     6       7     8       9
     
        pInfo[playerid][pAdmin] = cache_get_row_int(0, 4); //we're getting a field 4 from row 0. And since it's an integer, we use cache_get_row_int
        pInfo[playerid][pVip] = cache_get_row_int(0, 5); //Above
        pInfo[playerid][pCash] = cache_get_row_int(0, 6);//Above
        pInfo[playerid][pDeaths] = cache_get_row_int(0, 7);//Above
        pInfo[playerid][pKills] = cache_get_row_int(0, 8);//Above
        pInfo[playerid][pScore] = cache_get_row_int(0, 9);//Above
        pInfo[playerid][pFreeze] = cache_get_row_int(0, 10); //Above
        pInfo[playerid][pWarns] = cache_get_row_int(0, 11);//Above
        pInfo[playerid][pMuted] = cache_get_row_int(0, 12);//Above
        pInfo[playerid][pReg] = cache_get_row_int(0, 13);//Above
        pInfo[playerid][pLog] = cache_get_row_int(0, 14);//Above
        pInfo[playerid][pBan] = cache_get_row_int(0, 15);//Above
        pInfo[playerid][pAirforce] = cache_get_row_int(0, 16);//Above
        pInfo[playerid][pAlpha] = cache_get_row_int(0, 17);//Above
        pInfo[playerid][pHitman] = cache_get_row_int(0, 18);//Above
        pInfo[playerid][pAXP] = cache_get_row_int(0, 19);//Above
        pInfo[playerid][pCXP] = cache_get_row_int(0, 20);//Above
        pInfo[playerid][pSXP] = cache_get_row_int(0, 21);//Above
        pInfo[playerid][pEXP] = cache_get_row_int(0, 22);//Above
        pInfo[playerid][pPXP] = cache_get_row_int(0, 23);//Above
        pInfo[playerid][pBXP] = cache_get_row_int(0, 24);//Above
        pInfo[playerid][pAlphaKill] = cache_get_row_int(0, 25);//Above
        pInfo[playerid][pHitmanKill] = cache_get_row_int(0, 26);//Above
        pInfo[playerid][pPlaytime] = cache_get_row_int(0, 27);//Above
        pInfo[playerid][pXp] = cache_get_row_int(0, 28);//Above
     
            GivePlayerMoney(playerid, pInfo[playerid][pCash]);//Let's set their money
        //For player's position, set it once they spawn(OnPlayerSpawn)
        SendClientMessage(playerid, -1, "Successful logged in"); //tell them that they have succesfully logged in
        return 1;
    }
     
    public OnPlayerDisconnect(playerid, reason)
    {
        new query[2048];
        new query2[1024];
        strcat(query2,"UPDATE `players` SET `Admin`=%d, `VIP`=%d, `Money`=%d, `Deaths`=%d, `Kills`=%d, `Score`=%d, `Freeze`=%d, `Warns`=%d, `Muted`=%d, `Reg`=%d,`Log`=%d,`Ban`=%d,`AirForce`=%d,`Alpha`=%d,`Hitman`=%d,`AXP`=%d,`CXP`=%d,`SXP`=%d,`EXP`=%d,`PXP`=%d,`BXP`=%d,`AlphaKill`=%d,`HitmanKill`=%d,`Playtime`=%d,`XP`=%d  WHERE `ID`=%d");
            mysql_format(mysql, query, sizeof(query),query2,pInfo[playerid][pAdmin], pInfo[playerid][pVip], pInfo[playerid][pCash] , pInfo[playerid][pDeaths] , pInfo[playerid][pKills] , pInfo[playerid][pScore], pInfo[playerid][pFreeze], pInfo[playerid][pWarns], pInfo[playerid][pMuted], pInfo[playerid][pReg], pInfo[playerid][pLog], pInfo[playerid][pBan], pInfo[playerid][pAirforce], pInfo[playerid][pAlpha], pInfo[playerid][pHitman], pInfo[playerid][pAXP],
            pInfo[playerid][pCXP], pInfo[playerid][pSXP], pInfo[playerid][pEXP], pInfo[playerid][pPXP],pInfo[playerid][pBXP],pInfo[playerid][pAlphaKill],pInfo[playerid][pHitmanKill],pInfo[playerid][pPlaytime],pInfo[playerid][pXp], pInfo[playerid][ID]);
        mysql_tquery(mysql, query, "", "");
        return 1;
    }
     
    main()
    {
     
    }
    CMD:statson(playerid,params[])
    {
                    pInfo[playerid][pAdmin] = 8;
            pInfo[playerid][pVip] = 3;
            pInfo[playerid][pCash] = 1000;
            pInfo[playerid][pDeaths] = 50;
            pInfo[playerid][pKills] = 100;
            pInfo[playerid][pScore] = 10000;
            pInfo[playerid][pMuted] = 50;
            pInfo[playerid][pWarns] = 100;
            pInfo[playerid][pFreeze] = 10000;
            pInfo[playerid][pBan] = 1;
            pInfo[playerid][pReg] = 1;
            pInfo[playerid][pLog] = 1;
            pInfo[playerid][pAXP] = 100;
            pInfo[playerid][pBXP] = 10000;
            pInfo[playerid][pSXP] = 1;
            pInfo[playerid][pCXP] = 1;
            pInfo[playerid][pEXP] = 1;
            pInfo[playerid][pAirforce] = 1;
            pInfo[playerid][pHitman] = 1;
            pInfo[playerid][pAlpha] = 1;
            return 1;
    }
    CMD:ss(playerid,params[])
    {
            new query[2048];
        new query2[1024];
        strcat(query2,"UPDATE `players` SET `Admin`=%d, `VIP`=%d, `Money`=%d, `Deaths`=%d, `Kills`=%d, `Score`=%d, `Freeze`=%d, `Warns`=%d, `Muted`=%d, `Reg`=%d,`Log`=%d,`Ban`=%d,`AirForce`=%d,`Alpha`=%d,`Hitman`=%d,`AXP`=%d,`CXP`=%d,`SXP`=%d,`EXP`=%d,`PXP`=%d,`BXP`=%d,`AlphaKill`=%d,`HitmanKill`=%d,`Playtime`=%d,`XP`=%d  WHERE `ID`=%d");
            mysql_format(mysql, query, sizeof(query),query2,pInfo[playerid][pAdmin], pInfo[playerid][pVip], pInfo[playerid][pCash] , pInfo[playerid][pDeaths] , pInfo[playerid][pKills] , pInfo[playerid][pScore], pInfo[playerid][pFreeze], pInfo[playerid][pWarns], pInfo[playerid][pMuted], pInfo[playerid][pReg], pInfo[playerid][pLog], pInfo[playerid][pBan], pInfo[playerid][pAirforce], pInfo[playerid][pAlpha], pInfo[playerid][pHitman], pInfo[playerid][pAXP],
            pInfo[playerid][pCXP], pInfo[playerid][pSXP], pInfo[playerid][pEXP], pInfo[playerid][pPXP],pInfo[playerid][pBXP],pInfo[playerid][pAlphaKill],pInfo[playerid][pHitmanKill],pInfo[playerid][pPlaytime],pInfo[playerid][pXp], pInfo[playerid][ID]);
        mysql_tquery(mysql, query, "", "");
        return 1;
    }

