draw_sprite_ext(sprite_index, 0, xprevious, yprevious, image_xscale, image_yscale, image_angle, make_color_rgb(0, 174, 240), 101/255);

draw_self();

if (lastBumperId>=0) {
	draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, image_angle, global.allColors[global.plyrColors[lastBumperId%4]], 1);
} else {
	draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, image_angle, c_black, 1);
}