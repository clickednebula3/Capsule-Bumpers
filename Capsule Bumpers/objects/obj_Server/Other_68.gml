#macro ASSIGN_PLAYER_ID			0//CHECK
#macro UPDATE_SETTINGS_ALL		1//CHECK
#macro SEND_USERNAME			14//CHECK
#macro UPDATE_USERNAMES_LIST	19//CHECK
#macro UPDATE_PLAYER_COLOR		3//needs testing
#macro UPDATE_PLAYER_COLOR_ALL	4//needs testing

#macro KILL_PLAYER_ID			2//CHECK //kill when there's nobody connected to that player
#macro KILL_PLAYER_SELF			18//CHECK //ask server to kill my player

#macro KEY_UPDATE				5//CHECK
#macro KEY_UPDATE_ID			6//CHECK

#macro MAP_START 				7//CHECK
#macro MAP_CHECK 				16//CHECK //needs testing? //kill players that fail the check (only apply after 3s of map)
#macro MAP_STOP_ALL				8//CHECK
#macro MAP_RESTART				15//CHECK

#macro ARE_WE_CONNECTED			21
#macro WE_ARE_IN_FACT_CONNECTED 22
#macro UPDATE_SCORES			9//CHECK
#macro FIX_PLAYER_DATA			17//half-check //every like 1-2s?
//TODO: fix coords thingamajig and fake death coordination
//current room check
//player coords (and respawn false deads)
//powerup status for players and for objects
//score update

#macro POWERUP_SPAWN			10//CHECK
#macro POWERUP_PICKUP			11//maybe this isn't necessary? nvm it is
#macro BOTBALL_SPAWN			20//CHECK

#macro QUICK_CHAT				12
#macro QUICK_CHAT_ALL			13
//idea: you have 4 chat slots, and you can use NumKeys 1-4 to say them mid-game.
//controllers could use lshoulder to change selection and ltrigger to select
//idea: maybe could have some sort of emotions? emojis maybe? sprites?

var event_id = async_load[? "id"];

