draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fnt_smol);
var startEscapeShow = sec;
var escapePercent = (escapeHeld-startEscapeShow)/(escapeHeldMax-startEscapeShow);
draw_set_alpha(escapePercent);
draw_text(16, 16, "Quitting... "+string(floor(4-(escapePercent*4))));
draw_set_alpha(1);

if (menuMode == 0)//main
{
	draw_set_alpha(1);
	draw_sprite(spr_logo_art, 0, room_width/4, 2*room_height/7);
	if (global.egg_pillcolliders) {
		draw_sprite_ext(spr_logo_pill_colliders, 0, 2*room_width/3, 2*room_height/7, 1.5, 1.5, 0, c_white, 1);
	} else {
		draw_sprite_ext(spr_logo_text, 0, 2*room_width/3, 2*room_height/7, 1.5, 1.5, 0, c_white, 1);
	}
	
	if (instance_exists(obj_Server)) {
		playerIsFound[0] = obj_Server.connections[0];
		playerIsFound[1] = obj_Server.connections[1];
		playerIsFound[2] = obj_Server.connections[2];
		playerIsFound[3] = obj_Server.connections[3];
	}
	
	var xOffset = 192+16;
	for (var i=0; i<array_length(playerIsFound); i++) {
		if (playerIsFound[i] && global.devices[global.plyrDevices[i]] != "NotConnected") {
			draw_sprite_ext(global.deviceSprites[global.plyrDevices[i]], 0, (room_width/2) - (1.5*(room_width/6)) + (i*(room_width/8)) + xOffset, 5*room_height/8, 2, 2, 0, c_white, 1);
			draw_sprite_ext(spr_player,  4*global.egg_darkmode, (room_width/2) - (1.5*(room_width/6)) + (i*(room_width/8)) + xOffset, 14*room_height/16, 1, 1, 0, c_white, 1);
			draw_sprite_ext(spr_player, 1, (room_width/2) - (1.5*(room_width/6)) + (i*(room_width/8)) + xOffset, 14*room_height/16, 1, 1, 0, global.allColors[global.plyrColors[i]], 1);
		} else {
			draw_sprite_ext(global.deviceSprites[global.plyrDevices[i]], 0, (room_width/2) - (1.5*(room_width/6)) + (i*(room_width/8)) + xOffset, 5*room_height/8, 2, 2, 0, make_color_rgb(255, 255, 160), 1);
			draw_sprite(spr_not_connected, 0, (room_width/2) - (1.5*(room_width/6)) + (i*(room_width/8)) + xOffset, 5*room_height/8);
		}
		
		if (playerIsFound[i] || true) {
			draw_set_font(fnt_smol);
			draw_set_color(global.allColors[global.plyrColors[i]]);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_alpha(1);
			if (instance_exists(obj_Server)) {
				draw_text((room_width/2) - (1.5*(room_width/6)) + (i*(room_width/8)) + xOffset, (3*room_height/4)-((-i)*12)+92, string(obj_Server.usernames[i]));
			}
			if (global.wins[i] > 0) {
				draw_text((room_width/2) - (1.5*(room_width/6)) + (i*(room_width/8)) + xOffset, (3*room_height/4), string(global.wins[i]));
			}
		}
	}
}
else if (menuMode == 1)//settings
{
	var xOffset = -64;
	var yOffset = 48;
	//in retrospect, idk why I made all too many calculations if I'll end up using an offset anyways
	var buttonID = array_length(menuItems[1]);
	for (var i=0; i<array_length(playerIsFound); i++) {
		
		var main_x = (room_width/2) - (1.5*(room_width/6)) + (i*(room_width/8)) + xOffset
		var IS_SELECTED = (selectedButtonID == buttonID);
		var my_device = global.deviceSprites[global.plyrDevices[i]];
		var my_device_text = global.devices[global.plyrDevices[i]];
		var my_color = global.allColors[global.plyrColors[i]];
		var device_tint = c_white;
		if (!playerIsFound[i]) {device_tint = make_color_rgb(255, 255, 160);}
		
		draw_sprite_ext(my_device, IS_SELECTED, main_x, (5*room_height/8) + yOffset, 2, 2, 0, device_tint, 1);
		if (!playerIsFound[i]) {draw_sprite(spr_not_connected, 0, main_x, (5*room_height/8) + yOffset);}
		draw_set_halign(fa_center);
		if (IS_SELECTED) {draw_set_color(c_aqua);}
		else {draw_set_color(c_white);}
		draw_text_transformed(main_x, (3.3*room_height/8) + yOffset+72, my_device_text, 0.5, 0.5, 0);
		buttonID++;
		
		IS_SELECTED = (selectedButtonID == buttonID);
		var apropriate_image_index = (4*global.egg_darkmode)+(2*IS_SELECTED);
		draw_sprite(spr_player_inboxation, IS_SELECTED, main_x, (14*room_height/16) + yOffset);
		draw_sprite_ext(spr_player, apropriate_image_index, main_x, (14*room_height/16) + yOffset, 1, 1, 0, c_white, 1);
		draw_sprite_ext(spr_player, 1, main_x, (14*room_height/16) + yOffset, 1, 1, 0, my_color, 1);
		buttonID++;
		
	}
	
	draw_set_color(make_color_rgb(255, 255, 160));
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text_transformed(24, (room_height/2)-8,    "Game By    Nebby/clickednebula3", 1, 1, 0);
	draw_text_transformed(24, (room_height/2)+24,    "Capsule Bumpers is still in BETA", 1, 1, 0);
	//draw_text_transformed(24, (room_height/2)+16+8, "Music By   ohwaitwedonthavethatyet Studio", 0.75, 0.75, 0);
}
else if (menuMode == 2)//play
{
	var selectedIndex = selectedButtonID-1;
	if (selectedIndex<0) {selectedIndex = 0;}
	
	if (abs(mapSelectionSlowValue - selectedIndex) > 0.25)
	{ mapSelectionSlowValue += clamp((selectedIndex-mapSelectionSlowValue)/5, -0.25, 0.25); }
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_alpha(1);
	
	draw_set_color(c_white);
	if (selectedIndex > 0) {
		var _last_map = global.mapArenas[selectedIndex-1];
		draw_sprite(_last_map.sprite, 0, (-selectedIndex+mapSelectionSlowValue)*(room_width/2), room_height/2);
		draw_sprite(_last_map.icon_frame, 0, (-selectedIndex+mapSelectionSlowValue)*(room_width/2), room_height/2);
		if (room_exists(_last_map.room_)) {
			draw_text((-selectedIndex+mapSelectionSlowValue)*(room_width/2), 3*room_height/4, _last_map.name);
		}
		//draw_sprite(global.mapSprites[selectedIndex-1], 0, (-selectedIndex+mapSelectionSlowValue)*(room_width/2), room_height/2);
		//if (room_exists(global.mapRooms[selectedIndex-1])) {
		//	draw_text((-selectedIndex+mapSelectionSlowValue)*(room_width/2), 3*room_height/4, global.mapNames[selectedIndex-1]);
		//}
	}
	
	var _this_map = global.mapArenas[selectedIndex];
	var _scale = 0.85+((1+sin( drawTimer/sec ))/10);
	var _rotate = 5*sin(1.5*drawTimer/sec);
	draw_sprite_ext(
		_this_map.sprite, selectedButtonID != 0,
		(-selectedIndex+mapSelectionSlowValue+1)*(room_width/2), room_height/2,
		_scale, _scale, _rotate, c_white, 1);
	draw_sprite_ext(
		_this_map.icon_frame, selectedButtonID != 0,
		(-selectedIndex+mapSelectionSlowValue+1)*(room_width/2), room_height/2,
		_scale, _scale, _rotate, c_white, 1);
	for (var i=0; i<array_length(_this_map.powerups); i++) {
		var _power = _this_map.powerups[i];
		var _power_spr = ds_map_find_value(global.powerup_sprites, _power);
		var _w = (-20+sprite_get_width(_this_map.sprite)/2)*_scale;
		var _h = (32+sprite_get_height(_this_map.sprite)/2)*_scale;
		var _sep = i*48*_scale;
		draw_sprite_ext(
			spr_back_power, 0,
			(-selectedIndex+mapSelectionSlowValue+1)*(room_width/2) + _h*dcos(_rotate+90) - _w*dcos(_rotate) + _sep*dcos(_rotate),
			room_height/2 - _h*dsin(_rotate+90) + _w*dsin(_rotate) - _sep*dsin(_rotate),
			_scale, _scale, _rotate, c_white, 1);
		draw_sprite_ext(
			_power_spr, 0,
			(-selectedIndex+mapSelectionSlowValue+1)*(room_width/2) + _h*dcos(_rotate+90) - _w*dcos(_rotate) + _sep*dcos(_rotate),
			room_height/2 - _h*dsin(_rotate+90) + _w*dsin(_rotate) - _sep*dsin(_rotate),
			_scale, _scale, _rotate, c_white, 1);
	}
	//draw_sprite_ext(
	//	global.mapSprites[selectedIndex], selectedButtonID != 0, (-selectedIndex+mapSelectionSlowValue+1)*(room_width/2), room_height/2,
	//	0.85+((1+sin( drawTimer/sec ))/10),
	//	0.85+((1+sin( drawTimer/sec )) /10),
	//	5*sin(1.5*drawTimer/sec), c_white, 1
	//);
	if (selectedButtonID != 0) { draw_set_color(c_aqua); }
	if (room_exists(_this_map.room_)) {
		draw_text_transformed((-selectedIndex+mapSelectionSlowValue+1)*(room_width/2), 3*room_height/4, _this_map.name, _scale, _scale, _rotate);
	}
	//if (room_exists(global.mapRooms[selectedIndex])) {
	//	draw_text((-selectedIndex+mapSelectionSlowValue+1)*(room_width/2), 3*room_height/4, global.mapNames[selectedIndex]);
	//}
	
	if (array_contains(_this_map.sudden_deaths, SuddenDeathType.FallingMeteors) && !irandom_range(0, 15)) {
		var _meteor = instance_create_depth(random_range(0, room_width), -64, depth+10, obj_meteor);
		_meteor.alarm[0] = 5*sec;
	}
	if (array_contains(_this_map.sudden_deaths, SuddenDeathType.RisingLava)) {
		lava_time = DrawLava(lava_time, 12, 2, 1, -64, room_width+64, room_height-32, room_height+96);
	}
	
	draw_set_color(c_white);
	if (selectedIndex < array_length(global.mapArenas)-1) {
		var _next_map = global.mapArenas[selectedIndex+1];
		draw_sprite(_next_map.sprite, 0, (-selectedIndex+mapSelectionSlowValue+2)*(room_width/2), room_height/2);
		draw_sprite(_next_map.icon_frame, 0, (-selectedIndex+mapSelectionSlowValue+2)*(room_width/2), room_height/2);
		if (room_exists(_next_map.room_)) {
			draw_text((-selectedIndex+mapSelectionSlowValue+2)*(room_width/2), 3*room_height/4, _next_map.name);
		}
		//draw_sprite(global.mapSprites[selectedIndex+1], 0, (-selectedIndex+mapSelectionSlowValue+2)*(room_width/2), room_height/2);
		//if (room_exists(global.mapRooms[selectedIndex+1])) {
		//	draw_text((-selectedIndex+mapSelectionSlowValue+2)*(room_width/2), 3*room_height/4, global.mapNames[selectedIndex+1]);
		//}
	}
	
}
else if (menuMode == 3)//online: server or client
{
	if (!instance_exists(obj_Server) && !instance_exists(obj_Client))//select server or client
	{
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_sprite(spr_menu_serverorclient, selectedButtonID == 1, room_width/3, room_height/2);
		draw_sprite(spr_menu_serverorclient, selectedButtonID == 2, 2*room_width/3, room_height/2);
		
		//player name
		if (selectedButtonID == 3) { draw_set_color(c_aqua); }
		draw_rectangle(room_width/3, room_height/9, 2*room_width/3, 2*room_height/9, false);
		draw_set_color(c_black);
		draw_rectangle((room_width/3)+8, (room_height/9)+8, (2*room_width/3)-8, (2*room_height/9)-8, false);
		draw_set_color(c_yellow);
		draw_text(room_width/2, (1.5*room_height/9), global.username);
		
		
		draw_set_color(c_white);
		if (selectedButtonID == 1) { draw_set_color(c_aqua); }
		draw_text(room_width/3, room_height/2, "Host");
		draw_set_color(c_white);
		if (selectedButtonID == 2) { draw_set_color(c_aqua); }
		draw_text(2*room_width/3, room_height/2, "Join");
	} else {
		//no
	}
}
else if (menuMode == 4 || menuMode == 5) //enter server ip and username
{
		//text bar
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_rectangle(room_width/3, room_height/9, 2*room_width/3, 2*room_height/9, false);
		if (menuMode == 4) { draw_text(room_width/2, 2*room_height/7, "Enter Username:"); }
		else { draw_text(room_width/2, 2*room_height/7, "Enter Server Ip Address:"); }
		draw_set_color(c_black);
		draw_rectangle((room_width/3)+8, (room_height/9)+8, (2*room_width/3)-8, (2*room_height/9)-8, false);
		draw_set_color(c_yellow);
		if (menuMode == 4) { draw_text(room_width/2, (1.5*room_height/9), global.username); }
		else { draw_text(room_width/2, (1.5*room_height/9), global.ipaddress); }
		
		//letters
		draw_set_color(c_white);
		var xOff = 48;
		var yOff = 64;
		var letterIndex = 1;
		for (var yy=0; yy<string_length(LETTERS)/letterRow; yy++) {
			for (var xx=0; xx<letterRow; xx++) {
				var myX = (room_width/2)+((xx-6)*xOff);
				var myY =  (3*room_height/5)+((yy-2)*yOff);
				if (letterIndex == selectedButtonID) {
					draw_set_color(c_aqua);
					if (yy == (string_length(LETTERS)/letterRow)-1 && xx == letterRow-1) draw_set_color(c_red);
					draw_circle(myX-32, myY-8, 32, true);
				}
				else draw_set_color(c_white);
				if (yy == (string_length(LETTERS)/letterRow)-1 && xx == letterRow -1) draw_set_color(c_red);
				draw_set_halign(fa_middle);
				draw_set_valign(fa_center);
				draw_set_font(fnt_mid);
				
				draw_text_transformed(myX-32, myY, string_char_at(LETTERS, letterIndex), 1, 1, (letterIndex == selectedButtonID)*random_range(-10, 10));
				letterIndex+=1;
			}
		}
}
else if (menuMode == 5) //online menu
{
		//see connected players and their names and colors
		//select your player profile (1-2-3-4 from the normal players) (server will decide the colors tho)
		//chat with others
		//TODO: disable settings for clients
}


///All online menus:

//select server or client or change username (CHECK)
//enter username [letters, backspace, confirm]
//client: enter ip
	//check server status: [in a game, in the online menu]
//online main menu
	//server: accept player joins
	//players: names and colored capsules
	//chat?