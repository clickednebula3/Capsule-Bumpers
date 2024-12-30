laser_passthrough_ground = true;

direction = 180;
image_angle = 180;

timer = 90*3;
function move() {
	if (instance_exists(obj_control) && obj_control.alarm[3] <= 0) {
		timer++;
		x += 4*dsin(timer/3);
	}
};

myStepOG = myStep;
myStep = function() {
	myStepOG();
	move();
}