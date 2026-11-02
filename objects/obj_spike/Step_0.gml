// Send all players back to their starting positions if any player touches a spike.
var _hit = false;
with (obj_actor) {
    if (place_meeting(x, y, obj_spike)) _hit = true;
}

if (_hit) {
    with (obj_actor) {
        x = x_start;
        y = y_start;
        xspd = 0;
        yspd = 0;
        x_remain = 0;
        y_remain = 0;
		show_debug_message("respawn: x=" + string(x) + " y=" + string(y)
    + " vis=" + string(visible) + " alpha=" + string(image_alpha)
    + " depth=" + string(depth));
    }
}