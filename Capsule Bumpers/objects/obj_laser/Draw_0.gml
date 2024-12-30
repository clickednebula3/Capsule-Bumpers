var _a = abs(dsin(Time*4)) * dcos(Time*3) * abs(dsin(Time*5));

draw_set_alpha(4/5 + _a/5);
draw_line_width_color(x, y, x+point_offx, y+point_offy, 10+3*_a, myColors[0], myColors[0]);
draw_line_width_color(x, y, x+point_offx, y+point_offy, 5 , myColors[1], myColors[1]);
draw_line_width_color(x, y, x+point_offx, y+point_offy, 2, myColors[2], myColors[2]);
draw_set_alpha(1);

if (main_source) { draw_self(); }