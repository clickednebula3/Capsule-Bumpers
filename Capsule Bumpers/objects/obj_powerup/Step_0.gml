var _coll = collision_circle((bbox_right+bbox_left)/2, y, 16, obj_ground, true, false);

if (_coll != noone && _coll.object_index != obj_ground_mirror) {
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
} else { vspeed = 2; }

if (instance_exists(obj_screenizer_end) and y > obj_screenizer_end.y) { instance_destroy(); }

switch (powerup_type) {
	case PowerupType.BulletGun:
		if (my_player != noone) {
			if (!instance_exists(my_player)) { instance_destroy(); return; }
			vspeed = 0;
			gravity = 0;
			x = my_player.x+my_player.hspeed*3;
			y = my_player.y+my_player.vspeed-32;
			var _lr = my_player.hspeed/abs(my_player.hspeed);
			image_xscale = _lr;
			var _t = alarm[1];
			with (my_player) {
				dashDisabled = 5;
				if (global.plyrInputs[playerId][KEY_DASH][0] and abs(hspeed) > 5 and _t <= 0) {
					_t = sec/3;
					var myBullet = instance_create_depth(x, bbox_top+((bbox_bottom-bbox_top)/2), depth, obj_pistol_bullet);
					myBullet.owner = self;
					myBullet.hspeed = _lr*20+hspeed/5;
					hspeed = -hspeed/3;
				}
			}
			alarm[1] = _t;
		}
		break;
	case PowerupType.Jetpack:
		break;
	case PowerupType.Jumbo:
		break;
	case PowerupType.PowerBump:
		break;
	default:
		break;
}