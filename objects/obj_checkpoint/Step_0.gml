if (obj_owner == noone && place_meeting(x, y, obj_player_1) && place_meeting(x, y, obj_player_2)) {
	with(obj_actor) {
		x_start = x;
		y_start = y;
	}
	instance_destroy();
} else if (obj_owner != noone) {
	if (place_meeting(x, y, obj_owner)) {
		with (obj_owner) {
			x_start = x;
			y_start = y;
		}
		instance_destroy();
	}
}