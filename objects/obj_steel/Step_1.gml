if (move_dir > 0 && x + move_speed >= start_x + move_range) {
    move_dir = -1;
} else if (move_dir < 0 && x - move_speed <= start_x) {
    move_dir = 1;
}

var _total = move_speed * move_dir + move_remain;
var _step  = floor(abs(_total)) * sign(_total);
move_remain = _total - _step;
move_delta_x = 0;

var _dir = sign(_step);

repeat (abs(_step)) {
	if (place_meeting(x + _dir, y, obj_wall)) {
		move_dir *= -1;
		move_remain = 0;
		break;
	}
	x += _dir;
	push_blocked = false;

	// anything in the way?
	with (obj_actor) {
		if (attached_steel != other.id && place_meeting(x, y, other)) {
			if (blocked_ignoring(x + _dir, y, other.id)) other.push_blocked = true;
		}
	}

	// something in the way
	if (push_blocked) {
		x -= _dir;
		move_dir *= -1;
		move_remain = 0;
		break;
	}

	// carry riders, push everyone else
	with (obj_actor) {
		if (attached_steel == other.id) {
			if (!blocked_ignoring(x + _dir, y, other.id)) {
				x += _dir;
			} else {
				attached_steel = noone; 
				attached_side = 0;
			}
		}
		if (attached_steel != other.id && place_meeting(x, y, other)) {
			if (!blocked_ignoring(x + _dir, y, other.id)) x += _dir;
			else unstick();
		}
	}
	move_delta_x += _dir;
}