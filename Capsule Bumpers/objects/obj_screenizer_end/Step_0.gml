var coll = collision_rectangle(x, -2*room_height, x+64, 3*room_height, obj_player, false, false);
if (coll != noone && instance_exists(coll)) {
	if (instance_exists(obj_screenizer_start)) {
		if (death_enabled) { instance_destroy(coll); }
		else if (warp_enabled) { coll.x = obj_screenizer_start.x+64; }
	}
}

var ball_coll = collision_rectangle(x, -2*room_height, x+64, 3*room_height, obj_botball, false, false);
if (ball_coll != noone) {
	if (instance_exists(obj_screenizer_start)) {
		if (death_enabled) { instance_destroy(ball_coll); }
		else if (warp_enabled) { ball_coll.x = obj_screenizer_start.x+64; }
	}
}

if (sudden_death && !irandom_range(0, 15)) {
	var mostLeft = -(room_width)+64;
	var mostRight = +(room_width)-64;
	if (instance_exists(obj_screenizer_start)) {mostLeft = obj_screenizer_start.x}
	if (instance_exists(obj_screenizer_end)) {mostRight = obj_screenizer_end.x}
	var decidedX = random_range(mostLeft, mostRight);
	var decidedY = -room_height;
	instance_create_depth(decidedX, decidedY, depth, obj_meteor);
}

move();