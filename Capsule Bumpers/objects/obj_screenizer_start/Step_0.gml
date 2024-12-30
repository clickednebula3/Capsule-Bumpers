if (atmosphere_mode) {
	var _mid_x = (x+obj_screenizer_end.x)/2;
	var _mid_y = (y+obj_screenizer_end.y)/2;
	var _rad = point_distance(x, y, x+obj_screenizer_end.x, y+obj_screenizer_end.y)/2;
	if (death_enabled) {
		with (obj_player) {
			if (point_distance(x, y, _mid_x, _mid_y) > _rad-48) { instance_destroy(); }
		}
	} else if (warp_enabled) {
		with (obj_player) {
			if (point_distance(x, y, _mid_x, _mid_y) > _rad-40) {
				var _ang = point_direction(_mid_x, _mid_y, x, y);
				x = _mid_x + (_rad-45)*dcos(_ang);
				y = _mid_y + (_rad-45)*-dsin(_ang);
				direction = _ang;
			}
		}
	} else {
		with (obj_player) {
			if (point_distance(x, y, _mid_x, _mid_y) > _rad-40) {
				var _ang = point_direction(_mid_x, _mid_y, x, y)+180;
				direction = _ang;
			}
		}
	}
} else {
	var coll = collision_rectangle(x, -2*room_height, x-64, 3*room_height, obj_player, false, false);
	if (coll != noone) {
		if (instance_exists(obj_screenizer_end)) {
			if (death_enabled) {
				instance_destroy(coll);
			} else if (warp_enabled) {
				coll.x = obj_screenizer_end.x-64;
			}
		}
	}

	var ball_coll = collision_rectangle(x, -2*room_height, x-64, 3*room_height, obj_botball, false, false);
	if (ball_coll != noone) {
		if (instance_exists(obj_screenizer_end)) {
			if (death_enabled) {
				instance_destroy(ball_coll);
			} else if (warp_enabled) {
				ball_coll.x = obj_screenizer_end.x-64;
			}
		}
	}
}

//if (instance_exists(obj_screenizer_end) && x-camera_get_view_x(0) > 0) {
//	//where to place the view window
//	view_set_xport(1, 0);
//	view_set_yport(1, 0);
//	//how big should the window take of the screen
//	view_set_wport(1, x-camera_get_view_x(0));
//	view_set_hport(1, camera_get_view_height(0));
//	//what of the world does the window see
//	camera_set_view_pos(myCamera, camera_get_view_width(0)-x, 0);
//	camera_set_view_size(myCamera, x-camera_get_view_x(0), camera_get_view_height(0));
//} else {
//	//where to place the view window
//	view_set_xport(1, 0);
//	view_set_yport(1, 0);
//	//how big should the window take of the screen
//	view_set_wport(1, 0);
//	view_set_hport(1, 0);
//}

move();