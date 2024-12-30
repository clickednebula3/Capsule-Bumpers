/// @description Are We Connected Ping

if (areWeConnectedCount > areWeConnectedDisconnectionLimit) {
	show_message("Disconnected.\nSent "+string(areWeConnectedDisconnectionLimit)+" pings that the server has not responded to.");
	game_restart();
}

areWeConnectedCount += 1;

var areWeConnectedBro = buffer_create(2048, buffer_grow, 1);
buffer_seek(areWeConnectedBro, buffer_seek_start, 0);
buffer_write(areWeConnectedBro, buffer_u8, ARE_WE_CONNECTED);
network_send_packet(client, areWeConnectedBro, buffer_tell(areWeConnectedBro));

if (!instance_exists(obj_Server)) {
	alarm[1] = global.clientAreWeConnectedFreakoutTimer;
}