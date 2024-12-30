image_angle += rspd;
if (!irandom_range(0, 4)) {
	var _p = instance_create_depth(x, y, depth, obj_particle_jetpack);
	_p.speed *= -1;
	_p.alarm[0] = 15;
}