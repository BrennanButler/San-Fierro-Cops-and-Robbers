#include <a_samp>
#include <SFCNR/files>

main() {}

public OnGameModeInit()
{
	new string[100];

	for(new i = 0; i < 5000; ++i)
	{
		new time = GetTickCount();
		new File:chicken = FileOpen("chicken.ini");
		F_String(chicken, "Chicken2", "is guud");
		F_GetString(chicken, "boobs", string, 100);
		printf(string);
		F_GetString(chicken, "beans", string, 100);
		printf(string);
		F_GetString(chicken, "chicken", string, 100);
		printf(string);
		F_GetString(chicken, "Chicken2", string, 100);
		F_Close(chicken);
		printf("took %ims to complete", GetTickCount() - time);
	}

	return 1;
}