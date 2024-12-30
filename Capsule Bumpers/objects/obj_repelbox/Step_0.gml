hspeed *= 0.99;
s_hspeed = hspeed;
//vspeed = 0.5*dsin(Time*sec/20);
Time++;

image_alpha = 0.7 + 0.15 + 0.15*dsin(360*Time/(3*sec));