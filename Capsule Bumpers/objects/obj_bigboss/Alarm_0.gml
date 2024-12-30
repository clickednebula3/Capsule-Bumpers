/// @description Select target

var allBossPoints = [];

with(obj_bosspoint) { array_push(allBossPoints, self); }

if (array_length(allBossPoints) > 0) {
	targetBossPoint = allBossPoints[irandom_range(0, array_length(allBossPoints)-1)];
}

alarm[1] = waitBeforeTargetMovingTime;