if (death_enabled) {
	draw_set_color(c_red);
	draw_line_width(x, -2*room_height, x, 3*room_height, 5);
}
if (warp_enabled) {
	draw_set_color(c_aqua);
	draw_line_width(x, -2*room_height, x, 3*room_height, 5);
}

if (death_bottom && alarm[0] <= sec && alarm[0] > 0) {
	//SUDDENLY: DEATH
	draw_set_color(c_red);
	draw_set_font(fnt_big);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	var timeSpareChange = ((alarm[0]/sec)%1);
	draw_set_alpha(timeSpareChange);
	draw_text_transformed(room_width/2, room_height/2, "SUDDEN DEATH", 1/timeSpareChange, 1/timeSpareChange, 0);
}
if (draw_lava) {
	//draw_set_color(c_red);
	//draw_line_width(-2*room_width, y, 3*room_width, y, 5);
	time = DrawLava(time, lava_radius, 2, 1, -2*room_width, 3*room_width, y, 3*room_height);
	if (sudden_death) { time+=0.6; }
	//time++;
	//var lava_speed = 2;
	//var particle_speed = 1;
	//draw_set_alpha(1);
	
	//var deep_lava_color = make_color_rgb(158, 31, 11);
	//draw_set_color(deep_lava_color);
	//draw_rectangle(-2*room_width, y+(lava_radius*-dsin(lava_speed*time)), 3*room_width, 3*room_height, false);

	//for (var i=-2*room_width; i<3*room_width; i+=64)
	//{ draw_sprite(spr_lava, 1, i+(lava_radius*dcos(lava_speed*time))+((lava_speed*time)%64), y-16+(lava_radius*-dsin(lava_speed*time))); }
	
	//for (var i=-2*room_width; i<3*room_width; i+=64) {
	//	draw_set_alpha(1- ( ((particle_speed*time)%128) / 128) );
	//	draw_sprite(spr_lava, 2, i, y+32-((particle_speed*time)%128));
		
	//	draw_set_alpha(1- ( (((particle_speed*time)+64)%128) / 128) );
	//	draw_sprite(spr_lava, 2, i, y+32-(((particle_speed*time)+64)%128));
	//	draw_set_alpha(1);
	//}
	
	//var lava_color = make_color_rgb(238, 55, 27);
	//draw_set_color(lava_color);
	//draw_rectangle(-2*room_width, y+16+(lava_radius*-dsin((lava_speed*time)+90)), 3*room_width, 3*room_height, false);
	
	//for (var i=-2*room_width; i<3*room_width; i+=64)
	//{ draw_sprite(spr_lava, 0, i+(lava_radius*dcos(lava_speed*time+90))+((lava_speed*time)%64), y+(lava_radius*-dsin((lava_speed*time)+90))); }
}