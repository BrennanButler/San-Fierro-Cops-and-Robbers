Debug(DEBUG_TYPE, fstring[], {Float, _}:...)
{
	#define BYTES_PER_CELL 4
	// See what type the debug is and if we should output it at all
	new debugLine[400];
	switch(DEBUG_TYPE)
	{
		case DEBUG_CALLBACK:
		{
			debugLine = "[callback] ";
		}
		case DEBUG_CALLBACK_FREQUENT:
		{
			debugLine = "[callback] ";
		}
		case DEBUG_CALLBACK_QUERY:
		{
			debugLine = "[query] ";
		}
		case DEBUG_TIMER:
		{
			debugLine = "[timer] ";
		}
		case DEBUG_HTTP:
		{
			debugLine = "[http] ";
		}
		case DEBUG_QUERY:
		{
			debugLine = "[query] ";
		}
		case DEBUG_VECTOR:
		{
			debugLine = "[vector] ";
		}
		case DEBUG_VAR:
		{
			debugLine = "[variable] ";
		}
		default: debugLine[0] = EOS;
	}

    // This is the number of parameters which are not variable that are passed
    // to this function (i.e. the number of named parameters).
    static const
        STATIC_ARGS = 2;
    // Get the number of variable arguments.
    new
        n = (numargs() - STATIC_ARGS) * BYTES_PER_CELL;
    if (n)
    {
        new
            message[350],
            arg_start,
            arg_end;

        // Load the real address of the last static parameter. Do this by
        // loading the address of the last known static parameter and then
        // adding the value of [FRM].
        #emit CONST.alt		fstring
        #emit LCTRL			5
        #emit ADD
        #emit STOR.S.pri	arg_start

        // Load the address of the last variable parameter. Do this by adding
        // the number of variable parameters on the value just loaded.
        #emit LOAD.S.alt	n
        #emit ADD
        #emit STOR.S.pri	arg_end

        // Push the variable arguments. This is done by loading the value of
        // each one in reverse order and pushing them. I'd love to be able to
        // rewrite this to use the values of pri and alt for comparison,
        // instead of having to constantly load and reload two variables.
        do
        {
			#emit LREF.S.pri arg_end
			#emit PUSH.pri
			arg_end -= BYTES_PER_CELL;
        }
        while (arg_end > arg_start);

        // Push the static format parameters.
        #emit PUSH.S	fstring
        #emit PUSH.C	256
        #emit PUSH.ADR	message

        // Now push the number of arguments passed to format, including both
        // static and variable ones and call the function.
        n += BYTES_PER_CELL * 3;
        #emit PUSH.S	n
        #emit SYSREQ.C	format

        // Remove all data, including the return value, from the stack.
        n += BYTES_PER_CELL;
        #emit LCTRL			4
        #emit LOAD.S.alt	n
        #emit ADD
        #emit SCTRL			4

		strcat(debugLine, message);
    }
    else
    {
		strcat(debugLine, fstring);
    }
	print(debugLine);
	return true;
}
