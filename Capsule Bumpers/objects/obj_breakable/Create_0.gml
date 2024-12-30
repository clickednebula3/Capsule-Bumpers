event_inherited();

HP_MAX = sec/4;
HP = HP_MAX;
heat = 0;

myStep = function() {
	if (HP <= 0) {
		if (global.sounds) { audio_play_sound(sfx_glass_shatter, 5, false, random_range(0.7, 1.3), 0, random_range(0.7, 1.3)); }
		instance_destroy();
		return;
	}
	image_alpha = 0.5+(HP/HP_MAX)*0.5;
	heat *= 0.99;
}