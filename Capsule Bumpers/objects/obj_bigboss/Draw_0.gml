if (instance_exists(targetBossPoint)) {
	draw_set_color(c_red);
	if (alarm[1] > 0) { draw_line(x, y, targetBossPoint.x, targetBossPoint.y); }
	draw_sprite_ext(spr_bosspoint, 0, targetBossPoint.x, targetBossPoint.y, 4, 4, 5*dsin(12*Time), c_white, (alarm[1] > 0) + (alarm[2]/moveTowardsTargetTime));
}

draw_self();

if (shield > 0) {
	draw_sprite_ext(sprite_index, 3, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
}

if (iframes > 0) {
	draw_sprite_ext(sprite_index, 2, x, y, image_xscale, image_yscale, image_angle, c_white, dsin(4*360*iframes/iframesMax)+0.2);
}

if (instance_exists(obj_control)) {
	var camx = camera_get_view_x(obj_control.myCamera);
	var camy = camera_get_view_y(obj_control.myCamera);
	var camw = camera_get_view_width(obj_control.myCamera);
	var camh = camera_get_view_height(obj_control.myCamera);
	
	var colorOfHealthbar = c_yellow;
	if (HP <= 50) { colorOfHealthbar = c_aqua; }

	draw_healthbar(
		camx+(10*camw/room_width), camy+(10*camh/room_height),
		camx+camw-(10*camw/room_width), camy+(30*camh/room_height),
		HP, c_black, colorOfHealthbar, colorOfHealthbar, 0, true, true
	);
}