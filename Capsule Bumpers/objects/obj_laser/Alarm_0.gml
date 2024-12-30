/// @description Remove temp reflects

if (!main_source) { instance_destroy(); return; }

if (passthrough_ground) { myColors = [c_maroon, c_red, c_yellow]; }
if (playerId >= 0) {
	var _player_color = global.allColors[global.plyrColors[playerId]];
	var _dark_color = make_color_rgb(color_get_red(_player_color)/2, color_get_green(_player_color)/2, color_get_blue(_player_color)/2);
	myColors = [_dark_color, _player_color, c_black];
}