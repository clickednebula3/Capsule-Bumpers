event_inherited();

//checks if reverse is necessary (if player is from below instead of from top)

var _slope = dtan(image_angle);
var _player_offx = other.x - x;
var _player_offy = other.y - y;
var _potential_y = y + _slope*_player_offx;
var _r = _potential_y > _player_offy;
_r = 2*_r-1;
var _dist = point_distance(x, y, other.x, other.y);
var _lr = (x - other.x) / abs(x - other.x);
rspd += (_r*_lr*_dist)/250;