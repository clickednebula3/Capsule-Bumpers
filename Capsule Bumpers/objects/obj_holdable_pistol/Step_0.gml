if (instance_exists(obj_screenizer_end)) {
	if (y > obj_screenizer_end.y) { instance_destroy(); return; }
}

if (my_player != noone) {
	if (!instance_exists(my_player)) { instance_destroy(); return; }
	my_player.dashDisabled = 5;
	vspeed = 0;
	gravity = 0;
	var _lr = my_player.hspeed/abs(my_player.hspeed);
	if (string_starts_with(room_get_name(room), "rm_space")) {
		x = my_player.x+my_player.hspeed*3;
		y = my_player.y+my_player.vspeed*3;
		image_angle = my_player.image_angle+90;
	} else {
		x = my_player.x+my_player.hspeed*3;
		y = my_player.y+my_player.vspeed-32;
		image_xscale = _lr;
	}
	if (global.plyrInputs[my_player.playerId][KEY_DASH][0] && abs(my_player.hspeed) > 5 && alarm[1] <= 0) {
		alarm[1] = sec/5;
		var myBullet = instance_create_depth(x, y, depth, obj_pistol_bullet);
		myBullet.owner = my_player;
		if (string_starts_with(room_get_name(room), "rm_space")) {
			myBullet.direction = my_player.direction;
			myBullet.speed = 20+my_player.speed/5;
		} else { myBullet.hspeed = _lr*20+my_player.hspeed/5; }
		my_player.hspeed = -my_player.hspeed/3;
	}
	
}
//else {
//	var _coll = collision_circle((bbox_right+bbox_left)/2, y, 16, obj_ground, true, false);

//	if (_coll != noone) {
//		vspeed = 0;
//		gravity = 0;
	
//		if (_coll.image_angle == 0) {
//			y = _coll.bbox_top - 16;
//		} else {
//			var _coll_YatX;
//			if (_coll.image_angle < 0 || _coll.image_angle > 180) {
//				_coll_YatX = _coll.bbox_top - dsin(_coll.image_angle)*point_distance(_coll.bbox_left, _coll.bbox_top, x, y) + 8*dsin(_coll.image_angle);
//			} else {
//				_coll_YatX = _coll.bbox_top + dsin(_coll.image_angle)*point_distance(_coll.bbox_right, _coll.bbox_top, x, y) - 8*dsin(_coll.image_angle);
//			}
//			y = _coll_YatX - 16;
//		}
//	} else {
//		gravity = 0.4;
//	}
//}