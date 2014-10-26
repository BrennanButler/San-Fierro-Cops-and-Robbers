#include <a_samp>



stock formula(l)
{
	new a = 0;
	for(new Float:x = 1; x < l; x++)
	{
		a += floatround(x+300*floatpower(2, (x/7)), floatround_floor);
	}
	return floatround(a/4, floatround_floor);
}

public OnFilterScriptInit()
{
	for(new i = 1; i < 10; i++)
	{
		printf("%i", formula(i));
	}
}