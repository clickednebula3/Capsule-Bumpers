if (instance_exists(obj_menu) && visible) {
	if (global.anyPlyrInputs[4][1] && myMenuSelectionID == obj_menu.selectedButtonID) {
		if (myValue == "Music") {
			global.music = !global.music;
		} else if (myValue == "Sounds") {
			global.sounds = !global.sounds;
		} else if (myValue == "Spawn Powers") {
			global.canSpawnPowerups = !global.canSpawnPowerups;
		} else if (myValue == "Controlled Dash Aim") {
			global.controlledDashAim = !global.controlledDashAim;
		} else if (myValue == "Cycle Through Maps") {
			global.mapCycleMode = !global.mapCycleMode;
		}
	}
}