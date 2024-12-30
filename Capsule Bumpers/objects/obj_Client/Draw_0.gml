if (instance_exists(obj_menu) && obj_menu.menuMode == 6 && client >= 0) {
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	draw_text(8, 8, "Connected");
	for (var i=0; i<array_length(usernames); i++) {
		draw_text(8, 32+i*16, "("+string(i)+") "+usernames[i]);
	}
}

areWeConnectedTime++;
draw_text(room_width/2, room_height/2, string(areWeConnectedTimeMax));