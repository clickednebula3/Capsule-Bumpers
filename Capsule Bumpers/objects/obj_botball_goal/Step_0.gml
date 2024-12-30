image_angle += myTurnSpeed;
image_xscale = myImageScale;
image_yscale = myImageScale;

myTurnSpeed += random_range(-0.05, 0.05);
myTurnSpeed = clamp(myTurnSpeed, goasOppositeWay*3, goasOppositeWay*6);

myImageScale += random_range(-0.01, 0.01);
myImageScale = clamp(myImageScale, 3.75, 4.25);