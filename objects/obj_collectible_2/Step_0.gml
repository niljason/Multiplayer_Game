if (place_meeting(x, y, obj_player_2)) {
	with (obj_player_2) {
		coins_collected++;
	}
	instance_destroy();
}