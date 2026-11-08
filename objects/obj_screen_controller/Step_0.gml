if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
	if (room == rm_start) {
		room_goto(rm_level_1);
	} else {
		room_goto(rm_start);
	}
}
