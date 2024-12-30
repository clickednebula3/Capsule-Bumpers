switch (powerup_type) {
	case PowerupType.BulletGun:
		if (my_player == noone) {
			my_player = other;
			alarm[2] = 5*sec;
			play_my_sfx();
		}
		break;
	case PowerupType.Duplicate:
		var dupe = instance_create_depth(other.x, other.y, other.depth, other.object_index);
		dupe.playerId = other.playerId;
		play_my_sfx();
		instance_destroy();
		break;
	case PowerupType.Jetpack:
		other.jetpackFuel += sec*1.5;
		play_my_sfx();
		instance_destroy();
		break;
	case PowerupType.Jumbo:
		other.image_xscale *= 3;
		other.image_yscale *= 3;
		other.image_xscale = clamp(other.image_xscale, 1, 5);
		other.image_yscale = clamp(other.image_yscale, 1, 5);
		play_my_sfx();
		instance_destroy();
		break;
	case PowerupType.PowerBump:
		other.hasPowerBump = true;
		play_my_sfx();
		instance_destroy();
		break;
	default:
		play_my_sfx();
		instance_destroy();
		break;
}