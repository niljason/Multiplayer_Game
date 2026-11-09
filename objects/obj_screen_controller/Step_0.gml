if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
	if (room == rm_start) {
		if (instance_exists(obj_game_manager)) {
			with (obj_game_manager) start_new_run();
		}
		room_goto(rm_level_1);
	} else {
		room_goto(rm_start);
	}
}
