/// @description Online syncronisation

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
		//update scores
		var bufferScores = buffer_create(2048, buffer_grow, 1);
		buffer_seek(bufferScores, buffer_seek_start, 0);
		buffer_write(bufferScores, buffer_u8, UPDATE_SCORES);
		buffer_write(bufferScores, buffer_u8, global.wins[0]);
		buffer_write(bufferScores, buffer_u8, global.wins[1]);
		buffer_write(bufferScores, buffer_u8, global.wins[2]);
		buffer_write(bufferScores, buffer_u8, global.wins[3]);
		for (var s=0; s<ds_list_size(sockets); s++) {
			network_send_packet(sockets[|s], bufferScores, buffer_tell(bufferScores));
		}
		
		//check for map perminance
		var selectedMapIndex = -1;
		for (var m=0; m<array_length(global.mapRooms); m++) {
			if (room == global.mapRooms[m]) { selectedMapIndex = m; break; }
		}
		if (selectedMapIndex != -1) {
			var bufferMapCheck = buffer_create(2048, buffer_grow, 1);
			buffer_seek(bufferMapCheck, buffer_seek_start, 0);
			buffer_write(bufferMapCheck, buffer_u8, MAP_CHECK);
			buffer_write(bufferMapCheck, buffer_u8, selectedMapIndex);
			for (var i=0; i<ds_list_size(sockets); i++) {
				network_send_packet(sockets[|i], bufferMapCheck, buffer_tell(bufferMapCheck));
			}
		}
		//check for player location perminance
		//check for player powerup perminance
		var alive = [false, false, false, false];
		var plyrscoords = [[0, 0], [0, 0], [0, 0], [0, 0]];
		var plyrjetpacks = [0, 0, 0, 0];
		var plyrpowerbumps = [false, false, false, false];
		var plyrbulletcount = [0, 0, 0, 0];
		var plyrslowmotiontime = [0, 0, 0, 0];
			//get player statuses
		for (var p=0; p<4; p++) {
			with(obj_player) {
				if (playerId == p) {
					plyrscoords[p][0] = x - obj_anchor.x;
					plyrscoords[p][1] = y - obj_anchor.y;
					plyrjetpacks[p] = jetpackFuel;
					plyrpowerbumps[p] = hasPowerBump;
					plyrbulletcount[p] = bulletCount;
					plyrslowmotiontime[p] = slowMotionTime;
					alive[p] = true;
				}
			}
		}
			//send statuses to players
		for (var p=0; p<4; p++) {
			if (alive[p]) {
				var bufferCoord = buffer_create(2048, buffer_grow, 1);
				buffer_seek(bufferCoord, buffer_seek_start, 0);
				buffer_write(bufferCoord, buffer_u8, FIX_PLAYER_DATA);
				buffer_write(bufferCoord, buffer_u8, p);
				buffer_write(bufferCoord, buffer_u8, plyrscoords[p][0]);
				buffer_write(bufferCoord, buffer_u8, plyrscoords[p][1]);
				buffer_write(bufferCoord, buffer_u8, plyrjetpacks[p]);
				buffer_write(bufferCoord, buffer_u8, plyrpowerbumps[p]);
				buffer_write(bufferCoord, buffer_u8, plyrbulletcount[p]);
				buffer_write(bufferCoord, buffer_u8, plyrslowmotiontime[p]);
				for (var s=0; s<ds_list_size(sockets); s++) {
					network_send_packet(sockets[|s], bufferCoord, buffer_tell(bufferCoord));
				}
				
			} else {
				var bufferKill = buffer_create(2048, buffer_grow, 1);
				buffer_seek(bufferKill, buffer_seek_start, 0);
				buffer_write(bufferKill, buffer_u8, KILL_PLAYER_ID);
				buffer_write(bufferKill, buffer_u8, p);
				for (var s=0; s<ds_list_size(sockets); s++) {
					network_send_packet(sockets[|s], bufferKill, buffer_tell(bufferKill));
				}
			}
		}
		//check for powerup perminance
	}
}

alarm[2] = sec/2;