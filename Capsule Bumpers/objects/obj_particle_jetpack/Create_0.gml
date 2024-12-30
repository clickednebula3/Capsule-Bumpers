speed = irandom_range(4, 8);
direction = 270 + irandom_range(-10, 10);
image_index = irandom_range(0, sprite_get_number(sprite_index)-1);
alarm[0] = irandom_range(sec/2, sec*2);