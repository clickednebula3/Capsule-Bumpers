/// @description Map Restart
if (global.mapCycleMode) {
	//room_restart();
	//var mapIndex = -1;
	//for (var i=0; i<array_length(global.mapRooms); i++) {
	//	if (room_get_name(room) == room_get_name(global.mapRooms[i])) { mapIndex = i; break; }
	//}
	//if (mapIndex == -1) { room_restart(); }
	//else { room_goto(global.mapRooms[(mapIndex+1)%array_length(global.mapRooms)]); }
	var map_i = -1;
	for (var i=0; i<array_length(global.mapArenas); i++) {
		if (room_get_name(room) == room_get_name(global.mapArenas[i].room_)) { map_i = i; break; }
	}
	if (map_i == -1) { room_restart(); } else { global.mapArenas[(i+1)%array_length(global.mapArenas)].StartArena(); }
} else {
	room_restart();
}