drawTimer += 1;

if (global.wins[0] + global.wins[1] + global.wins[2] + global.wins[3] >= 100) {
	global.egg_pillcolliders = true;
} else {
	global.egg_pillcolliders = false;
}

if (keyboard_check_pressed(vk_pageup)) { global.ipaddress = "nebneb.ddns.net"; }

var isEscapeHeld = keyboard_check_direct(vk_escape);
escapeHeld+= (2*isEscapeHeld)-1;
if (escapeHeld >= escapeHeldMax) { game_end(); }
escapeHeld = clamp(escapeHeld, 0, escapeHeldMax+5);

//selection movement
if (menuMode == 0)
{
	if (global.anyPlyrInputs[3][1]) || (global.anyPlyrInputs[1][1] && selectedButtonID == 2) {
		selectedButtonID+=1;
	}
	if (global.anyPlyrInputs[2][1]) {
		if (selectedButtonID == 3) {selectedButtonID -=1;}
		selectedButtonID-=1;
	}
	if (global.anyPlyrInputs[0][1] && selectedButtonID == 3) {
		selectedButtonID-=1;
	}
	selectedButtonID = clamp(selectedButtonID, 0, 3);
}
else if (menuMode == 1)//settings
{
	//Sections
	var slidersUntil = slidersEndAt;//7
	var togglesUntil = array_length(menuItems[1])-1;//12
	var playersUntil = togglesUntil+8;//20
	if (global.anyPlyrInputs[KEY_LEFT][1]) {
		if (selectedButtonID <= 0) {
			selectedButtonID = playersUntil;
		} else if (selectedButtonID <= slidersUntil && selectedButtonID >= abs(slidersUntil)-abs(togglesUntil)) {
			selectedButtonID = slidersUntil+abs(slidersUntil+1-selectedButtonID);
		} else if (selectedButtonID >= togglesUntil+3 && selectedButtonID <= playersUntil) {
			selectedButtonID-=2;
		}
	}
	if (global.anyPlyrInputs[KEY_RIGHT][1]) {
		if (selectedButtonID >= slidersUntil+1 && selectedButtonID <= togglesUntil) {
			selectedButtonID = slidersUntil+1-abs(slidersUntil-selectedButtonID);
		} else if (selectedButtonID >= togglesUntil+1 && selectedButtonID <= playersUntil-2) {
			selectedButtonID+=2;
		} else if (selectedButtonID == playersUntil-1) {
			selectedButtonID = 1;
		} else if (selectedButtonID == playersUntil) {
			selectedButtonID = 0;
		}
	}
	if (global.anyPlyrInputs[KEY_UP][1]) {
		if (selectedButtonID <= slidersUntil) {
			selectedButtonID+=1;
		} else if (selectedButtonID >= playersUntil-3 && selectedButtonID%2 == (playersUntil+1)%2) {
			selectedButtonID = 1;
		} else if (selectedButtonID >= playersUntil-5 && selectedButtonID%2 == (playersUntil+1)%2) {
			selectedButtonID = togglesUntil;
		} else {
			selectedButtonID-=1;
		}
	}
	if (global.anyPlyrInputs[KEY_DOWN][1]) {
		if (selectedButtonID <= slidersUntil) {
			selectedButtonID-=1;
		} else {
			selectedButtonID+=1;
		}
	}
	
	selectedButtonID = clamp(selectedButtonID, 0, playersUntil);
	
	if (global.anyPlyrInputs[4][1]) {
		if (selectedButtonID > togglesUntil) {
			var daPlayerID = floor((selectedButtonID-togglesUntil-1)/2);
			if (selectedButtonID%2 != playersUntil%2)
			{
				if (!instance_exists(obj_Client) && !instance_exists(obj_Server)) {
					//next applicable device
					global.plyrDevices[daPlayerID]++;
					if (global.plyrDevices[daPlayerID]>=array_length(global.devices)-4) { global.plyrDevices[daPlayerID] = 0; }
					//sort controllers?
				}
			}
			else
			{
				if (instance_exists(obj_Client) && obj_Client.client >= 0) {
					if (daPlayerID == global.myOnlineId) {
						with (obj_Client) {
							var buffer = buffer_create(2048, buffer_grow, 1);
							buffer_seek(buffer, buffer_seek_start, 0);
							buffer_write(buffer, buffer_u8, UPDATE_PLAYER_COLOR);
							network_send_packet(client, buffer, buffer_tell(buffer));
						}
					}
				} else {
					ColorSwitch(daPlayerID);
				}
			}
		}
	}
}
else if (menuMode == 2)//play select map
{
	if (global.anyPlyrInputs[3][1]) {
		selectedButtonID = 0;
		mapSelectionSlowValue = -abs(mapSelectionSlowValue);
	}
	if (global.anyPlyrInputs[0][1] && selectedButtonID != 0) {
		if (selectedButtonID > 1) { mapSelectionSlowValue -= 2; }
		selectedButtonID -= 1;
	}
	if ((global.anyPlyrInputs[1][1] && selectedButtonID != 0) || (global.anyPlyrInputs[2][1] && selectedButtonID == 0)) {
		if (selectedButtonID < array_length(global.mapArenas) && selectedButtonID != 0) { mapSelectionSlowValue += 2; }
		selectedButtonID += 1;
	}
	selectedButtonID = clamp(selectedButtonID, 0, array_length(global.mapArenas));
	if (global.anyPlyrInputs[4][1]) {
		var selectedIndex = selectedButtonID-1;
		if (selectedIndex>=0) {
			if (room_exists(global.mapArenas[selectedIndex].room_)) {
				if (instance_exists(obj_Server)) {
					with (obj_Server) {
						//update settings
						var bufferSets = buffer_create(2048, buffer_grow, 1);
						buffer_seek(bufferSets, buffer_seek_start, 0);
						buffer_write(bufferSets, buffer_u8, UPDATE_SETTINGS_ALL);
						buffer_write(bufferSets, buffer_u8, global.hf);
						buffer_write(bufferSets, buffer_u8, global.hz);
						buffer_write(bufferSets, buffer_u8, global.hr);
						buffer_write(bufferSets, buffer_u8, global.vf);
						buffer_write(bufferSets, buffer_u8, global.vz);
						buffer_write(bufferSets, buffer_u8, global.vr);
						buffer_write(bufferSets, buffer_u8, global.controlledDashAim);
						for (var s=0; s<ds_list_size(sockets); s++) {
							network_send_packet(sockets[|s], bufferSets, buffer_tell(bufferSets));
						}
						//start game
						var buffer = buffer_create(2048, buffer_grow, 1);
						buffer_seek(buffer, buffer_seek_start, 0);
						buffer_write(buffer, buffer_u8, MAP_START);
						buffer_write(buffer, buffer_u8, selectedIndex);
						for (var i=0; i<ds_list_size(sockets); i++) {
							network_send_packet(sockets[|i], buffer, buffer_tell(buffer));
						}
					}
				} else {
					//room_goto(global.mapArenas[selectedIndex].room_);
					global.mapArenas[selectedIndex].StartArena();
				}
			}
		}
	}
}
else if (menuMode == 3)//Online
{
	if (!instance_exists(obj_Server) && !instance_exists(obj_Client))//choose client or server
	{
		if (global.anyPlyrInputs[3][1]) {
			selectedButtonID -= 2;
		}
		if (global.anyPlyrInputs[0][1] && selectedButtonID != 0 && selectedButtonID != 3) {
			selectedButtonID -= 1;
		}
		if ((global.anyPlyrInputs[1][1] && selectedButtonID != 0 && selectedButtonID < 2) || (global.anyPlyrInputs[2][1] && (selectedButtonID == 0 || selectedButtonID == 1))) {
			selectedButtonID += 1;
		}
		if (global.anyPlyrInputs[2][1] && selectedButtonID == 2) {
			selectedButtonID += 2;
		}
		selectedButtonID = clamp(selectedButtonID, 0, 3);
		if (global.anyPlyrInputs[4][1]) {
			if (selectedButtonID == 1) {
				instance_create_depth(0, 0, depth, obj_Server);
			} else if (selectedButtonID == 2) {
				menuMode = 5;
				event_user(0);
			} else if (selectedButtonID == 3) {
				menuMode = 4;
				event_user(0);
			}
			selectedButtonID = 0;
		}
	} else {//online menu
		menuMode = 6;
	}
}
else if (menuMode == 4 || menuMode == 5)//Username
{
		if (global.anyPlyrInputs[0][1] && selectedButtonID != 0) {
			selectedButtonID -= 1;
		}
		if (global.anyPlyrInputs[1][1] && selectedButtonID != 0) {
			selectedButtonID += 1;
		}
		if (global.anyPlyrInputs[2][1]) {
			if (selectedButtonID == 0) selectedButtonID = string_length(LETTERS);
			else if (selectedButtonID > letterRow) selectedButtonID -= letterRow;
		}
		if (global.anyPlyrInputs[3][1]) {
			if (selectedButtonID <= letterRow*4) selectedButtonID += letterRow;
			else selectedButtonID = 0;
		}
		selectedButtonID = clamp(selectedButtonID, 0, string_length(LETTERS)+1);
		if (global.anyPlyrInputs[4][1]) {
			var letterIndex = 1;
			for (var yy=0; yy<string_length(LETTERS)/letterRow; yy++) {
				for (var xx=0; xx<letterRow; xx++) {
					if (letterIndex == selectedButtonID) {
						if (letterIndex == string_length(LETTERS)) {
							if (menuMode == 4) {
								global.username = string_delete(global.username, string_length(global.username), 1);
							} else {
								global.ipaddress = string_delete(global.ipaddress, string_length(global.ipaddress), 1);
							}
						} else {
							if (menuMode == 4) {
								global.username += string_char_at(LETTERS, letterIndex);
								if (string_length(global.username) > 16) {
									global.username = string_delete(global.username, string_length(global.username), 1);
								}
							} else {
								global.ipaddress += string_char_at(LETTERS, letterIndex);
								if (string_length(global.ipaddress) > 32) {
									global.ipaddress = string_delete(global.ipaddress, string_length(global.ipaddress), 1);
								}
							}
						}
					}
					letterIndex+=1;
				}
			}
		}
}
else {
	selectedButtonID = clamp(selectedButtonID, 0, 0);
}