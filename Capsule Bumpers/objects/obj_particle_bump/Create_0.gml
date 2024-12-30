speed = irandom_range(6, 16);
direction = 90 + irandom_range(-45, 45);
image_index = irandom_range(0, sprite_get_number(sprite_index)-1);
alarm[0] = irandom_range(sec/8, sec/2);
gravity = 0.6;
image_xscale = random_range(0.5, 2.5);
image_yscale = random_range(0.5, 2.5);