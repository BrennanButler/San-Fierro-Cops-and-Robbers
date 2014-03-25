/*

	Fat_File.inc by thefatshizms
	
	
	info about the functions here;


*/

#if defined _fat_file_included
	#endinput
#endif

#define _fat_file_included

//------------------------------Defines & Variables-----------------------------//

//Misc defines

#define             MAX_FILE_ENTRY              (32)
#define             INI                        	File
#define             MAX_KEY                     (MAX_FILE_ENTRY)
#define             MAX_STRING_KEY              (MAX_FILE_ENTRY*5)
#define             MAX_OPEN_FILES              (20)

#if defined MAX_STRING
	#define     MAX_FILE_STRING             MAX_STRING
#else
	#define     MAX_FILE_STRING             (250)
#endif

//------------------------------Functions---------------------------------------//

stock File:INI_Opens(file[], Open_type=0) {

	new File:INI_FILE;
	
	if(Open_type == 0 && !fexist(file)) {
		print("Oops! that file seems to not exist.");
		return INI_FILE;
	} else if(Open_type == 0) {
	    INI_FILE = fopen(file, io_read);
	} else if(Open_type == 1) {
	    INI_FILE = fopen(file, io_write);
	} else if(Open_type == 2) {
        INI_FILE = fopen(file, io_readwrite);
	} else if(Open_type == 3) {
 	   INI_FILE = fopen(file, io_append);
	} else {
	    printf("ERROR: Attempted to open file \"%s\" with an unkown mode!");
	}
	

	return INI_FILE;
}

stock INI_Close(File:ID) {

	if(!ID) printf("This file isn't open.");
	fclose(ID);
	
	return 1;
}

stock INI_GetInt(INI:filehandle, Key[], &dest)
{

    if(!filehandle)
    {
        printf("Failed to open file!");
        return 0;
    }

    new
        line[128],
        len = strlen(Key);

    while( fread(filehandle, line) )
    {
        if(!strcmp(line, Key, true, len))
        {
            len = len + strlen(Key)-2;
            printf("line[len] = %s", line[len]);
            if(line[len] == '=') {
            	len = len + strlen(Key)-3;
            	printf("line[len] = %s", line[len]);
                return dest = (len < sizeof(line)) ? strval(line[len]) : 0;
            }
            
            return dest = (len < sizeof(line)) ? strval(line[len]) : 0;
            
            
        }
    }
    return -1;
}

stock INI_GetString(INI:filehandle, string[MAX_STRING_KEY], dest[], size) {

	if(!filehandle) return printf("Failed to open file!");
	
	new pos, line[MAX_FILE_STRING];
	
	while( fread(filehandle, line) ) {
	
	    if( (pos = strfind(line, string)) != -1 ) {
	    
			new idx = pos + strlen(string)+1;
			
			if(line[idx] == '=') {
			
			    if(idx > sizeof(line)) return -1;
				idx = pos + strlen(string)+3;//plus 3 because with this method it can leave a blank space before the string.
	 			format(dest, size, line[idx]);
	 			return 1;
			}
            if(idx > sizeof(line)) return -1;
			format(dest, size, line[idx]);
			return 1;
	    }
	
	}
	return 0;
}

stock INI_GetBool(INI:filehandle, Key[], &dest)
{
    if(!filehandle) return printf("Failed to open file!");

	new pos, line[MAX_FILE_STRING];

	while( fread(filehandle, line) ) {

    	if( (pos = strfind(line, Key)) != -1 ) {
    	
    		new idx = pos + strlen(Key)+1;

			if(line[idx] == '=') {
			
   				idx = pos + strlen(Key)+3;
   				
   				if(idx > sizeof(line)) return -1;
   				
	 			if(!strcmp(line[idx], "true")) {
            		return dest = true;
            	} else if(!strcmp(line[idx], "false")) {
            	    return dest = false;
            	}
			}
			
            if(idx > sizeof(line)) return -1;
            
            if(!strcmp(line[idx], "true")) {
            	return dest = true;
            } else if(!strcmp(line[idx], "false")) {
       	    	return dest = false;
           	}
			
	    }

	}
	return -1;
}