if (event_id == server) {
	var data_type = async_load[? "type"];
	var socket = async_load[? "socket"];
	switch (data_type) {
		case network_type_connect:
			var freeSpot = -1;
			for (var i=0; i<max_players; i++) {
				if (!connections[i]) {
					freeSpot = i;
					connections[i] = true;
					break;
				}
			}
			if (freeSpot >= 0) {
				ds_map_add(clients, socket, freeSpot);
				ds_list_add(sockets, socket);
			
				//send them their id
				var bufferPlyrId = buffer_create(2048, buffer_grow, 1);
				buffer_seek(bufferPlyrId, buffer_seek_start, 0);
				buffer_write(bufferPlyrId, buffer_u8, ASSIGN_PLAYER_ID);
				buffer_write(bufferPlyrId, buffer_u8, freeSpot);
				network_send_packet(socket, bufferPlyrId, buffer_tell(bufferPlyrId));
				
				//update their settings
				var response2 = buffer_create(2048, buffer_grow, 1);
				buffer_seek(response2, buffer_seek_start, 0);
				buffer_write(response2, buffer_u8, UPDATE_SETTINGS_ALL);
				buffer_write(response2, buffer_u8, global.hf);
				buffer_write(response2, buffer_u8, global.hz);
				buffer_write(response2, buffer_u8, global.hr);
				buffer_write(response2, buffer_u8, global.vf);
				buffer_write(response2, buffer_u8, global.vz);
				buffer_write(response2, buffer_u8, global.vr);
				buffer_write(response2, buffer_u8, global.controlledDashAim);
				network_send_packet(socket, response2, buffer_tell(response2));
				
				//update connected players
				var bufferUsernameList = buffer_create(2048, buffer_grow, 1);
				buffer_seek(bufferUsernameList, buffer_seek_start, 0);
				buffer_write(bufferUsernameList, buffer_u8, UPDATE_USERNAMES_LIST);
				buffer_write(bufferUsernameList, buffer_string, usernames[0]);
				buffer_write(bufferUsernameList, buffer_string, usernames[1]);
				buffer_write(bufferUsernameList, buffer_string, usernames[2]);
				buffer_write(bufferUsernameList, buffer_string, usernames[3]);
			
				for (var i=0; i<ds_list_size(sockets); i++) {
					network_send_packet(sockets[|i], bufferUsernameList, buffer_tell(bufferUsernameList));
				}
			}
		break;
		case network_type_disconnect:
			connections[clients[? socket]] = false;
			ds_list_delete(sockets, ds_list_find_index(sockets, socket));
			var response = buffer_create(2048, buffer_grow, 1);
			buffer_seek(response, buffer_seek_start, 0);
			buffer_write(response, buffer_u8, KILL_PLAYER_ID);
			buffer_write(response, buffer_u8, clients[? socket]);
			
			for (var i=0; i<ds_list_size(sockets); i++) {
				network_send_packet(sockets[|i], response, buffer_tell(response));
			}
			
			ds_map_delete(clients, socket);
		break;
	}
} else {
	var socket = async_load[? "id"];
	var buffer = async_load[? "buffer"];
	var theirId = clients[? socket];
	
	buffer_seek(buffer, buffer_seek_start, 0);
	var cmd = buffer_read(buffer, buffer_u8);
	switch (cmd) {
		case SEND_USERNAME:
			var theirUsername = buffer_read(buffer, buffer_string);
			usernames[theirId] = theirUsername;
			
			var bufferUsernameList = buffer_create(2048, buffer_grow, 1);
			buffer_seek(bufferUsernameList, buffer_seek_start, 0);
			buffer_write(bufferUsernameList, buffer_u8, UPDATE_USERNAMES_LIST);
			buffer_write(bufferUsernameList, buffer_string, usernames[0]);
			buffer_write(bufferUsernameList, buffer_string, usernames[1]);
			buffer_write(bufferUsernameList, buffer_string, usernames[2]);
			buffer_write(bufferUsernameList, buffer_string, usernames[3]);
			
			for (var i=0; i<ds_list_size(sockets); i++) {
				network_send_packet(sockets[|i], bufferUsernameList, buffer_tell(bufferUsernameList));
			}
			
		break;
		case KEY_UPDATE:
			var keys = [];
			keys[KEY_LEFT]  = buffer_read(buffer, buffer_u8);
			keys[KEY_RIGHT] = buffer_read(buffer, buffer_u8);
			keys[KEY_UP]    = buffer_read(buffer, buffer_u8);
			keys[KEY_DOWN]  = buffer_read(buffer, buffer_u8);
			keys[KEY_DASH]  = buffer_read(buffer, buffer_u8);
			
			var bufferKeyId = buffer_create(2048, buffer_grow, 1);
			buffer_seek(bufferKeyId, buffer_seek_start, 0);
			buffer_write(bufferKeyId, buffer_u8, KEY_UPDATE_ID);
			buffer_write(bufferKeyId, buffer_u8, theirId);
			buffer_write(bufferKeyId, buffer_u8, keys[KEY_LEFT]);
			buffer_write(bufferKeyId, buffer_u8, keys[KEY_RIGHT]);
			buffer_write(bufferKeyId, buffer_u8, keys[KEY_UP]);
			buffer_write(bufferKeyId, buffer_u8, keys[KEY_DOWN]);
			buffer_write(bufferKeyId, buffer_u8, keys[KEY_DASH]);
			
			for (var i=0; i<ds_list_size(sockets); i++) {
				network_send_packet(sockets[|i], bufferKeyId, buffer_tell(bufferKeyId));
			}
			
		break;
		case KILL_PLAYER_SELF:
			var bufferKillId = buffer_create(2048, buffer_grow, 1);
			buffer_seek(bufferKillId, buffer_seek_start, 0);
			buffer_write(bufferKillId, buffer_u8, KILL_PLAYER_ID);
			buffer_write(bufferKillId, buffer_u8, theirId);
			
			for (var s=0; s<ds_list_size(sockets); s++) {
				network_send_packet(sockets[|s], bufferKillId, buffer_tell(bufferKillId));
			}
		break;
		case UPDATE_PLAYER_COLOR:
			ColorSwitch(theirId);
			
			var bufferColorAll = buffer_create(2048, buffer_grow, 1);
			buffer_seek(bufferColorAll, buffer_seek_start, 0);
			buffer_write(bufferColorAll, buffer_u8, UPDATE_PLAYER_COLOR_ALL);
			buffer_write(bufferColorAll, buffer_u8, global.plyrColors[0]);
			buffer_write(bufferColorAll, buffer_u8, global.plyrColors[1]);
			buffer_write(bufferColorAll, buffer_u8, global.plyrColors[2]);
			buffer_write(bufferColorAll, buffer_u8, global.plyrColors[3]);
			
			for (var s=0; s<ds_list_size(sockets); s++) {
				network_send_packet(sockets[|s], bufferColorAll, buffer_tell(bufferColorAll));
			}
		break;
		case ARE_WE_CONNECTED:
			var truly_excellent = buffer_create(2048, buffer_grow, 1);
			buffer_seek(truly_excellent, buffer_seek_start, 0);
			buffer_write(truly_excellent, buffer_u8, WE_ARE_IN_FACT_CONNECTED);
			network_send_packet(socket, truly_excellent, buffer_tell(truly_excellent));
		break;
	}
}