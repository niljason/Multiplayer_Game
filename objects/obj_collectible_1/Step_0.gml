var _dist = sprite_width + obj_player_1.coin_hitbox;

if (distance_to_object(obj_player_1) <= _dist) {
	with (obj_player_1) {
		coins_collected++;
	}
	global.p1_coins++;
	instance_destroy();
}
