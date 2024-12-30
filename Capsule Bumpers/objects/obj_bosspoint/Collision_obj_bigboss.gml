if (forcePhaseChange > -1 && alarm[1] <= 0 && other.phase != forcePhaseChange) {
	other.phase = forcePhaseChange;
	alarm[0] = alertTime;
	alarm[1] = alertTime * 30;
}