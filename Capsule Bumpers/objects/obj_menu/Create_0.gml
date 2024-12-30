playerIsFound = [true, true, false, false];
playerSprite = [spr_keyboard, spr_keyboard_wasd, spr_controller, spr_controller];
LETTERS = "1234567890._-+"+"ABCDEFGHIJKLM~"+"NOPQRSTUVWXYZ@"+"abcdefghijklm "+"nopqrstuvwxyzX";//final X is for del
letterRow = 14;

depth++;

selectedButtonID = 0;
mapSelectionSlowValue = 0;
menuMode = 0; //"Main", "Settings", "Play (select map)", "Soon"
drawTimer = 0;
escapeHeld = 0;
escapeHeldMax = sec*3;

menuItems = [
	[
		instance_create_depth(room_width/4, 4.5*room_height/8, depth, obj_menu_play),
		instance_create_depth(room_width/4, 5.5*room_height/8, depth, obj_menu_online),
		instance_create_depth(room_width/4, 6.5*room_height/8, depth, obj_menu_sets),
		instance_create_depth(room_width/4, 6.5*room_height/8, depth, obj_menu_exit)
	],
	[
		instance_create_depth(7*room_width/9, 7*room_height/8, depth, obj_menu_back),
		
		instance_create_depth(6*room_width/7, 1.0*room_height/8, depth, obj_menu_slider),//wobble
		instance_create_depth(6*room_width/7, 1.5*room_height/8, depth, obj_menu_slider),//smoothness
		instance_create_depth(6*room_width/7, 2.0*room_height/8, depth, obj_menu_slider),//physics
		instance_create_depth(6*room_width/7, 2.5*room_height/8, depth, obj_menu_slider),
		instance_create_depth(6*room_width/7, 3.0*room_height/8, depth, obj_menu_slider),
		instance_create_depth(6*room_width/7, 3.5*room_height/8, depth, obj_menu_slider),
		instance_create_depth(6*room_width/7, 4.0*room_height/8, depth, obj_menu_slider),
		instance_create_depth(6*room_width/7, 4.5*room_height/8, depth, obj_menu_slider),
		
		instance_create_depth(2*room_width/5, 1.0*room_height/8, depth, obj_menu_option),//music
		instance_create_depth(2*room_width/5, 1.5*room_height/8, depth, obj_menu_option),//sounds
		instance_create_depth(2*room_width/5, 2.0*room_height/8, depth, obj_menu_option),//spawn powers
		instance_create_depth(2*room_width/5, 2.5*room_height/8, depth, obj_menu_option),//controlled dash aim
		instance_create_depth(2*room_width/5, 3.0*room_height/8, depth, obj_menu_option),//cycle through maps
		
	],
	[
		instance_create_depth(7*room_width/9, 7*room_height/8, depth, obj_menu_back),
	],
	[
		instance_create_depth(7*room_width/9, 7*room_height/8, depth, obj_menu_back),//online: select server/client
	],
	[
		instance_create_depth(7*room_width/9, 7*room_height/8, depth, obj_menu_back),//online: enter username
	],
	[
		instance_create_depth(7*room_width/9, 7*room_height/8, depth, obj_menu_back),//client: enter ip
	],
	[
		instance_create_depth(7*room_width/9, 7*room_height/8, depth, obj_menu_back),//online main menu
	]
];


//sliders
menuItems[1][1].myValue = "Screen Wobblablity";
menuItems[1][2].myValue = "Screen Smoothness";
menuItems[1][3].myValue = "hf";
menuItems[1][4].myValue = "hz";
menuItems[1][5].myValue = "hr";
menuItems[1][6].myValue = "vf";
menuItems[1][7].myValue = "vz";
menuItems[1][8].myValue = "vr";

slidersEndAt = 8;//make sure to update this when adding sliders

for (var i = 1; i <= slidersEndAt; i++) {
	menuItems[1][i].myMenuSelectionID = slidersEndAt+1-i;
}

menuItems[1][9].myValue = "Music";//Do not change without accounting for it in obj_menu_option
menuItems[1][10].myValue = "Sounds";
menuItems[1][11].myValue = "Spawn Powers";
menuItems[1][12].myValue = "Controlled Dash Aim";
menuItems[1][13].myValue = "Cycle Through Maps";

for (var i = slidersEndAt+1; i < array_length(menuItems[1]); i++) {
	menuItems[1][i].myMenuSelectionID = i;
}

event_user(0);

lava_time = 0;