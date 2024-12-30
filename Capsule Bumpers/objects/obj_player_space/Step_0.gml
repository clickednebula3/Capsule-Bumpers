//can dash?
if (bulletCount > 0) { dashDisabled = 5; }
else { dashDisabled *= 0.9; }

//physics want to go point (cool)
var wantX = x;
var wantY = y;
//if (canMove) { wantY += 120; }

//collisions
var grounded = false;
var _jumpcoll = collision_circle((bbox_right+bbox_left)/2, y, 12, obj_ground, true, false);
var _jumpcoll2 = collision_circle((bbox_right+bbox_left)/2, y, 10, obj_repelbox, true, false);
var _coll = collision_circle((bbox_right+bbox_left)/2, y, 8, obj_ground, true, false);
var _roofcoll = collision_circle((bbox_right+bbox_left)/2, bbox_top, 8, obj_ground, true, false);
var _stickycoll = collision_circle((bbox_right+bbox_left)/2, bbox_top, 16, obj_stickyroof, true, false);
var nearbyPlayers = ds_list_create();
var nearbyPlayerCount = collision_circle_list(x, y, 64*15, object_index, false, true, nearbyPlayers, true);
var targeted = noone;

if (instance_exists(obj_bigboss)) { targeted = obj_bigboss; }
else if (nearbyPlayerCount > 0) { targeted = nearbyPlayers[|0]; }

//cpu controls
if (global.devices[global.plyrDevices[playerId]] == "CPU" && (nearbyPlayerCount > 0 || room = rm_boss)) {
	if (random_range(0, 1) < 0.8) {
		var _target_ang = point_direction(x, y, targeted.x, targeted.y) - direction;
		var _difang = 10;
		if (_target_ang < 180 && _target_ang > 0) { global.plyrInputs[playerId][KEY_LEFT][0] = true; }
		else { global.plyrInputs[playerId][KEY_RIGHT][0] = true; }
		if (abs(_target_ang) < _difang*2) { global.plyrInputs[playerId][KEY_UP][0] = true; }
		if (abs(_target_ang) < _difang) { global.plyrInputs[playerId][KEY_DASH][0] = true; }
		
		//if (targeted.x < x) { global.plyrInputs[playerId][KEY_LEFT][0] = true; }
		//if (targeted.x > x) { global.plyrInputs[playerId][KEY_RIGHT][0] = true; }
		//if (targeted.y-16 < bbox_top) { global.plyrInputs[playerId][KEY_UP][0] = true; }
		//if (targeted.bbox_top > bbox_bottom && abs(targeted.x - x) < 64)
		//{ global.plyrInputs[playerId][KEY_DOWN][0] = true; }
		//if (abs(targeted.x - x) > 64*8 && abs(hspeed) > 4 && hspeed/abs(hspeed) == (targeted.x - x)/abs(targeted.x - x))
		//{ global.plyrInputs[playerId][KEY_DASH][0] = true; }
	}
}

if (_jumpcoll != noone || _jumpcoll2 != noone) { grounded = true; }

