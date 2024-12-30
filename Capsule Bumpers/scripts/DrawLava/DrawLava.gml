// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DrawLava(time, lava_radius, lava_speed, particle_speed, from_x, to_x, at_y, bottom_y) {
	draw_set_alpha(1);
	
	var deep_lava_color = make_color_rgb(158, 31, 11);
	draw_set_color(deep_lava_color);
	draw_rectangle(from_x, at_y+(lava_radius*-dsin(lava_speed*time)), to_x, bottom_y, false);

	for (var i=from_x; i<to_x; i+=64)
	{ draw_sprite(spr_lava, 1, i+(lava_radius*dcos(lava_speed*time))+((lava_speed*time)%64), at_y-16+(lava_radius*-dsin(lava_speed*time))); }
	
	for (var i=from_x; i<to_x; i+=64) {
		draw_set_alpha(1- ( ((particle_speed*time)%128) / 128) );
		draw_sprite(spr_lava, 2, i, at_y+32-((particle_speed*time)%128));
		
		draw_set_alpha(1- ( (((particle_speed*time)+64)%128) / 128) );
		draw_sprite(spr_lava, 2, i, at_y+32-(((particle_speed*time)+64)%128));
		draw_set_alpha(1);
	}
	
	var lava_color = make_color_rgb(238, 55, 27);
	draw_set_color(lava_color);
	draw_rectangle(from_x, at_y+16+(lava_radius*-dsin((lava_speed*time)+90)), to_x, bottom_y, false);
	
	for (var i=from_x; i<to_x; i+=64)
	{ draw_sprite(spr_lava, 0, i+(lava_radius*dcos(lava_speed*time+90))+((lava_speed*time)%64), at_y+(lava_radius*-dsin((lava_speed*time)+90))); }
	
	return time+1;
}