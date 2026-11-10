var _hit_player = instance_place(x, y, obj_actor);

if (_hit_player != noone && _hit_player.invincibility_timer <= 0) {
	juice_player_died(_hit_player.x, _hit_player.y);
	global.deaths++;
	// send all players back
	with (obj_actor) {
		reset_actor_to_spawn();
		invincibility_timer = invincibility_duration;
	}
}
