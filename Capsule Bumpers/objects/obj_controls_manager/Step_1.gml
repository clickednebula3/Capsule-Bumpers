for (var p=0; p<4; p++) {
	if (instance_exists(obj_Client) && obj_Client.client >= 0) {
		if (instance_exists(obj_menu)) { obj_menu.playerIsFound[p] = true; }
		global.plyrInputs[p] = [
			[global.onlineAppetiser[p][KEY_LEFT], false, false],
			[global.onlineAppetiser[p][KEY_RIGHT], false, false],
			[global.onlineAppetiser[p][KEY_UP], false, false],
			[global.onlineAppetiser[p][KEY_DOWN], false, false],
			[global.onlineAppetiser[p][KEY_DASH], false, false],
		];
	} else {
		if (global.devices[global.plyrDevices[p]] == "Keyboard")//arrow keys
		{
			if (instance_exists(obj_menu)) { obj_menu.playerIsFound[p] = true; }
			global.plyrInputs[p] = [
				[keyboard_check(vk_left), keyboard_check_pressed(vk_left), keyboard_check_released(vk_left)],
				[keyboard_check(vk_right), keyboard_check_pressed(vk_right), keyboard_check_released(vk_right)],
				[keyboard_check(vk_up), keyboard_check_pressed(vk_up), keyboard_check_released(vk_up)],
				[keyboard_check(vk_down), keyboard_check_pressed(vk_down), keyboard_check_released(vk_down)],
				[keyboard_check(vk_rshift), keyboard_check_pressed(vk_rshift), keyboard_check_released(vk_rshift)],
			];
		}
		else if (global.devices[global.plyrDevices[p]] == "KeyboardWASD")//wasd
		{
			if (instance_exists(obj_menu)) { obj_menu.playerIsFound[p] = true; }
			global.plyrInputs[p] = [
				[keyboard_check(ord("A")), keyboard_check_pressed(ord("A")), keyboard_check_released(ord("A")) ],
				[keyboard_check(ord("D")), keyboard_check_pressed(ord("D")), keyboard_check_released(ord("D")) ],
				[keyboard_check(ord("W")), keyboard_check_pressed(ord("W")), keyboard_check_released(ord("W")) ],
				[keyboard_check(ord("S")), keyboard_check_pressed(ord("S")), keyboard_check_released(ord("S")) ],
				[keyboard_check(vk_lshift), keyboard_check_pressed(vk_lshift), keyboard_check_released(vk_lshift)],
			];
		}
		else if (global.devices[global.plyrDevices[p]] == "KeyboardZQSD")//zqsd
		{
			if (instance_exists(obj_menu)) { obj_menu.playerIsFound[p] = true; }
			global.plyrInputs[p] = [
				[keyboard_check(ord("Q")), keyboard_check_pressed(ord("Q")), keyboard_check_released(ord("Q")) ],
				[keyboard_check(ord("D")), keyboard_check_pressed(ord("D")), keyboard_check_released(ord("D")) ],
				[keyboard_check(ord("Z")), keyboard_check_pressed(ord("Z")), keyboard_check_released(ord("Z")) ],
				[keyboard_check(ord("S")), keyboard_check_pressed(ord("S")), keyboard_check_released(ord("S")) ],
				[keyboard_check(vk_lshift), keyboard_check_pressed(vk_lshift), keyboard_check_released(vk_lshift)],
			];
		}
		else if (global.devices[global.plyrDevices[p]] == "KeyboardIJKL")//ijkl
		{
			if (instance_exists(obj_menu)) { obj_menu.playerIsFound[p] = true; }
			global.plyrInputs[p] = [
				[keyboard_check(ord("J")), keyboard_check_pressed(ord("J")), keyboard_check_released(ord("J")) ],
				[keyboard_check(ord("L")), keyboard_check_pressed(ord("L")), keyboard_check_released(ord("L")) ],
				[keyboard_check(ord("I")), keyboard_check_pressed(ord("I")), keyboard_check_released(ord("I")) ],
				[keyboard_check(ord("K")), keyboard_check_pressed(ord("K")), keyboard_check_released(ord("K")) ],
				[keyboard_check(vk_space), keyboard_check_pressed(vk_space), keyboard_check_released(vk_space)],
			];
		}
		else if (string_starts_with(global.devices[global.plyrDevices[p]], "Controller"))// controller 1-4
		{
			var myGP = global.plyrDevices[p]-4;
			var isConnected = gamepad_is_connected(myGP);
			if (instance_exists(obj_menu)) { obj_menu.playerIsFound[p] = isConnected; }
			if (isConnected) {
				global.plyrInputs[p] = [
					[
						gamepad_button_check(myGP, gp_padl) || gamepad_axis_value(myGP, gp_axislh) < -0.5,
						gamepad_button_check_pressed(myGP, gp_padl), gamepad_button_check_released(myGP, gp_padl)
					],
					[
						gamepad_button_check(myGP, gp_padr) || gamepad_axis_value(myGP, gp_axislh) > 0.5,
						gamepad_button_check_pressed(myGP, gp_padr), gamepad_button_check_released(myGP, gp_padr)
					],
					[
						gamepad_button_check(myGP, gp_padu) || gamepad_axis_value(myGP, gp_axislv) < -0.5 || gamepad_button_check(myGP, gp_face1) || gamepad_button_check(myGP, gp_face4),
						gamepad_button_check_pressed(myGP, gp_padu), gamepad_button_check_released(myGP, gp_padu)
					],
					[
						gamepad_button_check(myGP, gp_padd) || gamepad_axis_value(myGP, gp_axislv) > 0.5,
						gamepad_button_check_pressed(myGP, gp_padd), gamepad_button_check_released(myGP, gp_padd)
					],
					[
						gamepad_button_check(myGP, gp_shoulderrb) || gamepad_button_check(myGP, gp_face2) || gamepad_button_check(myGP, gp_face3),
						gamepad_button_check_pressed(myGP, gp_shoulderrb) || gamepad_button_check_pressed(myGP, gp_face2) || gamepad_button_check_pressed(myGP, gp_face3),
						gamepad_button_check_released(myGP, gp_shoulderrb) || gamepad_button_check_released(myGP, gp_face2) || gamepad_button_check_released(myGP, gp_face3)
					],
				];
			} else {
				global.plyrInputs[p] = [
					[false, false, false],
					[false, false, false],
					[false, false, false],
					[false, false, false],
					[false, false, false],
				];
			}
		}
		else //cpu or dummy or online
		{
			if (instance_exists(obj_menu)) { obj_menu.playerIsFound[p] = true; }
			global.plyrInputs[p] = [
				[false, false, false],
				[false, false, false],
				[false, false, false],
				[false, false, false],
				[false, false, false],
			];
		
		}
	}
}

