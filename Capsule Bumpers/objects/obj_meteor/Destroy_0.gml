for (var _i=0; _i<20; _i++) {
	var _p = instance_create_depth(x, y, depth, obj_particle_jetpack);
	_p.speed *= -1;
	_p.gravity = 0.3;
}