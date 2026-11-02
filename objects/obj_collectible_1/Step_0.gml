if (place_meeting(x, y, obj_player_1)) {
	with (obj_player_1) {
		coins_collected++;
	}
	instance_destroy();
}