/// @description Kill unused online players

var possibleKillId = playerId;
if (instance_exists(obj_Server)) {
	with (obj_Server) {
		if (!connections[possibleKillId]) {
			var buffer = buffer_create(2048, buffer_grow, 1);
			buffer_seek(buffer, buffer_seek_start, 0);
			buffer_write(buffer, buffer_u8, KILL_PLAYER_ID);
			buffer_write(buffer, buffer_u8, possibleKillId);
			for (var s=0; s<ds_list_size(sockets); s++) {
				network_send_packet(sockets[|s], buffer, buffer_tell(buffer));
			}
		}
	}
}