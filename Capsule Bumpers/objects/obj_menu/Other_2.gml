#macro sec		game_get_speed(gamespeed_fps)

randomise();//this SHOULD work during the entire game, right?
global.debugMode = false;

global.wins = [0, 0, 0, 0];
global.plyrColors = [0, 1, 2, 3];

global.allColors = [c_red, c_blue, c_green, c_fuchsia, c_maroon, c_aqua, c_lime, c_yellow, c_orange, c_purple, c_teal, c_dkgray, c_white];
//global.powerups = [obj_powerup];//obj_power_jetpack, obj_power_bump, obj_power_big, obj_power_bullet];
//global.powerups = [obj_power_bump];//test
enum PowerupType {
	PowerBump,
	Jetpack,
	Jumbo,
	BulletGun,
	Duplicate,
}
#region
global.powerup_sprites = ds_map_create();
ds_map_set(global.powerup_sprites, PowerupType.PowerBump, spr_power_bump);
ds_map_set(global.powerup_sprites, PowerupType.Jetpack, spr_power_jetpack);
ds_map_set(global.powerup_sprites, PowerupType.Jumbo, spr_power_big);
ds_map_set(global.powerup_sprites, PowerupType.BulletGun, spr_gun_pistol);
ds_map_set(global.powerup_sprites, PowerupType.Duplicate, spr_power_duplicate);
#endregion


global.mapPowerups = [];//set by arena
global.mapSuddenDeath = [];//set by arena
global.mapArenas = [];
var _default_powerups = [PowerupType.PowerBump, PowerupType.Jumbo, PowerupType.Duplicate, PowerupType.Jetpack, PowerupType.BulletGun];
var _default_suddeads = [SuddenDeathType.RisingLava, SuddenDeathType.FallingMeteors];
array_push( global.mapArenas, new ArenaMap("Simple",		rm_smash,			map_smash,				_default_powerups,	_default_suddeads,	frame_simple) );
array_push( global.mapArenas, new ArenaMap("Rotate",		rm_sine_platform,	map_sine_platform,		_default_powerups,	_default_suddeads,	frame_simple) );
array_push( global.mapArenas, new ArenaMap("Jetpack",		rm_jetpack_zone,	map_jetpack_zone,		[],					[],					frame_simple) );
array_push( global.mapArenas, new ArenaMap("Classic",		rm_game,			map_game,				_default_powerups,	_default_suddeads,	frame_simple) );
array_push( global.mapArenas, new ArenaMap("Cloud",			rm_block_traverser,	map_block_traverser,	_default_powerups,	_default_suddeads,	frame_simple) );
array_push( global.mapArenas, new ArenaMap("Ghost Glass",	rm_breakroom,		spr_not_connected,		_default_powerups,	_default_suddeads,	frame_simple) );
array_push( global.mapArenas, new ArenaMap("Laser: Sine",	rm_laser_1,			map_laser_race,			_default_powerups,	_default_suddeads,	frame_simple) );
array_push( global.mapArenas, new ArenaMap("Laser: Time",	rm_laser_2,			spr_not_connected,		_default_powerups,	_default_suddeads,	frame_simple) );
array_push( global.mapArenas, new ArenaMap("Laser^2",		rm_smash_1,			spr_not_connected,		_default_powerups,	_default_suddeads,	frame_simple) );
array_push( global.mapArenas, new ArenaMap("Botball",		rm_botball,			map_botball,			_default_powerups,	_default_suddeads,	frame_botball) );
array_push( global.mapArenas, new ArenaMap("Space Sumo",	rm_space,			spr_not_connected,		[PowerupType.Duplicate, PowerupType.Jumbo, PowerupType.PowerBump],	[],	frame_simple) );

global.mapRooms =	[rm_game, rm_smash, rm_smash_1, rm_smash_2, rm_sine_platform, rm_jetpack_zone, rm_laser_1, rm_laser_2, rm_space, rm_botball, rm_boss, rm_block_traverser];
global.mapSprites =	[map_game, map_smash, map_smash, map_smash, map_sine_platform, map_jetpack_zone, map_laser_race, map_laser_race, map_laser_race, map_botball, map_smash, map_block_traverser];
//scale down 8 times then take a 375*248 screenshot
global.mapNames =	["Classic", "Simple", "Test1", "Test2", "Rotating Platform", "Jetpack", "Laser Stairs", "Laser Mayhem", "Space", "Botball: Classic", "BossBattle: Smash", "Block Shuffle"];
/*"Can you really call this a map?\nI didn't see a powerup being used\nduring last game or anything..."*/
//global.mapPowerups = ds_map_create();
//for (var i=0; i<array_length(global.mapRooms); i++) { ds_map_set(global.mapPowerups, rm_game, [obj_power_jetpack, obj_power_big, obj_power_bullet, obj_power_bump]); }
//ds_map_set(global.mapPowerups, rm_smash_1, [obj_holdable_pistol]);



global.audioClearWithMap = [];

global.music = true;
global.sounds = true;
global.canSpawnPowerups = true;
global.controlledDashAim = false;
global.mapCycleMode = false;
global.egg_pillcolliders = false;
global.egg_darkmode = false;

var coolNameToHave = [
	//Meta Names
	"Capsule", "Collidor", "Dr. Pill", "Bumper Main", "Name Enterer", "caps the skebaps.", "Kab Joule", "Just an 0", "Cool-Eye-Door", "Bump Man",
	//Regular Names
	"Rudo", "Lou", "Milo", "Cappy", "Soul", "Leyla", "Lucy", "Dashy", "Pen",
	//Cool Sounding Names
	"Shadow Bumper", "Jetpack Enjoyer", "Win Incapsulator", "Discombobulator", "Pill Bullet", "Slice Inducer", "TechnoCapsule"
	];
global.username = coolNameToHave[irandom_range(0, array_length(coolNameToHave)-1)];
global.ipaddress = "127.0.0.1";
global.myOnlineId = 0;
global.nameChosen = false;

global.wobbleness = 2;//uhh I ordered some 'smoothness', not whatever this is. (0-5)
global.smoothness = 2;//ahh finally (0-5)

global.hf = 1;//frequency
global.hz = 1;//something
global.hr = 1;//something

global.vf = 1;
global.vz = 1;
global.vr = 1;

global.postGameFinishTimer = 3*sec;
global.preGameStartTimer = 2*sec;
global.clientAreWeConnectedFreakoutTimer = 2*sec;