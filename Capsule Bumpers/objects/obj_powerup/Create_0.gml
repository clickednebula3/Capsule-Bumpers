vspeed = 5;

if (array_length(global.mapPowerups) <= 0) { instance_destroy(); return; }

powerup_type = global.mapPowerups[irandom_range(0, array_length(global.mapPowerups)-1)];
my_player = noone;

alarm[0] = 1;

function play_my_sfx() {
	if (global.sounds) { audio_play_sound(sfx_power_gained, 5, false, random_range(0.5, 1.5), 0, random_range(1, 1.2)); }
}