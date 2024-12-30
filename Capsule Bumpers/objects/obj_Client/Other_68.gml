var event_id = async_load[? "id"];

if (client == event_id) {
	var buffer = async_load[? "buffer"];
	
	buffer_seek(buffer, buffer_seek_start, 0);
	var cmd = buffer_read(buffer, buffer_u8);
	switch(cmd) {
		case ASSIGN_PLAYER_ID:
			//get player id
			var newId = buffer_read(buffer, buffer_u8);
			global.myOnlineId = newId;
			
			//send username
			var response = buffer_create(2048, buffer_grow, 1);
			buffer_seek(response, buffer_seek_start, 0);
			buffer_write(response, buffer_u8, SEND_USERNAME);
			buffer_write(response, buffer_string, global.username);
			network_send_packet(client, response, buffer_tell(response));
		break;
		case KEY_UPDATE_ID:
			var theirId = buffer_read(buffer, buffer_u8);
			var keys = [false, false, false, false, false];
			keys[KEY_LEFT] = buffer_read(buffer, buffer_u8);
			keys[KEY_RIGHT] = buffer_read(buffer, buffer_u8);
			keys[KEY_UP] = buffer_read(buffer, buffer_u8);
			keys[KEY_DOWN] = buffer_read(buffer, buffer_u8);
			keys[KEY_DASH] = buffer_read(buffer, buffer_u8);
			
			global.plyrInputs[theirId][KEY_LEFT][0] = keys[KEY_LEFT];
			global.plyrInputs[theirId][KEY_RIGHT][0] = keys[KEY_RIGHT];
			global.plyrInputs[theirId][KEY_UP][0] = keys[KEY_UP];
			global.plyrInputs[theirId][KEY_DOWN][0] = keys[KEY_DOWN];
			global.plyrInputs[theirId][KEY_DASH][0] = keys[KEY_DASH];
			
			global.onlineAppetiser[theirId][KEY_LEFT] = keys[KEY_LEFT];
			global.onlineAppetiser[theirId][KEY_RIGHT] = keys[KEY_RIGHT];
			global.onlineAppetiser[theirId][KEY_UP] = keys[KEY_UP];
			global.onlineAppetiser[theirId][KEY_DOWN] = keys[KEY_DOWN];
			global.onlineAppetiser[theirId][KEY_DASH] = keys[KEY_DASH];
		break;
		case MAP_START:
			var mapIndex = buffer_read(buffer, buffer_u8);
			if (room_exists(global.mapRooms[mapIndex])) {room_goto(global.mapRooms[mapIndex]);}
		break;
		case MAP_STOP_ALL:
			room_goto(rm_menu);
		break;
		case MAP_CHECK:
			var mapCheckIndex = buffer_read(buffer, buffer_u8);
			if (room != global.mapRooms[mapCheckIndex]) {
				if (room_exists(global.mapRooms[mapCheckIndex])) {room_goto(global.mapRooms[mapCheckIndex]);}
				var bufferKillPlayer = buffer_create(2048, buffer_grow, 1);
				buffer_seek(bufferKillPlayer, buffer_seek_start, 0);
				buffer_write(bufferKillPlayer, buffer_u8, KILL_PLAYER_SELF);
				//huh? there's no send here.. TEST HERE
				network_send_packet(client, bufferKillPlayer, buffer_tell(bufferKillPlayer));
			}
		break;
		case MAP_RESTART:
			room_restart();
		break;
		case KILL_PLAYER_ID:
			var killPlayerId = buffer_read(buffer, buffer_u8);
			if (instance_exists(obj_player)) {
				with (obj_player) {
					if (playerId == killPlayerId) {
						instance_destroy();
					}
				}
			}
		break;
		case POWERUP_SPAWN:
			var decidedX = buffer_read(buffer, buffer_u8);
			var decidedY = buffer_read(buffer, buffer_u8);
			var selectedPowerIndex = buffer_read(buffer, buffer_u8);
			instance_create_depth(decidedX, decidedY, depth, obj_powerup/*global.powerups[selectedPowerIndex]*/);
		break;
		case UPDATE_SCORES:
			var scores = [];
			scores[0] = buffer_read(buffer, buffer_u8);
			scores[1] = buffer_read(buffer, buffer_u8);
			scores[2] = buffer_read(buffer, buffer_u8);
			scores[3] = buffer_read(buffer, buffer_u8);
			global.wins = [scores[0], scores[1], scores[2], scores[3]];
		break;
		case FIX_PLAYER_DATA:
			var plyrId = buffer_read(buffer, buffer_u8);
			var plyrX = buffer_read(buffer, buffer_u8);
			var plyrY = buffer_read(buffer, buffer_u8);
			var plyrJetpackFuel = buffer_read(buffer, buffer_u8);
			var plyrHasPowerBump = buffer_read(buffer, buffer_u8);
			var plyrBulletCount = buffer_read(buffer, buffer_u8);
			var plyrSlowMotionTime = buffer_read(buffer, buffer_u8);
			
			var foundAlivePlayerAndApplied = false;
			//oh it's alive, lets update it
			if (instance_exists(obj_player)) {
				with (obj_player) {
					if (playerId == plyrId && !foundAlivePlayerAndApplied) {
						//coords did not work, you can't set them reliably in a moving room
						//x = obj_anchor.x + plyrX;
						//y = obj_anchor.x + plyrY;
						jetpackFuel = plyrJetpackFuel;
						hasPowerBump = plyrHasPowerBump;
						bulletCount = plyrBulletCount;
						slowMotionTime = plyrSlowMotionTime;
						foundAlivePlayerAndApplied = true;
					}
				}
			}
			//oh it's dead, lets do a necromancy
			if (!foundAlivePlayerAndApplied) {
				//var falseDeadNecromancyRevoked = instance_create_depth(obj_anchor.x+plyrX, obj_anchor.y+plyrY, depth, obj_player);
				//^can't really do this without something relative //obj_anchor didn't work :(
				//falseDeadNecromancyRevoked.playerId = plyrId;
				//falseDeadNecromancyRevoked.jetpackFuel = plyrJetpackFuel;
				//falseDeadNecromancyRevoked.hasPowerBump = plyrHasPowerBump;
				//falseDeadNecromancyRevoked.bulletCount = plyrBulletCount;
				//falseDeadNecromancyRevoked.slowMotionTime = plyrSlowMotionTime;
			}
		break;
		case UPDATE_USERNAMES_LIST:
			usernames[0] = buffer_read(buffer, buffer_string);
			usernames[1] = buffer_read(buffer, buffer_string);
			usernames[2] = buffer_read(buffer, buffer_string);
			usernames[3] = buffer_read(buffer, buffer_string);
		break;
		case UPDATE_SETTINGS_ALL:
			global.hf = buffer_read(buffer, buffer_u8);
			global.hz = buffer_read(buffer, buffer_u8);
			global.hr = buffer_read(buffer, buffer_u8);
			global.vf = buffer_read(buffer, buffer_u8);
			global.vz = buffer_read(buffer, buffer_u8);
			global.vr = buffer_read(buffer, buffer_u8);
			global.controlledDashAim = buffer_read(buffer, buffer_u8);
		break;
		case UPDATE_PLAYER_COLOR_ALL:
			global.plyrColors[0] = buffer_read(buffer, buffer_u8);
			global.plyrColors[1] = buffer_read(buffer, buffer_u8);
			global.plyrColors[2] = buffer_read(buffer, buffer_u8);
			global.plyrColors[3] = buffer_read(buffer, buffer_u8);
		break;
		case BOTBALL_SPAWN:
			if (instance_exists(obj_botball)) {
				with (obj_botball) { instance_destroy(); }
			}
			
			var targetPlayerId = buffer_read(buffer, buffer_u8);
			if (targetPlayerId < 0) {
				instance_create_depth(room_width/2, 0, depth, obj_botball);
			} else {
				var dropX = room_width/2;
				var stillFinding = true;
				with (obj_player) {
					if (playerId == targetPlayerId && stillFinding) {
						dropX = x;
						stillFinding = false;
					}
				}
				instance_create_depth(dropX, 0, depth, obj_botball);
			}
		break;
		case WE_ARE_IN_FACT_CONNECTED:
			areWeConnectedCount = max(0, areWeConnectedCount-2);
			areWeConnectedTimeMax = max(areWeConnectedTime, areWeConnectedTimeMax/2);
			areWeConnectedTime = 0;
		break;
	}
}