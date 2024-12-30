global.devices = [
	"Keyboard", "KeyboardWASD", "KeyboardZQSD", "KeyboardIJKL",
	"Controller1", "Controller2", "Controller3", "Controller4",
	"CPU", "DUM", "NotConnected",
	"Online0", "Online1", "Online2", "Online3"
];
global.deviceSprites= [
	spr_keyboard, spr_keyboard_wasd, spr_keyboard_zqsd, spr_keyboard_ijkl,
	spr_controller, spr_controller, spr_controller, spr_controller,
	spr_cpu, spr_dummy, spr_not_playing,
	spr_online_server, spr_online_client, spr_online_client, spr_online_client
];
global.plyrDevices = [0, 1, 4, 5];//default controls

//playerID - keyID - direct/pressed/released
global.plyrInputs = [
	[									
		[false, false, false],
		[false, false, false],
		[false, false, false],
		[false, false, false],
		[false, false, false],
	],
	[
		[false, false, false],
		[false, false, false],
		[false, false, false],
		[false, false, false],
		[false, false, false],
	],
	[
		[false, false, false],
		[false, false, false],
		[false, false, false],
		[false, false, false],
		[false, false, false],
	],
	[
		[false, false, false],
		[false, false, false],
		[false, false, false],
		[false, false, false],
		[false, false, false],
	],
];

global.onlineAppetiser = [
	[false, false, false, false, false],
	[false, false, false, false, false],
	[false, false, false, false, false],
	[false, false, false, false, false]
];

global.anyPlyrInputs = [
	[
		global.plyrInputs[0][0][0] || global.plyrInputs[1][0][0] || global.plyrInputs[2][0][0] || global.plyrInputs[3][0][0],
		global.plyrInputs[0][0][1] || global.plyrInputs[1][0][1] || global.plyrInputs[2][0][1] || global.plyrInputs[3][0][1],
		global.plyrInputs[0][0][2] || global.plyrInputs[1][0][2] || global.plyrInputs[2][0][2] || global.plyrInputs[3][0][2],
	],
	[
		global.plyrInputs[0][1][0] || global.plyrInputs[1][1][0] || global.plyrInputs[2][1][0] || global.plyrInputs[3][1][0],
		global.plyrInputs[0][1][1] || global.plyrInputs[1][1][1] || global.plyrInputs[2][1][1] || global.plyrInputs[3][1][1],
		global.plyrInputs[0][1][2] || global.plyrInputs[1][1][2] || global.plyrInputs[2][1][2] || global.plyrInputs[3][1][2],
	],
	[
		global.plyrInputs[0][2][0] || global.plyrInputs[1][2][0] || global.plyrInputs[2][2][0] || global.plyrInputs[3][2][0],
		global.plyrInputs[0][2][1] || global.plyrInputs[1][2][1] || global.plyrInputs[2][2][1] || global.plyrInputs[3][2][1],
		global.plyrInputs[0][2][2] || global.plyrInputs[1][2][2] || global.plyrInputs[2][2][2] || global.plyrInputs[3][2][2],
	],
	[
		global.plyrInputs[0][3][0] || global.plyrInputs[1][3][0] || global.plyrInputs[2][3][0] || global.plyrInputs[3][3][0],
		global.plyrInputs[0][3][1] || global.plyrInputs[1][3][1] || global.plyrInputs[2][3][1] || global.plyrInputs[3][3][1],
		global.plyrInputs[0][3][2] || global.plyrInputs[1][3][2] || global.plyrInputs[2][3][2] || global.plyrInputs[3][3][2],
	],
	[
		global.plyrInputs[0][4][0] || global.plyrInputs[1][4][0] || global.plyrInputs[2][4][0] || global.plyrInputs[3][4][0],
		global.plyrInputs[0][4][1] || global.plyrInputs[1][4][1] || global.plyrInputs[2][4][1] || global.plyrInputs[3][4][1],
		global.plyrInputs[0][4][2] || global.plyrInputs[1][4][2] || global.plyrInputs[2][4][2] || global.plyrInputs[3][4][2],
	]
];