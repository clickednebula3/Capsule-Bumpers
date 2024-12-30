draw_set_color(c_white);

draw_self();

var value = ((bbox_right-bbox_left))/2;
var chosenSlide;
if (myValue == "hf") {
	chosenSlide = global.hf;
} else if (myValue == "hz") {
	chosenSlide = global.hz;
} else if (myValue == "hr") {
	chosenSlide = global.hr;
} else if (myValue == "vf") {
	chosenSlide = global.vf;
} else if (myValue == "vz") {
	chosenSlide = global.vz;
} else if (myValue == "vr") {
	chosenSlide = global.vr;
} else if (myValue == "Screen Wobblablity") {
	chosenSlide = global.wobbleness/5;
} else if (myValue == "Screen Smoothness") {
	chosenSlide = global.smoothness/5;
} else {
	chosenSlide = 0;
}
value *= chosenSlide;
draw_sprite(spr_menu_sliderbox, myMenuSelectionID == obj_menu.selectedButtonID, bbox_left+value, y);

if (myMenuSelectionID == obj_menu.selectedButtonID) {
	draw_set_color(c_aqua);
} else {
	draw_set_color(c_white);
}
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_set_font(fnt_smol);
if (myValue == "Screen Wobblablity" || myValue == "Screen Smoothness") {
	draw_text(bbox_left-48, y, string(myValue)+":");
} else {
	draw_text(bbox_left-48, y, "Physics "+string(myValue)+":");
}
draw_set_halign(fa_center);
draw_text(bbox_left+value, bbox_bottom+16, string(chosenSlide));