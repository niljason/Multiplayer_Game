var _center_x = (bbox_left + bbox_right) * 0.5;
var _center_y = (bbox_top + bbox_bottom) * 0.5;

if (obj_owner == noone && place_meeting(x, y, obj_player_1) && place_meeting(x, y, obj_player_2)) {
	with(obj_actor) {
		x_start = x;
		y_start = y;
	}
	juice_checkpoint_activated(_center_x, _center_y);
	instance_destroy();
} else if (obj_owner != noone) {
	if (place_meeting(x, y, obj_owner)) {
		with (obj_owner) {
			x_start = x;
			y_start = y;
		}
		juice_checkpoint_activated(_center_x, _center_y);
		instance_destroy();
	}
}
