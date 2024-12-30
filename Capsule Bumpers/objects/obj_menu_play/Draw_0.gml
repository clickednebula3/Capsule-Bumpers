draw_self();

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_smol);
if (instance_exists(obj_Client) && !instance_exists(obj_Server)) {
	draw_text(x, y+36, "Awaiting Game...");
} else {
	draw_text(x, y+36, "Play");
}