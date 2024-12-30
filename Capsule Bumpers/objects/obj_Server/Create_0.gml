/// @description Initialize server

var port = 25567;
max_players = 4;
server = network_create_server(network_socket_tcp, port, max_players);

if (server < 0) {
	show_message("Error whilst creating server");
	game_restart();
}

clients = ds_map_create();
sockets = ds_list_create();

connections = [false, false, false, false];
usernames = ["Online0", "Online1", "Online2", "Online3"];

var connectSelf = instance_create_depth(x, y, depth, obj_Client);
connectSelf.ip = "127.0.0.1";


global.plyrDevices = [11, 12, 13, 14];//set controls to Online0-3