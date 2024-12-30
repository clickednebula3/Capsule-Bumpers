randomise();
roundWon = false;
alarm[2] = sec/3;
alarm[3] = global.preGameStartTimer;

while (array_length(global.audioClearWithMap) > 0) {
	var _last_i = array_length(global.audioClearWithMap)-1;
	audio_stop_sound(global.audioClearWithMap[_last_i]);
	array_pop(global.audioClearWithMap);
}