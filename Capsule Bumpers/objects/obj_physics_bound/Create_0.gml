event_inherited();

gravity = 1;

function myStep() {
	gravity = 1;
	if (place_meeting(x+hspeed, y, obj_ground)) { hspeed *= 0; }
	if (place_meeting(x, y+vspeed, obj_ground)) { vspeed = 0; gravity = 0; }
}