//generally for menus
global.anyPlyrInputs = [
	[
		global.plyrInputs[0][0][0] || global.plyrInputs[1][0][0] || global.plyrInputs[2][0][0] || global.plyrInputs[3][0][0] || keyboard_check(vk_left) || keyboard_check(ord("A")) || keyboard_check(ord("J")) || keyboard_check(ord("Q")),
		global.plyrInputs[0][0][1] || global.plyrInputs[1][0][1] || global.plyrInputs[2][0][1] || global.plyrInputs[3][0][1] || keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")) || keyboard_check_pressed(ord("J")) || keyboard_check_pressed(ord("Q")),
		global.plyrInputs[0][0][2] || global.plyrInputs[1][0][2] || global.plyrInputs[2][0][2] || global.plyrInputs[3][0][2] || keyboard_check_released(vk_left) || keyboard_check_released(ord("A")) || keyboard_check_released(ord("J")) || keyboard_check_released(ord("Q")),
	],
	[
		global.plyrInputs[0][1][0] || global.plyrInputs[1][1][0] || global.plyrInputs[2][1][0] || global.plyrInputs[3][1][0] || keyboard_check(vk_right) || keyboard_check(ord("D")) || keyboard_check(ord("L")),
		global.plyrInputs[0][1][1] || global.plyrInputs[1][1][1] || global.plyrInputs[2][1][1] || global.plyrInputs[3][1][1] || keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")) || keyboard_check_pressed(ord("L")),
		global.plyrInputs[0][1][2] || global.plyrInputs[1][1][2] || global.plyrInputs[2][1][2] || global.plyrInputs[3][1][2] || keyboard_check_released(vk_right) || keyboard_check_released(ord("D")) || keyboard_check_released(ord("L")),
	],
	[
		global.plyrInputs[0][2][0] || global.plyrInputs[1][2][0] || global.plyrInputs[2][2][0] || global.plyrInputs[3][2][0] || keyboard_check(vk_up) || keyboard_check(ord("W")) || keyboard_check(ord("I")) || keyboard_check(ord("Z")),
		global.plyrInputs[0][2][1] || global.plyrInputs[1][2][1] || global.plyrInputs[2][2][1] || global.plyrInputs[3][2][1] || keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || keyboard_check_pressed(ord("I")) || keyboard_check_pressed(ord("Z")),
		global.plyrInputs[0][2][2] || global.plyrInputs[1][2][2] || global.plyrInputs[2][2][2] || global.plyrInputs[3][2][2] || keyboard_check_released(vk_up) || keyboard_check_released(ord("W")) || keyboard_check_released(ord("I")) || keyboard_check_released(ord("Z")),
	],
	[
		global.plyrInputs[0][3][0] || global.plyrInputs[1][3][0] || global.plyrInputs[2][3][0] || global.plyrInputs[3][3][0] || keyboard_check(vk_down) || keyboard_check(ord("S")) || keyboard_check(ord("K")),
		global.plyrInputs[0][3][1] || global.plyrInputs[1][3][1] || global.plyrInputs[2][3][1] || global.plyrInputs[3][3][1] || keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || keyboard_check_pressed(ord("K")),
		global.plyrInputs[0][3][2] || global.plyrInputs[1][3][2] || global.plyrInputs[2][3][2] || global.plyrInputs[3][3][2] || keyboard_check_released(vk_down) || keyboard_check_released(ord("S")) || keyboard_check_released(ord("K")),
	],
	[
		global.plyrInputs[0][4][0] || global.plyrInputs[1][4][0] || global.plyrInputs[2][4][0] || global.plyrInputs[3][4][0] || keyboard_check(vk_rshift) || keyboard_check(vk_lshift) || keyboard_check(vk_space),
		global.plyrInputs[0][4][1] || global.plyrInputs[1][4][1] || global.plyrInputs[2][4][1] || global.plyrInputs[3][4][1] || keyboard_check_pressed(vk_rshift) || keyboard_check_pressed(vk_lshift) || keyboard_check_pressed(vk_space),
		global.plyrInputs[0][4][2] || global.plyrInputs[1][4][2] || global.plyrInputs[2][4][2] || global.plyrInputs[3][4][2] || keyboard_check_released(vk_rshift) || keyboard_check_released(vk_lshift) || keyboard_check_released(vk_space),
	]
];

