point_offx = 0;
point_offy = 0;

var _r = 0;
while((passthrough_ground || collision_point(x+point_offx, y+point_offy, obj_ground, true, true) == noone) && _r < max_radius) {
	point_offx += 8*dcos(image_angle);
	point_offy -= 8*dsin(image_angle);
	_r++;
}

var _deathify = collision_line(x, y, x+point_offx, y+point_offy, obj_player, true, true);
if (_deathify != noone) {
	if (_deathify.playerId != playerId) {
		if (global.sounds) { audio_play_sound(sfx_laser_zap, 5, false, random_range(0.8, 1.2), 0, random_range(0.8, 1.2)); }
		instance_destroy(_deathify);
	}
}

image_angle += rspd/sec;
Time++;

var _hit_mirror = collision_point(x+point_offx, y+point_offy, obj_ground_mirror, true, true);
var _hit_breakable = collision_point(x+point_offx, y+point_offy, obj_breakable, true, true);

if (_hit_mirror == noone) {
	if (!irandom_range(0, 3)) {
		var _percent = random_range(0, 0.3);
		var _p_x = (_percent*x)+((1-_percent)*(x+point_offx));
		var _p_y = (_percent*y)+((1-_percent)*(y+point_offy));
		var _particle = instance_create_depth(_p_x, _p_y, depth, obj_laserhit_particle);
		_particle.direction = direction+180;
		_particle.myColor = myColors[1];
	}
	
	if (_hit_breakable != noone) {
		_hit_breakable.HP -= 0.2;
		_hit_breakable.heat++;
	}
	
} else {
	var _p_x = x+point_offx-8*dcos(image_angle);
	var _p_y = y+point_offy+8*dsin(image_angle);
	var _reflected_laser = instance_create_depth(_p_x, _p_y, depth+1, obj_laser);
	_reflected_laser.main_source = false;
	_reflected_laser.passthrough_ground = passthrough_ground;
	_reflected_laser.playerId = playerId;
	_reflected_laser.myColors = myColors;
	_reflected_laser.Time = Time+1;
	_reflected_laser.rspd = 0;
	_reflected_laser.image_angle = (_hit_mirror.image_angle+90) - ((image_angle+180) - (_hit_mirror.image_angle+90));
}