//ground collision and phasing through it
if (_coll != noone) {
	if (!(global.plyrInputs[playerId][KEY_DOWN][0]) || !_coll.canThrough) {
		if (_coll.image_angle == 0) { wantY = _coll.bbox_top; }
		else {
			var _coll_YatX;
			if (_coll.image_angle < 0 || _coll.image_angle > 180) {
				_coll_YatX = _coll.bbox_top - dsin(_coll.image_angle)*point_distance(_coll.bbox_left, _coll.bbox_top, x, y) + 16*dsin(_coll.image_angle);
			} else {
				_coll_YatX = _coll.bbox_top + dsin(_coll.image_angle)*point_distance(_coll.bbox_right, _coll.bbox_top, x, y) - 16*dsin(_coll.image_angle);
			}
		
			wantY = _coll_YatX;
		}
		y = wantY;
		vspeed = 0;
		hspeed += dcos(_coll.image_angle+90);
		passthroughGround = noone;
	} else {
		if (!instance_exists(passthroughGround)) { passthroughGround = _coll; }
		if (passthroughGround != _coll) {
			if (_coll.image_angle == 0) { wantY = _coll.bbox_top; }
			else
			{
				var _coll_YatX;
				if (_coll.image_angle < 0 || _coll.image_angle > 180)
				{ _coll_YatX = _coll.bbox_top - dsin(_coll.image_angle)*point_distance(_coll.bbox_left, _coll.bbox_top, x, y) + 16*dsin(_coll.image_angle); }
				else
				{ _coll_YatX = _coll.bbox_top + dsin(_coll.image_angle)*point_distance(_coll.bbox_left, _coll.bbox_top, x, y) - 16*dsin(_coll.image_angle); }
				wantY = _coll_YatX;
			}
			//y = wantY+50;
			speed -= 1;
			vspeed = 0;
			hspeed += dcos(_coll.image_angle+90);
		}
	}
}

//yellow ground and sticking to it
if (_stickycoll != noone) {
	if (!global.plyrInputs[playerId][KEY_DOWN][0]) {
		showHands = true;
		if (_stickycoll.image_angle == 0) {
			wantY = _stickycoll.bbox_bottom+(bbox_bottom-bbox_top);
		}
		else {
			var _stickycoll_YatX;
			if (_stickycoll.image_angle < 0 || _stickycoll.image_angle > 180) {
				_stickycoll_YatX = _stickycoll.bbox_top - dsin(_stickycoll.image_angle)*point_distance(_stickycoll.bbox_left, _stickycoll.bbox_top, x, bbox_top)+8+(bbox_bottom-bbox_top);
			} else {
				_stickycoll_YatX = _stickycoll.bbox_top + dsin(_stickycoll.image_angle)*point_distance(_stickycoll.bbox_right, _stickycoll.bbox_top, x, bbox_top)+8+(bbox_bottom-bbox_top);
			}
		
			wantY = _stickycoll_YatX;
		}
		y = wantY;
		vspeed = 0;
	} else if (!_stickycoll.canThrough) { vspeed = clamp(vspeed, 0, 200); }
}
//unused?
if (_roofcoll != noone)
{
	//if (_roofcoll.image_angle == 0) {
	//	y = clamp(y, _roofcoll.bbox_bottom+(bbox_bottom-bbox_top)+16, y);
	//} else {
	//	var _roofcoll_YatX;
	//	if (_roofcoll.image_angle < 0 || _roofcoll.image_angle > 180) {
	//		_roofcoll_YatX = _roofcoll.bbox_top - dsin(_roofcoll.image_angle)*point_distance(_roofcoll.bbox_left, _roofcoll.bbox_top, x, bbox_top)+8+(bbox_bottom-bbox_top);
	//	} else {
	//		_roofcoll_YatX = _roofcoll.bbox_top + dsin(_roofcoll.image_angle)*point_distance(_roofcoll.bbox_right, _roofcoll.bbox_top, x, bbox_top)+8+(bbox_bottom-bbox_top);
	//	}
		
	//	y = clamp(y, _roofcoll_YatX, y);
	//}
	
}

