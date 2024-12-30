//averageX = 0;
//averageY = 0;
//EXPERIMENTAL
var divisionNum = global.smoothness; //todo: add wobble back!!
//averageX *= global.wobbleness;
//averageY *= global.wobbleness;
//averageX += global.smoothness*(room_width/2);
//averageY += global.smoothness*(room_height/2);

//var oldAvrgX = averageX;
//var oldAvrgY = averageY;
averageX *= global.smoothness;
averageY *= global.smoothness;

if (instance_exists(obj_botball) && obj_botball.cameraFollows) {
	divisionNum+=1;
	averageX += obj_botball.x;
	averageY += obj_botball.y;
}

if (instance_exists(obj_bigboss) && obj_bigboss.cameraFollows) {
	divisionNum+=1;
	averageX += obj_bigboss.x;
	averageY += obj_bigboss.y;
}

if (instance_exists(obj_player)) {
	with (obj_player) {
		divisionNum += 1;
		obj_control.averageX += x;
		obj_control.averageY += y;
	}
}

if (divisionNum > 0) {
	averageX = averageX/divisionNum;
	averageY = averageY/divisionNum;
} else {
	averageX = room_width/2;
	averageY = room_height/2;
}

//averageX = (averageX + (averageX-oldAvrgX)*global.wobbleness/20) / (1+global.wobbleness/20);

x = averageX;
y = averageY;
//with (all) {
//	if (object_index != obj_control) {
//		x -= obj_control.x - room_width/2;
//		y -= obj_control.y - room_height/2;
//	}
//}
//x = room_width/2;
//y = room_height/2;



var _diffXMin = 0;
var _diffXMax = 0;
var _diffYMin = 0;
var _diffYMax = 0;
with(obj_player) {
	_diffXMin = min(bbox_left-300, _diffXMin);
	_diffXMax = max(bbox_right+300, _diffXMax);
	_diffYMin = min(bbox_top-300, _diffYMin);
	_diffYMax = max(bbox_bottom+300, _diffYMax);
}
var _diff = max(_diffXMax-_diffXMin, (_diffYMax-_diffYMin)*heightToWidthRatio) - room_width;
_diff = max(_diff/2, 0);
camera_set_view_pos(myCamera, x-_diff-(room_width/2), y-(room_height/8)-_diff*heightToWidthRatio-(room_height/2));
camera_set_view_size(myCamera, room_width+(2*_diff), room_height+(2*_diff*heightToWidthRatio));





if (room == rm_boss) {
	if ((!instance_exists(obj_bigboss) || !instance_exists(obj_player)) && alarm[0] <= 0 && alarm[3] <= 3 && (!canceledAutoRestart || !instance_exists(obj_player))) {
		alarm[0] = global.postGameFinishTimer;
		if (!roundWon) {
			with (obj_player) { global.wins[playerId] +=1; }
			roundWon = true;
		}
	}
} else {
	var _alive_ids = [];
	with (obj_player) { if (!array_contains(_alive_ids, playerId)) { array_push(_alive_ids, obj_player.playerId); } }
	if (array_length(_alive_ids) <= 1 && alarm[0] <= 0 && alarm[3] <= 0 && (!canceledAutoRestart || !instance_exists(obj_player))) {
		alarm[0] = global.postGameFinishTimer;
		if (!roundWon) {
			if (instance_exists(obj_player)) { global.wins[obj_player.playerId] += 1; }
			roundWon = true;
		}
	}
}

//this doesn't work with online
//if (alarm[3] > 2 && global.anyPlyrInputs[KEY_DASH][0]) {
//	alarm[3] -= 1;
//}
//if (alarm[0] > 2 && global.anyPlyrInputs[KEY_DASH][0]) {
//	alarm[0] -= 1;
//}

//Make everything below compatible with online

//if (keyboard_check_pressed(vk_subtract) || gamepad_button_check_pressed(0, gp_shoulderl)) {
//	if (room_exists(room-1) && room-1 > 0) {
//		room_goto_previous();
//	}
//}

//if (keyboard_check_pressed(vk_add) || gamepad_button_check_pressed(0, gp_shoulderr)) {
//	if (room_exists(room+1)) {
//		room_goto_next();
//	}
//}

if (gamepad_button_check_pressed(0, gp_start) || gamepad_button_check_pressed(1, gp_start) || gamepad_button_check_pressed(2, gp_start) || gamepad_button_check_pressed(3, gp_start))
{ restart(); }

if (gamepad_button_check(0, gp_select) || gamepad_button_check(1, gp_select) || gamepad_button_check(2, gp_select) || gamepad_button_check(3, gp_select))
{ escape(); }