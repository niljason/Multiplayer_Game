if (place_meeting(x, y, obj_player_1) && place_meeting(x, y, obj_player_2)) {
	with(obj_actor) {
		x_start = x;
		y_start = y;
	}
	instance_destroy();
}