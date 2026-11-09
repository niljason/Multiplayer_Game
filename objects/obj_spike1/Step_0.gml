// Send all players back to their starting positions if a player touches this spike.
var _hit_player = instance_place(x, y, obj_actor);

if (_hit_player != noone) {
	juice_player_died(_hit_player.x, _hit_player.y);
	global.deaths++;
	with (obj_actor) reset_actor_to_spawn();
}
