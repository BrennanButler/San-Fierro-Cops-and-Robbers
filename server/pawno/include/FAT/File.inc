/*

	File system
	
	Used to write, read files
	
*/


//defines

#define                 MAX_FILE_READ           (500)

stock ReadFile(File:filehandle) {

	if(!filehandle) return -1;
	
	new line[MAX_FILE_READ];
	
	while(fread(filehandle, line)) {
	
	    return line;
	}
	
	return 0;

}
