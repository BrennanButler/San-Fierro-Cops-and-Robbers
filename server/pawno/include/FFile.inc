#if defined FFile_included
	#endinput
#endif	
#define File_included

#if !defined _samp_included
	#include <a_samp>
#endif

#define MAX_FILE_DESTINATION		(100)
#define MAX_FILES_OPEN				(1000)
#define MAX_INI_ENTRY				(500)

#pragma library FFile

enum FFile:(<<=1)
{
	FILE_IS_OPEN =1,
	CHICKEN
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

stock NewFileID() {

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


	new File:temp = fopen(dest, io_append);		

	if(temp) {
		FileInfo[id][FileHandle] = temp;
		FileInfo[id][FID] = id;
		FFileInfo[id] |= FILE_IS_OPEN;
		return temp;
	}
	else return File:0;
}

stock INI_Int(File:filehandle, key[], value) {

	if(!filehandle) {
		printf("File is not open!");
		return 0;
	}

	if(strlen(key) < 1) {
		printf("Key must be more or equal to 1 character.");
		return 0;
	}


	new int[MAX_INI_ENTRY];
	format(int, MAX_INI_ENTRY, "%s = %d\r\n", key, value);
	fwrite(filehandle, int);

	return 1;
}

stock INI_Float(File:filehandle, key[], Float:value) {

	if(!filehandle) {
		printf("File is not open!");
		return 0;
	}

	if(strlen(key) < 1) {
		printf("Key must be more or equal to 1 character.");
		return 0;
	}


	new float[MAX_INI_ENTRY];
	format(float, MAX_INI_ENTRY, "%s = %f\r\n", key, value);
	fwrite(filehandle, gloat);

	return 1;
}

stock GetFileID(File:filehandle) {
	for(new i = 0; i < MAX_FILES_OPEN; i++) {
		if(filehandle == FileInfo[i][FileHandle])
			return FileInfo[i][FID];
	}
	return -1;
}

stock INI_Close(File:filehandle) {

	if(!filehandle) {
		printf("The file needs to be open in order to close it.");
		return 0;
	}

	for(new i = 0; i < MAX_FILES_OPEN; i++) {

		if(filehandle == FileInfo[i][FileHandle]) {
			FFileInfo[i] &= ~FILE_IS_OPEN;
			return 1;
		}
	}
	return 0;
}