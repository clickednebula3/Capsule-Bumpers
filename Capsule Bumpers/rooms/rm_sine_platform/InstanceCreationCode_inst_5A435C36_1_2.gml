timer = 90;
leftOrRight = irandom_range(0, 1);

function myStep() {
	if (instance_exists(obj_control) && obj_control.alarm[3] <= 0) {
		image_angle += dsin(timer)/4;
		timer += leftOrRight + (leftOrRight-1);
	}
}