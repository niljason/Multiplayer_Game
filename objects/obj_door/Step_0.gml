// Open this door only after both players collect all coins assigned to them.
door_open = global.coins_ready
	&& global.p1_coins >= global.p1_total
	&& global.p2_coins >= global.p2_total
	&& place_meeting(x, y, obj_actor);

// Check whether every door in the room is open
var _all_open = true;
for (var i = 0; i < instance_number(obj_door); i++) {
	var _d = instance_find(obj_door, i);
	if (!_d.door_open) _all_open = false;
}

if (_all_open && !juice_transition_active()) {
    with (obj_actor) {
		coins_collected = 0;
	}
	juice_begin_next_room();
}
