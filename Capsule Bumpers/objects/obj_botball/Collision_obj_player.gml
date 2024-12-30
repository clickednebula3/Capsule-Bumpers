if (abs(other.hspeed) + abs(other.vspeed) > 7) {
	hspeed = other.hspeed*2;
}
vspeed = -10;
lastBumperId = other.playerId;
if (abs(vspeed) > 0.0005) {
	if (global.sounds) { audio_play_sound(sfx_ball_b, 5, false, random_range(0.7, 1.3), 0, random_range(0.2, 0.6)); }
}