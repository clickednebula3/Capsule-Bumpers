vspeed = -abs(vspeed)+1;
y = other.bbox_top-(sprite_width/2);
if (abs(vspeed) > 0.0005) {
	if (global.sounds) { audio_play_sound(sfx_ball_b, 5, false, random_range(0.7, 1.3), 0, random_range(0.7, 1.3)); }
}