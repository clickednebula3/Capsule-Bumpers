if (instance_exists(obj_menu) && visible) {
	if (obj_menu.selectedButtonID == 2) {
		if (global.anyPlyrInputs[4][2] && image_index == 2) {
			with(obj_menu) {
				menuMode = 1;
				event_user(0);
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