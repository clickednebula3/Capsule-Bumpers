if (instance_exists(obj_menu) && obj_menu.menuMode == 6) {
	var player_count = ds_list_size(sockets);

	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	if (player_count > 0) {
		draw_text(8, 8, "Connections: "+string(player_count));
		for (var i=0; i<array_length(usernames); i++) {
			if (connections[i]) {
				draw_text(8, 32+i*16, "("+string(i)+") "+usernames[i]);
			}
		}
	}
}
