/// @description Delayed client creation (to set ip)

var timeout_milliseconds = 5000;
network_set_config(network_config_connect_timeout, timeout_milliseconds);
client = network_create_socket(network_socket_tcp);
network_connect(client, ip, port);

if (client < 0) {
	show_message("Error creating client.");
	game_restart();
}

global.plyrDevices = [11, 12, 13, 14]; //set controls to Online0-3

if (!instance_exists(obj_Server)) {
	alarm[1] = global.clientAreWeConnectedFreakoutTimer;
}
//communicators = ds_map_create();
//var myCommunicator = instance_create_depth(x, y, depth, obj_Communicator);
//ds_map_add(communicators, idd, myCommunicator);