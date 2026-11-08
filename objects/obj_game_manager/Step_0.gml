if (keyboard_check_pressed(ord("0"))) {
	room_goto(rm_start);
}
if (keyboard_check_pressed(ord("1"))) {
	room_goto(rm_level_1);
}
if (keyboard_check_pressed(ord("2"))) {
	room_goto(rm_level_2);
}
if (keyboard_check_pressed(ord("3"))) {
	room_goto(rm_level_3);
}
if (keyboard_check_pressed(ord("4"))) {
	room_goto(rm_end);
}
