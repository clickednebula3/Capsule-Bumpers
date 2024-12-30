/// @description Sudden Death Lava Rise
if (death_bottom && room != rm_boss) {
	vspeed = -0.3;
	sudden_death = true;
	if (global.music) { 
		array_push(global.audioClearWithMap, audio_play_sound(snd_inevitable, 10, false, 1, 0, 1));
	}
}