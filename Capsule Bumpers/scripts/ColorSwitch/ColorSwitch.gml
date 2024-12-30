function ColorSwitch(playerId = 0) {
	playerId = clamp(playerId, 0, 3);
	//find player color
	var plyrColorId = global.plyrColors[playerId];
	
	var canProceed = -20; //limit so it doesn't loop infinitely
	while (canProceed < 0) {
		//get next color
		plyrColorId+=1;
		if (plyrColorId >= array_length(global.allColors)) { plyrColorId = 0; }
		//check if any player has it
		var nobodyHasThisColor = true;
		for (var i=0; i<array_length(global.plyrColors); i++) {
			//cpu and dum can have same color fine
			if (plyrColorId == global.plyrColors[i] && !((global.devices[global.plyrDevices[playerId]] == "CPU" || global.devices[global.plyrDevices[playerId]] == "DUM") && global.devices[global.plyrDevices[i]] == "CPU")) {
				nobodyHasThisColor = false;
				break;
			}
		}
		if (nobodyHasThisColor) {
			global.plyrColors[playerId] = plyrColorId;
			canProceed = 1;
		}
		canProceed+=1;
	}
}