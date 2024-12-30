originRadius = (32*3) + irandom_range(0, 16);
myColor = c_white;
myAlpha = random_range(0.5, 0.8);

var isLeftTurn = irandom_range(0, 1);
rotationSpeed = random_range(3, 6) * ((2*isLeftTurn)-1);

image_index = irandom_range(0, sprite_get_number(sprite_index)-1);
image_angle = irandom_range(0, 360);
alarm[0] = sec * random_range(0.5, 2);