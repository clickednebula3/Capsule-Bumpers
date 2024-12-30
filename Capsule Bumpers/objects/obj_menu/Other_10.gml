/// @description Show Menu Items

for (var i=0; i<array_length(menuItems); i++) {
	for (var j=0; j<array_length(menuItems[i]); j++) {
		if (i == menuMode) {
			menuItems[i][j].visible = true;
		} else {
			menuItems[i][j].visible = false;
		}
	}
}

selectedButtonID = 0;
if (menuMode == 2 || menuMode == 3) { selectedButtonID = 1; }