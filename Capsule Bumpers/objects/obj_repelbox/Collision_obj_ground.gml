//if (bbox_bottom+8+vspeed < other.bbox_top||true) {
//	y = other.bbox_top-1;
//	vspeed = 0;
//}

x = xprevious;
hspeed = -hspeed;
var direc = (other.x-x)/abs(other.x-x);
x -= direc;