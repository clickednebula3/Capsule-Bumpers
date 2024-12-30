draw_set_color(c_dkgray);
var _draw = false;
if (death_enabled) { draw_set_color(c_red); _draw = true; }
else if (warp_enabled) { draw_set_color(c_aqua); _draw = true; }

if (atmosphere_mode) {
	var _mid_x = (x+obj_screenizer_end.x)/2;
	var _mid_y = (y+obj_screenizer_end.y)/2;
	var _rad = point_distance(x, y, x+obj_screenizer_end.x, y+obj_screenizer_end.y)/2;
	draw_circle(_mid_x, _mid_y, _rad-3, true);
}
else if (_draw) { draw_line_width(x, -2*room_height, x, 3*room_height, 5); }