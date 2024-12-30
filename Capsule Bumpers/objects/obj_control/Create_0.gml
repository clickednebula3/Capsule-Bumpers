averageX = 0;
averageY = 0;

//diffXMin = 0;
//diffXMax = 0;
//diffYMin = 0;
//diffYMax = 0;
//diffMin = 0;
//diffMax = 0;

roundWon = false;
//global.canSpawnPowerups = true;
if (room != rm_jetpack_zone) {alarm[1] = 5;}

canceledAutoRestart = false;
heightToWidthRatio = room_height/room_width; //const

view_enabled = true;
view_visible[0] = true;

//camera
myCameraView = 0;
myCamera = camera_create_view(0, 0, room_width, room_height, 0);
view_set_camera(myCameraView, myCamera);

//viewPort
//view_xport[0] = 0; deprecated
view_set_xport(myCameraView, 0);
view_wport[0] = room_width;
depth = -9999;

function escape() {
	if (instance_exists(obj_Client) && !instance_exists(obj_Server)) {
		instance_destroy(obj_Client);
		room_goto(rm_menu);
	} else if (instance_exists(obj_Server)) {
		with (obj_Server) {
			var buffer = buffer_create(2048, buffer_grow, 1);
			buffer_seek(buffer, buffer_seek_start, 0);
			buffer_write(buffer, buffer_u8, MAP_STOP_ALL);
			for (var i=0; i<ds_list_size(sockets); i++) {
				network_send_packet(sockets[|i], buffer, buffer_tell(buffer));
			}
		}
	} else {
		room_goto(rm_menu);
	}
}

function restart() {
	if (instance_exists(obj_Client) && !instance_exists(obj_Server)) {
		//cannot
	} else if (instance_exists(obj_Server)) {
		with (obj_Server) {
			var buffer = buffer_create(2048, buffer_grow, 1);
			buffer_seek(buffer, buffer_seek_start, 0);
			buffer_write(buffer, buffer_u8, MAP_RESTART);
			for (var i=0; i<ds_list_size(sockets); i++) {
				network_send_packet(sockets[|i], buffer, buffer_tell(buffer));
			}
		}
	} else {
		room_restart();
	}
}