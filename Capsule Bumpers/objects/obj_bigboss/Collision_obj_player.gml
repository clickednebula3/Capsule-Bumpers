if (iframes <= 0) {
	if (shield > 0) {
		shield--;
	} else {
		instance_create_depth(other.x, other.bbox_top+16, depth, obj_particle_bump);
		instance_create_depth(other.x, other.bbox_top+16, depth, obj_particle_bump);
		instance_create_depth(other.x, other.bbox_top+16, depth, obj_particle_bump);
		instance_create_depth(other.x, other.bbox_top+16, depth, obj_particle_bump);
		HP -= abs((other.hasPowerBump+1)*other.hspeed)/10;
	}
	iframes = iframesMax;
}

instance_create_depth(other.x, other.bbox_top+16, depth, obj_particle_bump);
instance_create_depth(other.x, other.bbox_top+16, depth, obj_particle_bump);

var otherSize = (other.image_xscale+other.image_yscale)/2;

hspeed = (other.hasPowerBump+1)*other.hspeed*0.8*clamp(otherSize/2, 1, 5);
other.hspeed = -other.hspeed*1.5;
other.vspeed = (other.hasPowerBump+1)*-30;

other.hasPowerBump = false;