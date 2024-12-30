hspeed *= 0.95;


if (instance_exists(obj_screenizer_end)) {
	if (y > obj_screenizer_end.y && obj_screenizer_end.death_bottom) {
		if (!instance_exists(obj_Client) || instance_exists(obj_Server)) {
			var targetPlayerId = irandom_range(0, instance_number(obj_player)-1);
			var dropX = 0;
			if (instance_number(obj_player) > 0) {
				var stillFinding = true;
				with (obj_player) {
					if (playerId == targetPlayerId && stillFinding) {
						dropX = x;
						stillFinding = false;
					}
				}
			} else {
				dropX = room_width/2;
				targetPlayerId = -1;
			}
			instance_create_depth(dropX, 0, depth, object_index);
			if (instance_exists(obj_Server)) {
				//send botball creation packet
				var buffer = buffer_create(2048, buffer_grow, 1);
				buffer_seek(buffer, buffer_seek_start, 0);
				buffer_write(buffer, buffer_u8, BOTBALL_SPAWN);
				buffer_write(buffer, buffer_u8, targetPlayerId);
				for (var s=0; s<ds_list_size(obj_Server.sockets); s++) {
					network_send_packet(obj_Server.sockets[|s], buffer, buffer_tell(buffer));
				}
			}
			instance_destroy();
		}
	}
}