/// @description Spawn powerups

if (global.canSpawnPowerups && (!instance_exists(obj_Client) || instance_exists(obj_Server))) {
	//var selectedPowerIndex = irandom_range(0, array_length(global.powerups)-1);
	var mostLeft = x-(room_width/2)+64;
	var mostRight = x+(room_width/2)-64;
	var decidedX = random_range(mostLeft, mostRight);
	var decidedY = -room_height;
	if (instance_exists(obj_screenizer_start)) {mostLeft = obj_screenizer_start.x}
	if (instance_exists(obj_screenizer_end)) {mostRight = obj_screenizer_end.x}	
	
	if (instance_exists(obj_Server)) {
		with (obj_Server) {
			var buffer = buffer_create(2048, buffer_grow, 1);
			buffer_seek(buffer, buffer_seek_start, 0);
			buffer_write(buffer, buffer_u8, POWERUP_SPAWN);
			buffer_write(buffer, buffer_u8, decidedX);
			buffer_write(buffer, buffer_u8, decidedY);
			buffer_write(buffer, buffer_u8, selectedPowerIndex);
			for (var s=0; s<ds_list_size(sockets); s++) {
				network_send_packet(sockets[|s], buffer, buffer_tell(buffer));
			}
		}
	} else {
		instance_create_depth(decidedX, decidedY, depth, obj_powerup/*global.powerups[selectedPowerIndex]*/);
	}
}
if (global.debugMode) {
	alarm[1] = irandom_range(sec*1, sec*2);
} else {
	alarm[1] = irandom_range(sec*10, sec*20);
}