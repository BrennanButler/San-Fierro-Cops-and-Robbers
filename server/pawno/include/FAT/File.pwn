/*

	File system
	
	Used to write, read files
	
*/


//defines

#define                 MAX_FILE_READ           (500)

stock ReadFile(File:filehandle) {

	if(!filehandle) return printf("ERROR : File is not open!");
	
	new line[MAX_FILE_READ];
	
	while(fread(filehand, line)) {
	
	    return line;
	}
	
	return 0;

}
