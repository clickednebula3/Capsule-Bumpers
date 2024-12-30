var _particle = instance_create_depth(x, y, depth, obj_playercapsule_death_throw);
_particle.image_xscale = image_xscale;
_particle.image_yscale = image_yscale;
_particle.hspeed += hspeed;
_particle.vspeed += vspeed;
_particle.hasPowerBump = hasPowerBump;
_particle.jetpackFuel = jetpackFuel;
_particle.playerId = playerId;