SetVehicleEngineState(vid, setstate)
{
     new engine,lights,alarm,door,bonnet,boot,objective;
     GetVehicleParamsEx(vid,engine,lights,alarm,door,bonnet,boot,objective);
	 if(setstate) SetVehicleParamsEx(vid,VEHICLE_PARAMS_ON,lights,alarm,door,bonnet,boot,objective);
	 else SetVehicleParamsEx(vid,VEHICLE_PARAMS_OFF,lights,alarm,door,bonnet,boot,objective);
}