if (instance_exists(obj_menu) && visible) {
	if (obj_menu.selectedButtonID == 0) {
		if (global.anyPlyrInputs[4][2] && image_index == 2) {
			if (string_length(global.username) <= 0) {
				var notNames = ["YouCantReadThis","No","Invisible","Air","Void","YouCantSeeMe","JohnCena","...","Gust"/*like guest*/,"Disconnected","WhoAreWeTalkingAboutAgain?"];
				global.username = notNames[irandom_range(0, array_length(notNames)-1)];
			}
			if (string_length(global.ipaddress) <= 0) {
				global.ipaddress = "127.0.0.1";
			}
			if (obj_menu.menuMode == 4) {
				with(obj_menu) {
					menuMode = 3;
					event_user(0);
				}
			} else if (obj_menu.menuMode == 5) {
				with(obj_menu) {
					instance_create_depth(0, 0, depth, obj_Client);
					menuMode = 6;
					event_user(0);
				}
			} else {
				with(obj_menu) {
					menuMode = 0;
					event_user(0);
				}
			}
		}
		if (global.anyPlyrInputs[4][1]) {
			image_index = 2;
		} else if (!global.anyPlyrInputs[4][0] || image_index == 0) {
			image_index = 1;
		}
	} else {
		image_index = 0;
	}
}