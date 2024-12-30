var _coll = collision_circle((bbox_right+bbox_left)/2, y, 16, obj_ground, true, false);

if (_coll != noone) {
	vspeed = 0;
	if (_coll.image_angle == 0) {
		y = _coll.bbox_top - 16;
	} else {
		var _coll_YatX;
		if (_coll.image_angle < 0 || _coll.image_angle > 180) {
			_coll_YatX = _coll.bbox_top - dsin(_coll.image_angle)*point_distance(_coll.bbox_left, _coll.bbox_top, x, y) + 8*dsin(_coll.image_angle);
		} else {
			_coll_YatX = _coll.bbox_top + dsin(_coll.image_angle)*point_distance(_coll.bbox_right, _coll.bbox_top, x, y) - 8*dsin(_coll.image_angle);
		}
		y = _coll_YatX - 16;
	}
} else {
	vspeed = 2;
}

if (instance_exists(obj_screenizer_end)) {
	if (y > obj_screenizer_end.y) {
		instance_destroy();
	}
}