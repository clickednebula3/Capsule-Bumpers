showHands = false;
playerId = 0;
passthroughGround = noone;

dashDisabled = false;
jetpackFuel = 0;
hasPowerBump = false;
bulletCount = 0;
slowMotionTime = 0;

canMove = false;
alarm[1] = global.preGameStartTimer;

vspeed = 0;
hspeed = 0;

hf = global.hf / sec;
hz = global.hz;
hr = global.hr;

vf = global.vf / sec;
vz = global.vz;
vr = global.vr;

hk1 = hz / (pi * hf);
hk2 = 1 / (2 * pi * hf * 2 * pi * hf);
hk3 = (hz * hr) / (2 * pi * hf);

vk1 = vz / (pi * vf);
vk2 = 1 / (2 * pi * vf * 2 * pi * vf);
vk3 = (vz * vr) / (2 * pi * vf);


alarm[0] = 1;


function draw_Capsule() {//particle has its own function
	image_angle = direction-90;

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