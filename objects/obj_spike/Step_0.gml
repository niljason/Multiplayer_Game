// Send all players back to their starting positions if any player touches a spike.
var _hit = false;
with (obj_actor) {
    if (place_meeting(x, y, obj_spike)) _hit = true;
}

if (_hit) {
    with (obj_actor) {
        x = x_start;
        y = y_start;
		grav_dir = spawn_grav_dir;
		attached_steel = noone;
		attached_side = 0;
		attached_xspd = 0;
		attached_offset_x = 0;
		attached_offset_y = 0;
        xspd = 0;
        yspd = 0;
        x_remain = 0;
        y_remain = 0;
    }
}