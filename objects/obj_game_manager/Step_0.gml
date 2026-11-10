if (room != rm_start && room != rm_end) global.timer++;

if (!global.coins_ready) {
	global.p1_coins = 0;
	global.p1_total = instance_number(obj_collectible_1);
	global.p2_coins = 0;
	global.p2_total = instance_number(obj_collectible_2);
	global.coins_ready = true;
}

juice_update_room_transition();
if (juice_transition_active()) exit;

if (keyboard_check_pressed(ord("0"))) {
	reset_coins();
	room_goto(rm_start);
}
if (keyboard_check_pressed(ord("1"))) {
	reset_coins();
	room_goto(rm_level_1);
}
if (keyboard_check_pressed(ord("2"))) {
	reset_coins();
	room_goto(rm_level_2);
}
if (keyboard_check_pressed(ord("3"))) {
	reset_coins();
	room_goto(rm_level_3);
}
if (keyboard_check_pressed(ord("4"))) {
	reset_coins();
	room_goto(rm_end);
}
