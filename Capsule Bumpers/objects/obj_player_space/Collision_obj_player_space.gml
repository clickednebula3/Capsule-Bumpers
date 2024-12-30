instance_create_depth(x, bbox_top+16, depth, obj_particle_bump);
if (abs(hspeed) > 25) {
	instance_create_depth(x, bbox_top+16, depth, obj_particle_bump);
	instance_create_depth(x, bbox_top+16, depth, obj_particle_bump);
	instance_create_depth(x, bbox_top+16, depth, obj_particle_bump);
}
var multiplier = 2;
if (other.hasPowerBump) {
	multiplier = 8;
	y -=16;
	speed = -25;
	instance_create_depth(x, bbox_top+16, depth, obj_particle_bump);
	instance_create_depth(x, bbox_top+16, depth, obj_particle_bump);
	instance_create_depth(x, bbox_top+16, depth, obj_particle_bump);
	instance_create_depth(x, bbox_top+16, depth, obj_particle_bump);
	instance_create_depth(x, bbox_top+16, depth, obj_particle_bump);
	instance_create_depth(x, bbox_top+16, depth, obj_particle_bump);
	other.hasPowerBump = false;
}

var mySize = (image_xscale+image_yscale)/2;
var otherSize = (other.image_xscale+other.image_yscale)/2;

direction = point_direction(other.x, other.y, x, y);

if (x > other.x) {
	speed = (otherSize*multiplier*point_distance(other.x, other.y, x, y))/(2+(4*mySize));
	if (global.sounds) { audio_play_sound(sfx_sword_slang, 5, false, random_range(0.5, 0.5), 0, random_range(0.5, 1.5)); }
} else {
	speed = (otherSize*multiplier*point_distance(other.x, other.y, x, y))/(2+(4*mySize));
}