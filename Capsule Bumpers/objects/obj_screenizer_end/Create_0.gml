warp_enabled = false;
death_enabled = false;
death_bottom = true;
jump_bottom = false;
draw_lava = true;

time = 0;
lava_radius = 12;
sudden_death = false;

if (room != rm_boss) { alarm[0] = global.preGameStartTimer + 30*sec; }

function move() {
	
};

depth = -1001;