jetpackFuel = 0;
hasPowerBump = false;
playerId = 0;

vspeed = random_range(-15, -10);
hspeed = random_range(-7, 7);
image_alpha = 0.5;
gravity = 1;
alarm[0] = 2*sec;

if (obj_control.alarm[3] <= 0) {
	if (global.sounds) { 
		if (global.egg_darkmode) { audio_play_sound(sfx_hehehehe, 5, false, random_range(0.5, 1.5), 0, random_range(0.8, 1.2)); }
		else { audio_play_sound(sfx_dead_capsule, 5, false, random_range(0.5, 1.5), 0, random_range(0.8, 1.2)); }
	}
}

function draw_CapsuleParticle() {//particle has its own function
	image_angle = point_direction(0, 0, -hspeed, 50) + 90;

	draw_set_alpha(1);
	if (jetpackFuel > 0) { draw_sprite_ext(spr_power_jetpack, 1, x, y, image_xscale, image_yscale, image_angle, c_white, 1); }

	if (abs(hspeed) >= 12) {
		var dashSpriteIndex = 2;
		if (hasPowerBump || abs(hspeed) >= 32) {dashSpriteIndex = 3;}
		draw_sprite_ext(sprite_index, dashSpriteIndex, x-hspeed, y, image_xscale, image_yscale, image_angle, c_white, 0.8);
		draw_sprite_ext(sprite_index, dashSpriteIndex, x-(hspeed/2), y, image_xscale, image_yscale, image_angle, c_white, 1);
	}

	if (global.egg_darkmode) { draw_sprite_ext(sprite_index, 4, x, y, image_xscale, image_yscale, image_angle, c_white, 1); }
	else { draw_self(); }

	if (hasPowerBump) { draw_sprite_ext(spr_power_bump, 1, bbox_left+((bbox_right-bbox_left)/2), bbox_top+((bbox_bottom-bbox_top)/2), image_xscale, image_yscale, image_angle, c_white, 1); }
	
	draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, image_angle, global.allColors[global.plyrColors[playerId]], 1);
}