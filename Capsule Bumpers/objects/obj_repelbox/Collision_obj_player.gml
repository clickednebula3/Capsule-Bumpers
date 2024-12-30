if (other.bbox_bottom+other.vspeed < bbox_top+32) {other.y = bbox_top; other.vspeed = 0;}
else if (other.bbox_top+other.vspeed >= bbox_bottom-32) {other.vspeed = abs(other.vspeed*0.96);}
else {
	var old_hspd = hspeed;
	var direc = (other.x-x)/abs(other.x-x);
	hspeed = other.hspeed*10/9;
	other.hspeed = direc*abs(old_hspd*0.5);
	hspeed -= direc/2;
	other.hspeed += direc;
}