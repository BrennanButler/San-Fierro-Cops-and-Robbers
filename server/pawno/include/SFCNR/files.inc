#if defined file_included
	#endinput
#endif

#define file_included

#if !defined _samp_included
	#include <a_samp>
#endif

#pragma library files

//------------------------------Defines & Variables-----------------------------//

//Misc defines

#define 			MAX_FILE_DESTINATION		(100)
#define 			MAX_FILES_OPEN				(1000)
#define 			MAX_FILE_ENTRY				(500)
#define             MAX_KEY                     (MAX_FILE_ENTRY)
#define             MAX_STRING_KEY              (MAX_FILE_ENTRY*5)
#define             MAX_OPEN_FILES              (20)

#if defined MAX_STRING
	#define     MAX_FILE_STRING             MAX_STRING
#else
	#define     MAX_FILE_STRING             (250)
#endif


enum FFile:(<<=1)
{
	FILE_IS_OPEN =1
}
new FFile:FFileInfo[MAX_FILES_OPEN];

enum Files
{
	File:FileHandle,
	FID
}
new FileInfo[MAX_FILES_OPEN][Files];


/*
native FileOpen(dest[]);
*/


//------------------------------Functions---------------------------------------//

stock NewFileID() 
{
	for(new i = 0; i < MAX_FILES_OPEN; i++) {
		if(!(FFileInfo[i] & FILE_IS_OPEN)) return i;
	}
	return -1;
}

stock File:FileOpen(dest[]) {

	new id = NewFileID();
	if(id == -1) {
		printf("Max files are open. Chane MAX_FILES_OPEN from \"%d\" to the number you disire.", MAX_FILES_OPEN);
		return File:0;
	}

	if(strlen(dest) < 2) {
		printf("ERROR : Invalid destination. Please input a valid string.");
		return File:0;
	}


	new File:tempfile = fopen(dest, io_append);		

	if(tempfile) {
		FileInfo[id][FileHandle] = tempfile;
		FileInfo[id][FID] = id;
		FFileInfo[id] |= FILE_IS_OPEN;
		return File:tempfile;
	}
	else return File:0;
}

stock GetFileID(File:filehandle) {
	for(new i = 0; i < MAX_FILES_OPEN; i++) {
		if(filehandle == FileInfo[i][FileHandle])
			return FileInfo[i][FID];
	}
	return -1;
}

stock F_Close(File:filehandle) {

	if(!filehandle) {
		printf("The file needs to be open in order to close it.");
		return 0;
	}

	for(new i = 0; i < MAX_FILES_OPEN; i++) {

		if(filehandle == FileInfo[i][FileHandle]) {
			FFileInfo[i] &= ~FILE_IS_OPEN;
			fclose(filehandle);
			return 1;
		}
	}
	return 0;
}

stock F_GetInt(File:filehandle, Key[], &dest)
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
            //printf("line[len] = %s", line[len]);
            if(line[len] == '=') {
            	len = len + strlen(Key)-3;
            	//printf("line[len] = %s", line[len]);
                return dest = (len < sizeof(line)) ? strval(line[len]) : 0;
            }
            
            return dest = (len < sizeof(line)) ? strval(line[len]) : 0;
            
            
        }
    }
    return -1;
}

stock F_GetString(File:filehandle, string[MAX_STRING_KEY], dest[], size) {

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

stock F_GetBool(File:filehandle, Key[], &dest)
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

stock F_Int(File:filehandle, key[], value) {

	if(!filehandle) {
		printf("File is not open!");
		return 0;
	}

	if(strlen(key) < 1) {
		printf("Key must be more or equal to 1 character.");
		return 0;
	}


	new int[MAX_FILE_ENTRY];
	format(int, MAX_FILE_ENTRY, "%s = %d\r\n", key, value);
	fwrite(filehandle, int);

	return 1;
}

stock F_Float(File:filehandle, key[], Float:value) {

	if(!filehandle) {
		printf("File is not open!");
		return 0;
	}

	if(strlen(key) < 1) {
		printf("Key must be more or equal to 1 character.");
		return 0;
	}


	new float[MAX_FILE_ENTRY];
	format(float, MAX_FILE_ENTRY, "%s = %f\r\n", key, value);
	fwrite(filehandle, float);

	return 1;
}

stock F_Bool(File:filehandle, key[], bool:value) {

	if(!filehandle) {
		printf("File is not open!");
		return 0;
	}

	if(strlen(key) < 1) {
		printf("Key must be more or equal to 1 character.");
		return 0;
	}


	new bool[MAX_FILE_ENTRY];
	format(bool, MAX_FILE_ENTRY, "%s = %d\r\n", key, value);
	fwrite(filehandle, bool);

	return 1;
}

stock F_String(File:filehandle, key[], value[]) {

	if(!filehandle) {
		printf("File is not open!");
		return 0;
	}

	if(strlen(key) < 1) {
		printf("Key must be more or equal to 1 character.");
		return 0;
	}


	new string[MAX_FILE_ENTRY];
	format(string, MAX_FILE_ENTRY, "%s = %s\r\n", key, value);
	fwrite(filehandle, string);

	return 1;
}
