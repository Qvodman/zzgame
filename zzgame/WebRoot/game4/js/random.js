"use strict"
var g_MinSpeed = 0.2 ;
var g_MaxSpeed = 0.5 ;
//速度[g_MinSpeed,g_MaxSpeed]
var randomSpeed1 = function()
{
	var ran = Math.random();
	
	ran = ran*(g_MaxSpeed - g_MinSpeed) + g_MinSpeed ;
	if(ran > g_MaxSpeed)ran = g_MaxSpeed;
	if(ran < g_MinSpeed)ran = g_MinSpeed;
	return ran ;
}

//速度[g_MinSpeed,g_MaxSpeed],[-g_MaxSpeed,-g_MinSpeed]
var randomSpeed2 = function()
{
	var ran = Math.random();
	ran = ran*2 - 1;
	ran = ran*(g_MaxSpeed - g_MinSpeed) + g_MinSpeed ;
	if(ran >= 0)
	{
		if(ran > g_MaxSpeed)ran = g_MaxSpeed;
		if(ran < g_MinSpeed)ran = g_MinSpeed;
	}
	else{
		if(ran < -g_MaxSpeed)ran = -g_MaxSpeed;
		if(ran > -g_MinSpeed)ran = -g_MinSpeed;
	}
	return ran;
}