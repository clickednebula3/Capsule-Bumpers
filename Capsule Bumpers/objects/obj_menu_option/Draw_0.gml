draw_set_color(c_white);

image_index = myMenuSelectionID == obj_menu.selectedButtonID;
draw_self();

var isOn = false;
if (myValue == "Music") {
	isOn = global.music;
} else if (myValue == "Sounds") {
	isOn = global.sounds;
} else if (myValue == "Spawn Powers") {
	isOn = global.canSpawnPowerups;
} else if (myValue == "Controlled Dash Aim") {
	isOn = global.controlledDashAim;
} else if (myValue == "Cycle Through Maps") {
	isOn = global.mapCycleMode;
}
draw_sprite(sprite_index, isOn+2, bbox_left+(isOn*(bbox_right-bbox_left)), y);

if (myMenuSelectionID == obj_menu.selectedButtonID) {
	draw_set_color(c_aqua);
} else {
	draw_set_color(c_white);
}
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
draw_set_font(fnt_smol);
draw_text(bbox_left-48, y, string(myValue)+":");