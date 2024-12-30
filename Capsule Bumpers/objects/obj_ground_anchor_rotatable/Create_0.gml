event_inherited();

playerId = -1;//color of laser + immunity

has_laser = true;
laser = noone;
laser_passthrough_ground = false;
rspd = 0;//2; test
r_f = 0.92;

myStep = function() {
	rspd *= r_f;
	if (abs(rspd) >= 0.001) { image_angle += rspd; }
	if (has_laser) {
		if (laser == noone) { laser = instance_create_depth(x, y, depth, obj_laser); }
		laser.passthrough_ground = laser_passthrough_ground;
		laser.playerId = playerId;
		laser.image_angle = image_angle+270;
		laser.x = x + image_yscale*sprite_get_width(sprite_index)*dcos(laser.image_angle)*0.54;
		laser.y = y - image_yscale*sprite_get_height(sprite_index)*dsin(laser.image_angle)*0.54;
	}
}