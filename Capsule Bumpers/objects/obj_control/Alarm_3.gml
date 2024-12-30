/// @description Pre Game Start Countdown
alarm[4] = sec;
if (instance_exists(obj_player)) {
	with (obj_player) {
		alarm[1] = 2;
	}
}