if (instance_exists(obj_menu) && visible) {
	if (global.anyPlyrInputs[4][1] && myMenuSelectionID == obj_menu.selectedButtonID) {
		if (myValue == "hf") {
			global.hf += 0.25;
			if (global.hf > 2) {global.hf = 0;}
		} else if (myValue == "hz") {
			global.hz += 0.25;
			if (global.hz > 2) {global.hz = 0;}
		} else if (myValue == "hr") {
			global.hr += 0.25;
			if (global.hr > 2) {global.hr = 0;}
		} else if (myValue == "vf") {
			global.vf += 0.25;
			if (global.vf > 2) {global.vf = 0;}
		} else if (myValue == "vz") {
			global.vz += 0.25;
			if (global.vz > 2) {global.vz = 0;}
		} else if (myValue == "vr") {
			global.vr += 0.25;
			if (global.vr > 2) {global.vr = 0;}
		} else if (myValue == "Screen Wobblablity") {
			global.wobbleness += 1;
			if (global.wobbleness > 10) {global.wobbleness = 0;}
		} else if (myValue == "Screen Smoothness") {
			global.smoothness += 1;
			if (global.smoothness > 10) {global.smoothness = 0;}
		}
	}
}