hspeed *= 1.05;

var _coll = collision_line(x+hspeed, y+vspeed, xprevious, yprevious, obj_player, true, true);
if (_coll != noone &&_coll != owner) {
	_coll.hspeed = hspeed*0.8;
	instance_destroy();
	return;
}

var _coll_boss = collision_line(x+hspeed, y+vspeed, xprevious, yprevious, obj_player, true, true);
if (_coll_boss != noone) {
	_coll_boss.hspeed = hspeed*2;
	if (_coll_boss.iframes <= 0) {
		_coll_boss.HP -= 10;
		_coll_boss.iframes = other.iframesMax;
	}
}