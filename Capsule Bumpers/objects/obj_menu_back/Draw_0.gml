draw_self();

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_smol);
if (instance_exists(obj_menu) && (obj_menu.menuMode == 4 || obj_menu.menuMode == 5)) {
	draw_text(bbox_left+((bbox_right-bbox_left)/2), y+36, "Done");
} else {
	draw_text(bbox_left+((bbox_right-bbox_left)/2), y+36, "Back");
}