if (instance_exists(obj_Client)) {
	var myUsername = obj_Client.usernames[playerId];
	var barWidth = 224;
	
	draw_set_alpha(0.5);
	draw_set_color(c_black);
	draw_rectangle(x+hspeed-(barWidth/2), bbox_top-32-16, x+hspeed+(barWidth/2), bbox_top-32+16, false);
	
	draw_set_color(global.allColors[global.plyrColors[playerId]]);
	draw_set_alpha(0.7);
	draw_set_font(fnt_smol);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(x+hspeed, bbox_top-32+4, myUsername);
}

draw_Capsule();

if (showHands) {
	draw_sprite(spr_player_hands, 0, x, y-sprite_height);
	showHands = false;
}

if (abs(hspeed) > 0.01) {
	draw_set_color(c_white);
	if (hasPowerBump) {draw_set_color(c_black);}
	draw_arrow(
		(bbox_left+((bbox_right-bbox_left)/2)) - (4*(abs(hspeed)/hspeed)) + (0.4*hspeed), bbox_top+((bbox_bottom-bbox_top)/2),
		(bbox_left+((bbox_right-bbox_left)/2)) + (4*(abs(hspeed)/hspeed)) + (0.4*hspeed),  bbox_top+((bbox_bottom-bbox_top)/2), 20);
}