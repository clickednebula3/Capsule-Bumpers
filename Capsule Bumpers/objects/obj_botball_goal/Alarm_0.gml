/// @description Spawn particle
if (myTeamId != -1) {
	var myId = myTeamId;
	var canDrawParticles = false;
	if (instance_exists(obj_player)) {
		with (obj_player) {
			if (playerId == myId) { canDrawParticles = true; }
		}
	}
	if (canDrawParticles) {
		var myParticle = instance_create_depth(x, y, depth, obj_particle_portal);
		myParticle.myParent = self;
		myParticle.myColor = global.allColors[global.plyrColors[myTeamId%4]];
	}
}

if (myTeamId2 != -1) {
	var myId = myTeamId2;
	var canDrawParticles = false;
	if (instance_exists(obj_player)) {
		with (obj_player) {
			if (playerId == myId) { canDrawParticles = true; }
		}
	}
	if (canDrawParticles) {
		var myParticle = instance_create_depth(x, y, depth, obj_particle_portal);
		myParticle.myParent = self;
		myParticle.myColor = global.allColors[global.plyrColors[myTeamId2%4]];
	}
}

alarm[0] = irandom_range(1, 10);