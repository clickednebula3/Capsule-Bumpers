var n = 0.35;
for (var i= -3; i<6; i++) {
	draw_sprite_ext(
		sprite_index, image_index,
		(sprite_width*i) + (((n*x)+obj_control.x)/(n+1)), ((n*y)+obj_control.y)/(n+1),
		image_xscale, image_yscale, image_angle, c_white, 101/255
	);
}