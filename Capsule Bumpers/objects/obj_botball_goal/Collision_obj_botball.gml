if (myTeamId != -1 && other.lastBumperId != -1 && other.lastBumperId != myTeamId && other.lastBumperId != myTeamId2) {
	//close for gravity
	other.gravity_direction = point_direction(other.x, other.y, x, y);
	other.gravity = 2;
	other.alarm[0] = sec/3;
	
	if (point_distance(other.x, other.y, x, y) < goalRadius) {
		//Win for team
		other.x = x;
		other.y = y;
		other.vspeed = 0;
		other.hspeed = 0;
		other.gravity = 0;
		//other.cameraFollows = false; //uncomment if you don't really care about looking at the goal.
		var safeIndex = other.lastBumperId;
		if (instance_exists(obj_player)) {
			with (obj_player) {
				if (playerId != safeIndex) { instance_destroy(); }
			}
		}
	}
}