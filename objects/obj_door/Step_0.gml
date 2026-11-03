// Open this door when its owner stands in it
if (!door_open) {
    var _p = instance_place(x, y, owner_obj);
    if (_p != noone && _p.object_index == owner_obj) {
        door_open = true;
    }
}

// Check whether every door in the room is open
var _all_open = true;
for (var i = 0; i < instance_number(obj_door); i++) {
    var _d = instance_find(obj_door, i);
    if (!_d.door_open) _all_open = false;
}

if (_all_open && owner_obj == obj_player_1) {
    with (obj_actor) {
		coins_collected = 0;
	}
	room_goto_next();
}