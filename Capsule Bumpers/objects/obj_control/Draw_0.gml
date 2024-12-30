var camx = camera_get_view_x(myCamera);
var camy = camera_get_view_y(myCamera);
var camw = camera_get_view_width(myCamera);
var camh = camera_get_view_height(myCamera);

if (alarm[0] > 0 || alarm[3] > 0) {
	var theAlarmToUse = max(alarm[0], alarm[3]);
	if (theAlarmToUse == alarm[0]) { theAlarmToUse += global.preGameStartTimer; }
	
	//draw time remaining
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	var timeSpareChange = ((theAlarmToUse/sec)%1);
	draw_set_alpha(timeSpareChange);
	var timeSeconds = (theAlarmToUse/sec) - timeSpareChange + 1;

	draw_set_font(fnt_big);
	draw_text_transformed(room_width/2, room_height/2, string(timeSeconds), timeSpareChange, timeSpareChange, 0);
	
	//draw scoreboard
	draw_set_font(fnt_smol);
	draw_set_color(global.allColors[global.plyrColors[0]]);
	draw_set_alpha(0.8);
	draw_sprite(spr_player, 0, camx+32, camy+64);
	draw_set_alpha(1);
	draw_text(camx+32, camy+32, string(global.wins[0]));
	
	draw_set_color(global.allColors[global.plyrColors[1]]);
	draw_set_alpha(0.8);
	draw_sprite(spr_player, 0, camx+camw-32, camy+64);
	draw_set_alpha(1);
	draw_text(camx+camw-32, camy+32, string(global.wins[1]));
	
	draw_set_color(global.allColors[global.plyrColors[2]]);
	draw_set_alpha(0.8);
	draw_sprite(spr_player, 0, camx+32, camy+camh);
	draw_set_alpha(1);
	draw_text(camx+32, camy+camh-32, string(global.wins[2]));
	
	draw_set_color(global.allColors[global.plyrColors[3]]);
	draw_set_alpha(0.8);
	draw_sprite(spr_player, 0, camx+camw-32, camy+camh);
	draw_set_alpha(1);
	draw_text(camx+camw-32, camy+camh-32, string(global.wins[3]));
}
if (alarm[4] > 0 && alarm[0] <= 0 && alarm[3] <= 0) {
	//draw time remaining
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	var timeSpareChange = ((alarm[4]/sec)%1);
	draw_set_alpha(timeSpareChange);
	var timeSeconds = (alarm[4]/sec) - timeSpareChange + 1;

	draw_set_font(fnt_big);
	draw_text_transformed(room_width/2, room_height/2, "Go!", 1/timeSpareChange, 1/timeSpareChange, 0);
	draw_set_alpha(0.8);
}