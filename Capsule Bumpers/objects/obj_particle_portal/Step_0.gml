image_angle += rotationSpeed;

if (instance_exists(myParent)) {
	x = myParent.x + (originRadius*dcos(image_angle));
	y = myParent.y + (originRadius*-dsin(image_angle));
}

if (alarm[0] > 1) {
	image_xscale = (1 - (1/alarm[0]));
	image_yscale = (1 - (1/alarm[0]));
}