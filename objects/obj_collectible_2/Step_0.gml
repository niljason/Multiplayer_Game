var _dist = sprite_width + obj_player_2.coin_hitbox;

if (distance_to_object(obj_player_2) <= _dist) {
	with (obj_player_2) {
		coins_collected++;
	}
	instance_destroy();
}