if (instance_exists(obj_Client) && obj_Client.client >= 0) {
	//problem with this code is that it takes what it got online and sends it again
	//global.plyrInputs[global.myOnlineId][KEY_LEFT][0]	= global.anyPlyrInputs[KEY_LEFT][0];
	//global.plyrInputs[global.myOnlineId][KEY_RIGHT][0]	= global.anyPlyrInputs[KEY_RIGHT][0];
	//global.plyrInputs[global.myOnlineId][KEY_UP][0]		= global.anyPlyrInputs[KEY_UP][0];
	//global.plyrInputs[global.myOnlineId][KEY_DOWN][0]	= global.anyPlyrInputs[KEY_DOWN][0];
	//global.plyrInputs[global.myOnlineId][KEY_DASH][0]	= global.anyPlyrInputs[KEY_DASH][0];
	
	//this is anyPlyrInputs again but just for _direct checks (no _pressed or _released)
	global.plyrInputs[global.myOnlineId][KEY_LEFT][0]	= keyboard_check(vk_left)   || keyboard_check(ord("A"))  || keyboard_check(ord("J")) || keyboard_check(ord("Q")) || gamepad_button_check(0, gp_padl) || gamepad_axis_value(0, gp_axislh) < -0.5;
	global.plyrInputs[global.myOnlineId][KEY_RIGHT][0]	= keyboard_check(vk_right)  || keyboard_check(ord("D"))  || keyboard_check(ord("L")) || gamepad_button_check(0, gp_padr) || gamepad_axis_value(0, gp_axislh) > 0.5;
	global.plyrInputs[global.myOnlineId][KEY_UP][0]		= keyboard_check(vk_up)	    || keyboard_check(ord("W"))  || keyboard_check(ord("I")) || keyboard_check(ord("Z")) || gamepad_button_check(0, gp_padu) || gamepad_axis_value(0, gp_axislv) < -0.5 || gamepad_button_check(0, gp_face1) || gamepad_button_check(0, gp_face4);
	global.plyrInputs[global.myOnlineId][KEY_DOWN][0]	= keyboard_check(vk_down)   || keyboard_check(ord("S"))  || keyboard_check(ord("K")) || gamepad_button_check(0, gp_padd) || gamepad_axis_value(0, gp_axislv) > 0.5;
	global.plyrInputs[global.myOnlineId][KEY_DASH][0]	= keyboard_check(vk_rshift) || keyboard_check(vk_lshift) || keyboard_check(vk_space) || keyboard_check(vk_enter) || gamepad_button_check(0, gp_shoulderrb) || gamepad_button_check(0, gp_face2) || gamepad_button_check(0, gp_face3);
	
	with(obj_Client) {
		var buffer = buffer_create(2048, buffer_grow, 1);
		buffer_seek(buffer, buffer_seek_start, 0);
		buffer_write(buffer, buffer_u8, KEY_UPDATE);
		buffer_write(buffer, buffer_u8, global.plyrInputs[global.myOnlineId][KEY_LEFT][0]);
		buffer_write(buffer, buffer_u8, global.plyrInputs[global.myOnlineId][KEY_RIGHT][0]);
		buffer_write(buffer, buffer_u8, global.plyrInputs[global.myOnlineId][KEY_UP][0]);
		buffer_write(buffer, buffer_u8, global.plyrInputs[global.myOnlineId][KEY_DOWN][0]);
		buffer_write(buffer, buffer_u8, global.plyrInputs[global.myOnlineId][KEY_DASH][0]);
		network_send_packet(client, buffer, buffer_tell(buffer));
	}
}