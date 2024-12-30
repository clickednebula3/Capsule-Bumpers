image_xscale = 4;
image_yscale = 4;

selectTargetTime = 1*sec/2;
waitBeforeTargetMovingTime = sec;
moveTowardsTargetTime = sec;
changePhaseTime = 10*sec;

cameraFollows = true;
phase = 0;
spd = 10;
HP = 100;
Time = 0;
shield = 5;

iframes = 0;
iframesMax = sec/4;

targetBossPoint = noone;

alarm[0] = global.preGameStartTimer + sec;