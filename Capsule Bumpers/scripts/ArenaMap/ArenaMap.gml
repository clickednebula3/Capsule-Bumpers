// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ArenaMap(_name, _room, _sprite, _powerups, _sudden_deaths, _icon_frame) constructor {
	name = _name;
	room_ = _room;
	sprite = _sprite;
	powerups = _powerups;
	sudden_deaths = _sudden_deaths;
	icon_frame = _icon_frame;
	
	static StartArena = function() {
		//todo: check server somehow
		global.mapPowerups = powerups;
		global.mapSuddenDeath = sudden_deaths;
		room_goto(room_);
		//gimmicks doesn't need it. it is manual by the map maker. just info icons basically.
	}
}

enum SuddenDeathType {
	RisingLava,
	FallingMeteors,
	BlackHole,
}

enum GimmickType {//deprecated for icon_frame
	Simple,
	Laser,
	Space,
	Botball,
	Boss,
}