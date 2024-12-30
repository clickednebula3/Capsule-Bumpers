if (forcePhaseChange > -1) {
	if (alarm[1] <= 0) {
		draw_sprite_ext(sprite_index, 1, x, y, 3, 3, 0, c_white, 0.7);
	} else {
		draw_sprite_ext(sprite_index, 1, x, y, 3, 3, 0, c_white, 0.1+(0.6*(alarm[1]<=sec)*(1-(alarm[1]/sec))));
	}
}

draw_sprite_ext(sprite_index, 1, x, y, 25*alarm[0]/alertTime, 25*alarm[0]/alertTime, 5*sin(20*alarm[0]), c_white, alarm[0]-0.2);