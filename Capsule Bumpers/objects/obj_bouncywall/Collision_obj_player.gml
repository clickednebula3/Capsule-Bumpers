var myMid = bbox_left+((bbox_right-bbox_left)/2);
var isOnMyLeft = (other.x < myMid);

if (canThrough && global.plyrInputs[other.playerId][KEY_DOWN][0]) {
	other.hspeed = 0;
	other.vspeed = 0;
	if (isOnMyLeft) { other.x = bbox_left - (4*other.sprite_width/9); }
	else { other.x = bbox_right + (4*other.sprite_width/9); }
} else {
	other.hspeed = ((-20*isOnMyLeft) + (20*!isOnMyLeft)) - other.hspeed;
	other.vspeed = -10;
	if (global.plyrInputs[other.playerId][KEY_UP][0]) { other.vspeed = -35; }
}

if (global.sounds) { audio_play_sound(sfx_recoil_capsule, 5, false, random_range(0.7, 1.3), 0, random_range(0.7, 1.3)); }