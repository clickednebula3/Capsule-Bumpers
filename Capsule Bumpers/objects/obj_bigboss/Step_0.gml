image_angle += 4;
Time++;

if (alarm[2] > 0) {
	if (instance_exists(targetBossPoint) && phase = 0) {
		direction = point_direction(x, y, targetBossPoint.x, targetBossPoint.y);
		speed = spd;
	}
}

hspeed *= 0.85;
vspeed *= 0.85;

iframes = clamp(iframes-1, 0, iframesMax);
shield = clamp(shield, 0, 5);

x += 2*dsin(5*Time+45)/3;
y += 2*dcos(3*Time)/4;

if (phase == 0 && alarm[0] <= 0 && alarm[1] <= 0 && alarm[2] <= 0) {
	alarm[0] = 1;
}

if (phase == 1) {
	if (Time % (sec/2) == 0) {
		for (var i=0; i<4; i++) {
			var bullet = instance_create_depth(x, y, depth, obj_bossbullet);
			bullet.speed = spd*0.8;
			bullet.direction = (90*i)-45;
			bullet.image_xscale = 3;
			bullet.image_yscale = 3;
		}
	}
	if (instance_number(obj_bossbullet) > instance_number(obj_player)*5) { phase = 0; }
}

HP = clamp(HP, 0, 100);
if (HP <= 0) { instance_destroy(); }//maybe show a cool death animation