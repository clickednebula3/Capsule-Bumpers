if (my_player == noone) {
	my_player = other;
	alarm[0] = 5*sec;
	if (global.sounds) { audio_play_sound(sfx_power_gained, 5, false, random_range(0.5, 1.5), 0, random_range(1, 1.2)); }
}