//move left
if (global.plyrInputs[playerId][KEY_LEFT][0] && canMove)
{ direction+=5; }//{ wantX = x - 100*global.plyrInputs[playerId][KEY_LEFT][0]; }
//move right
if (global.plyrInputs[playerId][KEY_RIGHT][0] && canMove)
{ direction-=5; } //{ wantX = x + 100*global.plyrInputs[playerId][KEY_RIGHT][0]; }
//jump
if (global.plyrInputs[playerId][KEY_UP][0] && canMove/* && grounded*/) {
	speed += 1;// vspeed = -20;
	//if (global.plyrInputs[playerId][KEY_DASH][0] && abs(hspeed) < 10) { vspeed -= 20; }
}
//jump but while having jetpack
if (string_starts_with(room_get_name(room), "rm_space")) { jetpackFuel = 10; }
jetpackFuel = clamp(jetpackFuel, 0, sec*3);
if (global.plyrInputs[playerId][KEY_UP][0] && canMove && jetpackFuel > 0 && vspeed >= -9) {
	jetpackFuel -= 1;
	instance_create_depth(x, y, depth, obj_particle_jetpack);
	//vspeed = -8;
	if (global.plyrInputs[playerId][KEY_DASH][0] && jetpackFuel > 0) {
		jetpackFuel-=1;
		//vspeed = -16;
	}
}
//dash
if (global.plyrInputs[playerId][KEY_DASH][0] && !dashDisabled && canMove && abs(hspeed) > 0.01) {
	//if (global.controlledDashAim) {
	//	if ((hspeed/abs(hspeed) == 1 && global.plyrInputs[playerId][1][0]) ||
	//		(hspeed/abs(hspeed) == -1 && global.plyrInputs[playerId][0][0])) {
	//		hspeed = 30 * (hspeed / abs(hspeed));
	//	}
	//} else {
	//	hspeed = 30 * (hspeed / abs(hspeed));
	//}
	speed += 2;
}
//bullet
if (global.plyrInputs[playerId][KEY_DASH][0] && canMove && abs(hspeed) > 2 && bulletCount > 0) {
	var myBullet = instance_create_depth(x, bbox_top+((bbox_bottom-bbox_top)/2), depth, obj_bullet);
	myBullet.owner = self;
	myBullet.hspeed = hspeed;
	myBullet.vspeed = -5;
	bulletCount -= 1;
}

hf = global.hf / sec;
hz = global.hz;
hr = global.hr;

vf = global.vf / sec;
vz = global.vz;
vr = global.vr;

if (slowMotionTime > 0) {
	hf *= 0.75;
	vf *= 0.75;
	slowMotionTime -= 1;
}

hk1 = hz / (pi * hf);
hk2 = 1 / (2 * pi * hf * 2 * pi * hf);
hk3 = (hz * hr) / (2 * pi * hf);

vk1 = vz / (pi * vf);
vk2 = 1 / (2 * pi * vf * 2 * pi * vf);
vk3 = (vz * vr) / (2 * pi * vf);

//movephysics
hspeed += ( (wantX + (hk3*hspeed)) - (x + (hk1*hspeed)) ) / (hk2);
vspeed += ( (wantY + (vk3*vspeed)) - (y + (vk1*vspeed)) ) / (vk2);

hspeed = clamp(hspeed, -100, 100);
vspeed = clamp(vspeed, -100, 200);
//x = clamp(x, 0, room_width);

if (image_xscale > 1) { image_xscale *= 0.99; }
if (image_yscale > 1) { image_yscale *= 0.99; }
if (image_xscale < 1) { image_xscale *= 1.01; }
if (image_yscale < 1) { image_yscale *= 1.01; }
image_xscale = clamp(image_xscale, 0.3, 5);
image_yscale = clamp(image_yscale, 0.3, 5);

if (instance_exists(obj_screenizer_end)) {
	if (y > obj_screenizer_end.y) {
		if (obj_screenizer_end.death_bottom) {
			if (global.sounds) { audio_play_sound(sfx_lave_burn, 5, false, random_range(0.7, 1.3), 0, random_range(0.7, 1.3)); }
			instance_destroy();
		} else if (obj_screenizer_end.jump_bottom) {
			vspeed = -100;
		}
	}
}

if (string_starts_with(global.devices[global.plyrDevices[playerId]], "NotConnected") || (string_starts_with(global.devices[global.plyrDevices[playerId]], "Controller") && !gamepad_is_connected(global.plyrDevices[playerId]-4))) {
	instance_destroy();
}